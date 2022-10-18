package jee.support.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baidu.ueditor.ActionEnter;

import jee.support.entity.HttpRequest;
import jee.support.entity.JsonUtils;
import jee.support.entity.ResponseModel;
import jee.support.entity.ResultBody;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.util.HashMap;

import java.util.Map;

@Controller
public class UEditorController {


    @Value("${upload.imagesPath}")
    private String theSetDir; //全局配置文件中设置的图片的路径
    // 文件上传路径
    @Resource(name="fileuploadPath")
    private String fileuploadPath;


//    // 文件读取路径
//    @Resource(name="httpPath")
//    private String httpPath="http://localhost:8888/support/";

//    @RequestMapping(value="/ueditor/fileUploadServlet")
//    @ResponseBody
//    public Map<String, Object> fileupload(HttpServletRequest req) {
//        Map<String,Object> result = new HashMap<String, Object>();
//        MultipartHttpServletRequest mReq = null;
//        MultipartFile file = null;
//        InputStream is = null ;
//        String fileName = "";
//        // 原始文件名 UEDITOR创建页面元素时的alt和title属性
//        String originalFileName = "";
//        String filePath = "";
//        try {
//            mReq = (MultipartHttpServletRequest)req;
//        // 从config.json中取得上传文件 的ID
//            file = mReq.getFile("upfile");
//            // 取得文件的原始文件名称
//            fileName = file.getOriginalFilename();
//            originalFileName = fileName;
//            System.out.println("fileName"+fileName);
//
//            String fileuploadPath="http://localhost:8888/support/resource/static/testimg/";
//            System.out.println("fileuploadPath"+fileuploadPath);
//            if(!StringUtils.isEmpty(fileName)){
//                is = file.getInputStream();
//                fileName = FileUtils.reName(fileName);
//                filePath = FileUtils.saveFile(fileName, is, fileuploadPath);//imagePaht 就是文件的存储路径
//            } else {
//                throw new IOException("文件名为空!");
//            }
//            result.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
//            String httpPath = "http://localhost:8888/support/";
//            result.put("url", httpPath+filePath);//httpPath=http://IP:端口/映射名/
//            result.put("title", originalFileName);
//            result.put("original", originalFileName);
//        }
//        catch (Exception e) {
//            System.out.println(e.getMessage());
//            result.put("state", "文件上传失败!");
//            result.put("url","");
//            result.put("title", "");
//            result.put("original", "");
//            System.out.println("文件 "+fileName+" 上传失败!");
//        }
//        System.out.println("文件 "+result);
//        return result;
//    }



    @ResponseBody
    @RequestMapping(value="/ued/uploadImage")
    public Map<String, Object> uploadImage(@RequestParam(value = "upfile", required = false)MultipartFile file,
                                           HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        System.out.println("进入uploadImage里面");
        String url = fileuploadPath ;
        String directory = "allarticles";
        String result = HttpRequest.upload(url,file,directory);
        ResponseModel rm = JsonUtils.jsonToPojo(result,ResponseModel.class);
        String imageUrl="";
        if(rm.getCode()==0){
            imageUrl = rm.getData().toString();
        }else{

        }
        String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
//        int serverPort = request.getServerPort();
//        String serverName = request.getServerName();
//        String path1 = request.getSession().getServletContext().getContextPath();
//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        String uuid = UUID.randomUUID().toString().replaceAll("-","");
//        String imageName=file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
//        String path="/resource/static/upload/" + uuid + "." + imageName;
//        String url ="http://"+serverName+":"+serverPort+path1;
//        file.transferTo(new File(pathRoot+path));


        Map<String, Object> params = new HashMap<String, Object>();
//        params.put("url", url+ path);

        params.put("state", "SUCCESS");
        params.put("url", imageUrl);
        params.put("size", file.getSize());
        params.put("original", imageName);
        params.put("type", file.getContentType());

        return params;
    }

    @ResponseBody
    @RequestMapping(value="/ued/uploadvideo")
    public Map<String, Object> uploadvideo(@RequestParam(value = "upfile", required = false)MultipartFile file,
                                           HttpServletRequest request, HttpServletResponse response) throws Exception {
//        System.out.println("进入uploadvideo里面");
//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        System.out.println("rootPath"+pathRoot);
//        String uuid = UUID.randomUUID().toString().replaceAll("-","");
//        String videoName=file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
//        String path="/resource/static/video/" + uuid + "." + videoName;
//        int serverPort = request.getServerPort();
//        String serverName = request.getServerName();
//        String path1 = request.getSession().getServletContext().getContextPath();
//        String url ="http://"+serverName+":"+serverPort+path1;
//        file.transferTo(new File(pathRoot+path));

        String url = fileuploadPath ;
        String directory = "video";
        String result = HttpRequest.upload(url,file,directory);
        ResponseModel rm = JsonUtils.jsonToPojo(result,ResponseModel.class);
        String imageUrl="";
        if(rm.getCode()==0){
            imageUrl = rm.getData().toString();
        }else{
            System.out.println("上传视频有错");
        }
        String videoName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);


        Map<String, Object> params = new HashMap<String, Object>();
        params.put("state", "SUCCESS");
        params.put("url", imageUrl);
        params.put("size", file.getSize());
        params.put("original", videoName);
        params.put("type", file.getContentType());

        return params;
    }

    @RequestMapping(value="/ued/config")
    public void config(HttpServletRequest request , HttpServletResponse response){
        System.out.println("进入uerditorConfig里面");
        response.setContentType("application/json");
//        String rootPath = ClassUtils.getDefaultClassLoader().getResource("").getPath()+"resource/static/ueditor/jsp";
        String rootPath=request.getServletContext().getRealPath("/resource/static/ueditor");
        System.out.println("rootPath"+rootPath);
        try {
            String exec = new ActionEnter(request, rootPath).exec();
            PrintWriter writer = response.getWriter();
            writer.write(exec);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}
