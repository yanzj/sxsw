<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取到登陆的ID


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>保险列表</title>
     <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
 
</head>
<body>  
<div>
<!-- <div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
				<td class="ser_tit">
					<label>人社编号:</label>
				</td>
				<td class="ser_cont">
					<input id="SOCIAL_SECURITY_NO" type="text" value=""/>
				</td>
				<td class="ser_tit">
					<label>人社单位名称:</label>
				</td>
				<td class="ser_cont">
					<input id="COMPANY_NAME" type="text" value=""/>
				</td>
					<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
					<td class="ser_cont"><input type="button" id="importExcel" value="导入Excel" class="btn"/></td>
				</tr>
			</table>
		</form>
</div>
</div> -->
<!-- 需要审核的数据 -->
    <div id="maingrid"></div>
     <input id="type" type="hidden"/>
  <script type="text/javascript">
 jQuery(function($){
    my_initGrid();
});

/**
初始化表格
CustomersData：要填充的数据
*/

function my_initGrid(){
	window['g']=$("#maingrid").ligerGrid({
		checkbox: true,
		rowHeight:22,
		url:"CompanyTaxRelationQuery.action?TYPE=1",
		columns: [
			{ display: 'ID', name: 'ID',hide: true},
			{ display: 'COMPER_ID', name: 'COMPER_ID',hide: true},		
			{ display: '企业', name: 'COMPER_NAME',width:"20%" },
			{ display: '关联人社编号', name: 'SOCIAL_SECURITY_NO',width:"12%"},
			{ display: '关联社保类型', name: 'SOCIAL_TYPE',width:"10%"},
			{ display: '单位费率', name: 'RATE' ,width:"10%",
				render:function(item){
				var temp="";
				if(item.RATE!=""){
			     temp=(item.RATE)+"%";
				}
				return temp;
				}
			
			},
			{ display: '职工费率', name: 'WORKERS_RATE' ,width:"10%",
			
				render:function(item){
				var temp="--";
				
				if(item.WORKERS_RATE!=null){
				
				 temp=(item.WORKERS_RATE)+"%";
				}
				return temp;
				}
			},
			{ display: '统筹区', name: 'TAX_AREA',width:"20%"},
			{ display: '登记序号', name: 'REGISTER_NO' ,width:"10%"}
		],
		pageSize:50,
		pageSizeOptions:[50,100,150,200],
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"已审批数据",
		toolbar: { items: [
   			
  			{ text: '审批', click: itemdelete, icon: 'modify'}
  		
  		]} 
	});

}  

		function f_validate(){ 
			if(form.valid()){
				return datePost();
			}else{
			    form.showInvalid();
			}
		}
		function datePost(){
		
		 var  formData= liger.get("form2").getData();		 
			var TYPE = formData.TYPE;
			var COMPER_ID=formData.COMPER_ID;
			var data = {"TYPE":TYPE,"COMPER_ID":COMPER_ID};
			alert(COMPER_ID);
			return data;
		}



	function itemdelete(){
		var selected = g.getSelected();
		
		if (!selected) { top.my_alert('请选择数据行',"warn"); return; }
		var COMPER_ID = (g.getSelectedRow()).COMPER_ID; 
		var COMPANY_NAME  = (g.getSelectedRow()).COMPANY_NAME; 
			var selected = g.getSelected();
		if (!selected) { top.my_alert('请选择行!',"warn"); return; }
				var selecteds = g.getSelecteds();
				var idstr="";//所有选择行的id
				for(var i=0;i<selecteds.length;i++){
					idstr = idstr + selecteds[i].ID;
					if(i!=(selecteds.length-1)){
						idstr = idstr + ",";
				}
		//var SOCIAL_SECURITY_NO =(g.getSelectedRow()).SOCIAL_SECURITY_NO;
		//var COMPANY_TYPE_ID=(g.getSelectedRow()).COMPANY_TYPE_ID;
       var url = "bussiness/tax/CompanyTaxRelation/CompanyTaxRelationEdit.jsp?id="+COMPER_ID;/* COMPER_ID="+COMPER_ID+"&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO+"&COMPANY_TYPE_ID="+COMPANY_TYPE_ID; */
		winOpen(url,'社保审核',1000,600,'确定','取消',function(data){
       	$.ajax({
			url:"CompanyTaxRelationend.action?ID="+idstr+"", 
			data:data,
			dataType:"json", 
			type:"post",
			success:function (mm) {
	       		if("error" == mm.result){
	   				top.$.ligerDialog.error("失败!");
	   			}else{
	   				g.updateRow(selected,mm);
       				top.$.ligerDialog.success("成功!","提示");
       				my_initGrid();
	   			}
			}, 
			error:function (error) {
				top.$.ligerDialog.error("修改保险信息失败!" + error.status,"错误");
		}});
	});
}	
		 
}

 // 打开信窗口
function winOpen(url,title,width,height,button1,button2,callback){
	window.top.$.ligerDialog.open({
		width: width, height: height, url: url, title: title, buttons: [{
			text: button1, onclick: function (item, dialog) {
				var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
				var data = fn();
				if(data){
					callback(data);
					dialog.close();
				}
			}
		},{
			text: button2, onclick: function (item, dialog) {
				dialog.close();
			}
		}]
     });
}
    </script> 
</body>

</html>
