package com.yash.vegmart.utilities;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
public class EmailUtil {

    private static final String FROM_EMAIL = "vegmart49@gmail.com";

    private static final String PASSWORD = "tftv gwvf txht ykhh";

    public static void sendEmail(String to, String subject, String body) {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");

        props.put("mail.smtp.port", "587");

        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,

                new Authenticator() {

                    protected PasswordAuthentication getPasswordAuthentication() {

                        return new PasswordAuthentication(FROM_EMAIL, PASSWORD);

                    }

                });

        try {

            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(FROM_EMAIL));

            message.setRecipients(Message.RecipientType.TO,

                    InternetAddress.parse(to));

            message.setSubject(subject);

            message.setText(body);

            Transport.send(message);

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}

