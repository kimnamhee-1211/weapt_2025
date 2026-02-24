package egovframework.com.captcha;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.captcha.service.CaptchaService;

@Controller
public class CaptchaController {
	private static final Logger LOGGER = LoggerFactory.getLogger(CaptchaController.class);
	
	@Resource(name = "captchaService")
	protected CaptchaService captchaService;
	
	@RequestMapping(value = "/captcha")
	public void captcha(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("^o^ [ captcha ] start.");
		
		captchaService.generateCaptchaImage(request, response);
	}
}
