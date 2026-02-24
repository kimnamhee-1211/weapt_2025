package egovframework.com.util.RSA;

import java.io.IOException;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RSATest {
	private static final Logger LOGGER = LoggerFactory.getLogger(RSATest.class);
	
	/**
     * 공개키 반환
     */
    public void getPublicKey() 
            throws IOException {
        
        try {
            // 세션에서 키 쌍 확인
            KeyPair keyPair = RSAService.generateKeyPair();
            
            PublicKey publicKey = keyPair.getPublic();
            String publicKeyStr = RSAService.getPublicKeyAsString(publicKey);
            
            LOGGER.debug("^o^ [ RSATest : publicKeyStr(공개키) : " + publicKeyStr);
            
            PrivateKey privateKey = keyPair.getPrivate();
            
            String privateKeyStr = RSAService.getPrivateKeyAsString(privateKey);
            
            LOGGER.debug("^o^ [ RSATest : privateKeyStr(비밀키) : " + privateKeyStr);
            
            
        } catch (Exception e) {
        	LOGGER.debug("^o^ [ RSATest : 공개키 생성 중 오류 발생: " + e.getMessage());
        }
    }
    
    /**
     * 데이터 암호화 (서버에서)
     */
    public String encryptData(String publicKeyStr, String inputText) 
            throws IOException {
    	String encryptedText = "";
        try {
//            KeyPair keyPair = (KeyPair) session.getAttribute("keyPair");
            
//            if (keyPair == null) {
//            	LOGGER.debug("^o^ [ RSATest : 키 쌍이 없습니다. 먼저 공개키를 요청하세요.");
//                return;
//            }
            
//            PublicKey publicKey = keyPair.getPublic();
            encryptedText = RSAService.encrypt(inputText, RSAService.getPublicKeyFromString(publicKeyStr));
            
            LOGGER.debug("^o^ [ RSATest : 암호화 text : " + encryptedText);
            
        } catch (Exception e) {
        	LOGGER.debug("^o^ [ RSATest : 암호화 중 오류 발생: " + e.getMessage());
        }
        return encryptedText;
    }
    
    /**
     * 데이터 복호화
     */
    public String decryptData(String publicKeyStr, String encryptedText) 
            throws IOException {
    	String decryptedText = "";
        try {
            decryptedText = RSAService.decrypt(encryptedText, RSAService.getPrivateKeyFromString(publicKeyStr));
            
            LOGGER.debug("^o^ [ RSATest : 복호화 text : " + encryptedText);
        } catch (Exception e) {
        	LOGGER.debug("^o^ [ RSATest : 복호화 중 오류 발생: " + e.getMessage());
        }
        return decryptedText;
    }
}
