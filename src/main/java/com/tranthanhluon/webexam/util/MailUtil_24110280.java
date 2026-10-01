package com.tranthanhluon.webexam.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.InputStream;
import java.util.Properties;

public class MailUtil_24110280 {
    private static Properties mailProps = new Properties();

    static {
        try (InputStream input = MailUtil_24110280.class.getClassLoader().getResourceAsStream("mail.properties")) {
            if (input != null) {
                mailProps.load(input);
            }
        } catch (Exception e) {
            System.err.println("Could not load mail.properties: " + e.getMessage());
        }
    }

    public static boolean sendOtpEmail(String recipientEmail, String otpCode) {
        String host = mailProps.getProperty("mail.smtp.host", "smtp.gmail.com");
        String port = mailProps.getProperty("mail.smtp.port", "587");
        String user = mailProps.getProperty("mail.user", "");
        String pass = mailProps.getProperty("mail.password", "");

        System.out.println("=================================================");
        System.out.println(" [OTP GENERATED] Email: " + recipientEmail + " | OTP: " + otpCode);
        System.out.println("=================================================");

        if (user.contains("your_email") || pass.contains("your_app_password") || user.isEmpty()) {
            System.out.println("SMTP Email Credentials not configured in mail.properties. Using console log OTP for demo.");
            return true;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user, "WebExam - Trần Thanh Luôn"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Mã OTP xác thực tài khoản WebExamDe05");
            
            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; max-width: 500px;'>"
                    + "<h2 style='color: #0d6efd;'>Xác thực đăng ký tài khoản</h2>"
                    + "<p>Mã OTP kích hoạt tài khoản của bạn tại hệ thống <b>WebExam (Đề Số 05)</b> là:</p>"
                    + "<h1 style='background: #f8f9fa; color: #dc3545; padding: 10px 20px; display: inline-block; letter-spacing: 5px; border-radius: 5px;'>" + otpCode + "</h1>"
                    + "<p>Mã này có hiệu lực trong thời gian xác thực. Vui lòng không chia sẻ mã này cho người khác.</p>"
                    + "<hr style='border: none; border-top: 1px solid #eee;'>"
                    + "<p style='font-size: 12px; color: #6c757d;'>Thực hiện bởi SV: <b>Trần Thanh Luôn</b> - MSSV: <b>24110280</b></p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("OTP Email sent successfully to " + recipientEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to send OTP email: " + e.getMessage());
            return false;
        }
    }
}
