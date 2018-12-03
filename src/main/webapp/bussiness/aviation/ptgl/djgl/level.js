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
			var DJMC = $("#DJMC").val();
			var DJJC = $("#DJJC").val();
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
					{name : 'DJMC',value : DJMC},
				    {name : 'DJJC',value : DJJC}
				]
			});
			g.loadData();
		});
		$("#clearBtn").click(function() {
			$("#DJMC").val("");
			$("#DJJC").val("");
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
					{name : 'DJMC',value : ""},
				    {name : 'DJJC',value : ""}
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
		    url:"levelQueryList.action",
		    columns: [
				{ display: '等级简称', name: 'DJJC', width:"20%"},
				{ display: '等级名称', name: 'DJMC', width:"20%"},
				{ display: '最小分值', name: 'ZXFZ', width:"20%"},
				{ display: '最大分值', name: 'ZDFZ', width:"20%"},
				{ display: '备注信息', name: 'BZXX', width:"20%"}
				
		    ],
		    pageSize:10,
		    rownumbers:true,
		    root:"listmodel",
		    record:"record",
			title:"等级管理列表",
			toolbar: { items: [
			       			{ text: '添加', click: itemclick, icon: 'add' },
			       			{ line: true },
			       			{ text: '编辑', click: itemedit, icon: 'modify' },
			       			{ line: true }
			       		]}
		    
		});
	}
	 /**
    打开添加窗口的方法
  */
  function  itemclick(){
     var url = "bussiness/aviation/ptgl/djgl/LevelAdd.jsp";
     winOpen(url,"添加等级信息",500,300,'添加','取消',function(data){
	       	$.ajax({
				url:"levelAdd.action", 
				data:data, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
	       			if("error"==mm.result){
	       				top.my_alert("添加等级信息失败！");
	       			}else{
	       				my_initGrid();
						top.$.ligerDialog.success("添加等级信息成功！");
	       			}
				}, 
				error:function (error) {
					top.my_alert("添加等级信息失败！" + error.status,"error");
				}
			});
		});
  
  }
  /**
  打开修改窗口的方法
*/
function  itemedit(){
		var selected = g.getSelected();
		if (!selected) { top.my_alert('请选择数据行',"warn"); return; }
		var id = (g.getSelectedRow()).BH; 
		var url = "bussiness/aviation/ptgl/djgl/LevelEdit.jsp?id="+id;
		winOpen(url,"修改等级信息",500,300,'修改','取消',function(data){
	     	$.ajax({
				url:"levelEdit.action", 
				data:data, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
		     		if("error"==mm.result){
	       				top.my_alert("修改等级信息失败！");
	       			}else{
	       				my_initGrid();
						top.$.ligerDialog.success("修改等级信息成功！");
	       			}
				}, 
				error:function (error) {
					top.$.ligerDialog.error("修改等级信息失败！");
				}
			});
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