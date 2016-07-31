/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package handling.login.handler;

import client.MapleClient;
import handling.RecvPacketOpcode;
import tools.PacketHandler;
import tools.data.LittleEndianAccessor;
import tools.packet.LoginPacket;

/**
 *
 * @author MaxCloud
 */
public class AuthServer {
    
    @PacketHandler(opcode = RecvPacketOpcode.USE_AUTH_SERVER)
    public static void handling(MapleClient c, LittleEndianAccessor slea) {
        c.getSession().write(LoginPacket.SENDCLIENTSTARTER());
    }
}
