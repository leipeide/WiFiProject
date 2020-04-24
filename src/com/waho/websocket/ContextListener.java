package com.waho.websocket;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 项目一启动通过监视器该类启动，
 * 此后每一小时调度一次myTask任务，
 * 进行定时清除用户验证信息，清除策略操作执行标志位
 * @author liyan
 */
public class ContextListener implements ServletContextListener{
    private  java.util.Timer  timer  =  null; 
    
    public  void  contextInitialized(ServletContextEvent  event)  {    
            timer  =  new  java.util.Timer(true);  
            event.getServletContext().log("定时器已启动");   
            //每小时调度一次任务MyTask
            timer.schedule(new MyTask(event.getServletContext()),  0,  60*60*1000); 
            event.getServletContext().log("已经添加任务调度表");    
       }       
    
    public  void  contextDestroyed(ServletContextEvent  event)  {    
            timer.cancel();    
            event.getServletContext().log("定时器销毁");    
    }    
}
