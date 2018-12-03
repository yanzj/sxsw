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
		url:"OrganizationQueryList.action",
		columns: [	
		          
		    { display: '行政区', name: 'AREANAME',  width:"20%" },
			{ display: '经办机构名称', name: 'TYPENAME',  width:"20%" },
			{ display: '备注', name: 'MEMO',  width:"60%",
				
			 }
		],
		pageSize:10,
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"经办机构列表",
		toolbar: { items: [
			{ text: '增加', click: itemclick, icon: 'add' },
			{ line: true },
			{ text: '修改', click: itemedit, icon: 'modify' }
			/*{ line: true },
			{ text: '删除', click: itemdelete, icon: 'delete'}*/
		]},
	/*	onSelectRow	(rowdata, rowid, rowobj){
		var	TYPENAME=rowdata.TYPENAME;
		var	MEMO=rowdata.MEMO;
		var url = "bussiness/tax/organization/Organization.jsp?MEMO='"+MEMO+"'&TYPENAME="+TYPENAME+"";
		window.top.$.ligerDialog.open({
			width: 400, height: 300, url: url, title: '详情', buttons: [{
				text: '关闭', onclick: function (item, dialog) {dialog.close();}
				
			}]
	     });			
		}*/
	});
}
   
   /**
     打开添加信息窗口的方法
   */
function  itemclick(){
	var url = "bussiness/tax/organization/OrganizationAdd.jsp";
	winOpen(url,'添加经办机构',500,300,'添加','取消',function(data){
       	$.ajax({
			url:"OrganizationAdd.action", 
			data:data,
			dataType:"json", 
			type:"post",
			success:function (mm) {
       			if("error" == mm.result){
       				top.$.ligerDialog.error("添加信息失败!");
       			}else{
	       		
	       			top.$.ligerDialog.success("添加信息成功!");
	       			my_initGrid();
       			}
			}, 
			error:function (error) {
				top.$.ligerDialog.error("添加信息失败!" + error.status,"错误");
		}});
	});
}
   
    /**
     打开修改信息窗口的方法
   */
function  itemedit(){
	var selected = g.getSelected();
	if (!selected) {  top.$.ligerDialog.warn('请选择行'); return; }
	var id = (g.getSelectedRow()).ID; 
	var url = "bussiness/tax/organization/OrganizationEdit.jsp?id='"+id+"'";
	winOpen(url,'修改经办机构',500,300,'修改','取消',function(data){
       	$.ajax({
			url:"OrganizationUpdate.action", 
			data:data,
			dataType:"json", 
			type:"post",
			success:function (mm) {
	       		if("error" == mm.result){
	   				top.$.ligerDialog.error("修改信息失败!");
	   			}else{
	   				g.updateRow(selected,mm);
       				top.$.ligerDialog.success("修改信息成功!","提示");
       				my_initGrid();
	   			}
			}, 
			error:function (error) {
				top.$.ligerDialog.error("修改信息失败!" + error.status,"错误");
		}});
	});
}
   
   
   /**
    删除信息的方法
   */
function  itemdelete(){
	var selected = g.getSelected();
    if (!selected) {  top.my_alert('请选择要删除的数据行!',"warn"); return; }
    window.top.$.ligerDialog.confirm("确定删除选择的数据", "提示", function (ok) {
	    if (ok) {
	      	g.deleteSelectedRow();
			var selecteds = g.getSelecteds();
			var idstr="";//所有选择行的id
			for(var i=0;i<selecteds.length;i++){
				idstr = idstr + selecteds[i].id;
				if(i!=(selecteds.length-1)){
					idstr = idstr + ",";
				}
			}
			/**
				删除数据库数据
			 */
			$.ajax({
				url:"OrganizationDel.action?id="+idstr, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
		       		if("error"==mm.result){
		   				top.$.ligerDialog.error("删除信息失败!");
		   			}else{
		   				top.$.ligerDialog.success("删除信息成功!");
		   			}
				}, 
				error:function (error) {
					top.$.ligerDialog.error("删除系统配置信息失败!" + error.status);
				}
				});
	     }
	 });
}


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