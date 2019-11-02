package com.fh.shop.admin.controller.com;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.CannedAccessControlList;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.utils.FileUtil;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@RestController
@RequestMapping("/file")
public class FileController {

    @RequestMapping("/uploadFile")
    @CrossOrigin("*")
    public ServerResponse uploadFile(@RequestParam MultipartFile phonePath, HttpServletRequest request) {
        String originalFilename = phonePath.getOriginalFilename();
        String realPath = request.getServletContext().getRealPath(SystemConstant.FILE_UPLOAD);
        try {
            InputStream inputStream = phonePath.getInputStream();
            String fileName = FileUtil.copyFile(inputStream, originalFilename, realPath);
            return ServerResponse.success(SystemConstant.FILE_UPLOAD+fileName);
        } catch (IOException e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }



    @RequestMapping("/downloadFileALiOSS")
    public ServerResponse downloadFileALiOSS(@RequestParam MultipartFile phonePath , HttpServletRequest request){
        String endpoint = "oss-cn-beijing.aliyuncs.com";
        // 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
        String accessKeyId = "LTAI4Fr9c4F4cUu1HaKsybLh";
        String accessKeySecret = "QiL9IRUepflQawxVSjNiSyHK1Rb88J";
        String bucketName = "lishihui";
        //String  folder ="images/";
        // 创建OSSClient实例。
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
        String originalFilename = phonePath.getOriginalFilename();
        String houzhui=originalFilename.substring(originalFilename.indexOf("."));
        String newfileName=UUID.randomUUID().toString();
        newfileName=newfileName+houzhui;
        ossClient.setBucketAcl(bucketName,CannedAccessControlList.PublicRead);
        try {
            ossClient.putObject(bucketName, newfileName, phonePath.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        ossClient.shutdown();
        return ServerResponse.success("https://"+bucketName+"."+endpoint+"/"+newfileName);
    }


}
