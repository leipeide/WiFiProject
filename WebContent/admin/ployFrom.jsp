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
	width:100px;
	height:50px;
/* 	border:3px solid #00695F; */
	}
.tableDiv{
/*     border:3px solid #00695F;      */
}

</style> 
</head>
<body>
	<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
		<ul class="layui-tab-title">
			<!--<li class="layui-this" lay-id="ballastPloy">镇流器策略</li> -->
 			<li lay-id="ledDriverPloy">led驱动器策略</li>
			<!-- <li lay-id="wifiPloy">wifi无线调光器策略</li> -->
		</ul>
		<div class="layui-tab-content">
			<!-- 1.Tab镇流器策略控制区域 -->
			<div class="layui-tab-item" id=""></div>
			
			<!-- 2.Tabled驱动器策略控制区域 -->
			<div class="layui-tab-item layui-show" id="ledPloy_table">
				<form class="layui-form" method="" action="">
					<div class="functionDiv">
						<div class="addPloyDiv">
							<a href="javascript:;" class="layui-btn" onclick="newLedPloy('${pageContext.request.contextPath }/newPloyFromServlet',${userid})">添加策略</a>
						</div>
						<div class="selectPloyDiv">
							<select name="selectFilter" lay-filter="select">
								<option value="allPloy">所有策略</option>
								<c:forEach items="${result.ledPloy}" var="ledPloy">
									<option value=${ledPloy.id}>${ledPloy.ployName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv">
						<div id="allPloyTableDiv" style="display: block">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>名称</th>
										<th>绑定分组</th>
										<th>执行状态</th>
										<th>添加操作</th>
										<th>编辑策略</th>
<!-- 										<th>删除</th>
										<th>执行设置</th>
										 -->
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${result.ledPloy}" var="ledPloy">
										<tr>
											<td><a href="javascript:;"
												onclick="ployRename('${pageContext.request.contextPath }/ployRenameFromServlet',${userid},${ledPloy.id})">
													<span><font color="#009688">${ledPloy.ployName}</font></span>
											</a></td>
											<td><a href="javascript:;"
												onclick="groupMessage('${pageContext.request.contextPath }/groupMessageServlet',${userid},${ledPloy.groupid})">
													<span><font color="#009688">${ledPloy.groupid}</font></span>
											</a></td>
											<td>${ledPloy.runState == 0 ? "未执行" : "执行中"}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addOperate('${pageContext.request.contextPath }/addPloyOperateFormServlet',${userid},${ledPloy.id},${ledPloy.runState})">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="runPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">执行</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="stopPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">停止</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="ledPloyChangeGroup('${pageContext.request.contextPath }/ployChangeGroupFormServlet',${userid},${ledPloy.id},${ledPloy.groupid},${ledPloy.runState })">
													<i class="layui-icon">&#xe642;</i></a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
													onclick="deletePloy('${pageContext.request.contextPath }/deletePloyServlet',${userid},${ledPloy.id},${ledPloy.runState})">
													<i class="layui-icon">&#xe640;</i></a>
											</td>
<!-- 											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deletePloy('${pageContext.request.contextPath }/deletePloyServlet',${userid},${ledPloy.id},${ledPloy.runState})">
													<i class="layui-icon">&#xe640;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="runPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">执行</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="stopPloy('${pageContext.request.contextPath }/ployRunStateChangeServlet',${ledPloy.id},${userid })">停止</a>
											</td>
											 -->
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 	单个策略内操作表格 -->
						<div id="onePloyTableDiv" style="display:none">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>策略名称</th>
										<th>操作类型</th>
										<th>参数</th>
										<th>执行时间范围</th>
										<th>指令时间</th>
										<th>删除</th>
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
				</form>
			</div>
			
			<%--wifi无线调光器策略控制Tab选项区域 --%>
			<div class="layui-tab-item"></div>
			
		</div>
	</div>	
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/ployForm.js"></script>		
	<script type="text/javascript">
	    var ployid = "";
		layui.use(['element','form'], function(){
			  var element = layui.element;
			  var form = layui.form;
			  //1.监听Tab选项卡
			  var layid = location.hash.replace(/^#TabBrief=/, ''); //.获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
			  element.tabChange('TabBrief', layid); //.切换到lay-id对应的tab选项
			  element.on('tab(TabBrief)', function(){  //.监听Tab切换，以改变地址hash值
			    location.hash = 'TabBrief='+ this.getAttribute('lay-id');
			  });
			
			  //2.监听select;触发了select选择查看策略
			  form.on('select(select)',function(data){
				  if(data.value == "allPloy"){ //返回所有策略的页面
					  document.getElementById("onePloyTableDiv").style.display = "none";
					  document.getElementById("allPloyTableDiv").style.display = "block";
					  //注意：确认此次是否要更新
				  }else{//进入单个策略内的策略操作页面
					  document.getElementById("onePloyTableDiv").style.display = "block";
					  document.getElementById("allPloyTableDiv").style.display = "none";
					  ployid = data.value;
					  IntoPloyOperateTable(ployid);
					  //每隔一分钟刷新单个策略操作表格;定时刷新问题需要解决
					  //setInterval(WelcomeAJAXRequest,1000*3);
					 
				  }
			  });
			  
			});
		
		//ajax获取单个策略里的操作集合，并将数据动态插入到第2个table中
		function IntoPloyOperateTable(ployid){
			layui.use('layer', function(){
				 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
			    ,layer = layui.layer;
					 $.ajax({
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
											inner = inner + "开关灯";
										} else if(operate.operateType == 2){
											inner = inner + "调光";
										} else if(operate.operateType == 3){
											inner = inner + "调色";
										}
										inner = inner + "</td>\
										<td>";
										if (operate.operateParam == 0) {
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
				          error: function() {  
				          	 // layer.msg("提交失败!");	
				          	}
				  		});		  
		  		});		  
		}
		
	</script>
	
</body>
</html>