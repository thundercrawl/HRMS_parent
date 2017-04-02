package hrms.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class GetIpUtil {
	public static String returnIp(){
		String IP = null;
		try{
			InetAddress ia = InetAddress.getLocalHost(); 
			IP= ia.getHostAddress();//获取IP
		}catch(UnknownHostException e){
			e.printStackTrace();
		}
		return IP;
	}
}