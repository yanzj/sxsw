var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
$(function() {
	cacheDataSet = $(window.top.document).find("#cacheDataSet");
	//=====================================审批人员=================================
	//start 审批人员
	$("#selectuser").click(function() {
		f_selectContact();
	});
	function f_selectContact() {
		var basePath = $("#mypath").val();
		cacheDataSet.children("#cacheRY").addClass("selected");
		cacheDataSet.children("#cacheYJ").removeClass("selected");
		cacheDataSet.children("#cacheDept").removeClass("selected");
		window.top.$.ligerDialog.open({
			title : '选择人员',
			name : 'winselector',
			width : 900,
			height : 500,
			url : basePath
					+ 'bussiness/aviation/util/UserListMultiSelect.jsp',
			buttons : [

			{
				text : '确定',
				onclick : f_selectContactOK
			}, {
				text : '取消',
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
		});
		return false;
	}
	function f_selectContactOK(item, dialog) {
		var basePath = $("#mypath").val();
		var fn = dialog.frame.f_select || dialog.frame.window.f_select;
		var data = fn();
		if (!data) {
			alert('请选择人员');
			return;
		}
		cacheRY = data;
		cacheDataSet.children("#cacheRY").text("");
		cacheDataSet.children("#cacheRY").text(JSON.stringify(cacheRY));
		var users = "";
		for (var i = 0; i < data.length; i++) {
			var s = "<span style='font-size:14px;margin-right:10px' id='"
					+ data[i].id + "ry'>" + data[i].name + " <img src='"
					+ basePath + "images/delete.png' onclick=\"removeUser('"
					+ data[i].id + "','" + data[i].name
					+ "','spry')\" style=\"cursor:pointer\" /></span>";
			users += s;
		}
		
		$("#sdesc").attr("style","width:400px;min-height: 30px;background: #F2F2F2;border: 1px solid #D1D1D1;border-radius: 3px;overflow:auto;");
		$("#sdesc").html(users);
		dialog.close();
	}
	//end 审批人员
	
	//=====================================预警值班账号=======================================
	//start 预警值班账号
	$("#selectyjzbzh").click(function() {
		f_selectDept();
	});
	function f_selectDept() {
		var basePath = $("#mypath").val();
		cacheDataSet.children("#cacheDept").addClass("selected");
		cacheDataSet.children("#cacheYJ").removeClass("selected");
		cacheDataSet.children("#cacheRY").removeClass("selected");
		window.top.$.ligerDialog.open({
			title : '选择人员',
			name : 'winselector',
			width : 900,
			height : 500,
			url : basePath + 'bussiness/aviation/util/UserListMultiSelect.jsp?SelectDept=yjzbzh',
			buttons : [ {
				text : '确定',
				onclick : f_selectContactOKyjzbzh
			}, {
				text : '取消',
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
		});
		return false;
	}
	function f_selectContactOKyjzbzh(item, dialog) {
		var basePath = $("#mypath").val();
		var fn = dialog.frame.f_select || dialog.frame.window.f_select;
		var data = fn();
		if (!data) {
			alert('请选择人员');
			return;
		}
		cacheDept = data;
		cacheDataSet.children("#cacheDept").text("");
		cacheDataSet.children("#cacheDept").text(JSON.stringify(cacheDept));
		var users = "";
		for (var i = 0; i < data.length; i++) {
			var s = "<span style='font-size:14px;margin-right:10px' id='"
					+ data[i].id + "zbzh'>" + data[i].name + " <img src='"
					+ basePath + "images/delete.png' onclick=\"removeUser('"
					+ data[i].id + "','" + data[i].name
					+ "','yjzbzh')\" style=\"cursor:pointer\" /></span>";
			users += s;
		}
		$("#sdescyjzbzh").html(users);
		dialog.close();
	}
	
	//end 预警值班账号
	
	
	//=====================================预警对象===========================================
	//start 预警对象
	$("#selectuseryj").click(function() {
		f_selectContactyj();
	});
	function f_selectContactyj() {
		var basePath = $("#mypath").val();
		cacheDataSet.children("#cacheYJ").addClass("selected");
		cacheDataSet.children("#cacheRY").removeClass("selected");
		cacheDataSet.children("#cacheDept").removeClass("selected");
		window.top.$.ligerDialog.open({
			title : '选择人员',
			name : 'winselector',
			width : 900,
			height : 500,
			url : basePath + 'bussiness/aviation/util/UserListMultiSelect.jsp',
			buttons : [ {
				text : '确定',
				onclick : f_selectContactOKyj
			}, {
				text : '取消',
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
		});
		return false;
	}
	function f_selectContactOKyj(item, dialog) {
		var basePath = $("#mypath").val();
		var fn = dialog.frame.f_select || dialog.frame.window.f_select;
		var data = fn();
		if (!data) {
			alert('请选择人员');
			return;
		}
		cacheYJ = data;
		cacheDataSet.children("#cacheYJ").text("");
		cacheDataSet.children("#cacheYJ").text(JSON.stringify(cacheYJ));
		var users = "";
		for (var i = 0; i < data.length; i++) {
			var s = "<span style='font-size:14px;margin-right:10px' id='"
					+ data[i].id + "yj'>" + data[i].name + " <img src='"
					+ basePath + "images/delete.png' onclick=\"removeUser('"
					+ data[i].id + "','" + data[i].name
					+ "','yjry')\" style=\"cursor:pointer\" /></span>";
			users += s;
		}
		$("#sdescyj").html(users);
		dialog.close();
	}
	//end 预警对象
});

//清除值班账号
function cleardept(){
	 cacheDept = [];
	 cacheDataSet.children("#cacheDept").text("");
	 $("#sdescyjzbzh").html("");
}

//清除预警对象
function clearuseryj(){
	 cacheYJ = [];
	 cacheDataSet.children("#cacheYJ").text("");
	 $("#sdescyj").html("");
}
//移除选择的人员
function removeUser(id, name,type) {
	var data;
	if(type=="spry"){
		data = cacheRY;
	}else if(type=="yjry"){
		data = cacheYJ;
		
	}else if(type=="yjzbzh"){
		data = cacheDept;
	}
	var idx = -1;
	for (var i = 0; i < data.length; i++) {
		if (id == data[i].id) {
			idx = i;
			break;
		}
	}
	if (idx != -1) {
		try {
			data.splice(idx, 1);
		} catch (e) {
			var temp = [];
			for (i = 0; i < data.length; i++) {
				if (id != data[i].id) {
					temp.push(data[i]);
				}
			}
			data = temp;
		}
		//console.log(JSON.stringify(temp));
		//移除审批人员
		if(type=="spry"){
			cacheRY = data;
			cacheDataSet.children("#cacheRY").text(JSON.stringify(data));
			//移除标签 
			$("#" + id + "ry").remove();
		//移除预警对象
		}else if(type=="yjry"){
			cacheYJ = data ;
			cacheDataSet.children("#cacheYJ").text(JSON.stringify(data));
			//移除标签
			$("#" + id + "yj").remove();
		//移除值班账号
		}else if(type=="yjzbzh"){
			cacheDept = data ;
			cacheDataSet.children("#cacheDept").text(JSON.stringify(data));
			//移除标签
			$("#" + id + "zbzh").remove();
		}
	}
}
