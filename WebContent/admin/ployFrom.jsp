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
<style>
/* 
 *重要： layui-layout-body的overflow属性layui框架自带的是hidden; 
 *当页面内容超出页面时，内容被修剪，故自己设置overflow属性为auto  
 */
  .layui-layout-body{ 
	 	overflow:auto; 
  }
.functionDiv{
/* 	border:3px solid #00695F;     */
	height:40px; 
}
.addPloyDiv{
	float:left;
}
.selectPloyDiv{
	float:left;
	margin-left:20px;
	width:110px;
	height:50px;
/* 	border:3px solid #00695F; */
	}
.tableDiv{
/*   
order:3px solid #00695F;      */
}
</style> 
</head>
<body class="layui-layout-body">
	<form class="layui-form">
		<%--  作为隐藏标签,用于储存语言类型,在项目中传递  --%>
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
			<ul class="layui-tab-title">
				<li class="layui-this" name="BallastPloy" lay-id="ballastPloy"></li> 
				<li class="i18n" name="LedPloy" lay-id="ledDriverPloy"></li>
				<li class="i18n" name="LWWDPloy" lay-id="wifiPloy"></li> 
			</ul>
			
			<div class="layui-tab-content">
				<%-- 1.Tab镇流器策略控制区域 --%>
				<div class="layui-tab-item layui-show" id="ballastPloy_table">
					<div class="functionDiv1"> 
						<div class="addPloyDiv">
							<a href="javascript:;" class="layui-btn"
								onclick="newBallastPloy('${pageContext.request.contextPath }/newPloyFromServlet',${userid})">
								<span class="i18n" name="AddPloy"></span>
								</a>
						</div>
						<div class="selectPloyDiv">
							<select name="selectFilter" lay-filter="BallastPloySelect">
								<option value="allPloy" class="i18n" name="AllPloy"></option>
								<c:forEach items="${result.ballastPloy}" var="ballastPloy">
									<option value=${ballastPloy.id }>${ballastPloy.ployName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv">
						<div id="allPloyTableDiv1" style="display: block">
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="200">
									<col width="200">
									<col width="200">
									<col width="200">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="BoundGroup"></th>
										<th class="i18n" name="DoState"></th>
										<th class="i18n" name="AddOperation"></th>
										<th class="i18n" name="EditStrategy"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${result.ballastPloy}" var="ballastPloy">
										<tr>
											<td><a href="javascript:;"
												onclick="ployRename('${pageContext.request.contextPath }/ployRenameFromServlet',${userid},${ballastPloy.id})">
													<font color="#009688">${ballastPloy.ployName}</font>
											</a></td>
											<td><a href="javascript:;"
												onclick="groupMessage('${pageContext.request.contextPath }/groupMessageServlet',${userid},${ballastPloy.groupid})">
													<font color="#009688">${ballastPloy.groupid}</font>
											</a></td>
											<td>${ballastPloy.runState == 0 ? "Stoped" : "Running"}</td>
											<td><a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="addOperate('${pageContext.request.contextPath }/addBallastPloyOperateFormServlet',${userid},${ballastPloy.id},${ballastPloy.runState})">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><div class="layui-btn-container">
											    <a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="BallastPloyChangeGroup('${pageContext.request.contextPath }/ployChangeGroupFormServlet',${userid},${ballastPloy.id},${ballastPloy.groupid},${ballastPloy.runState })">
														<i class="layui-icon">&#xe642;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloy('${pageContext.request.contextPath }/deletePloyServlet',${userid},${ballastPloy.id},${ballastPloy.runState})">
														<i class="layui-icon">&#xe640;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="runPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ballastPloy.id},${userid })">
														<span class="i18n" name="DoPloy"></span>
												</a> 
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="stopPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ballastPloy.id},${userid })">
														<span class="i18n" name="StopPloy"></span>
												</a>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div> 
						
						<%-- 单个策略内操作表格 --%>
						<div id="onePloyTableDiv1" style="display: none">
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="180">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="OperationType"></th>
										<th class="i18n" name="LParam"></th>
										<th class="i18n" name="PloyDateRange"></th>
										<th class="i18n" name="CmdTime"></th>
										<th class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="tbody1">
									<%-- 	<c:forEach items="${}" var=""> 
											<tr>
												<td>策略名称</td>
												<td>1</td>
												<td>0</td>
												<td>2019/8/9-2019/9/9</td>
												<td>12:00</td>
												<td><a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet',)">
														<i class="layui-icon">&#xe640;</i>
												</a></td>
											</tr>
										 </c:forEach> --%>
								</tbody>
							</table>
						</div>
					</div>
				</div> 
			<%-- 2.Tab led驱动器策略控制区域 --%>
				<div class="layui-tab-item" id="ledPloy_table">
					<div class="functionDiv"> 
						<div class="addPloyDiv">
							<a href="javascript:;" class="layui-btn"
								onclick="newLedPloy('${pageContext.request.contextPath }/newPloyFromServlet',${userid})">
								<span class="i18n" name="AddPloy"></span>
								</a>
						</div>
						<div class="selectPloyDiv">
							<select name="selectFilter" lay-filter="select">
								<option value="allPloy" class="i18n" name="AllPloy"></option>
								<c:forEach items="${result.ledPloy}" var="ledPloy">
									<option value=${ledPloy.id }>${ledPloy.ployName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv">
						<div id="allPloyTableDiv" style="display: block">
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="200">
									<col width="200">
									<col width="200">
									<col width="200">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="BoundGroup"></th>
										<th class="i18n" name="DoState"></th>
										<th class="i18n" name="AddOperation"></th>
										<th class="i18n" name="EditStrategy"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${result.ledPloy}" var="ledPloy">
										<tr>
											<td><a href="javascript:;"
												onclick="ployRename('${pageContext.request.contextPath }/ployRenameFromServlet',${userid},${ledPloy.id})">
													<font color="#009688">${ledPloy.ployName}</font>
											</a></td>
											<td><a href="javascript:;"
												onclick="groupMessage('${pageContext.request.contextPath }/groupMessageServlet',${userid},${ledPloy.groupid})">
													<font color="#009688">${ledPloy.groupid}</font>
											</a></td>
											<td>${ledPloy.runState == 0 ? "Stoped" : "Running"}</td>
											<td><a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="addOperate('${pageContext.request.contextPath }/addPloyOperateFormServlet',${userid},${ledPloy.id},${ledPloy.runState})">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><div class="layui-btn-container">
											    <a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="ledPloyChangeGroup('${pageContext.request.contextPath }/ployChangeGroupFormServlet',${userid},${ledPloy.id},${ledPloy.groupid},${ledPloy.runState })">
														<i class="layui-icon">&#xe642;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloy('${pageContext.request.contextPath }/deletePloyServlet',${userid},${ledPloy.id},${ledPloy.runState})">
														<i class="layui-icon">&#xe640;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="runPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">
														<span class="i18n" name="DoPloy"></span>
												</a> 
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="stopPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">
														<span class="i18n" name="StopPloy"></span>
												</a>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<%-- 单个策略内操作表格 --%>
						<div id="onePloyTableDiv" style="display: none">
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="180">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="OperationType"></th>
										<th class="i18n" name="LParam"></th>
										<th class="i18n" name="PloyDateRange"></th>
										<th class="i18n" name="CmdTime"></th>
										<th class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="tbody2">
									<%-- 	<c:forEach items="${}" var=""> 
											<tr>
												<td>策略名称</td>
												<td>1</td>
												<td>0</td>
												<td>2019/8/9-2019/9/9</td>
												<td>12:00</td>
												<td><a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet',)">
														<i class="layui-icon">&#xe640;</i>
												</a></td>
											</tr>
										 </c:forEach> --%>
								</tbody>
							</table>
						</div>
					</div> 
				</div> 
				<%--wifi无线调光器策略控制Tab选项区域 --%>
				<div class="layui-tab-item" id="wifiPloy_table">
 					<div class="functionDiv">  
						<div class="addPloyDiv">
 							<a href="javascript:;" class="layui-btn"
								onclick="newWifiPloy('${pageContext.request.contextPath }/newPloyFromServlet',${userid})">
								<span class="i18n" name="AddPloy"></span>
								</a>
						</div>
						<div class="selectPloyDiv">
							<select name="selectFilter" lay-filter="wifiSelect">
								<option value="allPloy" class="i18n" name="AllPloy"></option>
								<c:forEach items="${result.wifiPloy}" var="wifiPloy">
									<option value=${wifiPloy.id }>${wifiPloy.ployName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv"> 
						<div id="allPloyTableDiv3" style="display: block">
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="200">
									<col width="200">
									<col width="200">
									<col width="200">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="BoundGroup"></th>
										<th class="i18n" name="DoState"></th>
										<th class="i18n" name="AddOperation"></th>
										<th class="i18n" name="EditStrategy"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${result.wifiPloy}" var="wifiPloy">
										<tr>
											<td><a href="javascript:;"
												onclick="ployRename('${pageContext.request.contextPath }/ployRenameFromServlet',${userid},${wifiPloy.id})">
													<font color="#009688">${wifiPloy.ployName}</font>
											</a></td>
											<td><a href="javascript:;"
												onclick="groupMessage('${pageContext.request.contextPath }/groupMessageServlet',${userid},${wifiPloy.groupid})">
													<font color="#009688">${wifiPloy.groupid}</font>
											</a></td>
											<td>${wifiPloy.runState == 0 ? "Stoped" : "Running"}</td>
											<td><a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="addOperate('${pageContext.request.contextPath }/addWifiPloyOperateFormServlet',${userid},${wifiPloy.id},${wifiPloy.runState})">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><div class="layui-btn-container">
											    <a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="wifiPloyChangeGroup('${pageContext.request.contextPath }/ployChangeGroupFormServlet',${userid},${wifiPloy.id},${wifiPloy.groupid},${wifiPloy.runState })">
														<i class="layui-icon">&#xe642;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloy('${pageContext.request.contextPath }/deletePloyServlet',${userid},${wifiPloy.id},${wifiPloy.runState})">
														<i class="layui-icon">&#xe640;</i>
												</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="runPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${wifiPloy.id},${userid })">
														<span class="i18n" name="DoPloy"></span>
												</a> 
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="stopPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${wifiPloy.id},${userid })">
														<span class="i18n" name="StopPloy"></span>
												</a>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<%--  单个策略内操作表格 --%>
						<div id="onePloyTableDiv3" style="display: none"> 
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="180">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th class="i18n" name="PolicyName"></th>
										<th class="i18n" name="OperationType"></th>
										<th class="i18n" name="LParam"></th>
										<th class="i18n" name="PloyDateRange"></th>
										<th class="i18n" name="CmdTime"></th>
										<th class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="tbody3">
									<%-- 	<c:forEach items="${}" var=""> 
											<tr>
												<td>策略名称</td>
												<td>1</td>
												<td>0</td>
												<td>2019/8/9-2019/9/9</td>
												<td>12:00</td>
												<td><a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet',)">
														<i class="layui-icon">&#xe640;</i>
												</a></td>
											</tr>
										 </c:forEach> --%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
		//1.全局变量
	    var ployid = ""; //用于储存策略id,传递到单个策略信息的页面中
	    var i18nLanguage = jQuery("#hiddenLan").val();//获取id为hiddenLan的value值，是当前系统的语言环境
	//	var ployType = "";//全局变量，策略类型,默认为1；用于刷新策略下的节点信息页面；根据分组类型选择相应的刷新节点信息函数
	   
		//2.加载layui模块
		layui.use(['element','form'], function(){
			  var element = layui.element;
			  var form = layui.form;
			  //2.1.监听Tab选项卡
			  var layid = location.hash.replace(/^#TabBrief=/, ''); //.获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
			  element.tabChange('TabBrief', layid); //.切换到lay-id对应的tab选项
			  element.on('tab(TabBrief)', function(){  //.监听Tab切换，以改变地址hash值s
			  location.hash = 'TabBrief='+ this.getAttribute('lay-id');
			 
			  });
			  //2.2.监听LEDselect;触发了select选择查看策略
			  form.on('select(BallastPloySelect)',function(data){
				  if(data.value == "allPloy"){ //返回所有策略的页面
					  document.getElementById("onePloyTableDiv1").style.display = "none";
					  document.getElementById("allPloyTableDiv1").style.display = "block";
					  //注意：确认此次是否要更新
				  }else{//进入单个策略内的策略操作页面
					  document.getElementById("onePloyTableDiv1").style.display = "block";
					  document.getElementById("allPloyTableDiv1").style.display = "none";
					  ployid = data.value;
					  IntoBallastPloyOperateTable(ployid);
					  //每隔一分钟刷新单个策略操作表格;定时刷新问题需要解决
					  //暂定策略页面不刷新，该页面不涉及到节点的信息；
					  //setInterval(WelcomeAJAXRequest,1000*3);
				  }
			  });
			  //2.2.监听LEDselect;触发了select选择查看策略
			  form.on('select(select)',function(data){
				  if(data.value == "allPloy"){ //返回所有策略的页面
					  document.getElementById("onePloyTableDiv").style.display = "none";
					  document.getElementById("allPloyTableDiv").style.display = "block";
					  //注意：确认此次是否要更新
				  }else{//进入单个策略内的策略操作页面
					  document.getElementById("onePloyTableDiv").style.display = "block";
					  document.getElementById("allPloyTableDiv").style.display = "none";
					  ployid = data.value;
					  IntoLEDPloyOperateTable(ployid);
					  //每隔一分钟刷新单个策略操作表格;定时刷新问题需要解决
					  //暂定策略页面不刷新，该页面不涉及到节点的信息；
					  //setInterval(WelcomeAJAXRequest,1000*3);
				  }
			  });
			  //2.2.监听wifiSelect;触发了select选择查看无线调光器策略
			  form.on('select(wifiSelect)',function(data){
				  if(data.value == "allPloy"){ //返回所有策略的页面
					  document.getElementById("onePloyTableDiv3").style.display = "none";
					  document.getElementById("allPloyTableDiv3").style.display = "block";
					  //注意：确认此次是否要更新
				  }else{//进入单个策略内的策略操作页面
					  document.getElementById("onePloyTableDiv3").style.display = "block";
					  document.getElementById("allPloyTableDiv3").style.display = "none";
					  ployid = data.value;
					  IntoWifiPloyOperateTable(ployid);
					  //每隔一分钟刷新单个策略操作表格;定时刷新问题需要解决
					  //暂定策略页面不刷新，该页面不涉及到节点的信息；
					  //setInterval(WelcomeAJAXRequest,1000*3);
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
	                 // 第一类：class未使用layui的框架；自己命名的i18n
	                 var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
	                 insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
	                	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                	// alert(jQuery.i18n.prop(jQuery(this).attr('name')));
	                 });
	             
	             	 // 第二类：layui-this
		             var tabEle = jQuery(".layui-this"); // 获得所有class为layui-this的元素
		             tabEle.each(function() {  // 遍历，根据layui-this元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
	       	  }
	      }); 
	    
	  //4.ajax获取单个镇流器策略里的操作集合，并将数据动态插入到第2个table中
		function IntoBallastPloyOperateTable(ployid){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getPloyOperateServlet",
		          data:{
		        	//参数
		        	ployid:ployid
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var operate = "";
		        	  inner = "";
		        	  for(var index=0; index < json.length; index++){
		        		  operate = json[index];
		        		  var startDate = new Date(operate.startDate);//毫秒数转换成时间
		        		  var endDate = new Date(operate.endDate);//毫秒数转换成时间
		        		  var year1 = startDate.getFullYear();
		        		  var year2 = endDate.getFullYear();
		        		  var month1 = startDate.getMonth() + 1;
		        		  var month2 = endDate.getMonth() + 1;
		        		  var date1 = startDate.getDate();
		        		  var date2 = endDate.getDate();
		        		  inner = inner + "<tr><td>" + operate.ployName + "</td>\
								<td>";
								if (operate.operateType == 1) {
									//inner = inner + "开关灯";
									inner = inner + jQuery.i18n.prop('SwitchLamp');
								} else if(operate.operateType == 2){
									//inner = inner + "调光";
									inner = inner + jQuery.i18n.prop('aDim');
								} 
								inner = inner + "</td>\
								<td>";
								if (operate.operateParam == 0 && operate.operateType == 1) {
									inner = inner + "OFF";
								} else if(operate.operateType == 1){
									inner = inner + "ON";
								} else{
									inner = inner + operate.operateParam + "%";
								}
								inner = inner + "</td>\
								<td>" +  year1 + "/" + month1 + "/" + date1 + "-" + year2 + "/" + month2 + "/" + date2 + "</td>\
								<td>";
								if (operate.hours == 0 && operate.minutes != 0) {
									inner = inner + "00" + ":" + operate.minutes;
								}else if(operate.hours != 0 && operate.minutes == 0) {
									inner = inner + operate.hours + ":" + "00";
								}else if(operate.hours == 0 && operate.minutes == 0){
									inner = inner + "00:00";
								}else{
									inner = inner + operate.hours + ":" + operate.minutes;
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet', " + operate.ployid + "," + operate.id 
	+ " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";
		        		 
		        	  }
		        	 document.getElementById("tbody1").innerHTML = inner;
		        	 
		          },
		          error: function() {  //提交失败
		        	  layer.msg(jQuery.i18n.prop('submitFailed'));
		          	}
		  	  
 			});		  
		}
		//4.ajax获取单个LED策略里的操作集合，并将数据动态插入到第2个table中
		function IntoLEDPloyOperateTable(ployid){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getPloyOperateServlet",
		          data:{
		        	//参数
		        	ployid:ployid
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var operate = "";
		        	  inner = "";
		        	  for(var index=0; index < json.length; index++){
		        		  operate = json[index];
		        		  var startDate = new Date(operate.startDate);//毫秒数转换成时间
		        		  var endDate = new Date(operate.endDate);//毫秒数转换成时间
		        		  var year1 = startDate.getFullYear();
		        		  var year2 = endDate.getFullYear();
		        		  var month1 = startDate.getMonth() + 1;
		        		  var month2 = endDate.getMonth() + 1;
		        		  var date1 = startDate.getDate();
		        		  var date2 = endDate.getDate();
		        		  inner = inner + "<tr><td>" + operate.ployName + "</td>\
								<td>";
								if (operate.operateType == 1) {
									//inner = inner + "开关灯";
									inner = inner + jQuery.i18n.prop('SwitchLamp');
								} else if(operate.operateType == 2){
									//inner = inner + "调光";
									inner = inner + jQuery.i18n.prop('aDim');
								} else if(operate.operateType == 3){
									//inner = inner + "调色";
									inner = inner + jQuery.i18n.prop('aToning');
								}
								inner = inner + "</td>\
								<td>";
								if (operate.operateParam == 0 && operate.operateType == 1) {
									inner = inner + "OFF";
								} else if(operate.operateType == 1){
									inner = inner + "ON";
								} else{
									inner = inner + operate.operateParam + "%";
								}
								inner = inner + "</td>\
								<td>" +  year1 + "/" + month1 + "/" + date1 + "-" + year2 + "/" + month2 + "/" + date2 + "</td>\
								<td>";
								if (operate.hours == 0 && operate.minutes != 0) {
									inner = inner + "00" + ":" + operate.minutes;
								}else if(operate.hours != 0 && operate.minutes == 0) {
									inner = inner + operate.hours + ":" + "00";
								}else if(operate.hours == 0 && operate.minutes == 0){
									inner = inner + "00:00";
								}else{
									inner = inner + operate.hours + ":" + operate.minutes;
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet', " + operate.ployid + "," + operate.id 
	+ " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";
		        		 
		        	  }
		        	 document.getElementById("tbody2").innerHTML = inner;
		        	 
		          },
		          error: function() {  //提交失败
		        	  layer.msg(jQuery.i18n.prop('submitFailed'));
		          	}
		  	  
 			});		  
		}
		
		//4.ajax获取单个wifi策略里的操作集合，并将数据动态插入到第2个table中
		function IntoWifiPloyOperateTable(ployid){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getPloyOperateServlet",
		          data:{
		        	//参数
		        	ployid:ployid
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var operate = "";
		        	  inner = "";
		        	  for(var index=0; index < json.length; index++){
		        		  operate = json[index];
		        		  var startDate = new Date(operate.startDate);//毫秒数转换成时间
		        		  var endDate = new Date(operate.endDate);//毫秒数转换成时间
		        		  var year1 = startDate.getFullYear();
		        		  var year2 = endDate.getFullYear();
		        		  var month1 = startDate.getMonth() + 1;
		        		  var month2 = endDate.getMonth() + 1;
		        		  var date1 = startDate.getDate();
		        		  var date2 = endDate.getDate();
		        		  inner = inner + "<tr><td>" + operate.ployName + "</td>\
								<td>";
								if(operate.operateType == 5){
									//inner = inner + "调光";
									inner = inner + jQuery.i18n.prop('aDim');
								} else if(operate.operateType == 4){
									//inner = inner + "自动调光";
									inner = inner + jQuery.i18n.prop('AutoDim');
								} 
								inner = inner + "</td>\
								<td>";
								if (operate.operateType == 5) {
									inner = inner + operate.operateParam + "%";
								} else if(operate.operateType == 4){
									inner = inner + operate.operateParam + "lux";
								} else{
									inner = inner + "null";
								}
								inner = inner + "</td>\
								<td>" +  year1 + "/" + month1 + "/" + date1 + "-" + year2 + "/" + month2 + "/" + date2 + "</td>\
								<td>";
								if (operate.hours == 0 && operate.minutes != 0) {
									inner = inner + "00" + ":" + operate.minutes;
								}else if(operate.hours != 0 && operate.minutes == 0) {
									inner = inner + operate.hours + ":" + "00";
								}else if(operate.hours == 0 && operate.minutes == 0){
									inner = inner + "00:00";
								}else{
									inner = inner + operate.hours + ":" + operate.minutes;
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"deletePloyOperate('${pageContext.request.contextPath }/deletePloyOperateServlet', " + operate.ployid + "," + operate.id 
	+ " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";
		        		 
		        	  }
		        	 document.getElementById("tbody3").innerHTML = inner;
		        	 
		          },
		          error: function() {  //提交失败
		        	  layer.msg(jQuery.i18n.prop('submitFailed'));
		          	}
		  	  
 			});		  
		}
		
		/**
		 * 5.删除策略内的定时指令
		 * @param url
		 * @param userid
		 * @param ployid
		 * @returns
		 */
		function deletePloyOperate(url,ployid,ployOperateId){
			 layer.confirm(jQuery.i18n.prop('DelTimingOperate'),{ 
			  		title: jQuery.i18n.prop('Tips'),
			  		btn: [jQuery.i18n.prop('confirmBtn'),jQuery.i18n.prop('Lcancel')], //确定、取消按钮
		        	btn1: function(){
		        		jQuery.ajax({
		      			  type:"post",
		      			  url:url,
		      			  data:{
		      				  operateId:ployOperateId
		      			  },
		      			  async : true,
		      			  datatype: "String",
		      			  success:function(datasource, textStatus, jqXHR) {
		      				  //返回删除提示
		      				  if(datasource == "删除成功"){
			      					layer.msg(jQuery.i18n.prop('DelSuccess'),function(){
				      				  
			      					});
		      				  }else if(datasource == "删除失败"){
			      					layer.msg(jQuery.i18n.prop('DelFailed'),function(){
				      					
				      				  });
		      				  }else if(datasource == "参数不完整"){
			      					layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
				      					
				      				  });
		      				  }else{
		      					  
		      					  
		      				  }
		      				//删除操作后重新获取策略内定时操作信息，重新操作显示数据到表格上
		      				IntoLEDPloyOperateTable(ployid);
		      				IntoWifiPloyOperateTable(ployid);
		      				IntoBallastPloyOperateTable(ployid);
		      			  },
		      			  error: function() {  
		      				  layer.msg(jQuery.i18n.prop('submitFailed'));
		      				  //layer.msg("提交失败!");	
		      	      		}
		        		});	
		        	
		        	}
			  	  ,btn2: function(){
			  		   //取消按钮取消删除操作
	         		 }
			});	
		}
		
		/**
		 * 6.新建镇流器策略弹窗
		 * led、镇流器、wifi弹窗函数不一样，公用一个jsp、servlet
		 * @param url
		 * @param userid
		 * @returns
		 */
		function newBallastPloy(url,userid){
			var groupType = 1; //绑定分组类型，groupType = 1是镇流器分组类型
			layer.open({
				area : [ '400px', '350px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?userid=" + userid + "&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title: jQuery.i18n.prop('CreateAPloy'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}
		/**
		 * 7.新建led策略弹窗
		 * led、镇流器、wifi弹窗函数不一样，公用一个jsp、servlet，绑定分组类型，groupType = 2是led分组类型
		 * @param url
		 * @param userid
		 * @returns
		 */
		function newLedPloy(url,userid){
			var groupType = 2;
			layer.open({
				area : [ '400px', '350px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?userid=" + userid + "&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title: jQuery.i18n.prop('CreateAPloy'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}
		
		/**
		 * 8.新建wifi策略弹窗
		 * led、镇流器、wifi弹窗函数不一样，公用一个jsp、servlet,绑定分组类型，groupType = 3是wifi分组类型
		 * @param url
		 * @param userid
		 * @returns
		 */
		function newWifiPloy(url,userid){
			var groupType = 3; //策略类型
			layer.open({
				area : [ '400px', '350px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?userid=" + userid + "&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title: jQuery.i18n.prop('CreateAPloy'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}
		/**
		 * 7.策略重命名,共用函数，servlet,jsp
		 * @param url
		 * @param userid
		 * @param ployid
		 * @returns
		 */
		function ployRename(url,userid,ployid){
			layer.open({
				area : [ '300px', '200px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?userid=" + userid + "&ployid=" + ployid + "&i18nLanguage=" + i18nLanguage, 
				closeBtn : 1,
				type : 2,
				title: jQuery.i18n.prop('EnterNewName'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}
		/**
		 * 8.添加策略操作弹窗,三种类型共用一个函数，由于url不同，跳转到不同的servlet
		 * @param url
		 * @param userid
		 * @param ployid
		 * @returns
		 */
		function addOperate(url,userid,ployid,runState){
			if(runState == 1){
				//策略正在执行，无法操作!策略执行过程中添加策略操作，避免websocket执行定时操作时出错
				layer.alert(jQuery.i18n.prop('PloyRunningCanNotOperate'),{
					title:jQuery.i18n.prop('Tips'),
					btn:[jQuery.i18n.prop('confirmBtn')],
				});
			}else if(runState == 0){
				layer.open({
					area : [ '500px', '350px' ],
					btnAlign : 'c',
					resize : false,
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					title:jQuery.i18n.prop('AddTimingInstruction'),
					cancel : function() {
						// 右上角关闭回调
					}
				});
			}
		}
		/**
		 * 9.添加wifi策略操作弹窗
		 * @param url
		 * @param userid
		 * @param ployid
		 * @returns
		 */
	/*	function addWifiOperate(url,userid,ployid,runState){
			if(runState == 1){
				//策略正在执行，无法操作!策略执行过程中添加策略操作，避免websocket执行定时操作时出错
				layer.alert(jQuery.i18n.prop('PloyRunningCanNotOperate'),{
					title:jQuery.i18n.prop('Tips'),
					btn:[jQuery.i18n.prop('confirmBtn')],
				});
			}else if(runState == 0){
				layer.open({
					area : [ '500px', '350px' ],
					btnAlign : 'c',
					resize : false,
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					title:jQuery.i18n.prop('AddTimingInstruction'),
					cancel : function() {
						// 右上角关闭回调
					}
				});
			}
		}
		*/
		/**
		 * 9.查看策略绑定分组的信息
		 * @param url
		 * @param userid
		 * @param groupid
		 * @returns
		 */
	function groupMessage(url,userid,groupid){
		 //1.ajax获取group对象
		 jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		        	userid:userid,
		            groupid:groupid
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  //2.弹窗显示group信息
		              var group = datasource;
		        	  if(group != null){
		        		  var message = "<div style='margin-top:10px;margin-left:25px;padding-buttom:10px'>"+jQuery.i18n.prop('UserIdM') + group.userid + "</br>"+ jQuery.i18n.prop('GroupID') + group.groupid + "</br>"+ jQuery.i18n.prop('GroupNameM') + group.groupName + "</br>" + jQuery.i18n.prop('NodeNumM') + group.nodeNum  + "</br></div>";
		        		  layer.open({
		        				 area : [ '380px', '220px' ],
		        				 btnAlign : 'l',
		        				 resize : false,
		        				 closeBtn : 1,
		        				 type : 1,
		        				 content : message,
		        				 title: jQuery.i18n.prop('BindGroupMessage'),
		        				 cancel : function(){
		        				 }
		        			 });
		        		  
		        	  }else{//未查询到信息	
		        		  layer.msg(jQuery.i18n.prop('NoGroupMessage'));	
		        	  }
		        	  
		          },
		          error: function() {  //查询出错了
		          	  layer.msg(jQuery.i18n.prop('QueryError'));	
		          	}
				});
		}
		/**
		 *10.删除策略
		 * @param url
		 * @param userid
		 * @param ployid
		 * @returns
		 */
		function deletePloy(url,userid,ployid,runState){
			 if(runState == 1){
				 //策略正在执行，无法进行删除;策略执行过程中删除策略，避免websocket执行定时操作时出错
				 layer.alert(jQuery.i18n.prop('PloyRunningCanNotDelete'),{
					 title:jQuery.i18n.prop('Tips'),
					 btn: [jQuery.i18n.prop('confirmBtn')]
				 }, function(index){
					  //do something
					  layer.close(index);
					});   
			 }else{
				 //ajax发送删除指令
				 jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	userid:userid,
			            ployid:ployid
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  //返回删除提示
			        	  if(datasource == '删除成功'){
			        		  layer.msg(jQuery.i18n.prop('DelSuccess'),function(){
				        		  location.reload();
				        	  });
			        	  }else if(datasource == '删除失败'){
			        		  layer.msg(jQuery.i18n.prop('DelFailed'),function(){
				        		  location.reload();
				        	  });
			        	  }
			        	
			          },
			          error: function() {  //提交失败
			        	  layer.msg(jQuery.i18n.prop('submitFailed'));
			          	
			          	}
			  		});	
			 }
		}
		
		/**
		 * 11.镇流器更改策略的绑定分组；函数不一样，三种类型节点servlet，jsp共用
		 * @param url
		 * @param ployid
		 * @param groupid
		 * @returns
		 */
		function BallastPloyChangeGroup(url,userid,ployid,groupid,runState){
			var groupType = 1; //镇流器分组类型是1
			if(runState == 1){
				 //策略正在执行，无法操作
				 layer.msg(jQuery.i18n.prop('PloyRunningCanNotOperate'));	
			}else{
				layer.open({
					area : [ '400px', '350px' ],
					btnAlign : 'c',
					resize : false,
					title: [jQuery.i18n.prop('PloyChangeGroup')], //策略更换绑定的分组
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&groupid=" + groupid +"&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					cancel : function() {
						// 右上角关闭回调
						 location.reload();
					}
				});
			}
		}
		/**
		 * 12.led更改策略的绑定分组；函数不一样，三种类型节点servlet，jsp共用
		 * @param url
		 * @param ployid
		 * @param groupid
		 * @returns
		 */
		function ledPloyChangeGroup(url,userid,ployid,groupid,runState){
			var groupType = 2;
			if(runState == 1){
				 //策略正在执行，无法操作
				 layer.msg(jQuery.i18n.prop('PloyRunningCanNotOperate'));	
			}else{
				layer.open({
					area : [ '400px', '350px' ],
					btnAlign : 'c',
					resize : false,
					title: [jQuery.i18n.prop('PloyChangeGroup')], //策略更换绑定的分组
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&groupid=" + groupid +"&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					cancel : function() {
						// 右上角关闭回调
						 location.reload();
					}
				});
			}
		}
		
		/**
		 * 12.wifi更改策略的绑定分组；函数不一样，三种类型节点servlet，jsp共用
		 * @param url
		 * @param ployid
		 * @param groupid
		 * @returns
		 */
		function wifiPloyChangeGroup(url,userid,ployid,groupid,runState){
			var groupType = 3;
			if(runState == 1){
				 //策略正在执行，无法操作
				 layer.msg(jQuery.i18n.prop('PloyRunningCanNotOperate'));	
			}else{
				layer.open({
					area : [ '400px', '350px' ],
					btnAlign : 'c',
					resize : false,
					title: [jQuery.i18n.prop('PloyChangeGroup')], //策略更换绑定的分组
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&groupid=" + groupid +"&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					cancel : function() {
						// 右上角关闭回调
						 location.reload();
					}
				});
			}
		}
		
		/**
		 * 12.wifi更改策略的绑定分组；三种类型节点更改策略共用servlet,jsp
		 * @param url
		 * @param ployid
		 * @param groupid
		 * @returns
		 */
		function WifiPloyChangeGroup(url,userid,ployid,groupid,runState){
			var groupType = 3;
			if(runState == 1){
				 //策略正在执行，无法操作
				 layer.msg(jQuery.i18n.prop('PloyRunningCanNotOperate'));	
			}else{
				layer.open({
					area : [ '400px', '350px' ],
					btnAlign : 'c',
					resize : false,
					title: [jQuery.i18n.prop('PloyChangeGroup')], //策略更换绑定的分组
					content : url + "?userid=" + userid + "&ployid=" + ployid + "&groupid=" + groupid +"&groupType=" + groupType + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					cancel : function() {
						// 右上角关闭回调
						 location.reload();
					}
				});
			}
		}
		/**
		 * 12.执行策略,三种类型节点共用函数、servlet、jsp
		 * @param url
		 * @param ployid
		 * @param userid
		 * @returns
		 */
		function runPloy(url,ployid,userid){
			//采用ajax
			var runState = 1; //状态为1，正在执行
			jQuery.ajax({
				  type:"post",
				  url:url,
				  data:{
					  userid:userid,
					  ployid:ployid,
					  runState:runState
				  },
				  async : true,
				  datatype: "String",
				  success:function(datasource, textStatus, jqXHR) {
					  //返回提示
					  if(datasource == "策略已执行"){ //策略正在执行
						  layer.msg(jQuery.i18n.prop('PloyImplemented'),function(){
							   location.reload();
						  });
					  }else if(datasource == "停止执行"){//策略已停止执行
						  layer.msg(jQuery.i18n.prop('StopImplement'),function(){
							   location.reload();
						  });
					  }else if(datasource == "指令发送失败"){//
						  layer.msg(jQuery.i18n.prop('cmdSendFail'),function(){
							   location.reload();
						  });
					  }else{
						  layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
							   location.reload();
						  });
					  }	
				  },
				  error: function() {  //提交失败
					  layer.msg(jQuery.i18n.prop('submitFailed'));	
		        	}
				});	
		}

		/**
		 * 13.停止执行策略，三种类型节点共用函数、servlet、jsp
		 * @param url
		 * @param ployid
		 * @param userid
		 * @returns
		 */
		function stopPloy(url,ployid,userid){
			//采用ajax
			var runState = 0; //状态为0，未执行
			jQuery.ajax({
				  type:"post",
				  url:url,
				  data:{
					  userid:userid,
					  ployid:ployid,
					  runState:runState
				  },
				  async : true,
				  datatype: "String",
				  success:function(datasource, textStatus, jqXHR) {
					  //返回提示
					  if(datasource == "策略已执行"){ //策略正在执行
						  layer.msg(jQuery.i18n.prop('PloyImplemented'),function(){
							   location.reload();
						  });
					  }else if(datasource == "停止执行"){//策略已停止执行
						  layer.msg(jQuery.i18n.prop('StopImplement'),function(){
							   location.reload();
						  });
					  }else if(datasource == "指令发送失败"){//
						  layer.msg(jQuery.i18n.prop('cmdSendFail'),function(){
							   location.reload();
						  });
					  }else{ //参数不完整
						  layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
							   location.reload();
						  });
					  }
				  },
				  error: function() {  //提交失败
					  layer.msg(jQuery.i18n.prop('submitFailed'));	
		      	}
			});	
		}
	</script>
</body>
</html> 