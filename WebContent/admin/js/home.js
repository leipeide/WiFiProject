//Layui JavaScript代码区域
layui.use('element', function() {
	var element = layui.element;

});
/**
 * ifarme区域页面切换为策略页面
 * @returns
 */
function ployControl(url,userid){
	document.getElementById('body-div').innerHTML = "<iframe style='min-height: 500px' name='fname' frameborder='0' scrolling='yes' width='100%' src='"+url+"?userid="+userid+"' class='body-frame'></iframe>";
}
/**
 * ifarme区域页面切换为报警页面
 * @returns
 */
function alarmMessage(url,userid){
	document.getElementById('body-div').innerHTML = "<iframe style='min-height: 500px' name='fname' frameborder='0' scrolling='yes' width='100%' src='"+url+"?userid="+userid+"' class='body-frame'></iframe>";
}
/**
 * 删除节点
 * @param url
 * @param userid
 * @returns
 */
function removeNodeFunction(url, userid) {
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

/**
 * 添加节点
 * @param url
 * @param userid
 * @returns
 */
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
/**
 * wifi重置,配置新的wifi信息
 * @param url
 * @param userid
 * @returns
 */
function wifiReset(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px','400px'],
			offset:['60px','550px'],
			btnAlign : 'c',
			resize : false,
			//resize : true,
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
/**
 * 恢复wifi至AP模式，重新配置wifi
 * @param url
 * @param userid
 * @returns
 */
function wifiApModel(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
		    //area: ['100%', '100%'],
			//offset:['0px','0px'],
			area: ['400px', '300px'],
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
/*		layer.alert('执行该操作后节点将恢复至AP模式，需要重新配置wifi，确定进行执行该操作吗？', {
			  btn: ['确定', '取消'] //可以无限个按钮
			 ,yes: function(index, layero){
				 //按钮【确定】的回调
				 layer.close(index);//关闭alert提示
				 layer.open({
						//area : ['auto'],
					    area :['350px','350px'],
						offset:['60px','550px'],
						btnAlign : 'c',
						resize : false,
						content : url + "?userid=" + userid,
						//scrollbar:true,
						closeBtn : 1,
						type : 2,
						cancel : function() {
							// 右上角关闭回调
							location.reload();
							// return false 开启该代码可禁止点击该按钮关闭
						}
					});
			 	}
			,btn2: function(index, layero){
				//按钮【取消】的回调；关闭alert提示
				 layer.close(index)
				}
			}, function(){
			  //do something
			});   
	*/
	});
}

/**
 * 跳转到用户信息页面
 * @param url
 * @param userid
 * @returns
 */
function um(url,userid){
	location.href=url + "?userid="+userid;
}
