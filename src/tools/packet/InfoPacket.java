/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools.packet;

import client.*;
import handling.SendPacketOpcode;
import java.util.*;
import tools.Pair;
import tools.StringUtil;
import tools.data.MaplePacketLittleEndianWriter;

/**
 *
 * @author Administrator
 */
public class InfoPacket {

		private enum InfoPacketOpcode {

			ITEM(0x0),
			QUEST(0x1),
			QUEST_RECORD_CHECK(0x2),
			CASH_ITEM_EXPIRED(0x3),
			EXP(0x4),
			SP(0x5),
			FAME(0x6),
			MESO(0x7),
			GP_GAIN(0x8),
			GP_MESSAGE(0x9),
			GIVE_BUFF(0xA),
			ITEM_EXPIRATION(0xB),
			MESSAGE(0xC),
			QUEST_EX_MESSAGE(0xD),
			WORLD_SHARE(0xE),
			PROTECT(0xF),
			REPLACE(0x10),
			ITEM_ABILITY(0x11),
			SKILL_EXPIRED(0x12),
			TRAIT(0x13),
			MAX_TRAIT(0x14),
			//MISSING 0x15
			ANDROID_MESSAGE(0x16),
			FATIGUE(0x17),
			PVP_POINT(0x18),
			PVP_ITEM_USE(0x19),
			WEDDING(0x1A),
			HARDCORE_EXP(0x1B),
			AUTO_LINE(0x1C),
			ENTRY_RECORD(0x1D),
			EVOLVING_MESSAGE(0x1E),
			EVOLVING_MESSAGE_NAME(0x1F),
			CORE(0x20),
			NX_RECORD(0x21),
			BLOCKED_BEHAVIOR(0x22),
			GAIN_WP(0x23),
			MAX_WP(0x24),
			MULTI_KILL(0x25),
			BARRIER_EFFECT(0x26),
			EXPIRED_CASH_ITEM(0x27),
			COLLECTION_RECORD(0x28),
			RANDOM_CHANCE(0x29),
			UNKNOWN(0x2A),
			;

			private final byte op;

			private InfoPacketOpcode(int op) {
				this.op = (byte) op;
			}

			public byte getValue(){
				return op;
			}
		}
                
                public static byte[] showMesoGain(long gain, boolean inChat) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			if (!inChat) {
				mplew.write(InfoPacketOpcode.ITEM.getValue());
				mplew.write(1);
				mplew.write(0);
				mplew.writeLong(gain);
				mplew.writeShort(0);
			} else {
				mplew.write(InfoPacketOpcode.MESO.getValue());
				mplew.writeLong(gain);
				mplew.writeInt(-1);
			}

			return mplew.getPacket();
		}

		public static byte[] getShowInventoryStatus(int mode) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.ITEM.getValue());
			mplew.write(mode);
			mplew.writeInt(0);
			mplew.writeInt(0);

			return mplew.getPacket();
		}

		public static byte[] getShowItemGain(int itemId, short quantity) {
			return getShowItemGain(itemId, quantity, false);
		}

		public static byte[] getShowItemGain(int itemId, short quantity, boolean inChat) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			if (inChat) {
				mplew.write(SendPacketOpcode.SHOW_SPECIAL_EFFECT);
				mplew.write(7);
				mplew.write(1);
				mplew.writeInt(itemId);
				mplew.writeInt(quantity);
			} else {
				mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
				mplew.write(0);
				mplew.write(0);
				mplew.writeInt(itemId);
				mplew.writeInt(quantity);
			}

			return mplew.getPacket();
		}

		public static byte[] updateQuest(MapleQuestStatus quest) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.QUEST.getValue());
			mplew.writeInt(quest.getQuest().getId());
			mplew.write(quest.getStatus());
			switch (quest.getStatus()) {
			case 0:
				mplew.write(0);
				break;
			case 1:
				mplew.writeMapleAsciiString(quest.getCustomData() != null ? quest.getCustomData() : "");
				break;
			case 2:
				mplew.writeLong(PacketHelper.getTime(System.currentTimeMillis()));
			}

			return mplew.getPacket();
		}

		public static byte[] updateQuestMobKills(MapleQuestStatus status) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.QUEST_RECORD_CHECK.getValue());
			mplew.writeInt(status.getQuest().getId());
			mplew.write(1);
			StringBuilder sb = new StringBuilder();
			for (Iterator<?> i$ = status.getMobKills().values().iterator(); i$.hasNext();) {
				int kills = ((Integer) i$.next()).intValue();
				sb.append(StringUtil.getLeftPaddedStr(String.valueOf(kills), '0', 3));
			}
			mplew.writeMapleAsciiString(sb.toString());
			mplew.writeLong(0L);

			return mplew.getPacket();
		}

		public static byte[] itemExpired(int itemid) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.CASH_ITEM_EXPIRED.getValue()); //Not sure why it is cash, might be wrong
			mplew.writeInt(itemid);

			return mplew.getPacket();
		}

		public static byte[] GainEXP_Monster(int gain, boolean white, List<Pair<MapleExpType, Integer>> exp) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.EXP.getValue());
			mplew.write(white ? 1 : 0);
			mplew.writeInt(gain);
			boolean inchat = false;
			mplew.write(inchat);//inchat or not
			long mask = 0;
			for (int i = 0; i < exp.size(); i++) {
				Pair<MapleExpType, Integer> stat = exp.get(i);
				if ((mask & stat.getLeft().getFlag()) != 0) {
					exp.remove(i);
				} else {
					mask |= stat.getLeft().getFlag();
				}
			}
			mplew.writeLong(mask);
			boolean pendant = false;
			for (Pair<MapleExpType, Integer> stat : exp) {
				if (stat.getLeft().getLength() == 4) {
					mplew.writeInt(stat.getRight());
				} else {
					mplew.write(stat.getRight());
				}
				if (stat.getLeft().getFlag() == 2 && stat.getRight() > 0) {
					pendant = true;
				}
				if (stat.getLeft().getFlag() == 0x20) {
					if (pendant) {
						mplew.write(0);
					}
					if (inchat) {
						mplew.write(0); // if > 0 write another byte
					}
				}
			}
			return mplew.getPacket();
		}

		public static byte[] GainEXP_Others(long gain, boolean inChat, boolean white) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.EXP.getValue());
			mplew.write(white ? 1 : 0);
			mplew.writeInt((int) gain);//int no dc??
			mplew.write(inChat ? 1 : 0);
			mplew.writeInt(0);
			mplew.write(0);
			mplew.write(0);
			mplew.writeInt(0);
			mplew.write(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0);
			mplew.writeInt(0); 
			//            if (inChat) {
			//                mplew.writeLong(0L);
			//            } else {
			//                mplew.writeShort(0);
			//                mplew.write(0);
			//            }
			mplew.write(0);
			return mplew.getPacket();
		}

		public static byte[] getSPMessage(byte sp, short job) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.SP.getValue());
			mplew.writeShort(job);
			mplew.write(sp);

			return mplew.getPacket();
		}

		public static byte[] getShowFameGain(int gain) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.FAME.getValue());
			mplew.writeInt(gain);

			return mplew.getPacket();
		}
		public static byte[] getGPContribution(int itemid) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.GP_GAIN.getValue());
			mplew.writeInt(itemid);

			return mplew.getPacket();
		}
		
		public static byte[] getGPMessage(int itemid) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();
			
			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.GP_MESSAGE.getValue());
			mplew.writeInt(itemid);
			
			return mplew.getPacket();
		}

		public static byte[] getStatusMessage(int itemid) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.ITEM_EXPIRATION.getValue());
			mplew.writeInt(itemid);

			return mplew.getPacket();
		}

		public static byte[] showInfo(String info) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.MESSAGE.getValue());
			mplew.writeMapleAsciiString(info);

			return mplew.getPacket();
		}

		public static byte[] updateInfoQuest(int quest, String data) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.QUEST_EX_MESSAGE.getValue());
			mplew.writeShort(quest);
			mplew.writeMapleAsciiString(data);
			return mplew.getPacket();
		}

		public static byte[] showItemReplaceMessage(List<String> message) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.REPLACE.getValue());
			mplew.write(message.size());
			for (String x : message) {
				mplew.writeMapleAsciiString(x);
			}

			return mplew.getPacket();
		}

		public static byte[] showTraitGain(MapleTrait.MapleTraitType trait, int amount) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.TRAIT.getValue());
			mplew.writeLong(trait.getStat().getValue());
			mplew.writeInt(amount);

			return mplew.getPacket();
		}

		public static byte[] showTraitMaxed(MapleTrait.MapleTraitType trait) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.MAX_TRAIT.getValue());
			mplew.writeLong(trait.getStat().getValue());

			return mplew.getPacket();
		}

		public static byte[] getBattlePointsMessage(int amount) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.PVP_POINT.getValue());
			mplew.writeInt(amount);
			mplew.writeInt(0);

			return mplew.getPacket();
		}

		public static byte[] showExpireMessage(byte type, List<Integer> item) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter(4 + item.size() * 4);

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(type);
			mplew.write(item.size());
			for (Integer it : item) {
				mplew.writeInt(it.intValue());
			}

			return mplew.getPacket();
		}

		public static byte[] showStatusMessage(int mode, String info, String data) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(mode);
			if (mode == 23) {
				mplew.writeMapleAsciiString(info);
				mplew.writeMapleAsciiString(data);
			}

			return mplew.getPacket();
		}

		public static byte[] showReturnStone(int act) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.PVP_ITEM_USE.getValue());
			mplew.write(act);

			return mplew.getPacket();
		}

		public static byte[] getShowCoreGain(int core, int quantity) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.CORE.getValue());
			mplew.write(22); //switch case
			mplew.writeInt(core);
			mplew.writeInt(quantity);

			return mplew.getPacket();
		}

		public static byte[] getWPGain(int wp) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.GAIN_WP.getValue());

			mplew.writeInt(wp);

			return mplew.getPacket();
		}

		public static byte[] showCombo(long exp, int comboSize, int oid) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(35); //Actually not sure here
			mplew.write(1);
			mplew.writeLong(exp + 1);
			mplew.writeInt(comboSize);
			mplew.writeInt(oid);

			return mplew.getPacket();
		}

		public static byte[] showMultiKill(long exp, int kills) {
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();

			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(InfoPacketOpcode.MULTI_KILL.getValue());
			mplew.write(0);
			mplew.writeLong(exp);
			mplew.writeInt(kills);

			return mplew.getPacket();
		}

		public static byte[] showKaiserSkillShortCut(int skill1, int skill2, int skill3) { //some1 fix
			MaplePacketLittleEndianWriter mplew = new MaplePacketLittleEndianWriter();
			mplew.write(SendPacketOpcode.SHOW_STATUS_INFO);
			mplew.write(12); //Who fucking knows man
			mplew.writeShort(52554);
			mplew.writeMapleAsciiString("cmd0=" + skill1 + ";cmd1=" + skill2 + ";cmd2=" + skill3);
			return mplew.getPacket();
		}
	}
