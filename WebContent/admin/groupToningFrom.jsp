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
<style>
.bodyDiv{
	margin-top:10px;
	padding-buttom:5px;
/* 	border:5px solid #95E75D; */
}
.colorControlDiv{
	padding-top:5px;
	height:60px;
/* 	border:1px solid #00695F; */
}
.colorControlSlide{
	padding-top:35px;
	width:104px;
 	margin-left:150px; 
/*  	border:5px solid #000;  */
}
.submitDiv{
	padding-top:70px;
	margin-left:170px;
/*  border:1px solid #C01C1C;   */
}
</style>
</head>
<body>
	<from class="layui-form" >
	<!-- 作为隐藏标签，传递当前系统语言环境 -->
	<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
	<div class="bodyDiv">
		<div class="colorControlDiv">
			<div class="layui-form-item">
				<label class="i18n" name="MoveSlider" style="width:180px;margin-left:25%;"></label>
				<div id="colorControlSlide" class="colorControlSlide"></div>
				<label class="RedSpan" name="color-red" style="float:left;margin-left:160px;margin-top:12px;"></label>
				<label class="BlueSpan" name="color-blue" style="float:left;margin-left:35px;margin-top:12px;"></label>
			</div>
		</div>
		<div class="submitDiv">
			<button class="layui-btn layui-btn-sm" 
				 onclick="submitToning('${pageContext.request.contextPath }/groupToningServlet',${groupid },${userid})">
				<font class="i18n" name="Lsubmit"></font>	 
			</button>
		</div>
	</div>
	</from>
	<!-- jquery.min.js与	jquery.i18n.properties.js是i18n国际化需要的插件 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
  		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>			
	<script type="text/javascript" >
	//1.全局变量
	var toningValue = 0; //调色参数初始化
	var i18nLanguage = jQuery("#hiddenLan").val();  //获取id为hiddenLan的value值，i18nLanguage是当前系统的语言环境

	//2.加载layui模块
	layui.use(['element','slider','form','layer'], function(){
		  var element = layui.element;
		  var slider = layui.slider;
		  var form = layui.form;
		  var layer = layui.layer;
		  //2.1.调色滑块的使用
		  slider.render({
		    elem: '#colorControlSlide'
		    ,setTips: function(value){ 
		    	//自定义提示文本
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
		             var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		               });
		             // 第三类：获取class为RedSpan
		             var insertRedEle = jQuery(".RedSpan"); 
		             insertRedEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		             // 第四类：获取class为BlueSpan
		             var insertBlueEle = jQuery(".BlueSpan"); 
		             insertBlueEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		     	}
		  });
	//}
	
	
	//4.led驱动器调光，提交函数
	function submitToning(url,groupid,userid){
		//1.获取调色的占空比
		if(toningValue != "0"){
			//从滑块的文本value%，提取value
			var tonPercentage = toningValue.substring(0,(toningValue.length)-1);
		}else{
			var tonPercentage = toningValue;
		}
		//2.携带参数至servlet
		if(tonPercentage != "" || tonPercentage == 0){
			 jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	groupid: groupid,
			        	userid: userid,
			        	tonPercentage: tonPercentage,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource > 0){
			        		 layer.msg(datasource + " " + jQuery.i18n.prop('NCmdSuccess'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "指令发送失败请检查设备是否离线或分组内无节点"){
			        		 layer.msg(jQuery.i18n.prop('TipDevOfflineOrNoNodes'),function(){
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