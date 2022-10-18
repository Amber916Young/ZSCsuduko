package jee.support.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.security.ntlm.Client;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import com.sun.jersey.api.client.WebResource;


import java.io.File;


//TODO  此功能是删除文件服务器的图片，但是没有完成  请忽略
public class DeleteFileController {

    public String url;

//    public static void main(String[] args){
//        String url="D:\\testfile\\qwe.jpg";
//        boolean an = deleteFile(url);
//        System.err.println(an);
//    }
    /**
     * 删除文件
     * @param filePath（文件完整地址：http://172.16.5.102:8090/upload/1234.jpg）
     * @return
     */
    public static String delete(String filePath){
        try {
            com.sun.jersey.api.client.Client client = new com.sun.jersey.api.client.Client();
            WebResource resource = client.resource(filePath);
            resource.delete();
            return "y";
        } catch (Exception e) {
            e.printStackTrace();
            return "n";
        }
    }


    public static boolean deleteFile(String url){
        boolean flag = false;
        File file = new File(url);
        boolean a =file.isFile();
        boolean b =file.exists();
        if(file.isFile()&&file.exists()){
            file.delete();
            flag = true;
        }
        return flag;
    }
}
