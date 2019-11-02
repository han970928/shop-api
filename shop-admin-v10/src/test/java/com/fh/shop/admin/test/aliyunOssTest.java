package com.fh.shop.admin.test;


import com.aliyun.oss.OSSClient;

import java.io.File;
import java.net.URL;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;

public class aliyunOssTest {



    public static void main(String[] args) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String endpoint = "http://oss-cn-beijing.aliyuncs.com";
        String accessKeyId = "LTAI4Fr9c4F4cUu1HaKsybLh";
        String accessKeySecret = "QiL9IRUepflQawxVSjNiSyHK1Rb88J";
        String fileName = "C://Users//李世辉//Pictures//Camera Roll//7.gif";
        String bucketName = "lishihui";
        // 获取文件的后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        // 生成上传文件名
        String finalFileName = System.currentTimeMillis() + "" + new SecureRandom().nextInt(0x0400) + suffixName;
        String objectName = sdf.format(new Date()) + "/" + finalFileName;
        File file = new File(fileName);
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
        ossClient.putObject(bucketName, objectName, file);
        // 设置URL过期时间为1小时。
        Date expiration = new Date(System.currentTimeMillis() + 3600 * 1000);
        // 生成以GET方法访问的签名URL，访客可以直接通过浏览器访问相关内容。
        URL url = ossClient.generatePresignedUrl(bucketName, objectName, expiration);
        ossClient.shutdown();
        System.out.println(url.toString());
    }
}
