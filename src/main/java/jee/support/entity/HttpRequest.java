package jee.support.entity;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.ByteArrayBody;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class HttpRequest {

	public static String getRemoteIp(HttpServletRequest request){
		String remoteAddr = "";

        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        return remoteAddr;
	}
	
	public static String get(String url) throws Exception {
        String result = "";
        BufferedReader in = null;
        
        try {
            URL realUrl = new URL(url);
            URLConnection connection = realUrl.openConnection();
            
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            
            // 建立实际的连接
            connection.connect();

            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
            
            return result;
            
        }
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
	
	public static String post(String url, String json) throws Exception {
		return post(url,json, ContentType.APPLICATION_JSON);
	}
	
	public static String post(String url, String data, ContentType contentType) throws Exception {

		CloseableHttpClient httpClient = HttpClients.createDefault();
		CloseableHttpResponse response = null;
		String resultString = "";
		
		try {
			HttpPost httpPost = new HttpPost(url);
			StringEntity entity = new StringEntity(data, contentType);
			httpPost.setEntity(entity);

			response = httpClient.execute(httpPost);
			resultString = EntityUtils.toString(response.getEntity(), "utf-8");
			
			return resultString;
		}
		finally {
			try {
				response.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String upload(String url, MultipartFile file, String directory) throws Exception {
		CloseableHttpClient httpClient = HttpClients.createDefault();
		CloseableHttpResponse response = null;
		String resultString = "";
		System.out.println(url);
		try {
			String fileName = file.getOriginalFilename();
	        ContentBody files = new ByteArrayBody(file.getBytes(), fileName);
	        
			MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
	        multipartEntityBuilder.addPart("file", files);
	        multipartEntityBuilder.addTextBody("directory", directory);
	        
	        HttpEntity httpEntity = multipartEntityBuilder.build();
			HttpPost httpPost = new HttpPost(url);
//			System.out.println(httpPost);
			httpPost.setEntity(httpEntity);
			response = httpClient.execute(httpPost);
			resultString = EntityUtils.toString(response.getEntity(), "utf-8");
			return resultString;
		}
		finally {
			try {
				response.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
