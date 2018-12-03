 jQuery(function($){
        my_initGrid();
        $("#tree").ligerTree({
    		url: "corpSelectedQuery.action",
    		onSelect: onSelect,
    		idFieldName: 'id',
    		parentIDFieldName: 'pid',
    		checkbox: false,
    		itemopen: false
    	});
    	
        $("#AREA_ID").click(function(){
        	$("#treediv").show();
     
        })
    	$("#SOCIAL_TYPE_ID").ligerComboBox({
    		width : 280,
    		url:"taxPostSelectedQuery.action",
    		onSelected: function (id){
    			$("#SOCIAL_TYPE_ID_VALUE").val(id);		
    		}
    		});
    	
        $(".my_info").live("mouseover",function(){
    		$(this).addClass("my_info_mess");
    	});
    	$(".my_info").live("mouseout",function(){
    		$(this).removeClass("my_info_mess");
    	});
        $("#serchform").ligerForm();
    	$("#searchBtn").click(function(){
    		var SOCIAL_SECURITY_NO = $("#SOCIAL_SECURITY_NO").val();
    		var COMPANY_NAME = $("#COMPANY_NAME").val();
    		var TAX_PERSON_NAME = $("#TAX_PERSON_NAME").val();
    		var AREA_ID=$("#AREA_ID_VALUE").val();	
    		var SOCIAL_TYPE_ID=$("#SOCIAL_TYPE_ID_VALUE").val();	
    		g.setOptions({newPage:1});
    		g.setOptions({
    			parms: [
    				{ name: 'SOCIAL_SECURITY_NO', value: SOCIAL_SECURITY_NO },
    				{ name: 'COMPANY_NAME', value: COMPANY_NAME },
    				{ name: 'TAX_PERSON_NAME', value: TAX_PERSON_NAME },
    				{ name: 'SOCIAL_TYPE_ID', value: SOCIAL_TYPE_ID },
    				{ name: 'AREA_ID', value: AREA_ID }
    				
    			]
    		});
    		g.loadData();
    	});
    	$("#clearBtn").click(function(){
    		 $("#SOCIAL_SECURITY_NO").val("");
    		 $("#COMPANY_NAME").val("");
    		 $("#TAX_PERSON_NAME").val("");
    		 $("#AREA_ID_VALUE").val("");	
    		 $("#SOCIAL_TYPE_ID_VALUE").val("");
    		 $("#AREA_ID").val("");	
    		 $("#SOCIAL_TYPE_ID").val("");
    		g.setOptions({newPage:1});
    		g.setOptions({
    			parms: [
    				{ name: 'SOCIAL_SECURITY_NO', value: '' },
    				{ name: 'COMPANY_NAME', value: '' },
    				{ name: 'TAX_PERSON_NAME', value: '' }
    				
    			]
    		});
    		g.loadData();
    	});
    	

    	$("#importExcel").click(function(){
    		var url = "bussiness/tax/CompanyTaxMessage/ExcelUpload.jsp?servicetype=1";
    		window.top.$.ligerDialog.open({
    			name:"importExcel",url: url, width:350, height:300, 
    			modal: true, isResize: false ,title:"导入企业信息",allowClose:true,
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
    	});
    	
        
        
    });
 function onSelect(note) {
		var cdid = note.data.id;
		var value = note.data.text;
		$("#AREA_ID_VALUE").val(cdid);
		$("#AREA_ID").val(value);
		$("#treediv").hide();
	}
    /**
    初始化表格
    CustomersData：要填充的数据
    */
    function my_initGrid(){
    	window['g']=$("#maingrid").ligerGrid({
    		checkbox: true,
    		rowHeight:24,
       		height: '100%',
       		heightDiff:-8,
    		url:"CompanyTaxMessageList.action?type=1",	   																								
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
    	 	rownumbers:true,
    	 	usePager:true,
    	 	title:"社保明细",
    		toolbar: { items: [
       			/*{ text: '增加', click: itemclick, icon: 'add' },
      			{ line: true },
      			{ text: '修改', click: itemedit, icon: 'modify' },
      			{ line: true },*/
       		/*	{ text: '重复数据检查', click: itemzk, icon: 'communication'},*/
      			{ text: '删除', click: itemdelete, icon: 'delete'}
      			/*{ line: true },
    			{ text: '展开全部', click: itemzk, icon: 'communication'},
    			{ line: true },
    			{ text: '收缩全部', click: itemss, icon: 'communication'}*/
      		]}
           });
       }
       
       /**
         打开添加信息窗口的方法
       */
       function  itemclick(){
          var url = "system/dept/DeptAdd.jsp?pid=0";
          winOpen(url,"添加部门信息",500,300,'添加','取消',function(data){
    	       	$.ajax({
    				url:"deptAdd.action", 
    				data:data, 
    				dataType:"json", 
    				type:"post",
    				success:function (mm) {
    	       			if("error"==mm.result){
    	       				top.my_alert("添加部门信息失败！");
    	       			}else{
    	       				g.addRow(mm);
    						top.$.ligerDialog.success("添加部门信息成功！");
    	       			}
    				}, 
    				error:function (error) {
    					top.my_alert("添加部门信息失败！" + error.status,"error");
    				}
    			});
     		});
       
       }
       
        /**
         打开修改信息窗口的方法
       */
       function  itemedit(){
    		var selected = g.getSelected();
    		if (!selected) { top.my_alert('请选择数据行',"warn"); return; }
    		var id = (g.getSelectedRow()).BMBH; 
    		var url = "system/dept/DeptEdit.jsp?id="+id;
    		winOpen(url,"修改部门信息",500,300,'修改','取消',function(data){
    	     	$.ajax({
    				url:"deptEdit.action", 
    				data:data, 
    				dataType:"json", 
    				type:"post",
    				success:function (mm) {
    		     		if("error"==mm.result){
    	       				top.my_alert("修改部门信息失败！");
    	       			}else{
    	       				var selected = g.getSelected();
    	      				g.updateRow(selected,mm);
    						top.$.ligerDialog.success("修改部门信息成功！");
    	       			}
    				}, 
    				error:function (error) {
    					top.$.ligerDialog.error("修改部门信息失败！");
    				}
    			});
    		});
       }
       
       
       /**
        删除信息的方法
       */
    	function  itemdelete(){
    		var selected = g.getSelected();
    		if (!selected) { top.my_alert('请选择行!',"warn"); return; }
    		window.top.$.ligerDialog.confirm("确定删除所选数据吗？", "提示", function (ok) {
                if (ok) {
    				var selecteds = g.getSelecteds();
    				var idstr="";//所有选择行的id
    				for(var i=0;i<selecteds.length;i++){
    					idstr = idstr + selecteds[i].ID;
    					if(i!=(selecteds.length-1)){
    						idstr = idstr + ",";
    					}
    				}
    			
    				// 重置数据库数据
    				$.post("socialPersonDel.action", { ids: idstr},
    					function(){
    					    g.deleteRange(selecteds);
    						top.my_alert("数据删除成功!","success");
    					});
    				}
    		});
    	}
    	//收缩全部
    	function itemss(){
    	 	g.collapseAll();
    	}
    	//展开全部
    	function itemzk(){
    		g.expandAll();
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