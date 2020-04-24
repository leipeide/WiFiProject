package com.waho.websocket;

import java.util.Calendar;
import java.util.TimerTask;

import javax.servlet.ServletContext;

import com.waho.dao.PloyOperateDao;
import com.waho.dao.UserDao;
import com.waho.dao.impl.PloyOperateDaoImpl;
import com.waho.dao.impl.UserDaoImpl;

/**
 * 每天0-1点期间进行清除用户验证码和获取验证码操作次数清零
 * 每天0-1点期间进行清除策略操作执行标志位
 * @author liyan
 */
public class MyTask extends TimerTask {
	//以常量C_SCHEDULE_HOUR表示(晚上12点，也即0点)。
	private  static  final  int  C_SCHEDULE_HOUR =  0; 
	//避免第二次又被调度以引起执行冲突，设置了当前是否正在执行的状态标志isRunning
	private  static  boolean  isRunning  =  false;    
	private  ServletContext  context  =  null;    
	

	public  MyTask(ServletContext  context)  {    
	            this.context  =  context;    
	      }    
	
	public  void  run()  {    
	      Calendar  cal  =  Calendar.getInstance();                    
	      if(!isRunning){                                        
	    	  if(C_SCHEDULE_HOUR  ==  cal.get(Calendar.HOUR_OF_DAY))  {                            
	                isRunning  =  true;                                    
	                context.log("开始执行指定任务");    
	               
	                //定时清除用户验证码信息
	                UserDao userDao = new UserDaoImpl();
	       			String verCode = null;
	       			int operateNum = 0; //获取验证码的次数
	       			//定时清除策略操作标志位（策略操作标志位已弃用）
	       		    //PloyOperateDao ployOperateDao = new PloyOperateDaoImpl();
					//int state = 0; //策略操作的执行标志位，0为未执行
	       			try {
	       				
	       				userDao.clearVercodeAndOpreateNum(verCode,operateNum);//清除用户验证码信息
	       			//	ployOperateDao.clearPloyOperateState(state);//清除策略标志位
	       				
	       			} catch (Exception e) {
	       				// TODO Auto-generated catch block
	       				e.printStackTrace();
	       			}
	                   
	                isRunning  =  false;    
	                context.log("指定任务执行结束");                                  
	             }                            
	        }else{    
	            context.log("上一次任务执行还未结束");    
	        }    
	      
	    }    
	      

	

}
