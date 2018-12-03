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
			var MC = $("#MC").val();
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
					{name : 'MC',value : MC}
				]
			});
			g.loadData();
		});
		$("#clearBtn").click(function() {
			$("#MC").val("");
			g.setOptions({
				newPage : 1
			});
			g.setOptions({
				parms : [
				    {name : 'MC',value : ""}
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
		    url:"databaseinfoQueryList.action",
		    columns: [
				{ display: '库名称', name: 'MC', width:"20%",
				  render:function(item){
					  return "<span class=\"my_info\" onclick=\"javascript:openDialog('"+item.BH+"','"+item.MC+"')\">"+item.MC+"</span>";
				  }
				},
				{ display: '服务id', name: 'FWID', width:"20%"},
				{ display: '分值', name: 'FZ', width:"10%"},
				{ display: '预警原因', name: 'YJYY', width:"15%"},
				{ display: '预警要求', name: 'YJYQ', width:"15%"},
				{ display: '备注信息', name: 'BZXX', width:"20%"}
				
		    ],
		    pageSize:10,
		    rownumbers:true,
		    root:"listmodel",
		    record:"record",
			title:"碰撞库管理列表",
			toolbar: { items: [
			       			{ text: '添加', click: itemclick, icon: 'add' },
			       			{ line: true },
			       			{ text: '编辑', click: itemedit, icon: 'modify' },
			       			{ line: true }
			       		]}
		    
		});
	}
	
   /**打开详细信息*/
	function openDialog(id,name)
	{
		var url = "bussiness/aviation/ptgl/pzkgl/DatabaseinfoMess.jsp?id="+id;
		var tabid = "GDPJ" + "-" + id;
		window.top.f_addTab(tabid,name,url);
	}
	
  /**
    打开添加窗口的方法
  */
  function  itemclick(){
     var url = "bussiness/aviation/ptgl/pzkgl/DatabaseinfoAdd.jsp";
     winOpen(url,"添加碰撞库信息",500,350,'添加','取消',function(data){
	       	$.ajax({
				url:"databaseinfoAdd.action", 
				data:data, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
	       			if("error"==mm.result){
	       				top.my_alert("添加碰撞库信息失败！");
	       			}else{
	       				my_initGrid();
						top.$.ligerDialog.success("添加碰撞库信息成功！");
	       			}
				}, 
				error:function (error) {
					top.my_alert("添加碰撞库信息失败！" + error.status,"error");
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
		var url = "bussiness/aviation/ptgl/pzkgl/DatabaseinfoEdit.jsp?id="+id;
		winOpen(url,"修改碰撞库信息",500,350,'修改','取消',function(data){
	     	$.ajax({
				url:"databaseinfoEdit.action", 
				data:data, 
				dataType:"json", 
				type:"post",
				success:function (mm) {
		     		if("error"==mm.result){
	       				top.my_alert("修改碰撞库信息失败！");
	       			}else{
	       				my_initGrid();
						top.$.ligerDialog.success("修改碰撞库信息成功！");
	       			}
				}, 
				error:function (error) {
					top.$.ligerDialog.error("修改碰撞库信息失败！");
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