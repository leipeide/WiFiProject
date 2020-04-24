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
</head>
<body class="layui-layout-body">
	<form class="layui-form" action="" method="">
		<input type="hidden" id="nodeid" name="nodeid" value="${nodeObj.id}">
		<!-- 用于储存语言类型,在正在项目中传递 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage}">
		<div class="layui-form-item" style="margin-top:10px;">
			<label class="i18n" style="width:130px;margin-left:25px;" name="DimPara"></label>
			<div class="layui-input-inline" style="width:130px;margin-left:60px;margin-top:10px;">
				<!-- 两种类型的节点调光范围不一样，用户if进行判断，进入不同调光范围的input -->
				<c:set var="nodeType" value="${nodeObj.type}"/>
					<!-- 镇流器类型节点调光范围是50-100 -->
  					<c:if test="${nodeType < 11}"> 
						<input type="text" id="text1" name="percentage" placeholder="50-100" 
							autocomplete="off"  required lay-verify="required" class="layui-input" 
							onchange="halfpercentCheck(this)">
					</c:if>
					<c:if test="${nodeType >= 11}"> 
						<c:if test="${nodeType < 21}"> 
							<input type="text" id="text2" name="percentage" placeholder="0-100" 
							autocomplete="off"  required lay-verify="required" class="layui-input" 
							onchange="percentCheck(this)">
						</c:if>
					</c:if>
			</div>
		</div>			
		<div class="layui-form-item" style="margin-left:57px;">
			<!-- 注意：此处不能使用button,因为form表单button提交后，会主动刷新页面，此时i18nLanguage无法获取 -->
				<a class="layui-btn layui-btn-sm" onclick="submitFunction('${pageContext.request.contextPath}/dimNodeServlet')">
					<font class="i18n" name="Lsubmit"></font>
				</a>					
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.全局变量
		var i18nLanguage = jQuery("#hiddenLan").val();  //获取id为hiddenLan的value值，是当前系统的语言环境
		var DimPercentage = ""; //全局变量，调光参数百分比
		
		//2.加载layui表单模块
		layui.use('form', function() {
			var form = layui.form;
			
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
		     	}
		  });
		
		//4.控制设置调光pwm输入框调光范围0-100
		function percentCheck(obj){
			var val = document.getElementById("text2").value;
			if(val<0){
				obj.value = 0;
			}if(val>100){
				obj.value = 100;
			}
			DimPercentage = document.getElementById("text2").value;
		}
		
		//5.控制设置调光范围PWM 50-100
		function halfpercentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<50){
				obj.value = 50;
			}if(val>100){
				obj.value = 100;
			}
			DimPercentage = document.getElementById("text1").value;	
		}
		
		//6.提交函数
		function submitFunction(url){
			var nodeId = jQuery("#nodeid").val(); //节点id
			if(DimPercentage != ""){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			            nodeid: nodeId,
			            percentage:DimPercentage ,
			          },
			          async : true,
			          datatype: "json",
			          success:function(datasource, textStatus, jqXHR) {
			        	 if(datasource == '指令发送成功'){
			        		  layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
				        		 location.reload();
				        	  });
			        	  }else if(datasource == '指令发送失败请检查设备是否已离线'){
			        		  layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
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

