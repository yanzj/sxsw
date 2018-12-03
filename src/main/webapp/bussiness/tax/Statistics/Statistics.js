
jQuery(function($){
    my_initGrid();
});
/**
初始化表格
CustomersData：要填充的数据
*/
function my_initGrid(){
	window['g']=$("#maingrid").ligerGrid({
		checkbox: false,
		rowHeight:22,
		url:"CompanyTaxMessageList.action?type=1",
		columns: [
			{ display: '人社单位编号', name: 'SOCIAL_SECURITY_NO',width:180},
			{ display: '税务纳税人识别号', name: 'TAX_NO',width:180},
			{ display: '人社单位名称', name: 'COMPANY_NAME' ,width:180},
			{ display: '税务纳税人名称', name: 'PAY_TAX_PEPOLE_NAME' ,width:180},
			{ display: '人社参保单位状态', name: 'COMPANY_STATUS',width:180 },
			{ display: '税务登记类型', name: 'TAX_TYPE' ,width:180},
			{ display: '税务纳税人状态', name: 'PAY_TAX_PEPOLE_STATUS' ,width:180},
			{ display: '主管税务局', name: 'TAX_BUREAU' ,width:180},
			{ display: '主管税务所科分局', name: 'SUB_TAX_BUREAU',width:180 },			
			{ display: '人社经办机构', name: 'SOCIAL_SECURITY_ORGANIZATION',width:180 },		
			{ display: '税务行政区划', name: 'TAX_AREA' ,width:180},
			{ display: '税务街道乡镇', name: 'TAX_STREET',width:180 },
			{ display: '人社单位电话', name: 'COMPANY_TEL' ,width:180},
			{ display: '人社单位地址', name: 'COMPANY_ADDRESS' ,width:180},
			{ display: '税务联系方式', name: 'TAX_TEL' ,width:180},
			{ display: '税务生产经营地址', name: 'TAX_PRODUCT_ADDRESS',width:180 },
			{ display: '人社工商营业执照号码', name: 'SOCIAL_BUSINESS_NO',width:180 },
			{ display: '人社组织机构代码', name: 'SOCIAL_ORGRNIZATION_NO',width:180 },
			{ display: '税务组织机构', name: 'TAX_ORGANIZATION' ,width:180},
			{ display: '人社法人姓名', name: 'LEGAL_PERSON_NAME' ,width:180},
			{ display: '人社法人身份证号', name: 'LEGAL_PERSON_ID' ,width:180},
			{ display: '人社法人联系方式', name: 'LEGAL_PERSON_TEL' ,width:180},
			{ display: '税务法定代表人姓名', name: 'TAX_LEGAL_PERSON_NAME',width:180 },
			{ display: '人社专管员姓名', name: 'SOCIAL_MASTER_NAME',width:180 },
			{ display: '人社专管员联系方式', name: 'SOCIAL_MASTER_TEL' ,width:180},
			{ display: '人社单位类型', name: 'COMPANY_TYPE' ,width:180},
			{ display: '人社缴费方式', name: 'SOCIAL_PAY_TYPE' ,width:180},
			{ display: '税收管理员', name: 'TAX_ADMIN',width:180 },
			{ display: '登记序号', name: 'REGISTER_NO' ,width:180},
		],
		pageSize:50,
		pageSizeOptions:[50,100,150,200],
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"社保信息列表",
		onSelectRow	(rowdata, rowid, rowobj){
			// 获取到公司社保编号 查询 并跳转页面
			var SOCIAL_SECURITY_NO=rowdata.SOCIAL_SECURITY_NO;
			var IF_MATCHED = 1;
			var url = "bussiness/tax/Statistics/Statictype.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO+"&IF_MATCHED="+IF_MATCHED;
			window.top.$.ligerDialog.open({
				width: 1200, height: 600, url: url, title: '职工社保明细'
		     });			
			}
	});
	window['g']=$("#maingridno").ligerGrid({
		checkbox: false,
		rowHeight:22,
		url:"CompanyTaxMessageList.action?type=0",
		columns: [
			{ display: '人社单位编号', name: 'SOCIAL_SECURITY_NO',width:180},
			{ display: '税务纳税人识别号', name: 'TAX_NO',width:180},
			{ display: '人社单位名称', name: 'COMPANY_NAME' ,width:180},
			{ display: '税务纳税人名称', name: 'PAY_TAX_PEPOLE_NAME' ,width:180},
			{ display: '人社参保单位状态', name: 'COMPANY_STATUS',width:180 },
			{ display: '税务登记类型', name: 'TAX_TYPE' ,width:180},
			{ display: '税务纳税人状态', name: 'PAY_TAX_PEPOLE_STATUS' ,width:180},
			{ display: '主管税务局', name: 'TAX_BUREAU' ,width:180},
			{ display: '主管税务所科分局', name: 'SUB_TAX_BUREAU',width:180 },			
			{ display: '人社经办机构', name: 'SOCIAL_SECURITY_ORGANIZATION',width:180 },		
			{ display: '税务行政区划', name: 'TAX_AREA' ,width:180},
			{ display: '税务街道乡镇', name: 'TAX_STREET',width:180 },
			{ display: '人社单位电话', name: 'COMPANY_TEL' ,width:180},
			{ display: '人社单位地址', name: 'COMPANY_ADDRESS' ,width:180},
			{ display: '税务联系方式', name: 'TAX_TEL' ,width:180},
			{ display: '税务生产经营地址', name: 'TAX_PRODUCT_ADDRESS',width:180 },
			{ display: '人社工商营业执照号码', name: 'SOCIAL_BUSINESS_NO',width:180 },
			{ display: '人社组织机构代码', name: 'SOCIAL_ORGRNIZATION_NO',width:180 },
			{ display: '税务组织机构', name: 'TAX_ORGANIZATION' ,width:180},
			{ display: '人社法人姓名', name: 'LEGAL_PERSON_NAME' ,width:180},
			{ display: '人社法人身份证号', name: 'LEGAL_PERSON_ID' ,width:180},
			{ display: '人社法人联系方式', name: 'LEGAL_PERSON_TEL' ,width:180},
			{ display: '税务法定代表人姓名', name: 'TAX_LEGAL_PERSON_NAME',width:180 },
			{ display: '人社专管员姓名', name: 'SOCIAL_MASTER_NAME',width:180 },
			{ display: '人社专管员联系方式', name: 'SOCIAL_MASTER_TEL' ,width:180},
			{ display: '人社单位类型', name: 'COMPANY_TYPE' ,width:180},
			{ display: '人社缴费方式', name: 'SOCIAL_PAY_TYPE' ,width:180},
			{ display: '税收管理员', name: 'TAX_ADMIN',width:180 },
			{ display: '登记序号', name: 'REGISTER_NO' ,width:180},
		],
		pageSize:50,
		pageSizeOptions:[50,100,150,200],
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"社保信息列表",
		onSelectRow	(rowdata, rowid, rowobj){
			// 获取到公司社保编号 查询 并跳转页面
			var SOCIAL_SECURITY_NO=rowdata.SOCIAL_SECURITY_NO;
			var IF_MATCHED = 0;
			//设置社保默认值为 1
			var typevalue=1;
			var url = "bussiness/tax/Statistics/Statictype.jsp?IF_MATCHED="+IF_MATCHED+"&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;
			window.top.$.ligerDialog.open({
				width: 1200, height: 600, url: url, title: '职工社保明细'
		     });			
			}
	});

}   


   /**
     打开上传窗口未匹配的方法
   */
function  itemclick(){	
	var url = "bussiness/tax/CompanyTaxMessage/ExcelUpload.jsp?servicetype=1";
	window.top.$.ligerDialog.open({
		name:"CompanyTaxMessageExcelImprot",url: url, width:400, height:300, 
		modal: true, isResize: false ,title:"导入Excel",allowClose:true,
		isHidden:false, buttons: [
	          { text: '上传', onclick: function(item,dialog){
	              	var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
	              	var data = fn(function(data){
	              		
	              		g.loadData(true);
	              		dialog.close();
	              	});
	          }},
	          { text: '取消', onclick: function(item,dialog){
	          		dialog.close();
	          	}  
	    }]
	});
}
   
/**
打开上传窗口已匹配的方法
*/
function  itemclick1(){	
var url = "bussiness/tax/CompanyTaxMessage/ExcelUpload.jsp?servicetype=0";
alert("上传");
window.top.$.ligerDialog.open({
	name:"CompanyTaxMessageExcelImprot",url: url, width:400, height:300, 
	modal: true, isResize: false ,title:"导入Excel",allowClose:true,
	isHidden:false, buttons: [
          { text: '上传', onclick: function(item,dialog){
              	var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
              	var data = fn(function(data){
              		
              		g.loadData(true);
              		dialog.close();
              	});
          }},
          { text: '取消', onclick: function(item,dialog){
          		dialog.close();
          	}  
    }]
});
}

    /**
     打开修改信息窗口的方法
   */
function  itemedit(){
	var selected = g.getSelected();
	if (!selected) {  top.$.ligerDialog.warn('请选择行'); return; }
	var id = (g.getSelectedRow()).ID; 
	var url = "system/CompanyTaxMessage/CompanyTaxMessageEdit.jsp?id='"+id+"'";
	winOpen(url,'修改保险',400,400,'修改','取消',function(data){
       	$.ajax({
			url:"CompanyTaxMessageUpdate.action", 
			data:data,
			dataType:"json", 
			type:"post",
			success:function (mm) {
	       		if("error" == mm.result){
	   				top.$.ligerDialog.error("修改保险信息失败!");
	   			}else{
	   				g.updateRow(selected,mm);
       				top.$.ligerDialog.success("修改保险信息成功!","提示");
       				my_initGrid();
	   			}
			}, 
			error:function (error) {
				top.$.ligerDialog.error("修改保险信息失败!" + error.status,"错误");
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
				url:"codeDelete.action?id="+idstr, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
		       		if("error"==mm.result){
		   				top.$.ligerDialog.error("删除保险信息失败!");
		   			}else{
		   				top.$.ligerDialog.success("删除保险信息成功!");
		   			}
				}, 
				error:function (error) {
					top.$.ligerDialog.error("删除系统配置信息失败!" + error.status);
				}
				});
	     }
	 });
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