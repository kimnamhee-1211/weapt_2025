package egovframework.com.util.RSA;

import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import javax.crypto.Cipher;

public class RSAService {
	private static final String ALGORITHM = "RSA";
    private static final String TRANSFORMATION = "RSA/ECB/PKCS1Padding";
    private static final int KEY_SIZE = 2048;
    
    /**
     * RSA 키 쌍 생성
     */
    public static KeyPair generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(ALGORITHM);
        keyPairGenerator.initialize(KEY_SIZE);
        return keyPairGenerator.generateKeyPair();
    }
    
    /**
     * 공개키를 Base64 문자열로 변환
     */
    public static String getPublicKeyAsString(PublicKey publicKey) {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }
    
    /**
     * 개인키를 Base64 문자열로 변환
     */
    public static String getPrivateKeyAsString(PrivateKey privateKey) {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }
    
    /**
     * Base64 문자열을 공개키로 변환
     */
    public static PublicKey getPublicKeyFromString(String publicKeyStr) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(publicKeyStr);
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePublic(spec);
    }
    
    /**
     * Base64 문자열을 개인키로 변환
     */
    public static PrivateKey getPrivateKeyFromString(String privateKeyStr) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(privateKeyStr);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePrivate(spec);
    }
    
    /**
     * 공개키로 암호화
     */
    public static String encrypt(String plainText, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
    
    /**
     * 공개키로 암호화 (문자열 키 사용)
     */
    public static String encrypt(String plainText, String publicKeyStr) throws Exception {
        PublicKey publicKey = getPublicKeyFromString(publicKeyStr);
        return encrypt(plainText, publicKey);
    }
    
    /**
     * 개인키로 복호화
     */
    public static String decrypt(String encryptedText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        return new String(decryptedBytes, "UTF-8");
    }
    
    /**
     * 개인키로 복호화 (문자열 키 사용)
     */
    public static String decrypt(String encryptedText, String privateKeyStr) throws Exception {
        PrivateKey privateKey = getPrivateKeyFromString(privateKeyStr);
        return decrypt(encryptedText, privateKey);
    }
}
