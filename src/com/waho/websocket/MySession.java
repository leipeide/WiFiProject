package com.waho.websocket;

import java.util.Timer;
import java.util.TimerTask;

import javax.websocket.Session;

public class MySession {
	
	public static final int TIMEOUT = 30; 

	private int timeCount;

	private Session session;

	private Timer timer;

	private Boolean online;

	public MySession(Session session) {
		super();
		//System.out.println("进入session");
		// TODO Auto-generated constructor stub
		this.session = session;
		this.timeCount = 0;
		this.online = true;
		this.setTimer(new Timer());
		//schedule（task，time，period）
		this.getTimer().schedule(new TimerTask() {
			public void run() {
				timeCount++;
				if (timeCount >= TIMEOUT) {
					online = false;
					//System.out.println("servlet置为离线");
					this.cancel();
				}
			}
		}, 1000, 1000);// 毫秒  //为测试时websocket保持长时间连接，修改周期1000*20的值；现在为10分钟内保持长连接
		
	}
	
	
	
	public Boolean getOnline() {
		return online;
	}

	public void setOnline(Boolean online) {
		this.online = online;
	}

	public int getTimeCount() {
		return timeCount;
	}

	public void setTimeCount(int timeCount) {
		this.timeCount = timeCount;
	}

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public Timer getTimer() {
		return timer;
	}

	public void setTimer(Timer timer) {
		this.timer = timer;
	}

	public static int getTimeout() {
		return TIMEOUT;
	}

}
