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
<title class="i18n" name="Ltitle"></title>
<style>
html {
	background: url('${pageContext.request.contextPath }/admin/img/loginbg.jpg')
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
	padding-top: 40px;
	padding-left: 10%;
	padding-right: 10%;
	padding-bottom: 40px;
}
.languageDiv{
	margin-top:30px;
	margin-left:80%;
}
.languageSelect{
	margin-top:10px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="languageDiv">
		<div class="languageChange"><span style="font-size:16px; color:red;" class="i18n" name="Lchange"></span></div>
		<div class="languageSelect">
			 <select id="language" style="width:100px;">
                <option value="zh-CN" class="i18n" name="LChinese"></option>
                <option value="en" class="i18n" name="LEnglish"></option>
            </select>
		</div>
	</div>
	<div class="layui-row main-form-div">
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
			<div class="grid-demo layui-bg-red" style="visibility:hidden">移动：1/12 | 平板：3/12 | 桌面：4/12</div>
		</div>
		<div class="layui-col-xs10 layui-col-sm6 layui-col-md4">
			<div class="grid-demo layui-bg-#F0F0F0">
				<div class="main-form-body">
					<form id="login-form" class="layui-form"
						action="${pageContext.request.contextPath }/homeServlet" method="post">
						<!-- 用于储存语言类型,在正在项目中传递 -->
						<input type="hidden" id="hiddenLan" name="i18nLanguage">
						<div class="layui-form-item">
							<label class="layui-form-label"  name="Lusername"></label>
							<div class="layui-input-inline" style="width:220px;">
								<input type="text" id="UserNameInput" name="username" selectname="usernamePlaceholder" selectattr="placeholder" 
									autocomplete="off"  required lay-verify="required" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label"  name="Lpassword"></label>
							<div class="layui-input-inline" style="width:220px;">
								<input type="password" id="PasswordInput" name="password" selectname="passwordPlaceholder" selectattr="placeholder" 
									 autocomplete="off" required lay-verify="required" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit style="margin-left:5px;"
									lay-filter="loginFilter"  name="Llogin"></button>
									 
								<a class="layui-btn" name="Lregister" style="margin-left:62px;"
									href="${pageContext.request.contextPath }/registerServlet" ></a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
			<div class="grid-demo layui-bg-blue" style="visibility:hidden">移动：1/12 | 平板：3/12 |
				桌面：4/12</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		/**
		* 1. 加载layui模块
		*/
		layui.use('form', function() {
			var form = layui.form;
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
		               // 第一类：class未使用layui的框架；自己命名的i18n
		               var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		               insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		               // 第二类：layui的label
		               var insertLabelEle = jQuery(".layui-form-label"); // 获得所有id为i18n的元素
		               insertLabelEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		               // 第三类：layui的button
		               var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为i18n的元素
		               insertBtnEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		               // 第四类：layui的input
		               var insertInputEle = jQuery(".layui-input");
		               insertInputEle.each(function() {
		                    var selectAttr = jQuery(this).attr('selectattr');
		                    if (!selectAttr) {
		                        selectAttr = "value";
		                    };
		                    jQuery(this).attr(selectAttr, jQuery.i18n.prop(jQuery(this).attr('selectname')));
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
	</script>
</body>
</html>