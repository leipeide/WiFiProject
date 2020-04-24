package com.waho.websocket;

import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

import com.waho.dao.UserDao;
import com.waho.dao.impl.UserDaoImpl;

/**
 * webSocket处理函数
 * author liyan
 */
public class WebSocketUtilHandle {
	
	private static  Logger logger = Logger.getRootLogger();
	
	//定时每天清除用户验证码信息，清除验证码，验证码操作次数清零
	public static void timingClearUserCheckCodeMessage() { 
		System.out.println("进入定时清除用户验证码信息函数");
		logger.info("进入定时清除用户验证码信息函数");
		//3.每天2点半定时清除用户验证码和操作次数
		Date nowTime = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 13); // 控制时
		calendar.set(Calendar.MINUTE,40);    // 控制分
		calendar.set(Calendar.SECOND,0);    // 控制秒
		Date Calendartime = calendar.getTime();//获取日历时间
		if((nowTime.getTime() -  Calendartime.getTime()) >= 0 
				&& (nowTime.getTime() -  Calendartime.getTime() <= 1000*60)) {
			System.out.println("到达清除时间");
			logger.info("到达清除用户验证码信息时间");
			UserDao userDao = new UserDaoImpl();
			String verCode = null;
			int operateNum = 0;
			try {
				
				userDao.clearVercodeAndOpreateNum(verCode,operateNum);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}
	
}
