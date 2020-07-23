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
<style type="text/css">
	.functionDiv{
		margin-top:20px; 
		margin-left:30px;
		width:400px;
		height:80px;
	/*  	border:3px solid #000;    */
		
	}
	.selectFunction{
		float:left;
	/*  	border:3px solid #C01C1C;     */
	}
	.paramDiv{
		float:right;
		margin-right:60px;
	/*   	border:3px solid #C01C1C;     */
	}
	.selectFunctionDiv{
	    width:100px;
		margin-top:10px;
		margin-left:30px;
	}
	
	
	.timeDiv{
		height:120px;
		margin-left:30px;
/* 	   	border:3px solid #00695F;     */
	}
	.time{
		width:340px;
		height:50px;
		margin-top:15px;
/* 		border:3px solid #C01C1C;  */
	}
	.date{
		width:340px;
		height:50px;
		margin-top:10px;
/* 		border:3px solid #C01C1C;  */
	}
	.label{
		float:left;
	}
	.dateInput{
	 	margin-right:5px;
	 	float:right;
	}
	.timeInput{
	 	margin-right:110px; 
	 	float:right;
	}
	
	.submit{
/* 		margin-top:10px; */
		margin-left:220px;
	/*    	border:3px solid #C01C1C;     */
	}
</style>
</head>
<body>
	<form class="layui-form">
		<input type="hidden" name="userid" value="${userid }">
		<input type="hidden" name="ployid" value="${ployid }">
		<input type="hidden" id="hiddenLan" value="${i18nLanguage }">
		<div class="content">
			<div class="functionDiv">
				<div class="selectFunction">
					<label class="i18n" name="SelectFunction"></label>
					<div class="selectFunctionDiv">
						<select id="selected" lay-verify="" lay-filter="selected">
						  <option value="switch" class="i18n" name="LSwitch"></option>
						  <option value="dim" class="i18n" name="LDim"></option>
						  <option value="toning" class="i18n" name="LToning"></option>
						</select> 
					</div>
				</div>
				<div class="paramDiv">
					<div class="switchValue" id="switchDiv" style="display:block">
						<label class="i18n" name="SelectSwitchStatus"></label>
						<div style="margin-top:10px;margin-left:40px;">
							<input type="checkbox" id="checkInput" lay-skin="switch" lay-text="ON|OFF" checked>
						</div>
					</div>
					<div class="dimValue" id="dimDiv" style="display:none;">
						<label class="i18n" name="EnterDimPara"></label>
						<div style="margin-top:10px;margin-left:40px;width:80px;">
							<input type="text" id="dimInput" placeholder="0-100" 
								autocomplete="off" class="layui-input" onchange="checkDim(this)">  
						</div>
					</div>
					<div class="dimValue" id="toningDiv" style="display:none;">
						<label class="i18n" name="MoveSlider"></label>
						<div id="colorControlSlide" style="margin-top:30px;margin-left:40px;width:80px;"></div>
					</div>
				</div>
			</div>
			
			<div class="timeDiv">
				<div class="time">
					<label class="label" name="ACmdTime"></label>
					<div class="timeInput">
						<input type="text" id="minutes" required lay-verify="number" placeholder="MM"
							autocomplete="off" style="width: 50px;height:30px;float:right;margin-top:0px;" class="layui-input">
							<div style="float:right; margin-left:5px;"> ：</div>
						<input type="text" id="hours" required lay-verify="number" placeholder="HH"
							value="" autocomplete="off" style="width: 50px;height:30px;float:right;margin-top:0px;" class="layui-input">
					</div>
				</div>
				<div class="date">
					<label class="label" name="PloyDateRange"></label>
					<div class="dateInput">
						<input type="text" id="endDate" required lay-verify="date" placeholder="xxxx/xx/xx"
							value="" autocomplete="off" style="width: 90px;height:30px;float:right;margin-top:0px;" class="layui-input"> 
						<div style="float:right;margin-left:5px;margin-right:5px;"> - </div>
						<input type="text" id="startDate" required lay-verify="date" placeholder="xxxx/xx/xx"
							value="" autocomplete="off" style="width: 90px;height:30px;float:right;margin-top:0px;"  class="layui-input">
					</div>
				</div>	
			</div>
		</div>
		<div class="submit">
			 <a class="layui-btn layui-btn-sm" lay-submit lay-filter=""
			 	onclick="submitBtn('${pageContext.request.contextPath }/addPloyOperateServlet',${userid},${ployid})">
			 	<font class="i18n" name="Lsubmit"></font>
			 </a>
		</div>
	</form>
    <!-- i18n国际化需要的包 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>	
	<script type="text/javascript">
	/*
	* 1.全局变量
	*/
	var toningValue = 0; //初始化调色参数
	var i18nLanguage=jQuery("#hiddenLan").val();
	
	/*
	* 2.加载layui模块
	*/
	layui.use(['element','slider','form','layer'], function(){
		  var element = layui.element;
		  var slider = layui.slider;
		  var form = layui.form;
		  var layer = layui.layer;
		  //2.1监听select，根据select选择值切换功能参数区域
		  form.on('select(selected)', function(data){
			  var switcher = document.getElementById("switchDiv");
		   	  var dim = document.getElementById("dimDiv");
			  var toning = document.getElementById("toningDiv");
			  switch(data.value){
		         case "switch":
		           //切换至开关灯功能
    	            switcher.style.display = "block";
		            dim.style.display = "none";
		            toning.style.display = "none";
			        break;
			     case "dim":
		            //切换至调光功能
			       	switcher.style.display = "none";
		            dim.style.display = "block";
		            toning.style.display = "none";
		            break;
			     case "toning":
		        	//切换至调色功能
			       	switcher.style.display = "none";
			        dim.style.display = "none";
		            toning.style.display = "block";
		        	break;      
		        }
			});    
		  
		  //2.2.调色滑块的使用
		  slider.render({
		    elem: '#colorControlSlide'
		    ,setTips: function(value){ //自定义提示文本
		    	return jQuery.i18n.prop('colorRed')+value+"%";
		  
		     }
		    ,change: function(value){
		    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
	  	    	toningValue = value;
		     }
		  });  
		
	});    
	
	
	/*
	* 3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	*/
    jQuery.i18n.properties({
      	 name : 'common', //资源文件名称,本页面只用到common.properties
      	 path : 'admin/i18n/', //资源文件路径
      	 mode : 'both', //用Map的方式使用资源文件中的值
           language : i18nLanguage,
           callback : function() {//加载成功后设置显示内容
                 // 第一类：class未使用layui的框架；自己命名的i18n
                 var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
                 insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
                	 jQuery(this).html(jQuery.i18n.prop($(this).attr('name')));
                  });
                 //第二类：layui的=labelbutton
	             var insertLabelEle = jQuery(".label"); // 获得所有class为label的元素
	             insertLabelEle.each(function() {  // 遍历，根据label元素的 name 获取语言库对应的内容写入
	            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	              });
       	  }
      }); 
	
  //3.控制调光范围
	function checkDim(obj){
		var val = document.getElementById("dimInput").value;
		//0-100的正则表达式
		var reg = new RegExp("^(\\d|[1-9]\\d|100)$");
		if(!reg.test(val)){
			layui.use(['layer'], function(){
				  var layer = layui.layer;
				  if(val<0){
						obj.value = 0;
				  }else if(val>100){
						obj.value = 100;
				  }
				  layer.msg(jQuery.i18n.prop('100Int'));
				//  layer.msg("请输入0-100以内的整数");
			});
		}
	}
	
	  //4.提交按钮
	  function submitBtn(url,userid,ployid){
			  /*
			  	regDate是日期格式如2019/09/12的判断正则表达式；
			  	^[12]\d{3}/(?:0[1-9]|1[0-2])/(?:0[1-9]|[12][0-9]|30|31)$
				匹配1000/01/01到2999/12/31日之间的日期，具体规则如下：
				1、年是4个数字，月、日是2个数字。
				2、年必须在[1000,2999]内；月必须在[1-12]内，1-9月前须加0，如01；日必须在[1-31]内，1-9日前须加0，如09；
				3、年、月后面必须跟/	
				以为判断2月天数挺麻烦，干脆都改为1-31日
				*/
		      var regDate = /^[12]\d{3}\/(?:0[1-9]|1[0-2])\/(?:0[1-9]|[12][0-9]|30|31)$/;
	 		  var hours = document.getElementById("hours").value; // 小时参数
	 		  var minutes = document.getElementById("minutes").value; // 分钟参数
	 		  var startDate = document.getElementById("startDate").value; // 开始时间范围
	 		  var endDate = document.getElementById("endDate").value; // 结束时间范围
	 		  var myselect = document.getElementById("selected"); //获取select DOM对象
	 		  var index = myselect.selectedIndex; //获取被选中的索引
	 		  var selected = myselect.options[index].value; //获取被选中的值
	 		  var functionStr = ""; //功能种类字符串：switch 、 dim、 toning;
	 		  var value = ""; // 功能对应的参数值
	 		  //把字符串格式转换为日期类,用于比较开始日期与结束日期的大小
	 		  var date= new Date();
	 		  var startTime = new Date(Date.parse(startDate));
	 		  var endTime = new Date(Date.parse(endDate));
	 		 
	 		  //判断时间格式
	 		  if(hours > 23 || hours < 0 || hours == ""){
	 			  	  //HH输入框应遵循小时范围：0-23
	 			      layer.msg(jQuery.i18n.prop('HHInputTip'));
	 			  	  return;
	 	
	 		  }else if(minutes > 59 || minutes < 0 || minutes == ""){
	 			  //MM输入框应遵循分钟范围：0-59
	 			  layer.msg(jQuery.i18n.prop('MMInputTip'));
			  	  return;
	 			  
	 		  }else if(regDate.test(startDate)==false || regDate.test(endDate)==false || startDate == "" || endDate == ""){
	 			  //日期格式不正确，正确格式如：2019/01/01
	 			  layer.msg(jQuery.i18n.prop('DateFormatError'));
			  	  return;
	 			  
	 		  }else if(startTime > endTime){
	 			  //日期格式不正确，开始时间范围大于结束时间范围
	 			  layer.msg(jQuery.i18n.prop('DateRangeError'));
			  	  return;
	 			  
	 		  }else{
	 			  //参数格式均正常，根据switch赋予功能参数和功能字符串
	 			  switch(selected){
	 		         case "switch":
	 		            //切换至开关灯功能，若开关选中了，value值为两种状态：true,false;
	 		           	functionStr = "switch";
	 		         	value = document.getElementById("checkInput").checked;
	 			        break;
	 			     case "dim":
	 		            //切换至调光功能，value为0-100的整数
	 		            functionStr = "dim";
	 		         	value = document.getElementById("dimInput").value;
	 		         	if(value==""){
	 		         		layer.msg(jQuery.i18n.prop('DimParaNULL'));//未输入调光值!
	 		         		return;
	 		         	}else{
	 			            break;
	 		         	}
	 			     case "toning":
	 		        	//切换至调色功能；value为0-100的整数
	 		        	functionStr = "toning";
	 		        	if(toningValue != "0"){
	 		        		value = toningValue.substring(3,(toningValue.length)-1);
	 		        	}else{
	 		        		value = toningValue;
	 		        	}
	 		        	break;      
	 		        }
		 		  jQuery.ajax({
		 				  type:"post",
		 		          url:url,
		 		          data:{
		 		        	//参数
		 		        	userid:userid,
		 		            ployid:ployid,
		 		            functionStr:functionStr,
		 		            paramValue:value,
		 		            hours:hours,
		 		            minutes:minutes,
		 		            startDate:startDate,
		 		            endDate:endDate
		 		          },
		 		          async : true,
		 		          datatype: "String",
		 		          success:function(datasource, textStatus, jqXHR) {
		 		        	  //返回提示
		 		        	 if(datasource == "操作成功"){
		 		        		 layer.msg(jQuery.i18n.prop('SuccessfulOperation'),function(){
			 		        		  location.reload();
			 		        	  });	
		 		        	  }else if(datasource == "操作失败"){
		 		        		 layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
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
		 		          	  layer.msg(jQuery.i18n.prop('submitFailed'));	//提交失败
		 		          	  
		 		          	}
		 		  		});	
	 		 	 }
	  }  
	</script>
</body>
</html>