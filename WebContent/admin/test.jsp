<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
    <meta charset="UTF-8">
    <title class="i18n" name='title'></title>
      <meta id="i18n_pagename" content="strings_zh_CN-strings_en"> 
<!--      <meta id="i18n_pagename" content="index-common"> -->

</head>
 <body> 
    <div class="lan">
        <div class="lan1"><label class="i18n" name="lan"></label></div>
        <div class="lan2">
            <select id="language">
                <option value="zh-CN">中文简体</option>
                <option value="en">English</option>
            </select>
        </div>
    </div>
    <br>
    <hr>
    <div><label class="i18n" name="hellomsg1"></label><label class="i18n" name="hellomsg2"></label></div><br>
    <div><label class="i18n" name="commonmsg1"></label><label class="i18n" name="commonmsg2"></label></div><br>
    <div>
        <input type="search" class="i18n-input" selectname="searchPlaceholder" selectattr="placeholder">
    </div>
    <script type="text/javascript"
	src="${pageContext.request.contextPath }/admin/js/jquery.js"></script>       
 	<script src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/language.js"></script> --%>
	<script>
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
	 * 设置语言类型： 默认为中文
	 */
	var i18nLanguage = "zh-CN";
	//alert("i18nLanguage:"+i18nLanguage);
	/*
	设置一下网站支持的语言种类
	 */
	var webLanguage = ['zh-CN', 'en'];

	/**
	 * 执行页面i18n方法
	 * @return
	 */ 
	var execI18n = function(){
	    /*
	    获取一下资源文件名
	     */
		alert("判断2");
	    var optionEle = $("#i18n_pagename");
	    if (optionEle.length < 1) {
	        console.log("未找到页面名称元素，请在页面写入\n <meta id=\"i18n_pagename\" content=\"页面名(对应语言包的语言文件名)\">");
	        return false;
	    };
	    var sourceName = optionEle.attr('content');
	    sourceName = sourceName.split('-');
	  //  alert("sourceName:"+sourceName);
	        /*
	        首先获取用户浏览器设备之前选择过的语言类型
	         */
	        if (getCookie("userLanguage")) {
	            i18nLanguage = getCookie("userLanguage");
	            alert("getCookieuserLanguage:"+i18nLanguage);
	        } else {
	            // 获取浏览器语言
	            var navLanguage = getNavLanguage();
	            if (navLanguage) {
	                // 判断是否在网站支持语言数组里
	                var charSize = $.inArray(navLanguage, webLanguage);
	                if (charSize > -1) {
	                    i18nLanguage = navLanguage;
	                   // alert("navLanguage:"+i18nLanguage);
	                    // 存到缓存中
	                    getCookie("userLanguage",navLanguage);
	                };
	            } else{
	                console.log("not navigator");
	                return false;
	            }
	        }
	       // alert(" i18nLanguage:"+ i18nLanguage);
	        /* 需要引入 i18n 文件*/
	      if ($.i18n == undefined) {
	        	//alert("请引入i18n js 文件");
	            console.log("请引入i18n js 文件")
	            return false;
	        };
	     
	        /*
	        这里需要进行i18n的翻译
	         */
	      jQuery.i18n.properties({
	        	 name : 'strings', //资源文件名称
	        	 path : 'i18n/', //资源文件路径
	        	 mode : 'both', //用Map的方式使用资源文件中的值
	             language : i18nLanguage,
	        	 //language : "zh_CN",
	            callback : function() {//加载成功后设置显示内容
	            	//alert(commonmsg1);
	               var insertEle = $(".i18n");
	                console.log(".i18n 写入中...");
	                insertEle.each(function() {
	                	//alert("45");
	                	//alert(lan);
	                    // 根据i18n元素的 name 获取内容写入
	                	//alert($(this).attr('name'));//title,无问题
	                	//alert($.i18n.prop($(this).attr('name')));//此处有问题
	                	$(this).html($.i18n.prop($(this).attr('name')));
	                   // alert("zxf");
	                });
	                console.log("写入完毕");

	                console.log(".i18n-input 写入中...");
	                var insertInputEle = $(".i18n-input");
	                insertInputEle.each(function() {
	                    var selectAttr = $(this).attr('selectattr');
	                    if (!selectAttr) {
	                        selectAttr = "value";
	                    };
	                    $(this).attr(selectAttr, $.i18n.prop($(this).attr('selectname')));
	                });
	                console.log("写入完毕");
	                
	           }
	        
	        });
	        
	}

	//页面执行加载执行
	$(function(){
		alert("判断1");
	    //执行I18n翻译
	    execI18n();

	    /*将语言选择默认选中缓存中的值*/
	    $("#language option[value="+i18nLanguage+"]").attr("selected",true);

	    /* 选择语言 */
	    $("#language").on('change', function() {
	        var language = $(this).children('option:selected').val()
	        console.log(language);
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