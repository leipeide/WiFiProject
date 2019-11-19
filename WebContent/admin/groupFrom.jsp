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
.functionDiv1 {
	/* 	border:3px solid #00695F;     */
	height: 40px;
}

.addGroupDiv1 {
	float: left;
}

.selectGroupDiv1 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}

.tableDiv1 {
	/*     border:3px solid #00695F;      */
	
}


/* led选项卡区域 */
.addGroupDiv2 {
	float: left;
}
.selectGroupDiv2 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}

/* wifi选项卡区域 */
.addGroupDiv3 {
	float: left;
}
.selectGroupDiv3 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}
</style>
</head>
<body>
	<form class="layui-form" method="" action="">
		<input type="hidden" name="useridDiv" id="useridDiv" value="${userid }">
		<!-- 隐藏标签，在系统中传递语言环境 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage }">
		<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
			<ul class="layui-tab-title">
				<li class="layui-this" name="Bgroup" lay-id="ballastGroup"></li>
				<li class="i18n" name="LDgroup" lay-id="ledDriverGroup"></li>
				<li class="i18n" name="Wifigroup" lay-id="wifiGroup"></li>
			</ul>
			
			<div class="layui-tab-content">
			
				<!--  1.Tab镇流器分组区域 -->
				<div class="layui-tab-item layui-show" id="ballast_table">
					<div class="functionDiv1">
						<div class="addGroupDiv1">
							<a href="javascript:;" class="layui-btn" name="AddGroup"
								onclick="addBalletGroup('${pageContext.request.contextPath }/addBallastGroupFromServlet',${userid })"></a>
						</div>
						<div class="selectGroupDiv1">
							<select name="select1" lay-filter="select1">
								<option class="i18n" name="LAllGroup" value="allGroup"></option>
								<c:forEach items="${GroupMap.ballastGroup}" var="ballastGroup">
									<option value=${ballastGroup.groupid }>${ballastGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv1">
						<div id="allGroupTableDiv1" style="display: block">
							<!-- 为美观，表格风格设置为sm -->
							<table class="layui-table" lay-size="sm">
<%-- 								<colgroup>
									<col width="200">
									<col width="200">
									<col width="200">
									<col width="200">
									<col>
								</colgroup> --%>
								<thead>
									<tr>
										<th class="i18n" name="AGroupName"></th>
<!-- 										<th>123</th>  -->
										<th class="i18n" name="ANodeNum"></th>
										<th class="i18n" name="AddBallast"></th>
										<th class="i18n" name="DeleteGroup"></th>
										<th class="i18n" name="BroadcastControl"></th>
									</tr>
								</thead>
								<tbody id="ballastGroupTableTbody">
<%--  									<c:forEach items="${GroupMap.ballastGroup}" var="ballastGroup">  
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${ballastGroup.groupid},${userid})"><span><font
														color="#009688">${ballastGroup.groupName }</font></span></a></td>
											<td>${ballastGroup.onlineNum}</td>
											<td>${ballastGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addBallestToBallestGroup('${pageContext.request.contextPath }/addBallastToBallastGroupFromServlet',${ballastGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${ballastGroup.groupid})"><i
													class="layui-icon">&#xe640;</i></a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet',${ballastGroup.groupid },${userid })">开灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet',${ballastGroup.groupid },${userid })">关灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet',${ballastGroup.groupid },${userid })">调光</a>
											</td>
										</tr>
									</c:forEach>
								--%>
								</tbody>
							</table>
						</div>
						<!-- 分组内的节点表格 -->
						<div id="oneGroupTableDiv1" style="display: none">
							<!-- 为美观，表格风格设置为sm -->
							<table class="layui-table" lay-size="sm">
<%-- 								<colgroup>
									<col width="120">
									<col>
								</colgroup> --%>
								<thead>
									<tr>
										<th class="i18n" name="NodeMacAddr"></th>
										<th class="i18n" name="NodeName"></th>
										<th class="i18n" name="NetworkState"></th>
										<th  class="i18n" name="SwitchLightStatus"></th>
										<th  class="i18n" name="DimPara"></th>
     									<th  class="i18n" name="SingleLampControl"></th>
										<th  class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="ballastGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
				<!--  2.led驱动器分组区域 -->
				<div class="layui-tab-item" id="ledDriver_table">
					<div class="functionDiv2">
						<div class="addGroupDiv2">
							<a href="javascript:;" class="layui-btn" name="AddGroup"
								onclick="addLedGroup('${pageContext.request.contextPath }/addLedGroupFromServlet',${userid })"></a>
						</div>
						<div class="selectGroupDiv2">
							<select name="select2" lay-filter="select2">
								<option class="i18n" name="LAllGroup" value="allGroup"></option>
								<c:forEach items="${GroupMap.ledGroup}" var="ledGroup">
									<option value=${ledGroup.groupid }>${ledGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv2">
						<div id="allGroupTableDiv2" style="display: block">
							<!-- 为美观，表格风格设置为sm -->
							<table class="layui-table" lay-size="sm">
<%-- 								<colgroup> 
									<col width="200">
									<col width="200">
									<col width="200">
									<col width="200">
									<col>
								</colgroup>--%>
								<thead>
									<tr>
										<th class="i18n" name="AGroupName"></th>
										<th class="i18n" name="ANodeNum"></th>
										<th class="i18n" name="AddLed"></th>
										<th class="i18n" name="DeleteGroup"></th>
										<th class="i18n" name="BroadcastControl"></th>
									</tr>
								</thead>
								<tbody id="ledGroupTableTbody">
<%--  									<c:forEach items="${GroupMap.ledGroup}" var="ledGroup"> 
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${ledGroup.groupid},${userid})">
													<span><font color="#009688">${ledGroup.groupName}</font></span>
											</a></td>
											<td>${ledGroup.onlineNum}</td>
											<td>${ledGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addLedToLedGroup('${pageContext.request.contextPath }/addLedToLedGroupFromServlet',${ledGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${ledGroup.groupid})">
													<i class="layui-icon">&#xe640;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet',${ledGroup.groupid},${userid })">开灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet',${ledGroup.groupid},${userid })">关灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet',${ledGroup.groupid},${userid })">调光</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet',${ledGroup.groupid},${userid })">调色</a>
											</td>
										</tr>
									</c:forEach>
									--%>
								</tbody>
							</table>
						</div>
						<div id="oneGroupTableDiv2" style="display: none">
							<!-- 为美观，表格风格设置为sm -->
							<table class="layui-table" lay-size="sm">
<%-- 								<colgroup>
									<col width="140">
									<col width="140">
									<col width="110">
									<col width="110">
									<col width="110">
									<col width="110">
									<col width="250">
									<col width="80">
									<col>
								</colgroup> --%>
								<thead>
									<tr>
										<th class="i18n" name="NodeMacAddr"></th>
										<th class="i18n" name="NodeName"></th>
										<th class="i18n" name="NetworkState"></th>
										<th  class="i18n" name="SwitchLightStatus"></th>
										<th  class="i18n" name="DimPara"></th>
										<th  class="i18n" name="TonPara"></th>
     									<th  class="i18n" name="SingleLampControl"></th>
										<th  class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="ledGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<%--wifi无线调光器分组Tab选项区域 --%>
				<div class="layui-tab-item">
					<div class="functionDiv3">
						<div class="addGroupDiv3"> 
							<a href="javascript:;" class="layui-btn" name="AddGroup"
								onclick="addWifiGroup('${pageContext.request.contextPath }/addWifiGroupFromServlet',${userid })"></a>
						</div>
						<div class="selectGroupDiv3">
							<select name="select3" lay-filter="select3">
								<option class="i18n" name="LAllGroup" value="allGroup"></option>
								<c:forEach items="${GroupMap.wifiGroup}" var="wifiGroup">
									<option value=${wifiGroup.groupid }>${wifiGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv3">
						<div id="allGroupTableDiv3" style="display: block">
							<!-- 为美观，表格风格设置为sm -->
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
										<th class="i18n" name="AGroupName"></th>
										<th class="i18n" name="ANodeNum"></th>
										<th class="i18n" name="AddWifiNode"></th>
										<th class="i18n" name="DeleteGroup"></th>
										<th class="i18n" name="DimControl"></th>
									</tr>
								</thead>
								<tbody id="wifiGroupTableTbody">
<%-- 									<c:forEach items="${GroupMap.wifiGroup}" var="wifiGroup">
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${wifiGroup.groupid},${userid})"><span><font
														color="#009688">${wifiGroup.groupName}</font></span></a></td>
											<td>${wifiGroup.onlineNum}</td>
											<td>${wifiGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addWifiToWifiGroup('${pageContext.request.contextPath }/addWifiToWifiGroupFromServlet',${wifiGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${wifiGroup.groupid})">
													<i class="layui-icon">&#xe640;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupDimByLux('${pageContext.request.contextPath }/groupDimByLuxFormServlet',${wifiGroup.groupid},${userid })">调光</a>
											</td>
										</tr>
									</c:forEach>
									 --%>
								</tbody>
							</table>
						</div>
						<div id="oneGroupTableDiv3" style="display: none">
							<!-- 为美观，表格风格设置为sm -->
							<table class="layui-table" lay-size="sm">
								<colgroup>
									<col width="120">
									<col>
								</colgroup> 
								<thead>
									<tr>
										<th class="i18n" name="NodeMacAddr"></th>
										<th class="i18n" name="NodeName"></th>
										<th class="i18n" name="NetworkState"></th>
<!-- 										<th  class="i18n" name="SwitchLightStatus">开关状态</th> -->
										<th  class="i18n" name="DimPara"></th>
     									<th  class="i18n" name="SingleLampControl"></th>
										<th  class="i18n" name="LDelete"></th>
									</tr>
								</thead>
								<tbody id="wifiGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- i18n国际化语言包 -->
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">	
		/*
		* 1.全局变量
		*/
		var groupId = ""; //全局变量，分组id,用于刷新分组下的节点信息页面
		var groupType = "";//全局变量，分组类型,默认为1；用于刷新分组下的节点信息页面；根据分组类型选择相应的刷新节点信息函数
		var userId = document.getElementById("useridDiv").value; //全局变量用户id
		var i18nLanguage =  jQuery("#hiddenLan").val(); //语言环境
		
		/*
		* 2.layui模块加载
		*/
		layui.use(['element','slider','form'], function(){
			  var element = layui.element;
			  var slider = layui.slider;
			  var form = layui.form;
			  //2.1.监听Tab选项卡
			  var layid = location.hash.replace(/^#TabBrief=/, ''); //.获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
			  element.tabChange('TabBrief', layid); //.切换到lay-id对应的tab选项
			  element.on('tab(TabBrief)', function(){  //.监听Tab切换，以改变地址hash值
				var layid = this.getAttribute('lay-id');
				location.hash = 'TabBrief='+ layid;
				//切换tab,给groupType赋相应的值，用于相应tab区域分组表格的刷新
			    if(layid == "wifiGroup"){
			   		groupType = 3;
			   	}else if(layid == "ledDriverGroup"){
			   		groupType = 2;
			   	} else {
			   		groupType = 1;
			   	}
			   	//由于分组的表格是通过ajax动态添加的，故切换tab选项时分组表格需动态再次添加
			    GroupRefreshAJAXRequest();
			  });
			  
			  //2.2.调色滑块的使用
			  slider.render({
			    elem: '#ledDriverSlide'
			  });
			  
			  //2.3.镇流器select监听
			  form.on('select(select1)',function(data){
				  groupType = 1; //分组类型，镇流器分组类型为1;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv1").style.display = "none";
					  document.getElementById("allGroupTableDiv1").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
					  document.getElementById("oneGroupTableDiv1").style.display = "block";
					  document.getElementById("allGroupTableDiv1").style.display = "none";
					  groupId = data.value;
					  IntoBallastGroupNodeTable(groupId);
				  }
			  });
			  
			  //2.4.LED select监听
			  form.on('select(select2)',function(data){
				  groupType = 2; //分组类型，led分组类型为2;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv2").style.display = "none";
					  document.getElementById("allGroupTableDiv2").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
					  document.getElementById("oneGroupTableDiv2").style.display = "block";
					  document.getElementById("allGroupTableDiv2").style.display = "none";
					  groupId = data.value;
					  IntoLedGroupNodeTable(groupId);
				  }
			  });
			  
			  //2.5.WIFI select监听
			  form.on('select(select3)',function(data){
				  groupType = 3; //分组类型，wifi分组类型为3;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv3").style.display = "none";
					  document.getElementById("allGroupTableDiv3").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
				  	  allGroupTableDiv3 = "none";
				  	  oneGroupTableDiv3 = "block";
					  document.getElementById("oneGroupTableDiv3").style.display = "block";
					  document.getElementById("allGroupTableDiv3").style.display = "none";
					  groupId = data.value;
					  IntoWifiGroupNodeTable(groupId);
				  }
			  });
			  
			});
		
		/*
		*3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		*/
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
		             // 第二类：layui-this
		             var tabEle = jQuery(".layui-this"); // 获得所有class为layui-this的元素
		             tabEle.each(function() {  // 遍历，根据layui-this元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		            // 第三类：layui的button
		             var insertBtnEle = jQuery(".layui-btn"); // 获得所有class为layui-btn的元素
		             insertBtnEle.each(function() {  // 遍历，根据layui-btn元素的 name 获取语言库对应的内容写入
		            	  jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		               });  
		     }
		  });

		 /*
			*4.页面加载完处理
			*注意：
			*页面刷新，指定5分钟刷新一次；
			*由于页面操作时会重载数据；故此自动刷新函数主要是对节点的在线状态进行实时刷新；
			*故不需要刷新太频繁，在此将刷新时间设置为5分钟
			*/
		window.onload = function() {
			GroupRefreshAJAXRequest();
			setInterval(function(){
				pageRefresh();
			},1000*60*5);  
		};
		//5.ajax动态获取节点分组的信息
		function GroupRefreshAJAXRequest() {
			var req = getXMLHttpRequest();
			req.onreadystatechange = function() {
				if (req.readyState == 4) {// 请求成功
					if (req.status == 200) {// 服务器响应成功
						var GroupMap = JSON.parse(req.responseText);
						var ballastGS = GroupMap.ballastGroup;
						var ledGS = GroupMap.ledGroup;
						var wifiGS = GroupMap.wifiGroup;
						var inner1 = ""; //镇流器分组table动态插入对象
						var inner2 = ""; //led驱动器分组table动态插入对象
						var inner3 = ""; //wi无线调光器分组table动态插入对象
						var bgObj; //镇流器分组对象
						var lgObj; //led分组对象
						var wgObj; //wifi分组对象
						/**
						*注意：ajax动态插入表格，无法实现i18n的语法，故使用if判断语言环境
						*配置2种环境，根据语言环境去选择
						*/
						//中文环境动态插入表格
						if(i18nLanguage == "zh-CN"){
							//1.动态插入镇流器分组表格
							for (var i = 0; i < ballastGS.length; i++) {
								bgObj =  ballastGS[i];
								inner1 = inner1 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><span><font color=\"#009688\"> " +bgObj.groupName + "</font></span></a></td>\
									<td>" + bgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addBallestToBallestGroup('${pageContext.request.contextPath }/addBallastToBallastGroupFromServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + bgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td>";
										if (bgObj.lastOperateType == "open") {
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a></div>";
										} else if(bgObj.lastOperateType == "close") {
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a></div>";
											
										}else{
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a></div>";
											
										}
										inner1 = inner1 + "</td>\
								</tr>";
							
							}
							//2.动态插入led分组表格
							for (var i = 0; i < ledGS.length; i++) {
								lgObj = ledGS[i];
								inner2 = inner2 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><span><font color=\"#009688\"> " +lgObj.groupName + "</font></span></a></td>\
									<td>" + lgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addLedToLedGroup('${pageContext.request.contextPath }/addLedToLedGroupFromServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + lgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td>";
									if (lgObj.lastOperateType == "open") {
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a></div>";
									
									} else if(lgObj.lastOperateType == "close") {
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a></div>";
									}else{
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a></div>";
										
									}
									inner2 = inner2 + "</td>\
								</tr>";
							}
							//3.动态插入wifi分组表格
							for (var i = 0; i < wifiGS.length; i++) {
								wgObj = wifiGS[i];
								inner3 = inner3 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><span><font color=\"#009688\"> " +wgObj.groupName + "</font></span></a></td>\
									<td>" + wgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addWifiToWifiGroup('${pageContext.request.contextPath }/addWifiToWifiGroupFromServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + wgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupDimByLux('${pageContext.request.contextPath }/groupDimByLuxFormServlet'," + wgObj.groupid + ", " + wgObj.userid + ")\">调光</a></td>\
								</tr>";
							}
							
						//英文环境动态插入表格
						}else{
							//1.动态插入镇流器分组表格
							for (var i = 0; i < ballastGS.length; i++) {
								bgObj =  ballastGS[i];
								inner1 = inner1 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><span><font color=\"#009688\"> " +bgObj.groupName + "</font></span></a></td>\
									<td>" + bgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addBallestToBallestGroup('${pageContext.request.contextPath }/addBallastToBallastGroupFromServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + bgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td>";
										if (bgObj.lastOperateType == "open") {
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">ON</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">OFF</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">Dim</a></div>";
											
										} else if(bgObj.lastOperateType == "close") {
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">ON</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">OFF</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">Dim</a></div>";
										}else{
											inner1 = inner1 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">ON</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">OFF</a>\
												<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
													onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">Dim</a></div>";

										}
										inner1 = inner1 + "</td>\
								</tr>";
							
							}
							//2.动态插入led分组表格
							for (var i = 0; i < ledGS.length; i++) {
								lgObj = ledGS[i];
								inner2 = inner2 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><span><font color=\"#009688\"> " +lgObj.groupName + "</font></span></a></td>\
									<td>" + lgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addLedToLedGroup('${pageContext.request.contextPath }/addLedToLedGroupFromServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + lgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td>";
									if (lgObj.lastOperateType == "open") {
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">ON</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">OFF</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Dim</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Toning</a></div>";
										
									} else if(lgObj.lastOperateType == "close") {
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">ON</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">OFF</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Dim</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Toning</a></div>";
									}else{
										inner2 = inner2 + "<div class='layui-btn-container'><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">ON</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">OFF</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Dim</a>\
											<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
												onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">Toning</a></div>";
									
									}
									inner2 = inner2 + "</td>\
								</tr>";
							
							}
							//3.动态插入wifi分组表格
							for (var i = 0; i < wifiGS.length; i++) {
								wgObj = wifiGS[i];
								inner3 = inner3 + "<tr>\
									<td><a href=\"javascript:;\"\
											onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><span><font color=\"#009688\"> " +wgObj.groupName + "</font></span></a></td>\
									<td>" + wgObj.nodeNum + "</td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"addWifiToWifiGroup('${pageContext.request.contextPath }/addWifiToWifiGroupFromServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + wgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupDimByLux('${pageContext.request.contextPath }/groupDimByLuxFormServlet'," + wgObj.groupid + ", " + wgObj.userid + ")\">Dim</a></td>\
								</tr>";
							}
						}
						
						document.getElementById("ballastGroupTableTbody").innerHTML = inner1;
						document.getElementById("ledGroupTableTbody").innerHTML = inner2;
						document.getElementById("wifiGroupTableTbody").innerHTML = inner3;
						
					}
				}
			}
			// 发送请求， 建立一个链接
			req.open("post", "${pageContext.request.contextPath }/refreshGroupServlet", true);
			// POST方式需要自己设置http的请求头
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			// POST方式发送数据
			req.send("userid=" + userId);
		}
		
		
		//6.刷新页面函数
		function pageRefresh(){
			GroupRefreshAJAXRequest();
			if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
				IntoBallastGroupNodeTable(groupId);
			
			}else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
				IntoLedGroupNodeTable(groupId);
			
			}else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
				IntoWifiGroupNodeTable(groupId);
			
			}else{
				
				
			}
		}
		//判断浏览器是否对ajax进行响应
		function getXMLHttpRequest() {
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlhttp;
		}
		
	   //7向单个镇流分组表格内插入镇流器分组下的节点数据
	   function IntoBallastGroupNodeTable(groupId){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
		          data:{
		        	//参数
		        	groupid:groupId,
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var node = "";
		        	  inner = "";
			          //中文环境
		        	  if(i18nLanguage == "zh-CN"){
			        	  for(var index=0; index < json.length; index++){
			        		  node = json[index];
		        			  inner = inner + "<tr><td>" + node.mac + "</td>\
		        		 		<td>" + node.nodeName + "</td>\
								<td>";
								if (node.online) {
									inner = inner + "online";
									//inner = inner + "在线";
								} else {
									inner = inner + "offline";
									//inner = inner + "离线";
								}
								inner = inner + "</td>\
								<td>";
								if (node.switchState == 1) {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";
									
								} else {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
								} 
								inner = inner + "</td>\
								<td>" +  node.precentage + "%</td>\
								<td>";
								if (node.lastOperateType == "open") {
									inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a></div>";
								} else if(node.lastOperateType == "close") {
									inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a></div>";
								}else{
									inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a></div>";
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromBallastGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet', "+groupId+"," + node.id + "," + node.userid + " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";
		        	 	 }
			        //英文环境
	        	  	}else{
	        	  		 for(var index=0; index < json.length; index++){
			        		 node = json[index];
		        			 inner = inner + "<tr><td>" + node.mac + "</td>\
		        		 	 <td>" + node.nodeName + "</td>\
						     <td>";
						  	 if (node.online) {
								inner = inner + "online";
								//inner = inner + "在线";
				 			 } else {
								inner = inner + "offline";
								//inner = inner + "离线";
						 	 }
							 inner = inner + "</td>\
							 <td>";
							 if (node.switchState == 1) {
								inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";	
							  } else {
								inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
							  } 
							  inner = inner + "</td>\
							  <td>" +  node.precentage + "%</td>\
							  <td>";
							  if (node.lastOperateType == "open") {
								 	inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a></div>";
							   } else if(node.lastOperateType == "close") {
									inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a></div>";
								}else{
									inner = inner +"<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a></div>";
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromBallastGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet', "+groupId+"," + node.id + "," + node.userid + " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";
		        		  }
	        	  	}
		        	//动态插入表格
		            document.getElementById("ballastGroupsTbody").innerHTML = inner;
		        	
		          },
		          error: function() {  //查询失败
		        	  layer.msg(jQuery.i18n.prop('QueryFailed'));	
		          		
		          	}
		  		});		  
		 }
		 
		//8.向单个led分组表格内插入led分组下的节点数据
		 function IntoLedGroupNodeTable(groupId){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
		          data:{//参数
		        	groupid:groupId,
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var node = "";
		        	  inner = "";
		        	  //中文环境
		        	  if(i18nLanguage == "zh-CN"){
		        		  for(var index=0; index < json.length; index++){
			        		  node = json[index];
			        		  inner = inner + "<tr><td>" + node.mac + "</td>\
		        		 		<td>" + node.nodeName + "</td>\
								<td>";
								if (node.online) {
									inner = inner + "online";
									//inner = inner + "在线";
								} else {
									inner = inner + "offline";
									//inner = inner + "离线";
								}
								inner = inner + "</td>\
								<td>";
								if (node.switchState == 1) {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";
								} else {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
								} 
								inner = inner + "</td>\
								<td>" + node.precentage + "%</td>\
								<td>";
									if(node.colorPrecentage != "" || node.colorPrecentage != null){
										var bluePara = 100 - node.colorPrecentage;
										inner = inner + "红色" + node.colorPrecentage + "%;蓝色" + bluePara + "%";
									}else{
										inner =inner + "--"
									}
								inner = inner + "</td>\
								<td>";
								if (node.lastOperateType == "open") {
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a></div>";
								} else if(node.lastOperateType == "close") {
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a></div>";
								}else{
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a></div>";
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromLedGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";	 
			        	  } 
		        	  //英文环境
		        	  }else{
		        		  for(var index=0; index < json.length; index++){
			        		  node = json[index];
			        		  inner = inner + "<tr><td>" + node.mac + "</td>\
		        		 		<td>" + node.nodeName + "</td>\
								<td>";
								if (node.online) {
									inner = inner + "online";
									//inner = inner + "在线";
								} else {
									inner = inner + "offline";
									//inner = inner + "离线";
								}
								inner = inner + "</td>\
								<td>";
								if (node.switchState == 1) {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";
								} else {
									inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
								} 
								inner = inner + "</td>\
								<td>" + node.precentage + "%</td>\
								<td>";
								if(node.colorPrecentage != "" || node.colorPrecentage != null){
									var bluePara = 100 - node.colorPrecentage;
									inner = inner + "red" + node.colorPrecentage + "%;blue" + bluePara + "%";
								}else{
									inner =inner + "--"
								}
								inner = inner + "</td>\
								<td>";
								if (node.lastOperateType == "open") {
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">Toning</a></div>";
								} else if(node.lastOperateType == "close") {
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">Toning</a></div>";
								}else{
									inner = inner + "<div class='layui-btn-container'><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">ON</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">OFF</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">Dim</a>\
									<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">Toning</a></div>";
								}
								inner = inner + "</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromLedGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
							</tr>";	 
			        	  } 
		        	  }
		        	 //动态插入表格
		        	 document.getElementById("ledGroupsTbody").innerHTML = inner;
		        	
		          },
		          error: function() {  //查询失败
		        	  layer.msg(jQuery.i18n.prop('QueryFailed'));	
		          	  
		          	}
		  		});		  
		 }
		
		//9.向单个wifi分组表格内插入led分组下的节点数据
		 function IntoWifiGroupNodeTable(groupId){
			 jQuery.ajax({
				  type:"post",
		          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
		          data:{//参数
		        	groupid:groupId,
		          },
		          async : true,
		          datatype: "Json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  var json = datasource; 
		        	  var node = "";
		        	  inner = "";
		        	  if(i18nLanguage == "zh-CN"){ //中文环境
		        		  for(var index=0; index < json.length; index++){
			        		  node = json[index];
			        		  inner = inner + "<tr><td>" + node.mac + "</td>\
			        		  <td>" + node.nodeName + "</td>\
								<td>";
								if (node.online) {
									inner = inner + "online";
									//inner = inner + "在线";
								} else {
									inner = inner + "offline";
									//inner = inner + "离线";
								}
								inner = inner + "</td>\
								<td>" +  node.lux + " lux</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeLuxDim('${pageContext.request.contextPath }/nodeInGroupLuxDimFromServlet',"+ node.id +")\">调光</a></td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromWifiGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								</tr>";	 
			        	 	 }
		        	  }else{//英文环境
		        		  for(var index=0; index < json.length; index++){
			        		  node = json[index];
			        		  inner = inner + "<tr><td>" + node.mac + "</td>\
			        		  <td>" + node.nodeName + "</td>\
								<td>";
								if (node.online) {
									inner = inner + "online";
									//inner = inner + "在线";
								} else {
									inner = inner + "offline";
									//inner = inner + "离线";
								}
								inner = inner + "</td>\
								<td>" +  node.lux + " lux</td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeLuxDim('${pageContext.request.contextPath }/nodeInGroupLuxDimFromServlet',"+ node.id +")\">Dim</a></td>\
								<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromWifiGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								</tr>";	 
			        	 	 }
		        	  }
		        	  
		        	 	document.getElementById("wifiGroupsTbody").innerHTML = inner;
		        	 
		          },
		          error: function() {  
		          	  layer.msg(jQuery.i18n.prop('QueryFailed'));	
		          	}
		  		});		  
		 }
		
		
/**************************************表格内函数*****************************/
/**
 * 添加镇流器分组
 * @param url
 * @param userid
 * @returns
 */
function addBalletGroup(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop("NewGroupWindowTip"),
			cancel : function() {
				location.reload();
			}
		});
	});
}

/**
 * 添加led分组
 * @param url
 * @param userid
 * @returns
 */
function addLedGroup(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop("NewGroupWindowTip"),
			cancel : function() { 
				location.reload();
			}
		});
	});
}
/**
 * 添加wifi无线调光器分组
 * @param url
 * @param userid
 * @returns
 */
function addWifiGroup(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop("NewGroupWindowTip"),
			cancel : function() {
				location.reload();
			}
		});
	});
}

/**
 *添加镇流器到镇流器分组
 * @param url
 * @param groupid
 * @returns
 */
function addBallestToBallestGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid +"&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title: jQuery.i18n.prop('AddBNodeToGroup'),
			cancel : function() {
				location.reload();
			}
		});
	});
}

/**
 * 添加led节点至到led分组
 * @param groupid
 * @param userid
 * @returns
 */
function addLedToLedGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title: jQuery.i18n.prop('AddLNodeToGroup'),
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 添加wifi节点至wifi分组
 * @param groupid
 * @param userid
 * @returns
 */
function addWifiToWifiGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title: jQuery.i18n.prop('AddWNodeToGroup'),
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 删除分组
 * @param url
 * @param groupid
 * @returns
 */
function deleteGroup(url,groupid){
	layer.confirm(jQuery.i18n.prop('DelGroup'),{ 
  		title: jQuery.i18n.prop('Tips'),
  		btn: [jQuery.i18n.prop('confirmBtn'),jQuery.i18n.prop('Lcancel')],
    	btn1: function(){
    		 jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		            groupid:groupid,
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	  if(datasource == "删除成功"){
		        		  layer.msg(jQuery.i18n.prop('DelSuccess'),function(){
			        		  location.reload();
			        	  });
		        	  }else if(datasource == "删除失败"){
		        		  layer.msg(jQuery.i18n.prop('DelFailed'),function(){
			        		  location.reload();
			        	  });
		        	  }else{
		        		  
		        	  }
		          },
		          error: function() {  
		          	  layer.msg(jQuery.i18n.prop("submitFailed"));	
		          	}
		  		});	
    	}
  	  ,btn2: function(){
  		   //取消按钮取消删除操作
  	  	}
	});
}

/**
 * 分组重命名
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupRename(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop('EnterNewName'),
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 分组广播控制：开、关、调光
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupSwitchOnNode(url,groupid,userid){
	var switcher = "on";
	 jQuery.ajax({
		  type:"post",
          url:url,
          data:{
       	  	 userid:userid,
	         groupid:groupid,
	         switcher:switcher
         	},
         async : true,
         datatype: "String",
         success:function(datasource, textStatus, jqXHR) {
	       	  if(datasource == "指令发送成功"){
	       		  layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
			         //注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
			   		  location.reload();
		        	});	
	       	  }else if(datasource == "指令发送失败请检查设备是否离线或分组内是否存在节点"){
	       		   layer.msg(jQuery.i18n.prop('TipDevOfflineOrNoNodes'),function(){
			          //注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
			       	  location.reload();
				    });	
	       	  }else if(datasource == "提交失败"){
	       		    layer.msg(jQuery.i18n.prop('submitFailed'),function(){
			        //注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
			      		location.reload();
				    });	
	       	  }else{
	       		  
	       	  }
         },
         error: function() { //提交失败
         	layer.msg(jQuery.i18n.prop('submitFailed'));	
         	}
 		});	
}

function groupSwitchOffNode(url,groupid,userid){
	var switcher = "off";
	jQuery.ajax({
		type:"post",
        url:url,
        data:{
          userid:userid,
          groupid:groupid,
          switcher:switcher
        },
        async : true,
        datatype: "String",
        success:function(datasource, textStatus, jqXHR) {
      	  if(datasource == "指令发送成功"){
      		   layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
		           //注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
		           location.reload();
			    });	
      	  }else if(datasource == "指令发送失败请检查设备是否离线或分组内是否存在节点"){
      		    layer.msg(jQuery.i18n.prop('TipDevOfflineOrNoNodes'),function(){
		        	//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
		        	location.reload();
			     });	
      	  }else if(datasource == "提交失败"){
      		    layer.msg(jQuery.i18n.prop('submitFailed'),function(){
		           //注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
		           location.reload();
			  	});	
      	  }else{
      		  
      	  }
        },
        error: function() {  
        	layer.msg(jQuery.i18n.prop('submitFailed'));	
        	}
		});	
}

function groupDimNode(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '250px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguageStr=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title : jQuery.i18n.prop('GroupBroadcastDim'),//设置以组为单位的广播调光指令
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}
/**
 * led分组广播调色
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupToningNode(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '390px', '250px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop('GroupBroadcastTon'),//设置以组为单位的广播调色指令
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}

/**
 * 分组控制通过lux调光
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupDimByLux(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '250px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop('SetWindowTitle'),
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}


/****************************************分组内节点表格的函数***************************/

/**
 * 将节点从镇流器分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromBallastGroup(url,groupid,nodeid,userid){
	layer.confirm(jQuery.i18n.prop("RemoveNodeFromGroupTip") //确定将节点从分组内移除？
		  	,{ 
		 	offset:['0px','350px'],
	 		title:jQuery.i18n.prop('Tips'),
	      	btn: [jQuery.i18n.prop('confirmBtn'),jQuery.i18n.prop('Lcancel')], //确定，取消按钮
        	btn1: function(){
        		jQuery.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回提示
	      				  if(datasource == "节点已从分组内移除"){
	      					 layer.msg(jQuery.i18n.prop('NodeRemoveFromGroup'),function(){
	      						  //刷新
	      						IntoBallastGroupNodeTable(groupId);
		      				  });	
	      				  }else if(datasource == "移除失败"){
	      					layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
	      						  //刷新
	      						IntoBallastGroupNodeTable(groupId);
		      				  });
	      				  }else if(datasource == "参数不完整"){
	      					layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
	      						  //刷新
	      						IntoBallastGroupNodeTable(groupId);
		      				  });
	      				  }else{
	      					  
	      				  }
	      			  },
	      			  error: function() {  
	      					layer.msg(jQuery.i18n.prop('submitFailed'));	
	      	      		}
        			});	
        		}
	  	  ,btn2: function(){
	  		   //取消按钮取消删除操作
     	}
	 });
}

/**
 * 将节点led分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromLedGroup(url,groupid,nodeid,userid){
	 layer.confirm(jQuery.i18n.prop("RemoveNodeFromGroupTip") //确定将节点从分组内移除？
			,{ 
		  	offset:['0px','350px'],
			title:jQuery.i18n.prop('Tips'),
	      	btn: [jQuery.i18n.prop('confirmBtn'),jQuery.i18n.prop('Lcancel')], //确定，取消按钮
	      	btn1: function(){
	        	jQuery.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid,
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回提示
	      				  if(datasource == "节点已从分组内移除"){
	      					 layer.msg(jQuery.i18n.prop('NodeRemoveFromGroup'),function(){
	      						  //刷新
	      						  IntoLedGroupNodeTable(groupId); 
		      				  });	
	      				  }else if(datasource == "移除失败"){
	      					layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
	      						  //刷新
	      						  IntoLedGroupNodeTable(groupId);
		      				  });
	      				  }else if(datasource == "参数不完整"){
	      					layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
	      						  //刷新
	      						  IntoLedGroupNodeTable(groupId);
		      				  });
	      				  }else{
	      					  
	      				  }	
	      			  },
	      			  error: function() {  
	      					layer.msg(jQuery.i18n.prop('submitFailed'));	
	      	      		}
	        		});	
	        	
	        	}
		  	 ,btn2: function(){
		  		   //取消按钮取消删除操作
     	 		}
	 });
}

/**
 * 将节点wifi分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromWifiGroup(url,groupid,nodeid,userid){
	 layer.confirm(jQuery.i18n.prop("RemoveNodeFromGroupTip") //确定将节点从分组内移除？
		  ,{ 
		  offset:['0px','350px'],
		  title:jQuery.i18n.prop('Tips'),
		  btn: [jQuery.i18n.prop('confirmBtn'),jQuery.i18n.prop('Lcancel')], //确定，取消按钮
	      btn1: function(){
	          jQuery.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid,
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回提示
	      				  if(datasource == "节点已从分组内移除"){
	      					 layer.msg(jQuery.i18n.prop('NodeRemoveFromGroup'),function(){
	      						  //刷新
		      					  IntoWifiGroupNodeTable(groupId); 
		      				  });	
	      				  }else if(datasource == "移除失败"){
	      					layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
	      						  //刷新
		      					  IntoWifiGroupNodeTable(groupId); 
		      				  });
	      				  }else if(datasource == "参数不完整"){
	      					layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
	      						  //刷新
		      					  IntoWifiGroupNodeTable(groupId); 
		      				  });
	      				  }else{
	      					  
	      				  } 
	      			  },
	      			  error: function() {  
	      				  layer.msg(jQuery.i18n.prop('submitFailed'));	
	      	      		}
	        	});	
	       
	       	}
			,btn2: function(){
		  	   //取消按钮取消删除操作
			  }
		 });
}

/**
 * 分组内节点开灯
 * @param url
 * @param nodeid
 * @returns
 */
function nodeSwitchOn(url,nodeid){
	var switchState = 1;
	jQuery.ajax({
		  type:"post",
		  url:url, //注意：三种类型的节点开关灯都是同一个servlet
		  data:{
			  nodeid:nodeid,
			  switchState:switchState,
		  },
		  async : true,
		  datatype: "String",
		  success:function(datasource, textStatus, jqXHR) {
			  //返回提示；注意：此处需要刷新组内节点的最新信息d
			  if(datasource == "指令发送成功"){
				 layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){  		
	 				  if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
 				  });	
			  }else if(datasource == "发送失败请检查设备是否已离线"){
				 layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){  		
	 				  if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
				  });	
			  }else if(datasource == "指令发送失败"){
				 layer.msg(jQuery.i18n.prop('cmdSendFail'),function(){  		
	 				  if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
				  });	
			  }else{
				  
			  }
		  },
		  error: function() {  
			  layer.msg(jQuery.i18n.prop('submitFailed'));	
      		}
	});	
}

/**
 * 分组内节点关灯
 * @param url
 * @param nodeid
 * @returns
 */
function nodeSwitchOff(url,nodeid){
	var switchState = 0;
	jQuery.ajax({
		  type:"post",
		  url:url, //注意：三种类型的节点开关灯都是同一个servlet
		  data:{
			  nodeid:nodeid,
			  switchState:switchState,
		  },
		  async : true,
		  datatype: "String",
		  success:function(datasource, textStatus, jqXHR) {
			  //返回提示；注意：此处需要刷新组内节点的最新信息
			  if(datasource == "指令发送成功"){
				 layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){  		
					 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
 				  });	
			  }else if(datasource == "发送失败请检查设备是否已离线"){
				 layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){  		
					 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
				  });	
			  }else if(datasource == "指令发送失败"){
				 layer.msg(jQuery.i18n.prop('cmdSendFail'),function(){  		
					 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
				  });	
			  }else{
				  
			  }
		  },
		  error: function() {  
			 layer.msg(jQuery.i18n.prop('submitFailed'));	
      		}
		});	
}

/**
 * 分组内节点pwm调光弹窗
 * @param url
 * @param nodeid
 * @returns
 */
function nodePwmDim(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			title:jQuery.i18n.prop('SetWindowTitle'),
			type : 2,
			cancel : function() {
				//注意：此时刷新，返回所有控制组页面	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
	});
}
/**
 * 分组内节点调色
 * @param url
 * @param nodeid
 * @returns
 */
function nodeToning(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '300px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop('SetWindowTitle'),
			cancel : function() {
				//注意：此时刷新，返回所有控制组页面	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
	});
}
/**
 * 分组内wifi节点lux调光
 * @param url
 * @param nodeid
 * @returns
 */
function nodeLuxDim(url,nodeid){
		layer.open({
			area : [ '400px', '260px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
			closeBtn : 1,
			type : 2,
			title:jQuery.i18n.prop('SetWindowTitle'),
			cancel : function() {
				 //返回提示；注意：此处需要刷新组内节点的最新信息	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
}

	</script>
</body>
</html>