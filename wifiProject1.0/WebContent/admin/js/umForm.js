function homePage(userid){
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
    form1.action = "returnHomeServlet";       
    // 对该 form 执行提交   
    form1.submit();     
    // 删除该 form      
    document.body.removeChild(form1);  
}