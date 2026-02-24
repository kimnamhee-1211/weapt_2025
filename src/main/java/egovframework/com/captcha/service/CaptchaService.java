package egovframework.com.captcha.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CaptchaService {
	
	public void generateCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws IOException;
	
	public void generateCaptchaAudio(HttpServletRequest request, HttpServletResponse response) throws IOException;
	
	public void refreshCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
