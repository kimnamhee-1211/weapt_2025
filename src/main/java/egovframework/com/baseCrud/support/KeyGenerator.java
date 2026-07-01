package egovframework.com.baseCrud.support;

import egovframework.com.login.model.LoginVO;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;


public class KeyGenerator{

	//pk param set
	public static List<Map<String, Object>> setKeyToParam(List<Map<String, Object>> param,
														  Map<String, Object> rawKey,
														  Map<String, Object> keyValues) {

		List<String> key = (List<String>) rawKey.get("column");
		List<Integer> seqArr = (List<Integer>) rawKey.get("seq");

		if (key == null || seqArr == null) return param;
		if (key.size() != seqArr.size()) return param;

		for(int k = 0 ; k < key.size(); k++){
			int seq = seqArr.get(k);
			if(keyValues == null){
				for(int i = 1 ; i < param.size() + 1; i++){
					param.get(i-1).put(key.get(k), i*seq);

				}
			}else{
				Object val = keyValues.get(key.get(k));
				for(int i = 1 ; i<param.size() + 1; i++){
					Object value;
					if(val == null){
						value =  i*seq;
					}else if (val instanceof Number) {
						value =  ((Number) val).intValue() + (i*seq);
					}else if(val instanceof String){
						try {
							//문자 + 숫자 조합
							if(!((String) val).matches("\\d+")){
								String prefix = (String) ((String) val).replaceAll("[0-9]", "");
								String number = (String) ((String) val).replaceAll("[^0-9]", "");
								int parsed = Integer.parseInt(number);
								value = prefix + String.valueOf(parsed + (i*seq));

							}else{
								//숫자 str
								int parsed = Integer.parseInt(val.toString());
								value = String.valueOf(parsed + (i*seq));
							}
						} catch (Exception e) {
							value = String.valueOf(i*seq);
						}
					}else{
						value =  i*seq;
					}
					param.get(i-1).put(key.get(k), value);
				}
			}
		}

		return param;
	}





	
}
