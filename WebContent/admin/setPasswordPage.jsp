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
<title></title>
<style>
html {
	background: url('<%=request.getContextPath()%>/admin/img/loginbg.jpg')
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
.main-form-div {
	margin-top: 100px;
}
.main-form-body {
	padding-top: 8%;
	padding-left: 24%;
	padding-right: 10%;
	padding-bottom: 40px;
/* 	border:1px solid #000; */
}

.passwordInput{ 
	background: url('<%=request.getContextPath()%>/admin/img/蓝色密码.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-row main-form-div">
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
			<div class="grid-demo layui-bg-red" style="visibility:hidden">移动：1/12 | 平板：3/12 | 桌面：4/12</div>
		</div>
		<div class="layui-col-xs10 layui-col-sm6 layui-col-md4">
			<div class="grid-demo layui-bg-#F0F0F0">
				<div class="main-form-body">
					<form class="layui-form" action="" method="post">
						<!-- 隐藏标签，传递用户id -->
						<input type="hidden" id="userid" value=${userid }>
						<!-- 用于储存语言类型,在正在项目中传递 -->
						<input type="hidden" id="hiddenLan" name="i18nLanguage" value=${language }>
						<div class="layui-form-item">
	 							<div class="layui-input-inline">
	 								<h1 style="margin-left:48px;width:200px;" class="i18n" name="SetPassword"></h1>
	 							</div>
	 					</div>
						<div class="layui-form-item">
							<div class="layui-input-inline">
								<input type="password" id="password" class="passwordInput"
									selectname="LNewPassword" selectattr="placeholder"
									required lay-verify="required" autocomplete="off">
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-inline">
								<input type="password" id="repassword" class="passwordInput"
									selectname="LComfirmPassword" selectattr="placeholder"
									required lay-verify="required" autocomplete="off" 
									onblur="checkRepassword()">
							</div>
						</div>
						<div class="layui-form-item">
							<button style="width:263px;margin-left:0px;" class="layui-btn" name="Lsubmit"></button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
			<div class="grid-demo layui-bg-red" style="visibility:hidden">移动：1/12 | 平板：3/12 |
				桌面：4/12</div>
		</div>
	</div>
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.全局变量
		var i18nLanguage = jQuery('#hiddenLan').val(); //语言环境
		var userid = jQuery("#userid").val(); //用户id
		//2.初始化layui元素
		layui.use(['element','form'], function() {
			var form = layui.form;
			var element = layui.element;
		});
		//3.进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	    jQuery.i18n.properties({
	    	 name : 'common', //资源文件名称,本页面只用到common.properties
        	 path : 'admin/i18n/', //资源文件路径
        	 mode : 'both', //用Map的方式使用资源文件中的值
             language : i18nLanguage,
             callback : function() {//加载成功后设置显示内容
	               // 第一类：class未使用layui的框架；自己命名的i18n
	               var insertEle =  jQuery(".i18n"); // 获得所有id为i18n的元素
	               insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
	            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                });
	               // 第三类：layui的button
	               var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为i18n的元素
	               insertBtnEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
	            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                });
	               //密码输入框
	                var passwordEle = jQuery(".passwordInput");
	                passwordEle.each(function() {
	                    var selectAttr = jQuery(this).attr('selectattr');
	                    if (!selectAttr) {
	                        selectAttr = "value";
	                    };
	                    jQuery(this).attr(selectAttr, jQuery.i18n.prop(jQuery(this).attr('selectname')));
	                });
	              
           }
        });    
		
		//4.对比两次密码是否一致
		function checkRepassword(){
			layui.use(['jquery','layer'], function() {
				var $ = layui.$ //重点处
				,layer = layui.layer;
				var password = $("#password").val();
				var repassword = $("#repassword").val();
				if(password == "" || repassword == ""){ //密码为空
					layer.alert(jQuery.i18n.prop('passwordPlaceholder'),{
		 	    		title:jQuery.i18n.prop('Lmessage'),
			 	        btn : jQuery.i18n.prop('closeBtn'),
		 		        });
				}else if(password != repassword){ //两次密码不一致，请重新输入
					layer.alert(jQuery.i18n.prop('LTowPasswordDif'),{
		 	    		title:jQuery.i18n.prop('Lmessage'),
			 	        btn : jQuery.i18n.prop('closeBtn'),
		 		        });
					$("#password").attr("value",'');//清空内容
					$("#repassword").attr("value",'');//清空内容S
				}else{
					//提交函数
					 $.ajax({
	                      url:"${pageContext.request.contextPath}/setNewPasswordServlet",
	                      data:{
	                    	  'newPassword' : password,
	                    	  'id' : userid,
	                    	  
	                    	},
	                      type:"Post",
	                      dataType:"json",
	                      success:function(data){
		                    	if(data == "" || data == null || data == undefined){
		                    		//跳转到对应的重新设置密码页面
		                    		layer.alert(jQuery.i18n.prop('passwordSetSuccess'),{//"密码设置成功，请去登录"
		                    			title:jQuery.i18n.prop('Lmessage'),
		                    			closeBtn: 0,
						 	       	 	btn :jQuery.i18n.prop('confirmBtn'),
					 			    	yes : function(index, layero) {
			                    			location.href = "${pageContext.request.contextPath }";
					 		        	},
					 	    		});
		                    		
		                      	}else if(data == "未获取到参数，请重新操作"){
									layer.alert(jQuery.i18n.prop('passwordSetFailed'),{//未获取到参数，密码设置失败
										title:jQuery.i18n.prop('Lmessage'),
										closeBtn: 0,
						 	       	 	btn :jQuery.i18n.prop('confirmBtn')
									 });
									
								}else if(data == "密码设置失败"){
									layer.alert(jQuery.i18n.prop('passwordSetFailed'),{//未获取到参数，密码设置失败
										title:jQuery.i18n.prop('Lmessage'),
										closeBtn: 0,
						 	       	 	btn :jQuery.i18n.prop('confirmBtn')
									 });
								}else{
									
								}
	                      },
	                      error:function(data){
	                    	  layer.alert(jQuery.i18n.prop('submitFailed'),{
					 	    		title:jQuery.i18n.prop('Error'),
					 	    		closeBtn: 0,
						 	        btn : jQuery.i18n.prop('closeBtn'),
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
	                    		$("#password").attr("value",'');//清空内容
	        					$("#repassword").attr("value",'');//清空内容
	                    		
	                      }
	                  });
				}
				
			});
		}
		
	</script>
</body>
</html>