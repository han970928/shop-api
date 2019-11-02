package com.fh.shop.admin.test;

import org.apache.http.HttpEntity;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class HttpclientTest {



    @Test
    public void httpclient() throws IOException {
        CloseableHttpClient client = HttpClientBuilder.create().build();
        HttpPost httpPost = new HttpPost("https://api.netease.im/sms/sendcode.action");
        //传递参数集合
        List<BasicNameValuePair> listBasic=new ArrayList<>();
        //传递header
        httpPost.addHeader("AppKey","541408ee41373593befbbe3d2b3c27fa");
        String nonce=UUID.randomUUID().toString();
        httpPost.addHeader("Nonce",nonce);
        String curTime=System.currentTimeMillis()+"";
        httpPost.addHeader("CurTime",curTime);
        httpPost.addHeader("CheckSum",CheckSumBuilder.getCheckSum("d23d0ea733f7",nonce,curTime));
        //传递的参数
        BasicNameValuePair basicName = new BasicNameValuePair("mobile", "15136302759");
        //将多个参数添加到 数组当中
        listBasic.add(basicName);
        //对参数进行 编码
        UrlEncodedFormEntity urlEncodedFormEntity = new UrlEncodedFormEntity(listBasic,"utf-8");
        //将参数添加到 httpPost 中
        httpPost.setEntity(urlEncodedFormEntity);
        //发送请求
        CloseableHttpResponse response = client.execute(httpPost);
        HttpEntity entity = response.getEntity();
        String s = EntityUtils.toString(entity, "utf-8");
        System.out.println(s);
    }
}
