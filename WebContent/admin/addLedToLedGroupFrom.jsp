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
	<form class="layui-form" >
		<!--  隐藏标签，在系统中传递系统当前的语言环境 -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="layui-form-item" style="margin-left:10px;margin-top:15px;">
			<label class="i18n" name="PleaseSelect"></label>
			<c:set var="length" scope="session" value="${ledListSize }" />
			<!-- 无节点，提示 -->
	    	<c:if test="${length == 0}">
				<div style="margin-top:30px;">
					<span class="i18n" name="NoNodeToOperate" style="margin-left:50px;"></span>
				</div>
			</c:if>
			<!-- 存在节点的情况下-->
		    <c:if test="${length != 0}">
				<div class="layui-input-block" style="margin-left:100px;">
					<input type="checkbox" id="checkAll" lay-filter="allChoose" lay-skin="primary" style="layui-input">
					<font id="chooseOrCancel" class="i18n" name="LallCheck"></font></br>
					<c:forEach items="${leds}" var="led">
						<input type="checkbox" name="checkOne" value="${led.mac}" class="layui-input" 
							style="padding-buttom:20px;" lay-skin="primary" title="${led.nodeName}"></br>
					</c:forEach>
				</div>
			</c:if>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm"  
				  onclick="submitBtn('${pageContext.request.contextPath }/addLedToGroupServlet',${groupid})">
				  <font class="i18n" name="Lsubmit"></font>
				</a>
			</div>
		</div>
	</form>
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
	//1.全局变量，当前系统的语言环境
	var i18nLanguage = jQuery("#hiddenLan").val();

	//2.加载layui模块
	layui.use('form', function(){
		  var form = layui.form;
		  //1.监听全选操作
		  form.on('checkbox(allChoose)', function(data){
			  //2.是否被选中，true或者false
			  var array = document.getElementsByName("checkOne");
			  var span = document.getElementById("chooseOrCancel");
			  if(data.elem.checked){//取消全选
				 for(var index=0; index < array.length; index++){
					 array[index].checked=true;
				 }
				 span.innerHTML=jQuery.i18n.prop('Lcancel');
			  }else{//全选
				  for(var index=0; index < array.length; index++){
						 array[index].checked=false;
					 }
				  span.innerHTML=jQuery.i18n.prop('LallCheck');
			  }
			  //3.更新渲染
			  form.render();
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
		             // 第二类：layui的label
		             var insertLabelEle = jQuery(".layui-form-label"); // 获得所有class为layui-form-label的元素
		             insertLabelEle.each(function() {  // 遍历，根据layui-form-label元素的 name 获取语言库对应的内容写入
		                 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		     	}
		  });
	
	//4.提交函数
	function submitBtn(url,groupid){
		var checkboxValue = new Array(); //复选框值
	    var checkboxObj = document.getElementsByName("checkOne");  
		for(var i=0; i< checkboxObj.length; i++){
			if(checkboxObj[i].checked){
			    checkboxValue.push(checkboxObj[i].value);   				
		    }
		}
		if(checkboxValue.length > 0){
			jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		            groupid:groupid,
		            checkboxValue: checkboxValue.join(","),
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	 if(datasource > 0){
		        		  layer.msg(datasource + " " + jQuery.i18n.prop('NAddNodeToGroupSuccess'),function(){
			        		 location.reload();
			        	  });
		        	  }else if(datasource == '添加失败'){
		        		  layer.msg(jQuery.i18n.prop('AddFailure'),function(){
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
			layer.msg(jQuery.i18n.prop('noChooseObj'));
		}
	}	
	</script>
</body>
</html>