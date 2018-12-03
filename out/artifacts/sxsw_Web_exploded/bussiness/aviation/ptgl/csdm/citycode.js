	jQuery(function($){
	    my_initGrid();
	    $(".my_info").live("mouseover",function(){
			$(this).addClass("my_info_mess");
		});
		$(".my_info").live("mouseout",function(){
			$(this).removeClass("my_info_mess");
		});
		$("#serchform").ligerForm();
		$("#searchBtn").click(function() {
			var code = $("#code").val();
			var cityname = $("#cityname").val();
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
					{name : 'code',value : code},
				    {name : 'cityname',value : cityname}
				]
			});
			g.loadData();
		});
		$("#clearBtn").click(function() {
			$("#code").val("");
			$("#cityname").val("");
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
					{name : 'code',value : ""},
				    {name : 'cityname',value : ""}
				]
			});
			g.loadData();
		});
	});	
	/**
	初始化表格
	CustomersData：要填充的数据
	*/
	function my_initGrid(){
		window['g']=$("#maingrid").ligerGrid({
		    checkbox: true,
			height: "100%",
			heightDiff:-8,
		    url:"citycodeQueryList.action",
		    columns: [
				{ display: '三字码', name: 'CITYCODE', width:"8%"},
				{ display: '城市名称', name: 'CHNNAME', width:"10%"},
				{ display: 'CityName', name: 'NAME', width:"13%"},
				{ display: '国家名称', name: 'FACTIONS', width:"10%"},
				{ display: '所属区域', name: 'AREA', width:"9%"},
				{ display: '省份及地区', name: 'PROVINCE', width:"15%"},
				{ display: '创建人', name: 'YHXM', width:"10%"},
				{ display: '创建时间', name: 'CJSJ', width:"9%"},
				{ display: '备注', name: 'BZXX', width:"15%"}
		    ],
		    pageSize:10,
		    rownumbers:true,
		    root:"listmodel",
		    record:"record",
			//title:"我的消息",
		    toolbar: getBtnReourceByUrl()
		});
	}
	//批量导入城市3字代码
	function itemimport(){
		var url = "bussiness/callcenter/util/ExcelUpload.jsp?servicetype=03";
		window.top.$.ligerDialog.open({
			name:"importExcel",url: url, width:400, height:300, 
			modal: true, isResize: false ,title:"导入管控对象Excel",allowClose:true,
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