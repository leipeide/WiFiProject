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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
<title></title>
<style>
.colorControlDiv{
	margin-left:24px;
	margin-top:30px;
}
.RedSpan { 
	float:left;
 	margin-left:100px; 
 	margin-top:12px;
 } 
.colorControlSlide {
	width:120px;
 	margin-left:85px; 
  	margin-top:25px; 
}
.BlueSpan {
	float:left;
 	margin-left:40px; 
	margin-top:12px;
/*  border:1px solid #00695F; */
}
</style>
</head>
<body>
	<from class="layui-form"> 
		<!-- 在页面中传递系统当前的语言环境 -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="layui-form-item">
			<label class="i18n" name="CurrPer" style="width:150px;margin-left:15%;"></label>
			<div style="margin-top:15px;width:120px;margin-left:110px;">
				<input class="layui-input" type="text" disabled="true" placeholder=${node.colorPrecentage }%>
			</div>
		</div>
		<div class="colorControlDiv"> 
			<label class="i18n" name="MoveSlider" style="width: 180px; margin-left: 30px;"></label>
			<div class="SlideDiv">
				<div id="colorControlSlide" class="colorControlSlide"></div>
				<label class="RedSpan" name="color-red"></label>
				<label class="BlueSpan" name="color-blue"></label>
			</div>
		<div class="layui-form-item" style="margin-left:120px;margin-top:60px;">
			<a class="layui-btn layui-btn-sm" onclick="submitToning('${pageContext.request.contextPath }/ledNodeToningServlet',${node.id})">
				<font class="i18n" name="Lsubmit"></font></a>
		</div>
	</from>
	<!-- jquery.min.js与	jquery.i18n.properties.js是i18n国际化需要的插件 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
  		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>			
	<script type="text/javascript" >
	//1.全局变量
	var i18nLanguage = jQuery("#hiddenLan").val();  //获取id为hiddenLan的value值，i18nLanguage是当前系统的语言环境
	var toningValue = 0; //初始化滑块的数值,全局变量
	
	//2.加载layui模块
	layui.use(['element','slider','form','layer'], function(){
		  var element = layui.element;
		  var slider = layui.slider;
		  var form = layui.form;
		  var layer = layui.layer;
		  //2.1.调色滑块的使用
		  slider.render({
		    elem: '#colorControlSlide'
		    ,setTips: function(value){ //自定义提示文本
		    	return value+"%";
		     }
		    ,change: function(value){
		    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
	  	    	toningValue = value;
		     }
		  });
		  
	});
	
	//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	jQuery.i18n.properties({
	  	 name : 'common', //资源文件名称,本页面只用到common.properties
	  	 path : 'admin/i18n/', //资源文件路径
	  	 mode : 'both', //用Map的方式使用资源文件中的值
	     language : i18nLanguage,
	     callback : function() {//加载成功后设置显示内容
	             // 第一类：layui的i18n
	             var insertEle = jQuery(".i18n"); // 获得所有class为i18n的元素
	             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
	            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	               });
	             // 第二类：获取class为RedSpan
	             var insertRedEle = jQuery(".RedSpan"); 
	             insertRedEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
	            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	              });
	             // 第三类：获取class为BlueSpan
	             var insertBlueEle = jQuery(".BlueSpan"); 
	             insertBlueEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
	            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                });
	     	}
	  });
	
	//4.led驱动器调光，提交函数
	function submitToning(url,nodeid){
		//从滑块的文本value%，提取value
		if(toningValue != "0"){
			var tonPercentage = toningValue.substring(0,(toningValue.length)-1);
		}else{
			var tonPercentage = toningValue;
		}
		if(toningValue != "" || toningValue == 0){
			 jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	nodeid: nodeid,
			        	tonPercentage: tonPercentage,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource == "指令发送成功"){
			        		 layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "节点离线或节点不存在"){
			        		 layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
	 		        		  	 location.reload();
	 		        	  		});	
			        	  }else if(datasource == "参数不完整"){
			        		  layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
		 		        		  location.reload();
			        		  });	
			        	  }else{
			        		  
			        	  } 
			          },
			          error: function() {  
			          	  layer.msg(jQuery.i18n.prop('cmdSendFail'));	
			          	}
			  		});	
		}else{
			layer.msg(jQuery.i18n.prop('ParaNULL'));	
		}
		
	 }
	</script>
</body>
</html>