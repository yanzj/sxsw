var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
jQuery(function($) {
	var BD_RYBH = $("#BD_RYBH").val();
	pass(); // 判断是否有最终的审批权限
	cacheDataSet = $(window.parent.document).find("#cacheDataSet");
	getMess(BD_RYBH,type); // 获取编辑项的初始值
	// 获取编辑项的初始值
	//GKLBBHQueryList();
});	
function getMess(BD_RYBH,type){
	var basePath = $("#mypath").val();
	$.ajax({
		url : "qylkdxQuery.action",
		dataType : "json",
		async : false,
		type : "post",
		data : "BD_RYBH=" + BD_RYBH,
		success : function(mm) {
			$("#YY").val(mm.YY);
			$("#BZXX").val(mm.BZXX);
			$("#DQSJ").val(mm.DQSJ);
			$("#GKLBMC").val(mm.GKLBMC);
			$("#YJYQ").val(mm.YJYQ);
			//预警值班账号
			var deptList = mm.yjDeptList;
			var itemyjzbzh = "";
			var arrDept = [];
			$(deptList).each(
				function(i, value) {
					arrDept.push({
						id : value.YHBH,
						name : value.YHXM
				});
				var item1 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
					+ value.YHBH + "zbzh'>"
					+ value.YHXM+ " <img src='"
					+ basePath + "images/delete.png' onclick=\"removeUser('"
					+ value.YHBH + "','" + value.YHXM
					+ "','yjzbzh')\" style=\"cursor:pointer\" /></span>&nbsp;&nbsp;";
				itemyjzbzh += item1;
			});
			cacheDept = arrDept;
			$("#sdescyjzbzh").html(itemyjzbzh);
			//预警对象
			var userList = mm.yjUserList;
			var itemuser = "";
			var arrYJ = [];
			$(userList).each(
				function(i, value) {
					arrYJ.push({
						id : value.YHBH,
						name : value.YHXM
				});
				var item2 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
					+ value.YHBH + "yj'>"
					+ value.YHXM+ " <img src='"
					+ basePath + "images/delete.png' onclick=\"removeUser('"
					+ value.YHBH + "','" + value.YHXM
					+ "','yjry')\" style=\"cursor:pointer\" /></span>&nbsp;&nbsp;";
				itemuser += item2;
			});
			cacheYJ = arrYJ;
			$("#sdescyj").html(itemuser);

			$(window.top.document).find("#cacheDataSet").children("#cacheYJ").text(JSON.stringify(arrYJ));
			$(window.top.document).find("#cacheDataSet").children("#cacheDept").text(JSON.stringify(arrDept));

		}
	});
}
function f_validate() {
	check();
	/**判断必选项是否都填*/
	if(!flag()){
		return false;
	}
	return data();
}
function check(){
	// 验证，必填项的验证，未填加红框提醒，文本框默认字，点击--字清空，移除点击后又赋默认值
	$("input[required]").each(function() {
		var $this = $(this);
		$this.addClass("holder");
		// 此处做判断，是再次点提交按钮时，写上的值会清空，变成默认值
		if ($(this).val() == "" || $(this).val() == "此项是必填项，请填写") {
			$this.val($this.attr("holder"));
			$this.attr("style", "border:2px dashed red;");
		}
	}).on("focusin", function() {
		var $this = $(this);
		if ($this.val() == $this.attr("holder")) {
			$this.removeClass("holder");
			$this.val("");
			$this.attr("style", "");
		}
	}).on("focusout", function() {
		var $this = $(this);
		if ($this.val() == "" || $this.val() == "此项是必填项，请填写") {
			$this.attr("style", "border:2px dashed red;");
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	});
}
//对数据封装
function data() {
	var type = $("#type").val();
	var yjdxid = "";
	var yjdxname="";
	var yjzbzh = "";
	var yjzbzhname="";
	var LB = "";
	if(type=="tjlk"){
		LB = "1";
	}
	if(type=="bjlk"){
		LB = "3";
	}
	if (cacheDept) {
		for (var i = 0; i < cacheDept.length; i++) {
			yjzbzh += cacheDept[i].id + ",";
			yjzbzhname += cacheDept[i].name + ",";
		}
	}
	if (cacheYJ) {
		for (var i = 0; i < cacheYJ.length; i++) {
			yjdxid += cacheYJ[i].id + ",";
			yjdxname += cacheYJ[i].name + ",";
		}
	}

	// 得到传给action的值
	var sprbh = "";
	var sprxm = "";
	if (cacheRY) {
		for (i = 0; i < cacheRY.length; i++) {
			sprbh += cacheRY[i].id + ",";
			sprxm += cacheRY[i].name +",";
		}
	}
	var BD_RYBH = $("#BD_RYBH").val();
	var	BD_RYXM= $("#BD_RYXM").val();
	var YY = $("#YY").val();
	var passok = $("#pass").val();
	var YJYQ = $("#YJYQ").val();
	var GKLBBH = $("#GKLBBH").val();
	var DQSJ = $("#DQSJ").val();
	var BZXX = $("#BZXX").val();
	// 把选中的预警部门、预警人、审批人清空
	cacheDataSet.children("#cacheRY").text("");
	var SPDXBH = $("#spdxbh").val();
	var addPost = {
			"spdxbh" : SPDXBH,
			"BD_RYBH" : BD_RYBH,
			"BD_RYXM" : BD_RYXM,
			"appObject.DQSJ" : DQSJ,
			"appObject.GKLBBH" : GKLBBH,
			"appObject.BZXX" : BZXX,
			"appObject.YY" : YY,
			"appObject.YJYQ" : YJYQ,
			"sprbh" : sprbh,
			"sprxm" :sprxm,
			"yjdx" : yjdxid,
			"yjdxname":yjdxname,
			"yjzbzh" : yjzbzh,
			"yjzbzhname": yjzbzhname,
			"LB" : LB,
			"passok" : passok,
			"appObject.WSXXX" : ""
	};
	return addPost;
}

//判断是否有最终的审批权限
function pass() {
	$.ajax({
		url : "approvalsModify.action",
		dataType : "json",
		async : false,
		type : "post",
		success : function(data) {
			if ("okpass" == data.result) {
				$("#pass").val("okpass");
				$("#spry").hide();
			} else {
				$("#pass").val("");
			}
		}
	});
}

/**判断必选项是否都填*/
function flag(){
	var flag;
	$("input[required]").each(function(){
		if($(this).val()==""||$(this).val()=="此项是必填项，请填写"){
			flag=false;
		}else{
			flag=true;
		}
	});
	
	var DQSJ = $("#DQSJ").val();  //到期时间
	if(DQSJ==""){
		$("#DQSJ").attr("style","width:200px;height: 24px;background-color: #F2F2F2;border:2px dashed red;");
		flag=false;
	}
	
	var time = new Date().getTime();
	if(Date.parse(DQSJ)<time){
		top.$.ligerDialog.warn("到期时间已过，请重填");
		flag=false;
	}
	//当无审批权限时判断是否添加了审批人
	if("okpass"!=$("#pass").val())
	{
		//审批人
		var spr =$("#sdesc").html();
		if(spr==""){
			$("#sdesc").attr("style","width:400px;min-height: 30px;background-color: #F2F2F2;border: 1px solid #F2F2F2;border:2px dashed red;");
			flag=false;
		}
	}
	return flag;
}

function Single(){
	var DQSJ = $("#DQSJ").val();
	if(DQSJ!=""){
		$("#DQSJ").attr("style","width:200px;height: 24px;background-color: #F2F2F2;border: 1px solid #D1D1D1;");
	}
}
