package com.fh.shop.admin.utils;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

public class FileUpload {

    // Endpoint以杭州为例，其它Region请按实际情况填写。
    private static String ENDPOINT = "http://oss-cn-beijing.aliyuncs.com";
    // 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
    private static String ACCESSKEYID = "LTAI4Fr9c4F4cUu1HaKsybLh";
    private static String ACCESSKEYSECRET = "QiL9IRUepflQawxVSjNiSyHK1Rb88J";
    private static String BUCKETNAME = "lishihui";
    private static String LOADPATH ="https://lishihui.oss-cn-beijing.aliyuncs.com/";


//上传  文件  / 图片
public static String upload(InputStream inputStream,String fileName){
    String objectName = null;
    String newFileName = null;
    OSS ossClient = null;

    try {
        //文件夹名
        objectName = DateAndString.date2String(new Date(),DateAndString.Y_M_D);
        //文件名
        newFileName = getNewFileName(fileName);
        // 创建OSSClient实例。
        ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);
        // 上传内容到指定的存储空间（bucketName）并保存为指定的文件名称（objectName）。
        ossClient.putObject(BUCKETNAME, objectName+"/"+newFileName,inputStream);
    } catch (OSSException e) {
        e.printStackTrace();
        throw new RuntimeException(e);
    } catch (ClientException e) {
        e.printStackTrace();
        throw new RuntimeException(e);
    } finally {
        if(null != inputStream){
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        if(null !=ossClient){
            // 关闭OSSClient。
            ossClient.shutdown();
        }
    }
return LOADPATH+objectName+"/"+newFileName;
}


//删除 文件 / 图片
public static  void delete(String filePath){
    OSS ossClient = null;
    if(StringUtils.isNotEmpty(filePath)){
    try {
        // 创建OSSClient实例。
        ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);
        //因为传进来的路径是全路径 所以把 域名替换为空  删除时只需要相对路径
        String filePathUri = filePath.replaceFirst(LOADPATH, "");
        // 删除文件。
        ossClient.deleteObject(BUCKETNAME, filePathUri);
    } catch (OSSException e) {
        e.printStackTrace();
       throw  new RuntimeException(e);
    } catch (ClientException e) {
        e.printStackTrace();
        throw  new RuntimeException(e);
    } finally {
        if(null != ossClient){
         // 关闭OSSClient。
            ossClient.shutdown();
        }
    }
    }


}



    //生成新的文件名
public static String getNewFileName(String fileName){
    //判断是否为空
    if(StringUtils.isEmpty(fileName)){
        return "";
    }
    //分割 后缀 获取下标
    int index = fileName.lastIndexOf(".");
    if(index==-1){
        return "";
    }
    //拼接新文件名
    String substring = UUID.randomUUID()+fileName.substring(index);
    return substring;
    }



}
