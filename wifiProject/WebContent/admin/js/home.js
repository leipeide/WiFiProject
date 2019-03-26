/**
 * 获取XMLHttpRequest对象
 */
function getXMLHttpRequest() {
	var xmlhttp;
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return xmlhttp;
}
/**
 * AJAX测试
 * 
 * @returns
 */
function testAJAX() {
	var req = getXMLHttpRequest();
	req.onreadystatechange = function() {
		if (req.readyState == 4) {// 请求成功
			if (req.status == 200) {// 服务器响应成功
				alert(req.responseText);
			}
		}
	}
	req.open("get", "${pageContext.request.contextPath }/servlet");// 建立一个链接
	req.send(null);// 发送请求
}


function removeNode(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ 'auto'],
			offset:['60px','550px'],
			btnAlign : 'c',
			resize : false,
			//resize : true,
			content : url + "?userid=" + userid,
			closeBtn : 1,
			type : 2,
			/*btn : '关闭',
			yes : function(index, layero) {
				// 按钮【按钮一】的回调
				layer.close(index);
			},*/
			cancel : function() {
				// 右上角关闭回调
				location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			}
		});
	});
}
 

function broadcastControl(url, userid) {
	layui.use('layer', function() {
	var layer = layui.layer;
		layer.open({
			area : [ 'auto'],
			offset:['60px','550px'],
			btnAlign : 'c',
			resize : false,
			//resize : true,
			content : url + "?userid=" + userid,
			closeBtn : 1,
			type : 2,
			/*btn : '关闭',
			yes : function(index, layero) {
				// 按钮【按钮一】的回调
				layer.close(index);
			},*/
			cancel : function() {
				// 右上角关闭回调
				location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			}
		});
	});
}

function addNode(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ 'auto', '200px' ],
			offset:['60px','550px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				// 右上角关闭回调
				location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			}
		});
	});
}

function um(userid){
	 // 创建一个 form      
	var form1 = document.createElement("form");     
	form1.id = "form1";      
	form1.name = "form1";        
	// 添加到 body 中     
	document.body.appendChild(form1);        
	// 创建一个输入    
	var input = document.createElement("input");     
	// 设置相应参数      
	input.type = "hidden";     
	input.name = "userid";     
    input.value = userid;        
    // 将该输入框插入到 form 中     
    form1.appendChild(input);        
    // form 的提交方式      
    form1.method = "POST";      
    // form 提交路径     
    form1.action = "userMessagesPageServlet";       
    // 对该 form 执行提交   
    form1.submit();     
    // 删除该 form      
    document.body.removeChild(form1);  
}
