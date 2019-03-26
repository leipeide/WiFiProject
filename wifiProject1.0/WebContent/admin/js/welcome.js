
/**
 * 节点单灯控制
 * 
 * @param {*}
 *            url 请求表单的servlet地址
 * @param {*}
 *            nodeid 设备id
 */
function nodeControl(url, nodeid) {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ 'auto', '350px' ],
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
			area : [ 'auto', '220px' ],
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

function  nextPage(currPage,totalPage){
	//alert("总的页面："+totalPage+";"+"当前页面："+currPage);
	if(totalPage == 0 || totalPage == currPage){
		document.getElementById("pageBt").disabled=true;
		//alert("下一页禁用");
	}else{
		document.getElementById("pageBt").disabled=false;
	}
}


