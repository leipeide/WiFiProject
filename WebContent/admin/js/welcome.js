/**
 * 节点广播控制；三种类型共用一个广播控制函数
 * @param url
 * @param userid
 * @param param:类型参数字符串（ballastBC、ledBC、wifiBC）；
 * 由于三种节点类型共用一个广播控制函数，为区别是哪一类型进行广播控制，用param字符串进行区分
 * @returns
 */
function BroadcastControl(url,userid,param){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&typeParam=" + param,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				// 右上角关闭回调
				location.reload();
			}
		});
	});
}
/**
 * 节点单灯控制
 * 
 * @param {*}
 *  url 请求表单的servlet地址
 * @param {*}
 *  nodeid 设备id
 */
function nodeControl(url, nodeid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ 'auto', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
			closeBtn : 1,
			type : 2,
			/*btn : '关闭',
			yes : function(index, layero) {
				// 按钮【按钮一】的回调
				location.reload();
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

/**
 * 节点重命名
 * @param url
 * @param nodeid
 * @returns
 */
function nodeRename(url, nodeid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
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

/**
 * 下一页按钮禁用、开启使用
 * @param currPage
 * @param totalPage
 * @returns
 */
function  nextPage(currPage,totalPage){
	if(totalPage == 0 || totalPage == currPage){
		document.getElementById("pageBt").disabled=true;
	}else{
		document.getElementById("pageBt").disabled=false;
	}
}

/**
 * 节点开、关、调光、调色控制
 * @param url
 * @param nodeid
 * @returns
 */
function switchOnNode(url,nodeid){
	var switcher = "on";
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		            nodeid:nodeid,
		            switcher:switcher
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  layer.msg(datasource,function(){
		        		  location.reload();
		        	  });
		        	
		          },
		          error: function() {  
		          	layer.msg("提交失败!");	
		          	}
		  		});	
		});
}

function switchOffNode(url,nodeid){
	var switcher = "off";
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		            nodeid:nodeid,
		            switcher:switcher
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  layer.msg(datasource,function(){
		        		  location.reload();
		        	  });
		          },
		          error: function() {  
		          	layer.msg("提交失败!");	
		          	}
		  		});	
		});
}

function dimNode(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
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
function toningNode(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
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
/**
 * wifi勒克斯调光
 * @param url
 * @param nodeid
 * @returns
 */
function luxDimNode(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//1.右上角关闭回调
				location.reload();
			}
		});
	});
}
