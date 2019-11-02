package com.fh.shop.admin.test;


import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class Mail {
    public static void main(String[] args) throws Exception{
        Properties properties = new Properties();
        properties.put("mail.transport.protocol","smtp");
        properties.put("mail.host","smtp.qq.com");
        properties.put("mail.user","1374232507@qq.com");
        properties.put("mail.from","1374232507@qq.com");
        Session session=Session.getInstance(properties);
        MimeMessage message=new MimeMessage(session);
        message.setSubject("Hellow");
        message.setFrom(new InternetAddress("1374232507@qq.com"));
        message.setContent("<h1>飞狐教育\n" +
                " Hellow</h1>", "text/html;charset=UTF-8");
        message.addRecipients(Message.RecipientType.TO,"1374232507@qq.com");
        Transport transport=session.getTransport();
        transport.connect("1374232507@qq.com","cyhtigfvpnogiibd");
        transport.sendMessage(message,new Address[]{new InternetAddress("1374232507@qq.com")});
        transport.close();
    }
}



