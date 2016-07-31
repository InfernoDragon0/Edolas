/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Administrator
 */
package tools;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import handling.RecvPacketOpcode;

/**
 * 
 * @author Jay
 *
 */ 
@Retention(RetentionPolicy.RUNTIME) 
@Target(ElementType.METHOD)
public @interface PacketHandler {
    RecvPacketOpcode opcode();
}
