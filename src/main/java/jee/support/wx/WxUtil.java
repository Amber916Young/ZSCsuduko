package jee.support.wx;

import java.util.Map;
 
import net.sf.json.JSONObject;

 

public class WxUtil {
	
	//此处的appid与wx.config 参数appId一致   微信公众账号提供给开发者的信息，以下同理
	public static String APPID = "wx26ba2a18beab0d74";
//	HoagFKDcsGMVCIY2vOjf9hpARVT-kvFtmo6dHTpRKkU6b1_eCytKkJt4f3vl5QHxz7hOeBBbgvRmDd0Mls3B5Q
	//同上
	public static String SECRET = "eafe1d32eb72a76115a9e04c0788a671";
	
	public static TokenJson getAccess_token(){
 
//		String url = String.format("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET",APPID,SECRET);
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx26ba2a18beab0d74&secret=eafe1d32eb72a76115a9e04c0788a671";
		System.err.println("getAccess_token!!!!!!!!"+url);
		try {
			String result = HttpGetRequest.doGet(url);
			System.out.println("微信服务器获取token:"+result);
			JSONObject rqJsonObject = JSONObject.fromObject(result);
			TokenJson tokenJson = (TokenJson) JSONObject.toBean(rqJsonObject,TokenJson.class);
			return tokenJson;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	
	private static TicketJson getTicket(String token){
		String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token+"&type=jsapi";
		try {
			String result = HttpGetRequest.doGet(url);
			System.out.println("微信服务器获取Ticket:"+result);
			JSONObject rqJsonObject = JSONObject.fromObject(result);
			TicketJson ticket = (TicketJson) JSONObject.toBean(rqJsonObject,TicketJson.class);
			return ticket;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 获取js sdk 认证信息
	* @author 
	* @date
	* @param url
	* @return
	 */
	public static Map<String, String> getSign(String url){
		System.err.println("url是啥？？？"+url );
//		https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=28_tTP1QC11C6IRYVnx9CE06Wtx8UG6OP7vPj9zBeVQEaw0HgpKGe52zsbJI1_sORRZJ0hO-wsXnbBEif_xw8XDLpBL9q27Tnqf2QbAfb5M5p3lAj_2L_q0IeVOeRGNhNLVk0KfCfKrIrsC-RP2BJIaAEALTS&type=jsapi

		//处理token失效的问题
		try {
			long tokenTimeLong = Long.parseLong(WxParams.tokenTime);
			long tokenExpiresLong = Long.parseLong(WxParams.tokenExpires);
			
			//时间差
			long differ = (System.currentTimeMillis() - tokenTimeLong) /1000;
			if (WxParams.token == null ||  differ > (tokenExpiresLong - 1800)) {
				System.out.println("token为null，或者超时，重新获取");
				TokenJson tokenJson = getAccess_token();
				if (tokenJson != null) {
					WxParams.token = tokenJson.getAccess_token();
					WxParams.tokenTime = System.currentTimeMillis()+"";
					WxParams.tokenExpires = tokenJson.getExpires_in()+"";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			TokenJson tokenJson = getAccess_token();
			if (tokenJson != null) {
				WxParams.token = tokenJson.getAccess_token();
				WxParams.tokenTime = System.currentTimeMillis()+"";
				WxParams.tokenExpires = tokenJson.getExpires_in()+"";
			}
		}
 
		//处理ticket失效的问题
		try {
			long ticketTimeLong = Long.parseLong(WxParams.ticketTime);
			long ticketExpiresLong = Long.parseLong(WxParams.ticketExpires);
			
			//时间差
			long differ = (System.currentTimeMillis() - ticketTimeLong) /1000;
			if (WxParams.ticket == null ||  differ > (ticketExpiresLong - 1800)) {
				System.out.println("ticket为null，或者超时，重新获取");
				TicketJson ticketJson = getTicket(WxParams.token);
				if (ticketJson != null) {
					WxParams.ticket = ticketJson.getTicket();
					WxParams.ticketTime = System.currentTimeMillis()+"";
					WxParams.ticketExpires = ticketJson.getExpires_in()+"";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			TicketJson ticketJson = getTicket(WxParams.token);
			if (ticketJson != null) {
				WxParams.ticket = ticketJson.getTicket();
				WxParams.ticketTime = System.currentTimeMillis()+"";
				WxParams.ticketExpires = ticketJson.getExpires_in()+"";
			}
		}
 
		Map<String, String> ret = Sign.sign(WxParams.ticket, url);
		System.out.println("计算出的签名-----------------------");
        for (Map.Entry entry : ret.entrySet()) {
            System.out.println(entry.getKey() + ", " + entry.getValue());
        }
        System.out.println("-----------------------");
        return ret;
	}
 
}