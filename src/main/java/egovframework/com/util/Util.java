package egovframework.com.util;

import egovframework.com.login.model.LoginVO;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class Util {

	public static String nvlString(Object object) {
		String rtnStr = "";

		if( object == null || "null".equals(object)) {
			rtnStr = "";
		}else {
			rtnStr = object.toString();
		}
		return rtnStr;
	}
	
	public static String upper1(Object object) {
		String rtnStr = "";
		
		if( object == null || "null".equals(object)) {
			rtnStr = "";
		}else {
			rtnStr = object.toString();
			rtnStr = rtnStr.substring(0, 1).toUpperCase() + rtnStr.substring(1);
		}
		
		return rtnStr;	
	}

	
}
