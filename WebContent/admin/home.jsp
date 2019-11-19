<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<title class="i18n" name="LhomeJspTitle"></title>
<style type="text/css">
</style>
</head>
<body class="layui-layout-body">
		<div class="layui-layout layui-layout-admin">
			<div class="layui-header">
				<div class="layui-logo" name="Llogo"></div>
				<!-- 头部区域（可配合layui已有的水平导航） -->
				<ul class="layui-nav layui-layout-left">
					<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LHomePage"
						onclick="location.reload()"></a></li>
					<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LGroupManagement"
						onclick="groupControl('${pageContext.request.contextPath}/groupFromServlet',${result.user.id})"></a></li>
					<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LPloyManagement"
						onclick="ployControl('${pageContext.request.contextPath}/ployFromServlet',${result.user.id})"></a></li>
					<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LWarningMessage"
						onclick="alarmMessage('${pageContext.request.contextPath}/alarmFromServlet',${result.user.id})"></a></li>
					<li class="layui-nav-item"><span id="warnning" class="layui-badge"></span></li>
				</ul>
				<ul class="layui-nav layui-layout-right">
					<li class="layui-nav-item"><a href="javascript:;"> <img
							src="http://t.cn/RCzsdCq" class="layui-nav-img">
								${result.user.username }</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:;" class="i18n" name="LAccountInformation"
								 onclick="um('${pageContext.request.contextPath}/userMessagesPageServlet',${result.user.id})"></a>
							</dd>
							<dd><a class="i18n" name="Lexit" 
								href="${pageContext.request.contextPath}/loginServlet"></a>
							</dd>
						</dl>
					</li>
<%-- 					<li class="layui-nav-item"><a href="${pageContext.request.contextPath}/loginServlet" class="i18n" name="Lexit"></a></li> --%>
				</ul>
			</div>
	
			<div class="layui-side">
				<div class="layui-side-scroll layui-bg-black">
					<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
					<ul class="layui-nav layui-nav-tree" lay-filter="test">
						<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LaddNode" 
							onclick="addNode('${pageContext.request.contextPath}/addNodeFormServlet', ${result.user.id })"></a></li>
						<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LdeleteNode" 
							onclick="removeNodeFunction('${pageContext.request.contextPath}/removeNodeFormServlet', ${result.user.id })"></a></li>
						<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LchangeInternet" 
							onclick="wifiReset('${pageContext.request.contextPath}/wifiResetFormServlet', ${result.user.id })"></a></li>
	 					<li class="layui-nav-item"><a href="javascript:;" class="i18n" name="LclearInternet"
	 						onclick="wifiApModel('${pageContext.request.contextPath}/wifiApFormServlet', ${result.user.id })"></a></li>
					</ul>
				</div>
			</div>
	
			<div class="layui-body">
				<!-- 作为隐藏标签，传递用户id值 -->
				<input type="hidden" id="useridInput" value=${result.user.id }>
				<!-- 作为隐藏标签,用于储存语言类型,在项目中传递 value=${i18nLanguage}-->
				<input type="hidden" id="hiddenLan" name="i18nLanguage" value=${i18nLanguage }>
				<!-- 内容主体区域 -->
				<div style="padding: 15px;" id="body-div">
	 				<iframe style="min-height: 500px;" name="fname" frameborder="0" 
						scrolling="yes" width="100%" height="100%" src="${pageContext.request.contextPath }/welcomeServlet?userid=${result.user.id }&i18nLanguage=${i18nLanguage}"
						class="body-frame"></iframe>
				</div>
			</div>
			<div class="layui-footer">
				<!-- 底部固定区域 -->
				© <font class="i18n" name="Lfooter"></font>
				<!-- © 雷培德WiFi灯控系统 -->
			</div>
		</div>
	<!-- i18n国际化语言包 -->
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/home.js"></script>
	<script type="text/javascript">
	/**
	 * 获取报警数量提示
	 * @returns
	 */
	//A.创建XMLHttpRequest对象,获取“报警”栏信息数量提示
	function getXMLHttpRequest() {
			var xmlhttp;
			if (window.XMLHttpRequest) {
				// code for IE7+,Firefox,Chrome,Opera,Safari
				xmlhttp = new XMLHttpRequest();
			} else {
				// code for IE5,IE6,
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlhttp;
		}
	//B.创建回调函数，根据响应动态更新页面
	function AjaxGetAlarmTipsRequest() {
		//1.创建请求
		var req = getXMLHttpRequest();
		//4.服务器处理
		req.onreadystatechange = function() {
			if (req.readyState == 4) {// 请求成功
				if (req.status == 200) {// 服务器响应成功,动态获取报警信息表格
					var warnningNum = JSON.parse(req.responseText);
					document.getElementById("warnning").innerHTML = warnningNum;
				}
			}
		}
		//1.建立链接
		var userid = document.getElementById("useridInput").value;
		req.open("post","${pageContext.request.contextPath }/getWarnningTipsServlet");
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//2.发送请求
		req.send("userid="+userid);
	}
	window.onload = function() {
		AjaxGetAlarmTipsRequest();  
	}
	setInterval(AjaxGetAlarmTipsRequest,1000*5);  //每隔5秒刷新一下报警的提示数字
	
	</script>
</body>
</html>