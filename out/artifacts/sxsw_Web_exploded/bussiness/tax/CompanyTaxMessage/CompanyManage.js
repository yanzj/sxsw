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
		url:"CompanyManageList.action",
		columns: [
            { display: '行政区', name: 'AREANAME',width:180},
			{ display: '人社单位编号', name: 'SOCIAL_SECURITY_NO',width:180},
			{ display: '税务纳税人识别号', name: 'TAX_NO',width:180},
			{ display: '人社单位名称', name: 'COMPANY_NAME' ,width:180},
			{ display: '税务纳税人名称', name: 'PAY_TAX_PEPOLE_NAME' ,width:180},
			{ display: '社保类型名称', name: 'TYPENAME' ,width:180},
			{ display: '密码', name: 'PASSWORD' ,width:180},
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
			{ display: '登记序号', name: 'REGISTER_NO' ,width:180}
		],
		pageSize:50,
		pageSizeOptions:[50,100,150,200],
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"企业管理",
		toolbar: { items: [
         			{ text: '修改密码', click: itemedit, icon: 'modify'},
         			{ line: true }
         			/*{ text: '增加', click: itemclick, icon: 'add' },
        			{ line: true },
        			{ text: '修改', click: itemeditMsg, icon: 'modify' },
        			{ line: true }*/
        ]}
		
	});
}

/**
打开修改密码信息窗口的方法
*/
function  itemedit(){
	var selected = g.getSelected();
	if (!selected) { top.my_alert('请选择行!',"warn"); return; }
	var selecteds = g.getSelecteds();
	if(selecteds.length>1){ top.my_alert('请选择唯一的行!',"warn"); return; }
	var id = (g.getSelectedRow()).ID; 
	var url = "bussiness/tax/CompanyTaxMessage/CompanyEdit.jsp?id="+id;
	winOpen(url,"修改企业密码",400,180,'修改','取消',function(data){
    	$.ajax({
			url:"resetPwd.action", 
			data:data, 
			dataType:"json", 
			type:"post",
			success:function (mm) {
	     		if("error"==mm.result){
      				top.my_alert("修改密码失败！");
      			}else{
      				my_initGrid();
					top.$.ligerDialog.success("修改密码成功！");
      			}
			}, 
			error:function (error) {
				top.$.ligerDialog.error("修改密码失败！");
			}
		});
	});
}

/**
打开添加信息窗口的方法
*/
function  itemclick(){
var url = "bussiness/tax/CompanyTaxMessage/CompanyAdd.jsp";
winOpen(url,'添加企业信息',900,600,'添加','取消',function(data){
  	$.ajax({
		url:"CompanyAdd.action", 
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
function  itemeditMsg(){
var selected = g.getSelected();
if (!selected) {  top.$.ligerDialog.warn('请选择行'); return; }
var id = (g.getSelectedRow()).ID; 
var url = "bussiness/tax/organization/OrganizationEdit.jsp?id='"+id+"'";
winOpen(url,'修改企业信息',500,300,'修改','取消',function(data){
  	$.ajax({
		url:"CompanyUpdate.action", 
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

