<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="refresh" content="5"> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<title>Insert title here</title>
<style>
  .pagenation { width: 100%; position: relative; bottom: -20px;}
</style> 
</head>
<body>
	<form method="post"
		action="${pageContext.request.contextPath }/servlet">
		<table class="layui-table">
			<colgroup>
				<col width="150">
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>节点mac地址</th>
					<th>节点名称</th>
					<th>网络状态</th>
					<th>当前输出百分比</th>
					<th>当前开关状态</th>
					<th>灯光控制</th>
				</tr>
			</thead>
			<tbody id="nodes-list">
			<!--  	<c:forEach items="${pb.nodes }" var="node">
					<tr>
						<td>${node.mac }</td>
						<td><a href="javascript:;"
							onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${node.id})">${node.nodeName }</a></td>
						<td>${node.online == true ? "online" : "offline" }</td>
						<td>${node.precentage }</td>
						<td>${node.switchState }</td>
						<td><a href="javascript:;"
							onclick="nodeControl('${pageContext.request.contextPath }/nodeFormServlet', ${node.id })">调光</a></td>
					</tr>
				</c:forEach>  -->	
			</tbody>
		</table>
	</form>
	
 	<div id="pagenation" class="pagenation" style="text-align:center">
			 <a href="${pageContext.request.contextPath  }/welcomeServlet?currentPage=${pb.currentPage==1?1:pb.currentPage-1}&userid=${userid}">
			 	<button  class="layui-btn layui-btn-primary layui-btn-xs" >上一页</button></a> &nbsp; 
			<c:if test="${pb.totalPage == '0'}">
			 	  第 1 页 &nbsp;/&nbsp;共${pb.totalPage }页 
			 	<a href="${pageContext.request.contextPath  }/welcomeServlet?currentPage=${(pb.currentPage==pb.totalPage)?pb.totalPage:pb.currentPage}&userid=${userid}">                                                        
				<button  id ="pageBt" class="layui-btn layui-btn-primary layui-btn-xs"   onclick="nextPage(${pb.currentPage},${pb.totalPage})">下一页</button></a>     
			</c:if>  
			<c:if test="${pb.totalPage != '0'}">
			  	 第${pb.currentPage }页 &nbsp;/ &nbsp;共 ${pb.totalPage }页  &nbsp;         
				<a href="${pageContext.request.contextPath  }/welcomeServlet?currentPage=${(pb.currentPage==pb.totalPage)?pb.totalPage:pb.currentPage+1}&userid=${userid}">                                                        
				<button  id ="pageBt" class="layui-btn layui-btn-primary layui-btn-xs"   onclick="nextPage(${pb.currentPage},${pb.totalPage})">下一页</button></a>
			</c:if> 
 	</div>  
 			
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/welcome.js"></script>
		
	<script type="text/javascript">
	function getXMLHttpRequest(){
		var xmlhttp;
		if(window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		}else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return xmlhttp;
	}


		function WelcomeAJAXRequest() {
			var req = getXMLHttpRequest();
			req.onreadystatechange = function() {
				if (req.readyState == 4) {// 请求成功
					if (req.status == 200) {// 服务器响应成功
						var pbs = JSON.parse(req.responseText);
						var nodes = pbs.nodes;
						var inner = "";
						var node;
						for(var i=0; i < nodes.length; i++){
							node = nodes[i];
							inner = inner + "<tr>\
				            <td>" + node.mac + "</td>\
							<td><a href='javascript:;'onclick=\"nodeRename('/wifiProject/nodeRenameFromServlet', " + node.id + ")\"> " + node.nodeName +"</a></td>\
							<td>";
							if(node.online == true){
								inner = inner + "online";
							}else {
								inner = inner + "offline";
							}
							inner = inner + "</td>\
							<td>" + node.precentage +"</td>\
							<td>" + node.switchState +"</td>\
							<td><a href='javascript:;'onclick=\"nodeControl('/wifiProject/nodeFormServlet', " + node.id +")\">调光</a></td>\
						</tr>";
						}
						document.getElementById("nodes-list").innerHTML = inner;
					}
				}
			}
			req.open("get","${pageContext.request.contextPath }/welcomeRefreshServlet?userid=${userid}&currentPage=${pb.currentPage}");// 建立一个链接
			req.send(null);// 发送请求
		}
		
		window.onload = function() {
			WelcomeAJAXRequest();
		}
		setInterval(WelcomeAJAXRequest,1000*3);
	
	</script>
</body>
</html>