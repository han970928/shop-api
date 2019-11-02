package com.fh.shop.admin.test;

import com.fh.shop.admin.utils.SMSUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.IOException;

public class TestGet {
    @Test
    public void testDemo3(){
        String s = SMSUtil.sentSMS("15136302759");
        System.out.println(s);
    }


    @Test
    public void testDemo2(){
        CloseableHttpClient build =null;
        HttpGet httpGet =null;
        CloseableHttpResponse response =null;
        try {
             build = HttpClientBuilder.create().build();
             httpGet = new HttpGet("http://localhost:8082/brand/queryBrandList.jhtml");
             response = build.execute(httpGet);
            HttpEntity entity = response.getEntity();
            String s = EntityUtils.toString(entity, "utf-8");
            System.out.println(s);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            if(response!=null){
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(httpGet!=null){
                try {
                    httpGet.clone();
                } catch (CloneNotSupportedException e) {
                    e.printStackTrace();
                }
            }
            if(build!=null){
                try {
                    build.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Test
    public void testDemo(){
        CloseableHttpClient build = null;
        HttpGet httpGet =null;
        CloseableHttpResponse response =null;
        try {
            //打开浏览器
             build = HttpClientBuilder.create().build();
             // 输入网址
             httpGet = new HttpGet("https://www.baidu.com");
             //敲回车
             response = build.execute(httpGet);
             // 获取内容
            HttpEntity entity = response.getEntity();
            String s = EntityUtils.toString(entity, "utf-8");
            System.out.println(s);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            if(response!=null){
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(httpGet!=null){
                httpGet.completed();
            }
            if(build!=null){
                try {
                    build.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
              }
            }
        }


    }
