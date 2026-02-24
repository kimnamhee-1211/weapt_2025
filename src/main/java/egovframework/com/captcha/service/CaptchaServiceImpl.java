package egovframework.com.captcha.service;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.util.Egov.EgovProperties;
import egovframework.com.util.RSA.RSATest;

@Service("captchaService")
public class CaptchaServiceImpl implements CaptchaService {
	private static final Logger LOGGER = LoggerFactory.getLogger(CaptchaServiceImpl.class);
	
	private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int CAPTCHA_LENGTH = 5;
    private Random random = new Random();

    public void generateCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	
        // 새 CAPTCHA 텍스트 생성
        String captchaText = generateRandomText();
        LOGGER.debug("^o^ [ generateCaptchaImage ] : " + captchaText);
        
        // 이미지 생성
        BufferedImage image = createCaptchaImage(captchaText);
        
        // 캡챠 번호 암호화
        String publicKey = EgovProperties.getProperty("RSA.publicKey");
        RSATest rsaTest = new RSATest();
        String encryptedText = rsaTest.encryptData(publicKey,captchaText);
        
        HttpSession session = request.getSession();
        session.setAttribute("captchaEnc", encryptedText);
        session.setAttribute("captcha_time", System.currentTimeMillis());

        // 응답 설정
        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // 이미지 출력
        ImageIO.write(image, "png", response.getOutputStream());
    }

    public void generateCaptchaAudio(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        HttpSession session = request.getSession();
        String captchaText = (String) session.getAttribute("captcha");
        
        if (captchaText == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "CAPTCHA not found");
            return;
        }

        // 음성 데이터 생성 (WAV 형식)
        byte[] audioData = generateAudioData(captchaText);

        response.setContentType("audio/wav");
        response.setHeader("Cache-Control", "no-cache");
        response.setContentLength(audioData.length);
        
        response.getOutputStream().write(audioData);
    }

    public void refreshCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // AJAX 요청으로 새 CAPTCHA 생성
        String captchaText = generateRandomText();
        HttpSession session = request.getSession();
        session.setAttribute("captcha", captchaText);
        session.setAttribute("captcha_time", System.currentTimeMillis());
        
        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"success\"}");
    }

    private String generateRandomText() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < CAPTCHA_LENGTH; i++) {
            sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }

    private BufferedImage createCaptchaImage(String text) {
        int width = 200;
        int height = 80;
        
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();
        
        // 안티앨리어싱
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        
        // 배경 그라데이션
        GradientPaint gradient = new GradientPaint(0, 0, Color.WHITE, width, height, 
                                                   new Color(240, 240, 255));
        g2d.setPaint(gradient);
        g2d.fillRect(0, 0, width, height);
        
        // 노이즈 라인
        addNoiseLines(g2d, width, height);
        
        // 텍스트 그리기
        drawDistortedText(g2d, text, width, height);
        
        // 노이즈 점
        addNoiseDots(g2d, width, height);
        
        g2d.dispose();
        return image;
    }

    private void drawDistortedText(Graphics2D g2d, String text, int width, int height) {
        Font font = new Font("Arial", Font.BOLD, 28);
        g2d.setFont(font);
        
        FontMetrics fm = g2d.getFontMetrics();
        int totalWidth = fm.stringWidth(text);
        int startX = (width - totalWidth) / 2;
        
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            Graphics2D charG2d = (Graphics2D) g2d.create();
            
            // 랜덤 색상
            Color[] colors = {
                new Color(220, 20, 60),   // Crimson
                new Color(30, 144, 255),  // DodgerBlue
                new Color(50, 205, 50),   // LimeGreen
                new Color(255, 140, 0),   // DarkOrange
                new Color(138, 43, 226)   // BlueViolet
            };
            charG2d.setColor(colors[random.nextInt(colors.length)]);
            
            // 문자 위치
            int charWidth = fm.charWidth(ch);
            int x = startX + (totalWidth * i) / text.length();
            int y = height / 2 + 10 + random.nextInt(20) - 10;
            
            // 회전
            double angle = Math.toRadians(random.nextInt(40) - 20);
            charG2d.rotate(angle, x + charWidth/2, y);
            
            charG2d.drawString(String.valueOf(ch), x, y);
            charG2d.dispose();
        }
    }

    private void addNoiseLines(Graphics2D g2d, int width, int height) {
        g2d.setStroke(new BasicStroke(1.5f));
        for (int i = 0; i < 5; i++) {
            g2d.setColor(new Color(random.nextInt(100) + 100, 
                                  random.nextInt(100) + 100, 
                                  random.nextInt(100) + 100));
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g2d.drawLine(x1, y1, x2, y2);
        }
    }

    private void addNoiseDots(Graphics2D g2d, int width, int height) {
        for (int i = 0; i < 30; i++) {
            g2d.setColor(new Color(random.nextInt(100) + 150, 
                                  random.nextInt(100) + 150, 
                                  random.nextInt(100) + 150));
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            g2d.fillOval(x, y, 2, 2);
        }
    }

    private byte[] generateAudioData(String text) {
        try {
            // 간단한 WAV 헤더와 톤 생성
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            
            int sampleRate = 22050;
            int duration = text.length() * 800; // 각 문자당 800ms
            int numSamples = (int) (sampleRate * duration / 1000.0);
            
            // WAV 헤더 작성
            writeWavHeader(baos, numSamples, sampleRate);
            
            // 각 문자에 대한 톤 생성
            for (int i = 0; i < text.length(); i++) {
                char ch = text.charAt(i);
                double frequency = getFrequencyForChar(ch);
                generateTone(baos, frequency, 600, sampleRate); // 600ms 톤
                generateSilence(baos, 200, sampleRate);         // 200ms 무음
            }
            
            return baos.toByteArray();
            
        } catch (IOException e) {
            // 오류 시 기본 비프음 반환
            return generateDefaultBeep();
        }
    }

    private void writeWavHeader(ByteArrayOutputStream baos, int numSamples, int sampleRate) 
            throws IOException {
        
        int dataSize = numSamples * 2; // 16-bit samples
        int fileSize = dataSize + 36;
        
        // RIFF header
        baos.write("RIFF".getBytes());
        writeInt(baos, fileSize);
        baos.write("WAVE".getBytes());
        
        // Format chunk
        baos.write("fmt ".getBytes());
        writeInt(baos, 16); // chunk size
        writeShort(baos, 1); // PCM format
        writeShort(baos, 1); // mono
        writeInt(baos, sampleRate);
        writeInt(baos, sampleRate * 2); // byte rate
        writeShort(baos, 2); // block align
        writeShort(baos, 16); // bits per sample
        
        // Data chunk
        baos.write("data".getBytes());
        writeInt(baos, dataSize);
    }

    private void writeInt(ByteArrayOutputStream baos, int value) {
        baos.write(value & 0xFF);
        baos.write((value >> 8) & 0xFF);
        baos.write((value >> 16) & 0xFF);
        baos.write((value >> 24) & 0xFF);
    }

    private void writeShort(ByteArrayOutputStream baos, int value) {
        baos.write(value & 0xFF);
        baos.write((value >> 8) & 0xFF);
    }

    private double getFrequencyForChar(char ch) {
        // 문자를 주파수로 매핑 (피아노 음계 기반)
        if (Character.isDigit(ch)) {
            int digit = Character.getNumericValue(ch);
            return 200 + (digit * 50); // 200Hz ~ 650Hz
        } else {
            int letterPos = ch - 'A';
            return 300 + (letterPos * 30); // 300Hz ~ 1080Hz
        }
    }

    private void generateTone(ByteArrayOutputStream baos, double frequency, int durationMs, int sampleRate) {
        int numSamples = (int) (sampleRate * durationMs / 1000.0);
        
        for (int i = 0; i < numSamples; i++) {
            double time = (double) i / sampleRate;
            double amplitude = 0.5 * Math.sin(2 * Math.PI * frequency * time);
            
            // 부드러운 페이드 인/아웃
            if (i < numSamples * 0.1) {
                amplitude *= (double) i / (numSamples * 0.1);
            } else if (i > numSamples * 0.9) {
                amplitude *= (double) (numSamples - i) / (numSamples * 0.1);
            }
            
            short sample = (short) (amplitude * Short.MAX_VALUE);
            baos.write(sample & 0xFF);
            baos.write((sample >> 8) & 0xFF);
        }
    }

    private void generateSilence(ByteArrayOutputStream baos, int durationMs, int sampleRate) {
        int numSamples = (int) (sampleRate * durationMs / 1000.0);
        for (int i = 0; i < numSamples; i++) {
            baos.write(0);
            baos.write(0);
        }
    }

    private byte[] generateDefaultBeep() {
        // 간단한 비프음 생성
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            writeWavHeader(baos, 11025, 22050); // 0.5초
            generateTone(baos, 800, 500, 22050);
        } catch (IOException e) {
            // 최후의 수단으로 빈 배열 반환
            return new byte[0];
        }
        return baos.toByteArray();
    }
}
