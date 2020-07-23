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
	background: url('<%=request.getContextPath()%>/admin/picture/loginbg.jpg')
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

.findEmailInput{ 
	background: url('<%=request.getContextPath()%>/admin/img/蓝色邮箱.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}

.CheckInput{ 
	background: url('<%=request.getContextPath()%>/admin/img/验证码.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
    width:100px;
	height:20px;
    float:left;
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
					<form class="layui-form" action="" method=""> 
						<!-- 用于储存语言类型,在正在项目中传递 -->
						<input type="hidden" id="hiddenLan" name="i18nLanguage">
	 						<div class="layui-form-item">
	 							<div class="layui-input-inline">
<!-- 	 								style="margin-left:75px;" -->
	 								<h1 class="i18n" style="margin-left:12px;width:250px;" name="findPassword"></h1>
	 							</div>
	 						</div>
							<div class="layui-form-item" style="margin-top:40px;">
								<div class="layui-input-inline">
									<input type="text" id="findEmail" class="findEmailInput" 
									 selectname="emailPlaceholder" selectattr="placeholder" 
									 autocomplete="off" required lay-verify="email">
								</div>
							</div>
							<div class="layui-form-item">
								<input type="text" id="Check" class="CheckInput" autocomplete="off" 
									selectname="checkPlaceholder" selectattr="placeholder"
									required lay-verify="required">
								<a id="getCheckCode" class="layui-btn" 
									name="getCode" autocomplete="off" 
									onclick="getCheckCodeFunction()"
									style="float:left;margin-left:10px;width:100px;"></a>
							</div>	
							<div class="layui-form-item">
								<div style="margin-top:20px;"> 
									<a href="javascript:;" class="layui-btn" style="width:263px;" 
										onclick="findPasswordFunction()" name="findPassword"></a>
								</div>
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
		//判断邮箱地址合法正则
		var emailReg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+/;
			
		layui.use(['element','form'], function() {
			var form = layui.form;
			var element = layui.element;
		});
		
		/**
		 * cookie操作
		 */
		var getCookie = function(name, value, options) {
		    if (typeof value != 'undefined') { // name and value given, set cookie
		        options = options || {};
		        if (value === null) {
		            value = '';
		            options.expires = -1;
		        }
		        var expires = '';
		        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
		            var date;
		            if (typeof options.expires == 'number') {
		                date = new Date();
		                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
		            } else {
		                date = options.expires;
		            }
		            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
		        }
		        var path = options.path ? '; path=' + options.path : '';
		        var domain = options.domain ? '; domain=' + options.domain : '';
		        var s = [cookie, expires, path, domain, secure].join('');
		        var secure = options.secure ? '; secure' : '';
		        var c = [name, '=', encodeURIComponent(value)].join('');
		        var cookie = [c, expires, path, domain, secure].join('')
		        document.cookie = cookie;
		    } else { // only name given, get cookie
		        var cookieValue = null;
		        if (document.cookie && document.cookie != '') {
		            var cookies = document.cookie.split(';');
		            for (var i = 0; i < cookies.length; i++) {
		                var cookie = jQuery.trim(cookies[i]);
		                // Does this cookie string begin with the name we want?
		                if (cookie.substring(0, name.length + 1) == (name + '=')) {
		                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
		                    break;
		                }
		            }
		        }
		        return cookieValue;
		    }
		};

		/**
		 * 获取浏览器语言类型
		 * @return {string} 浏览器国家语言
		 */
		var getNavLanguage = function(){
		    if(navigator.appName == "Netscape"){
		        var navLanguage = navigator.language;
		        return navLanguage.substr(0,2);
		    }
		    return false;
		}

		/**
		 * 2.设置语言类型： 默认为英文
		 */
		var i18nLanguage = "en";
		
		/*
		 * 3. 设置一下网站支持的语言种类
		 */
		var webLanguage = ['zh-CN','en'];

		/**
		 * 执行页面i18n方法
		 * @return
		 */ 
		var execI18n = function(){
		    //首先从cookie里获取用户浏览器设备之前选择过的语言类型
		    if (getCookie("userLanguage")) { //调用getCookie
		          i18nLanguage = getCookie("userLanguage");
		    } else {
		    	 // 获取浏览器语言
	             var navLanguage = getNavLanguage(); //调用getNavLanguage
	             if (navLanguage) {
	                // 判断是否在网站支持语言数组里
	                var charSize = $.inArray(navLanguage, webLanguage);
	                if (charSize > -1) {
	                    i18nLanguage = navLanguage;
	                    // 存到缓存中
	                    getCookie("userLanguage",navLanguage);
	                };
	             }else{  //"not navigator"
	                return false;
	             }
		    } 
		    // 需要引入 i18n 文件
		    if (jQuery.i18n == undefined) {
		           return false;
	          };
		    // 重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	        jQuery.i18n.properties({
	        	name : 'common', //资源文件名称,本页面只用到common.properties
	        	 path : 'admin/i18n/', //资源文件路径
	        	 mode : 'both', //用Map的方式使用资源文件中的值
	             language : i18nLanguage,
	             callback : function() {//加载成功后设置显示内容
		               // 第一类：layui的i18n
		               var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		               insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		               // 第四类：layui的email input
		               var Ele1 = jQuery(".findEmailInput");
		               Ele1.each(function() {
		                    var selectAttr = jQuery(this).attr('selectattr');
		                    if (!selectAttr) {
		                        selectAttr = "value";
		                    };
		                    jQuery(this).attr(selectAttr, jQuery.i18n.prop(jQuery(this).attr('selectname')));
		                });
		               // 第5类：layui的验证码input
		               var Ele2 = jQuery(".CheckInput");
		               Ele2.each(function() {
		                    var selectAttr = jQuery(this).attr('selectattr');
		                    if (!selectAttr) {
		                        selectAttr = "value";
		                    };
		                    jQuery(this).attr(selectAttr, jQuery.i18n.prop(jQuery(this).attr('selectname')));
		                });
		               // 第三类：layui的button
			           var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为i18n的元素
			           insertBtnEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
			        	  jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
			           });  
			           
			           // 给隐藏的input赋值，值为语言类型：en/zh—CN
		               jQuery('#hiddenLan').val(i18nLanguage);
	            }  
		   });   
		    
		}

		/*
		 * 4.页面执行加载执行
		 */
		jQuery(function(){
		    //1.执行I18n翻译
		    execI18n();
		    //2.将语言选择默认选中缓存中的值
		   jQuery("#language option[value="+i18nLanguage+"]").attr("selected",true);
		    //3.选择语言
		   jQuery("#language").on('change', function() {
		        var language = jQuery(this).children('option:selected').val();
		        getCookie("userLanguage",language,{
		            expires: 30,
		            path:'/'
		        });
		        location.reload();
		    });
		});
		
		
		//获取验证码
		function getCheckCodeFunction(){
			layui.use(['jquery','layer'], function() {
				var $ = layui.$ //重点处
				,layer = layui.layer;
				
				var emailVal = $("#findEmail").val();
				if(!emailReg.test(emailVal)){ //请输入正确的邮箱
					layer.alert(jQuery.i18n.prop('LerrorEmailFormat'),{
		 	    		title:jQuery.i18n.prop('Lmessage'),
			 	        btn : jQuery.i18n.prop('closeBtn'),
		 		        });
		
				}else{
					 $.ajax({
	                      url:"${pageContext.request.contextPath}/sendVerificationCodeServlet",
	                      data:{
	                    	  'email' : emailVal,
	                    	  
	                    	},
	                      type:"Post",
	                      dataType:"json",
	                      success:function(data){
		                    	var error = data.error;
		                    	if(error == "" || error == null || error == undefined){
		                    		layer.msg(jQuery.i18n.prop('LsendVercode'));
		                    		
		                      	}else if(error == "您今天的次数已超过4次，请明天再操作"){
									layer.alert(jQuery.i18n.prop('LmaxOperateNum'),{
						 	    		title:jQuery.i18n.prop('Lmessage'),
							 	        btn : jQuery.i18n.prop('closeBtn'),
						 		        });
									
								}else if(error == "未查找到用户，该邮箱未注册用户"){
									layer.alert(jQuery.i18n.prop('LnoFindUser'),{
						 	    		title:jQuery.i18n.prop('Lmessage'),
							 	        btn : jQuery.i18n.prop('closeBtn'),
						 		        });
									
								}else{
									
								}
	                      },
	                      error:function(data){
	                    		layer.alert(jQuery.i18n.prop('pleaseReoperate'),{
					 	    		title:jQuery.i18n.prop('Error'),
					 	    		closeBtn: 0,
						 	        btn : jQuery.i18n.prop('closeBtn'),
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
	                    		
	                      }
	                  });
				}
			});
				
		}
		
		
		//找回密码
		function findPasswordFunction(){
			layui.use(['jquery','layer'], function() {
				var $ = layui.$ //重点处
				,layer = layui.layer;
				
				var emailVal = $("#findEmail").val();
				var verCodeVal = $("#Check").val();
				var language = jQuery('#hiddenLan').val();
				
				if(!emailReg.test(emailVal)){ //请输入正确的邮箱
					layer.alert(jQuery.i18n.prop('LerrorEmailFormat'),{
		 	    		title:jQuery.i18n.prop('Lmessage'),
			 	        btn : jQuery.i18n.prop('closeBtn'),
		 		        });
					
				} else if(verCodeVal== "" || verCodeVal  == null){ //验证码为空
					layer.alert(jQuery.i18n.prop('LinputCheckCode'),{
		 	    		title:jQuery.i18n.prop('Lmessage'),
			 	        btn : jQuery.i18n.prop('closeBtn'),
		 		        });
					
				}else{
					 $.ajax({
	                      url:"${pageContext.request.contextPath}/findPasswordServlet",
	                      data:{
	                    	  'email' : emailVal,
	                    	  'verCode' : verCodeVal,
	                    	
	                    	},
	                      type:"Post",
	                      dataType:"json",
	                      success:function(data){
		                    	var error = data.error;
		                    	if(error == "" || error == null || error == undefined){
		                    		//跳转到对应的重新设置密码页面
		                    		var admin = data.user;
		                    		var id = admin.id;
		                    		location.href=
		                    			"${pageContext.request.contextPath}/setPasswordFormServlet?userid="+id+"&language="+language;
		                    		
		                      	}else if(error == "验证码错误"){
									layer.alert(jQuery.i18n.prop('ErrorCheckCode'),{
						 	    		title:jQuery.i18n.prop('Lmessage'),
						 	    		//closeBtn: 0,
							 	        btn : jQuery.i18n.prop('closeBtn'),
						 		        });
									
								}else if(error == "未查找到用户，该邮箱未注册用户"){
									//layer.alert("未查找到用户，该邮箱未注册用户");
									layer.alert(jQuery.i18n.prop('LnoFindUser'),{
						 	    		title:jQuery.i18n.prop('Lmessage'),
						 	    		//closeBtn: 0,
							 	        btn : jQuery.i18n.prop('closeBtn'),
						 		        });
									
								}else{
									
								}
	                      },
	                      error:function(data){
	                    	  layer.alert(jQuery.i18n.prop('pleaseReoperate'),{
					 	    		title:jQuery.i18n.prop('Error'),
					 	    		closeBtn: 0,
						 	        btn : jQuery.i18n.prop('closeBtn'),
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
	                      }
	                  });
				}
			});
			
		}
		
	</script>
</body>
</html>