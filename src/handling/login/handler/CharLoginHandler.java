package handling.login.handler;

import client.MapleCharacter;
import client.MapleCharacterUtil;
import client.MapleClient;
import client.PartTimeJob;
import client.Skill;
import client.SkillEntry;
import client.SkillFactory;
import client.inventory.Item;
import client.inventory.MapleInventory;
import client.inventory.MapleInventoryType;
import constants.GameConstants;
import constants.ServerConstants;
import constants.WorldConstants;
import constants.WorldConstants.WorldOption;
import constants.WorldConstants.TespiaWorldOption;
import handling.SendPacketOpcode;
import handling.channel.ChannelServer;
import handling.login.LoginInformationProvider;
import handling.login.LoginInformationProvider.JobType;
import handling.login.LoginServer;
import handling.login.LoginWorker;
import handling.world.World;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import server.MapleItemInformationProvider;
import server.quest.MapleQuest;
import tools.FileoutputUtil;
import tools.data.LittleEndianAccessor;
import tools.packet.CField;
import tools.packet.LoginPacket;
import tools.packet.PacketHelper;
import tools.packet.CWvsContext;

public class CharLoginHandler {

	private static boolean loginFailCount(final MapleClient c) {
		c.loginAttempt++;
		return c.loginAttempt > 6;
	}

	public static void handleAuthRequest(final LittleEndianAccessor slea, final MapleClient c) {
		// System.out.println("Sending response to client.");
		int request = slea.readInt();
		int response = request ^ SendPacketOpcode.AUTH_RESPONSE.getValue();

		c.getSession().write(LoginPacket.sendAuthResponse(response));
	}

	public static void sendReply(final LittleEndianAccessor slea, final MapleClient c) {
		slea.readInt();
		c.getSession().write(LoginPacket.sendResponse());
	}

	public static final void login(final LittleEndianAccessor slea, final MapleClient c) {
		slea.skip(1);

		String pwd = slea.readMapleAsciiString();
		String login = slea.readMapleAsciiString().replace("NP12:auth06:5:0:","");

		final boolean ipBan = c.hasBannedIP();
		final boolean macBan = c.hasBannedMac();

		int loginok = c.login(login, pwd, ipBan || macBan);

		final Calendar tempbannedTill = c.getTempBanCalendar();

		if (loginok == 0 && (ipBan || macBan) && !c.isGm()) {
			loginok = 3;
			if (macBan) {
				MapleCharacter.ban(c.getSession().getRemoteAddress().toString().split(":")[0], "Enforcing account ban, account " + login, false, 4, false);
			}
		}
		if (loginok == 3){
			c.getSession().write(CWvsContext.broadcastMsg(1, "You have been permanently banned for the following reason: " + c.getBanReason()));
			c.getSession().write(LoginPacket.getLoginFailed(3));
		}
		else if (loginok != 0) {
			if (!loginFailCount(c)) {
				c.clearInformation();
				c.getSession().write(LoginPacket.getLoginFailed(loginok));
			} else {
				c.getSession().close();
			}
		} else if (tempbannedTill.getTimeInMillis() != 0) {
			if (!loginFailCount(c)) {
				c.clearInformation();
				c.getSession().write(LoginPacket.getTempBan(PacketHelper.getTime(tempbannedTill.getTimeInMillis()), c.getBanReason()));
			} else {
				c.getSession().close();
			}
		} else {
			c.loginAttempt = 0;
			LoginWorker.registerClient(c);
		}
	}  

	public static void setBurningCharacter(LittleEndianAccessor slea, MapleClient c) {
		slea.skip(1);
		int accountId = slea.readInt();
		int charId = slea.readInt();
		if (!c.isLoggedIn() || c.getAccID() != accountId) { // hack
			return;
		}
		if (!c.setBurningCharacter(accountId, charId)) {
			c.getSession().write(CWvsContext.broadcastMsg(1, "Sucessfully!"));
			return;
		}
		c.send(LoginPacket.setBurningEffect(charId));
	}

	public static void ServerListRequest(final MapleClient c) {
		if (ServerConstants.TESPIA) {
			for (TespiaWorldOption tespiaservers : TespiaWorldOption.values()) {
				if (TespiaWorldOption.getById(tespiaservers.getWorld()).show() && TespiaWorldOption.getById(tespiaservers.getWorld()) != null) {
					c.getSession().write(LoginPacket.getServerList(Integer.parseInt(tespiaservers.getWorld().replace("t", "")), LoginServer.getLoad()));
				}
			}
		} else {
			for (WorldOption servers : WorldOption.values()) {
				if (WorldOption.getById(servers.getWorld()).show() && servers != null) {
					c.getSession().write(LoginPacket.getServerList(servers.getWorld(), LoginServer.getLoad()));
				}
			}
		}
		c.getSession().write(LoginPacket.getEndOfServerList());
		boolean hasCharacters = false;
		for (int world = 0; world < WorldOption.values().length; world++) {
			final List<MapleCharacter> chars = c.loadCharacters(world);
			if (chars != null) {
				hasCharacters = true;
				break;
			}
		}
		if (ServerConstants.TESPIA) {
			for (TespiaWorldOption value : TespiaWorldOption.values()) {
				String world = value.getWorld();
				//final List<MapleCharacter> chars = c.loadTespiaCharacters(world);
				//if (chars != null) {
				//    hasCharacters = true;
				//    break;
				//}
			}
		}
		if (!hasCharacters) {
			c.getSession().write(LoginPacket.enableRecommended(WorldOption.recommended));
		}
		if (WorldOption.recommended >= 0) {
			c.getSession().write(LoginPacket.sendRecommended(WorldOption.recommended, WorldOption.recommendedmsg));
		}
	}

	public static void ServerStatusRequest(final MapleClient c) {
		// 0 = Select world normally
		// 1 = "Since there are many users, you may encounter some..."
		// 2 = "The concurrent users in this world have reached the max"
		final int numPlayer = LoginServer.getUsersOn();
		final int userLimit = LoginServer.getUserLimit();
		if (numPlayer >= userLimit) {
			c.getSession().write(LoginPacket.getServerStatus(2));
		} else if (numPlayer * 2 >= userLimit) {
			c.getSession().write(LoginPacket.getServerStatus(1));
		} else {
			c.getSession().write(LoginPacket.getServerStatus(0));
		}
	}

	public static void CharlistRequest(final LittleEndianAccessor slea, final MapleClient c) {
		if (!c.isLoggedIn()) {
			c.getSession().close();
			return;
		}
		slea.readByte(); //2?
		final int server = slea.readByte();
		final int channel = slea.readByte() + 1;
		System.out.println("CHANNEL READ: " + channel);
		if (!World.isChannelAvailable(channel, server) || !WorldOption.isExists(server)) {
			c.getSession().write(LoginPacket.getLoginFailed(10)); //cannot process so many
			return;
		}

		if (!WorldOption.getById(server).isAvailable() && !(c.isGm() && server == WorldConstants.gmserver)) {
			c.getSession().write(CWvsContext.broadcastMsg(1, "We are sorry, but " + WorldConstants.getNameById(server) + " is currently not available. \r\nPlease try another world."));
			c.getSession().write(LoginPacket.getLoginFailed(1)); //Shows no message, but it is used to unstuck
			return;
		}

		//System.out.println("Client " + c.getSession().getRemoteAddress().toString().split(":")[0] + " is connecting to server " + server + " channel " + channel + "");
		final List<MapleCharacter> chars = c.loadCharacters(server);
		if (chars != null && ChannelServer.getInstance(channel) != null) {
			c.setWorld(server);
			c.setChannel(channel);
			// c.getSession().write(LoginPacket.getSecondAuthSuccess(c));
			c.getSession().write(LoginPacket.getCharList(c.getSecondPassword(), chars, c.getCharacterSlots()));
		} else {
			c.getSession().close();
		}
	}

	public static void updateCCards(final LittleEndianAccessor slea, final MapleClient c) {
		if (slea.available() != 36 || !c.isLoggedIn()) {
			c.getSession().close();
			return;
		}
		final Map<Integer, Integer> cids = new LinkedHashMap<>();
		for (int i = 1; i <= 6; i++) { // 6 chars
			final int charId = slea.readInt();
			if ((!c.login_Auth(charId) && charId != 0) || ChannelServer.getInstance(c.getChannel()) == null || !WorldOption.isExists(c.getWorld())) {
				c.getSession().close();
				return;
			}
			cids.put(i, charId);
		}
		c.updateCharacterCards(cids);
	}

	public static final void CheckCharName(final String name, final MapleClient c) {
		c.getSession().write(LoginPacket.charNameResponse(name,!(MapleCharacterUtil.canCreateChar(name, c.isGm()) && (!LoginInformationProvider.getInstance().isForbiddenName(name) || c.isGm()))));
	}
	public static void CreateChar(final LittleEndianAccessor slea, final MapleClient c) {
		if (!c.isLoggedIn()) {
			c.getSession().close();
			return;
		}
		final String name = slea.readMapleAsciiString();
		slea.readInt(); // key settings
		slea.readInt(); // -1 ?
		final JobType jobType = JobType.getByType(slea.readInt()); // BIGBANG: 0 = Resistance, 1 = Adventurer, 2 = Cygnus, 3 = Aran, 4 = Evan, 5 = mercedes
		final short subcategory = slea.readShort(); //whether dual blade = 1 or adventurer = 0
		final byte gender = slea.readByte(); //??idk corresponds with the thing in addCharStats
		byte skinColor = slea.readByte(); // 01
		int hairColor = 0;
		final byte unk = slea.readByte(); // 08
		final boolean mercedes = (jobType == JobType.Mercedes);
		final boolean demon = (jobType == JobType.Demon);
		final boolean mihile = (jobType == JobType.Mihile);
		final boolean aran = (jobType == JobType.Aran);
		final boolean evan = (jobType == JobType.Evan);
		final boolean resist = (jobType == JobType.Resistance);
		final boolean cygnus = (jobType == JobType.Cygnus);
		final boolean adv = (jobType == JobType.Adventurer);
		boolean jettPhantom = (jobType == LoginInformationProvider.JobType.Jett) || (jobType == LoginInformationProvider.JobType.Phantom) || (jobType == LoginInformationProvider.JobType.DualBlade);
		final int face = slea.readInt();
		final int hair = slea.readInt();
		if (!mercedes && !mihile && !demon && !jettPhantom) { //mercedes/demon dont need hair color since its already in the hair
			if (!adv) {
				hairColor = slea.readInt();
			}
			skinColor = (byte) slea.readInt();
		}
		if(mihile){ //For some reason an int was missing.
			final int unk3 = slea.readInt();
		}
		final int demonMark = (aran ? 0 : evan ? 0 : resist ? 0 : cygnus ? 0 : adv ? 0 : slea.readInt());
		//final int top = slea.readInt();
		// final int bottom = adv ? 0 : slea.readInt();
		//final int shoes = slea.readInt();
		// final int weapon = jobType == LoginInformationProvider.JobType.Phantom ? 1362046 : mercedes ? 1522038 : evan ? 1372005 : slea.readInt();
		int shield = jobType == LoginInformationProvider.JobType.Phantom ? 1352100 : jobType == LoginInformationProvider.JobType.Mihile ? 1098000 : mercedes ? 1352000 : demon ? slea.readInt() : 0;
		final int weapon = jobType == LoginInformationProvider.JobType.Adventurer ? 1302000 : slea.readInt();
		final int top = jobType == LoginInformationProvider.JobType.Adventurer ? 1040010  : slea.readInt();
		final int bottom = jobType == LoginInformationProvider.JobType.Adventurer ? 1060002 : slea.readInt();
		final int shoes = jobType == LoginInformationProvider.JobType.Adventurer ? 1072038 : slea.readInt();




		// System.out.println("Name:" + name + " jobType: " +jobType.toString() + " db: " + db + " gender: " + gender + " skinColor: " + skinColor + " unk2: " + unk2 + "face: " + face + " hair: " + hair
		//        + " demon: " + demonMark + " Top: "+ top + " bottom: " + bottom + " shoes: " + shoes + " wep: " + weapon + " shield: " + shield);

		MapleCharacter newchar = MapleCharacter.getDefault(c, jobType);
		newchar.setWorld((byte) c.getWorld());
		newchar.setFace(face);
		newchar.setHair(hair + hairColor);
		newchar.setGender(gender);
		newchar.setName(name);
		newchar.setSkinColor(skinColor);
		// newchar.setDemonMarking(demonMark);
		newchar.setHcMode((short)c.getWorld());

		final MapleItemInformationProvider li = MapleItemInformationProvider.getInstance();
		final MapleInventory equip = newchar.getInventory(MapleInventoryType.EQUIPPED);

		Item item = li.getEquipById(top);
		item.setPosition((byte) -5);
		equip.addFromDB(item);

		if (bottom > 0) { //resistance have overall
			item = li.getEquipById(bottom);
			item.setPosition((short)(byte)(jettPhantom ? -9 : -6));
			equip.addFromDB(item);
		}

		item = li.getEquipById(shoes);
		item.setPosition((byte) -7);
		equip.addFromDB(item);

		item = li.getEquipById(weapon);
		item.setPosition((byte) -11);
		equip.addFromDB(item);

		if (shield > 0) {
			item = li.getEquipById(shield);
			item.setPosition((byte) -10);
			equip.addFromDB(item);
		}

		switch (jobType) {
		case Resistance: // Resistance
			newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161001, (byte) 0, (short) 1, (byte) 0));
			break;
		case Adventurer: // Adventurer
			newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161001, (byte) 0, (short) 1, (byte) 0));
			break;
		case Cygnus: // Cygnus
			//newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161047, (byte) 0, (short) 1, (byte) 0));
			newchar.setQuestAdd(MapleQuest.getInstance(20022), (byte) 1, "1");
			newchar.setQuestAdd(MapleQuest.getInstance(20010), (byte) 1, null); //>_>_>_> ugh
			final Map<Skill, SkillEntry> ss2 = new HashMap<>();
			newchar.changeSkillLevel_Skip(ss2, false);
			break;
		case Aran: // Aran
			newchar.setJob(2100);
			final Map<Skill, SkillEntry> ss3 = new HashMap<>();
			//ss3.put(SkillFactory.getSkill(80001152), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss3, false);
			break;
		case Evan: //Evan
			newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161052, (byte) 0, (short) 1, (byte) 0));
			break;
		case Mercedes: // Mercedes
			//newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161079, (byte) 0, (short) 1, (byte) 0));
			final Map<Skill, SkillEntry> ss5 = new HashMap<>();
			ss5.put(SkillFactory.getSkill(20021000), new SkillEntry((byte) 0, (byte) 0, -1));
			ss5.put(SkillFactory.getSkill(20021001), new SkillEntry((byte) 0, (byte) 0, -1));
			ss5.put(SkillFactory.getSkill(20020002), new SkillEntry((byte) 0, (byte) 0, -1));				
			//ss5.put(SkillFactory.getSkill(20020022), new SkillEntry((byte) 1, (byte) 1, -1)); //wrong skill, fag
			ss5.put(SkillFactory.getSkill(20020109), new SkillEntry((byte) 1, (byte) 1, -1));
			ss5.put(SkillFactory.getSkill(20021110), new SkillEntry((byte) 1, (byte) 1, -1));
			ss5.put(SkillFactory.getSkill(20020111), new SkillEntry((byte) 1, (byte) 1, -1));
			ss5.put(SkillFactory.getSkill(20020112), new SkillEntry((byte) 1, (byte) 1, -1));
			ss5.put(SkillFactory.getSkill(20021181), new SkillEntry((byte) -1, (byte) 0, -1));
			ss5.put(SkillFactory.getSkill(20021166), new SkillEntry((byte) -1, (byte) 0, -1));
			//ss5.put(SkillFactory.getSkill(80001152), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss5, false);
			break;
		case Demon: //Demon
			//newchar.getInventory(MapleInventoryType.ETC).addItem(new Item(4161054, (byte) 0, (short) 1, (byte) 0));
			final Map<Skill, SkillEntry> ss6 = new HashMap<>();
			//ss6.put(SkillFactory.getSkill(30011000), new SkillEntry((byte) 0, (byte) 0, -1));
			//ss6.put(SkillFactory.getSkill(30011001), new SkillEntry((byte) 0, (byte) 0, -1));
			//ss6.put(SkillFactory.getSkill(30010002), new SkillEntry((byte) 0, (byte) 0, -1));				
			ss6.put(SkillFactory.getSkill(30010185), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30010112), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30010111), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30010110), new SkillEntry((byte) 1, (byte) 1, -1));
			//ss6.put(SkillFactory.getSkill(30010022), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30011109), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30011170), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30011169), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30011168), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30011167), new SkillEntry((byte) 1, (byte) 1, -1));
			ss6.put(SkillFactory.getSkill(30010166), new SkillEntry((byte) 1, (byte) 1, -1));
			//ss6.put(SkillFactory.getSkill(80001152), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss6, false);
			break;

		case Phantom:
			newchar.setLevel((short) 10);
			newchar.setJob(2400);
			newchar.getStat().maxhp += 294; //Beginner 10 levels
			newchar.getStat().maxmp += 113;
			newchar.getStat().hp += 294; //Beginner 10 levels
			newchar.getStat().mp += 113;
			newchar.getStat().str = 4;
			newchar.getStat().dex = 4;
			newchar.getStat().int_ = 30; //Why is int_ and luk switched?
			newchar.getStat().luk = 4;
			newchar.setRemainingAp((short) 28); 
			newchar.setRemainingSp(5); 
			final Map<Skill, SkillEntry> ss7 = new HashMap<>();
			ss7.put(SkillFactory.getSkill(20031203), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20030204), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20031205), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20030206), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20031207), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20031208), new SkillEntry((byte) 1, (byte) 1, -1));
			ss7.put(SkillFactory.getSkill(20031209), new SkillEntry((byte) 1, (byte) 1, -1)); //Judgement Draw I
			//ss7.put(SkillFactory.getSkill(20031210), new SkillEntry((byte) 1, (byte) 1, -1)); //Judgement Draw II is at 4th Job.
			//ss7.put(SkillFactory.getSkill(80001152), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss7, false);
			break;	

		case Jett:
			newchar.setLevel((short) 10);
			newchar.setJob(508);
			newchar.getStat().maxhp += 294; //Beginner 10
			newchar.getStat().maxmp += 113;
			newchar.getStat().hp += 294; //Beginner 10
			newchar.getStat().mp += 113;
			newchar.getStat().str -= 8;
			newchar.getStat().dex += 15;
			newchar.setRemainingAp((short) 38); 
			newchar.setRemainingSp(1); 
			final Map<Skill, SkillEntry> ss8 = new HashMap<>();
			ss8.put(SkillFactory.getSkill(228), new SkillEntry((byte) 1, (byte) 1, -1));
			//ss8.put(SkillFactory.getSkill(80001152), new SkillEntry((byte) 1, (byte) 1, -1));
			//ss8.put(SkillFactory.getSkill(80001151), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss8, false);
			break;	

		case Mihile:
			newchar.setLevel((short) 10);
			newchar.setJob(5100);
			newchar.getStat().maxhp += 382; //Starting ten levels.
			newchar.getStat().maxmp += 87;
			newchar.getStat().hp += 382; 
			newchar.getStat().mp += 87;
			newchar.getStat().str = 4;
			newchar.getStat().dex = 4;
			newchar.getStat().int_ = 4;
			newchar.getStat().luk = 4;
			newchar.setRemainingAp((short) 54); 
			newchar.setRemainingSp(5);
			final Map<Skill, SkillEntry> ss9 = new HashMap<>();
			ss9.put(SkillFactory.getSkill(50001214), new SkillEntry((byte) 1, (byte) 1, -1));
			newchar.changeSkillLevel_Skip(ss9, false);
			break;
		default:
			break;	
		}

		if (MapleCharacterUtil.canCreateChar(name, c.isGm()) && (!LoginInformationProvider.getInstance().isForbiddenName(name) || c.isGm()) && (c.isGm() || c.canMakeCharacter(c.getWorld()))) {
			MapleCharacter.saveNewCharToDB(newchar, jobType, subcategory);
			c.getSession().write(LoginPacket.addNewCharEntry(newchar, true));
			c.createdChar(newchar.getId());
		} else {
			c.getSession().write(LoginPacket.addNewCharEntry(newchar, false));
		}
	}

	public static void DeleteChar(final LittleEndianAccessor slea, final MapleClient c) {
		String Secondpw_Client = GameConstants.GMS ? slea.readMapleAsciiString() : null;
		if (Secondpw_Client == null) {
			if (slea.readByte() > 0) { // Specific if user have second password or not
				Secondpw_Client = slea.readMapleAsciiString();
			}
			slea.readMapleAsciiString();
		}

		final int Character_ID = slea.readInt();

		if (!c.login_Auth(Character_ID) || !c.isLoggedIn() || loginFailCount(c)) {
			c.getSession().close();
			return; // Attempting to delete other character
		}
		byte state = 0;

		if (c.getSecondPassword() != null) { // On the server, there's a second password
			if (Secondpw_Client == null) { // Client's hacking
				c.getSession().close();
				return;
			} else {
				if (!c.CheckSecondPassword(Secondpw_Client)) { // Wrong Password
					state = 20;
				}
			}
		}

		if (state == 0) {
			state = (byte) c.deleteCharacter(Character_ID);
		}
		c.getSession().write(LoginPacket.deleteCharResponse(Character_ID, state));
	}

	public static void Character_login_noPIC(final LittleEndianAccessor slea, final MapleClient c, final boolean view, final boolean haspic) {
		if (haspic) {
			final String password = slea.readMapleAsciiString();
			final int charId = slea.readInt();
			if (view) {
				c.setChannel(1);
				c.setWorld(slea.readInt());
			}
			c.updateMacs(slea.readMapleAsciiString());
			final String s = c.getSessionIPAddress();
			LoginServer.putLoginAuth(charId, s.substring(s.indexOf('/') + 1, s.length()), c.getTempIP(), c.getChannel());
			c.updateLoginState(MapleClient.LOGIN_SERVER_TRANSITION, s);
			c.getSession().write(CField.getServerIP(c, Integer.parseInt(ChannelServer.getInstance(c.getChannel()).getIP().split(":")[1]), charId, c.getChannel()));
		} else {
			slea.readByte(); // 1?
			slea.readByte(); // 1?
			final int charId = slea.readInt();
			if (view) {
				c.setChannel(1);
				c.setWorld(slea.readInt());
			}
			c.updateMacs(slea.readMapleAsciiString());
			slea.readMapleAsciiString();
			final String s = c.getSessionIPAddress();
			LoginServer.putLoginAuth(charId, s.substring(s.indexOf('/') + 1, s.length()), c.getTempIP(), c.getChannel());
			c.updateLoginState(MapleClient.LOGIN_SERVER_TRANSITION, s);
			c.getSession().write(CField.getServerIP(c, Integer.parseInt(ChannelServer.getInstance(c.getChannel()).getIP().split(":")[1]), charId, c.getChannel()));

		}
	}

	public static void Character_WithoutSecondPassword(final LittleEndianAccessor slea, final MapleClient c, final boolean haspic, final boolean view) {
		if (constants.ServerConfig.DISABLE_PIC) {
			Character_login_noPIC(slea, c, view, haspic);
		}
		slea.readByte(); // 1?
		slea.readByte(); // 1?
		final int charId = slea.readInt();
		if (view) {
			c.setChannel(1);
			c.setWorld(slea.readInt());
		}
		final String currentpw = c.getSecondPassword();
		/*if (!c.isLoggedIn() || loginFailCount(c) || (currentpw != null && (!currentpw.equals("") || haspic)) || !c.login_Auth(charId) || ChannelServer.getInstance(c.getChannel()) == null || !WorldOption.isExists(c.getWorld())) {
            c.getSession().close();
            return;
        }*/
		c.updateMacs(slea.readMapleAsciiString());
		slea.readMapleAsciiString();
		if (slea.available() != 0) {
			final String setpassword = slea.readMapleAsciiString();

			if (setpassword.length() >= 6 && setpassword.length() <= 16) {
				c.setSecondPassword(setpassword);
				c.updateSecondPassword();
			} else {
				c.getSession().write(LoginPacket.secondPwError((byte) 0x14));
				return;
			}
		} else if (haspic) {
			return;
		}
		if (c.getIdleTask() != null) {
			c.getIdleTask().cancel(true);
		}
		final String s = c.getSessionIPAddress();
		LoginServer.putLoginAuth(charId, s.substring(s.indexOf('/') + 1, s.length()), c.getTempIP(), c.getChannel());
		c.updateLoginState(MapleClient.LOGIN_SERVER_TRANSITION, s);
		c.getSession().write(CField.getServerIP(c, Integer.parseInt(ChannelServer.getInstance(c.getChannel()).getIP().split(":")[1]), charId, c.getChannel()));
	}

	public static void Character_WithSecondPassword(final LittleEndianAccessor slea, final MapleClient c, final boolean view) {
		if (constants.ServerConfig.DISABLE_PIC) {
			Character_login_noPIC(slea, c, view, true);
		}
		final String password = slea.readMapleAsciiString();
		final int charId = slea.readInt();
		if (view) {
			c.setChannel(1);
			c.setWorld(slea.readInt());
		}
		slea.skip(1);
		/*if (!c.isLoggedIn() || loginFailCount(c) || c.getSecondPassword() == null || !c.login_Auth(charId) || ChannelServer.getInstance(c.getChannel()) == null || !WorldOption.isExists(c.getWorld())) {
            c.getSession().close();
            return;
        }*/
		c.updateMacs(slea.readMapleAsciiString());
		slea.readMapleAsciiString();
		if (c.CheckSecondPassword(password) && password.length() >= 6 && password.length() <= 16 || c.isGm()) {
			if (c.getIdleTask() != null) {
				c.getIdleTask().cancel(true);
			}

			final String s = c.getSessionIPAddress();
			LoginServer.putLoginAuth(charId, s.substring(s.indexOf('/') + 1, s.length()), c.getTempIP(), c.getChannel());
			c.updateLoginState(MapleClient.LOGIN_SERVER_TRANSITION, s);
			c.getSession().write(CField.getServerIP(c, Integer.parseInt(ChannelServer.getInstance(c.getChannel()).getIP().split(":")[1]), charId, c.getChannel()));
		} else {
			c.getSession().write(LoginPacket.secondPwError((byte) 0x14));
		}
	}
}
