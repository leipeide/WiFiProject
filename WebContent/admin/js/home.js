//1.Layui JavaScript代码区域
layui.use(['element'], function() {
	var element = layui.element;
});
           

/**
 * ifarme区域页面切换为分组管理页面
 * @returns
 */
function groupControl(url,userid){
	document.getElementById('body-div').innerHTML = "<iframe style='min-height: 500px' name='fname' frameborder='0' scrolling='yes' width='100%' src='"+url+"?userid="+userid+"&i18nLanguage="+i18nLanguage+"' class='body-frame'></iframe>";
}
/**
 * ifarme区域页面切换为策略页面
 * @returns
 */
function ployControl(url,userid){
	document.getElementById('body-div').innerHTML = "<iframe style='min-height: 500px' name='fname' frameborder='0' scrolling='yes' width='100%' src='"+url+"?userid="+userid+"&i18nLanguage="+i18nLanguage+"' class='body-frame'></iframe>";
}
/**
 * ifarme区域页面切换为报警页面
 * @returns
 */
function alarmMessage(url,userid){
	document.getElementById('body-div').innerHTML = "<iframe style='min-height: 500px' name='fname' frameborder='0' scrolling='yes' width='100%' src='"+url+"?userid="+userid+"&i18nLanguage="+i18nLanguage+"' class='body-frame'></iframe>";
}
/**
 * 删除节点
 * @param url
 * @param userid
 * @returns i18nLanguage全局变量
 */
function removeNodeFunction(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : ['350px','450px'],
			offset:'auto', // 默认坐标，即垂直水平居中
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage="+i18nLanguage,
			closeBtn : 1,
			type : 2,
			title: jQuery.i18n.prop("LdeleteNode"),
			cancel : function() {
				// 右上角关闭回调
				location.reload();
			
			}
		});
	});
}

/**
 * 添加节点
 * @param url
 * @param userid
 * @returns i18nLanguage全局变量
 */
function addNode(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ 'auto', '200px' ],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage="+i18nLanguage,
			closeBtn : 1,
			type : 2,
			//title:"添加节点",
			title:jQuery.i18n.prop("LaddNode"),
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
 * @returns i18nLanguage全局变量
 */
function wifiReset(url, userid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px','400px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage="+i18nLanguage,
			closeBtn : 1,
			type : 2,
			//title:"更改wifi网络",
			title:jQuery.i18n.prop("LchangeInternet"),
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
 * @returns i18nLanguage全局变量
 */
function wifiApModel(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area: ['400px', '300px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&i18nLanguage="+i18nLanguage,
			closeBtn : 1,
			type : 2,
			//title:"清除节点网络信息",
			title:jQuery.i18n.prop("LclearInternet"),
			cancel : function() {
				// 右上角关闭回调
				location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			}
		});
	});
}

/**
 * 跳转到用户信息页面
 * @param url
 * @param userid
 * @returns i18nLanguage全局变量
 */
function um(url,userid){
	location.href=url + "?userid="+userid+"&i18nLanguage="+i18nLanguage;
}
