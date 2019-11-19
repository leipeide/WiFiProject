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
<title>Insert title here</title>
</head>
<body>
	<form class="layui-form">
		<!--  隐藏标签，传递参数 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage }">
		<div class="layui-form-item" style="margin-top:10px;">
			<label class="i18n" style="width:130px;margin-left:25px;" name="DimPara"></label>
			<div class="layui-input-block" style="width:130px;margin-left:60px;margin-top:10px;">
				<input class="layui-input" id="text1" type="text" name="percentage" placeholder="0-100"  
					required lay-verify="required" autocomplete="off" onchange="percentCheck(this)">
			</div>
		</div>
		<div class="layui-form-item" style="margin-left:60px;">
			<a class="layui-btn layui-btn-sm" 
				onclick="submitBtn('${pageContext.request.contextPath }/groupDimServlet',${userid },${groupid })">
				<font class="i18n" name="Lsubmit"></font>
			</a>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.加载layui模块
		layui.use('form', function() {
			var form = layui.form;
			
		});

		//2.i18nLanguage为全局变量，是当前系统的语言环境，获取id为hiddenLan的value值，
		var i18nLanguage = jQuery("#hiddenLan").val(); 
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		window.onload = function() {
			jQuery.i18n.properties({
			  	 name : 'common', //资源文件名称,本页面只用到common.properties
			  	 path : 'admin/i18n/', //资源文件路径
			  	 mode : 'both', //用Map的方式使用资源文件中的值
			     language : i18nLanguage,
			     callback : function() {//加载成功后设置显示内容
			             // 第一类：layui的i18n
			             var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
			             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
			            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
			               });
			             // 第二类：layui的button
			             var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为layui-btn的元素
			             insertBtnEle.each(function() {  // 遍历，根据layui-btn元素的 name 获取语言库对应的内容写入
			               jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
			               });
			     	}
			  });
		}
		
		//4.检查调光范围
		function percentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<0){
				obj.value = 0;
			}if(val>100){
				obj.value = 100;
			}
		}
		
		//5.按钮提交函数
		function submitBtn(url,userid,groupid){
			var text1 = jQuery("#text1").val(); //调光百分比
			if(text1 != ""){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	userid: userid,
			            groupid:groupid,
			            percentage:text1,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	 if(datasource > 0){
			        		  layer.msg(datasource + " " +jQuery.i18n.prop('NCmdSuccess'),function(){
				        		 location.reload();
				        	  });
			        	  }else if(datasource == '指令发送失败请检查设备是否离线或分组内无节点'){
			        		  layer.msg(jQuery.i18n.prop('TipDevOfflineOrNoNodes'),function(){
				        		  location.reload();
				        	  });
			        	  }else if(datasource == '提交失败'){
			        		  layer.msg(jQuery.i18n.prop('submitFailed'),function(){
				        		 location.reload();
				        	  });
			        	  }else{
			        	
			        	  }
			        	
			          },
			          error: function() {  
			          	layer.msg(jQuery.i18n.prop('submitFailed'));	
			          	}
			  		});	
			}else{
				layer.msg(jQuery.i18n.prop('DimParaNULL'));
			}
		}
	</script>
</body>
</html>