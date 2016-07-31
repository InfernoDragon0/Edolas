/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import client.MapleClient;
import tools.data.input.LittleEndianAccessor;

/**
 * 
 * @author Jay
 *
 */
public class HandlerManager {
    
    public static enum HandlerList {
        LOGIN("net.handling.LoginHandler"); // <------ Define your handlers here!
        
        private String className;
        
        private HandlerList(String className) {
            this.className = className;
        }
        
        public String getClassName() {
            return className;
        }
    }
    
    private static Map<Short, Method> handlers = new HashMap<Short, Method>();

    static {
        try {
            initialize();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private static void initialize() throws ClassNotFoundException {
        int count = 0;
        for (HandlerList handler : HandlerList.values()) {
            Class c = Class.forName(handler.getClassName());
            for (Method method : c.getMethods()) {
                PacketHandler annotation = method.getAnnotation(PacketHandler.class);
                if (annotation != null) {
                    if (isValidMethod(method)) {
                        if (handlers.containsKey(annotation.opcode())) {
                            System.out.println("Duplicate handler for opcode: " + annotation.opcode());
                        } else {
                            count++;
                            handlers.put(annotation.opcode().getValue(), method);
                        }
                    } else {
                        System.out.println("Failed to add handler with method name of: " + method.getName() + " in " + handler.getClassName());
                    }
                }
            }
        }
        System.out.println(count + " handlers loaded");
    }
    
    private static boolean isValidMethod(Method method) {
        Class[] types = method.getParameterTypes();
        return types.length == 2 && types[0].equals(MapleClient.class) && types[1].equals(LittleEndianAccessor.class);
    }

    public static void handle(MapleClient client, short opcode, LittleEndianAccessor slea) {
        Method method = handlers.get(opcode);
        try {
            if (method != null) {
                method.invoke(null, client, slea);
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }
}
