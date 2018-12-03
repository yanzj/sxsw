var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
var form;
$(function() {
	var TJXLKBH=$("#TJXLKBH").val();
	getMess(TJXLKBH);
	GKLBBHQueryList();  //管控类别下拉框
	pass();             //判断是否具有最终列控权限
	cacheDataSet = $(window.parent.document).find("#cacheDataSet");
});


function getMess(TJXLKBH){
	var basePath = $("#mypath").val();
	$
	.ajax({
		url : "conditioncontrolByIds.action",
		dataType : "json",
		async : false,
		type : "post",
		data : "id=" + TJXLKBH,
		success : function(mm) {
			$("#LKYXSJ").val(mm.LKYXSJ_Date);
			$("#YY").val(mm.YY);
			$("#YJYQ").val(mm.YJYQ);
			$("#GKLBMC").val(mm.GKLBMC);
			$("#BZXX").val(mm.BZXX);
			//预警部门
			var deptList = mm.yjDeptList;
			var itemdept = "";
			var arrDept = [];
			$(deptList)
			.each(
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
						itemdept += item1;
					});
			cacheDept = arrDept;
			$("#sdescyjzbzh").html(itemdept);
            //预警对象
			var userList = mm.yjUserList;
			var itemuser = "";
			var arrYJ = [];
			$(userList)
			.each(
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
			$(window.top.document).find("#cacheDataSet").children(
			"#cacheYJ").text(JSON.stringify(arrYJ));
	        $(window.top.document).find("#cacheDataSet").children(
			"#cacheDept").text(JSON.stringify(arrDept));

		}
	});
}


/**提交验证*/
function f_validate() {
	/**判断必选项是否都填*/
	check();
	var LKYXSJ = $("#LKYXSJ").val();  //有效时间
	var time = new Date().getTime();
	if(Date.parse(LKYXSJ)<time){
		top.$.ligerDialog.warn("到期时间已过，请重填");
		return false;
	}
	if(!flag()){
		return false;
	}else{
		return data();
	}
	
}

function check(){
	//验证，必填项的验证，未填加红框提醒，文本框默认字，点击--字清空，移除点击后又赋默认值
	$("input[required]").each(function(){
		var $this = $(this);
		$this.addClass("holder");
		if($(this).val()==""||$(this).val()=="此项是必填项，请填写"){
			$this.val($this.attr("holder"));
			$this.attr("style","border:2px dashed red;");
		}
	}).on("focusin", function() {
		var $this = $(this);
		if ($this.val() == $this.attr("holder")) {
			$this.removeClass("holder");
			$this.val("");
			$this.attr("style","")
		}
	}).on("focusout",function(){
		var $this = $(this);
		if($this.val()==""||$this.val()=="此项是必填项，请填写"){
			$this.attr("style","border:2px dashed red;")
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	});
}

/**验证身份证号码 正则表达式*/
function checksfzhm(value) {
	/**18位身份证最后一位可能为字母X*/
	var email18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	if (!email18.test(value)) {
		return false;
	}
	return true;
}
//判断是否是局长、副局长来做操作
function pass() {
	$.ajax({
		url : "approvalsModify.action",
		dataType : "json",
		async : false,
		type:"post",
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
function GKLBBHQueryList() {
	var GKLBMC = $("#GKLBMC").val();
	$
	.ajax({
		url:"loadTsdict.action",
		data:"sszdlx=GKLB",
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#GKLBBH").append(
					"<option  selected='selected' value='" + -1 + "'>"
					+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#GKLBBH").empty();
			$.each(data, function(n, value) {
				var text = "";
				if (value.text == GKLBMC) {
					text += "<option selected=\"selected\" value='" + value.id
							+ "'>" + value.text + "</option>";
				} else {
					text = "<option value='" + value.id + "'>" + value.text
							+ "</option>";
				}
				$("#GKLBBH").append(text);
			});
		}
	});
}
//对数据封装
function data() {
	var type = $("#type").val();
	var useridyj = "";
	var usernameyj = "";
	var deptid = "";
	var deptname = "";
	   //预警部门
		if (cacheDept) {
			for (i = 0; i < cacheDept.length; i++) {
				deptid += cacheDept[i].id + ",";
				deptname += cacheDept[i].name +",";
			}
		}
		//预警对象
		if (cacheYJ) {
			for (i = 0; i < cacheYJ.length; i++) {
				useridyj += cacheYJ[i].id + ",";
				usernameyj += cacheYJ[i].name +",";
			}
		}
	
	// 得到传给action的值
	var userid = "";
	//审批人
	if (cacheRY) {
		for (i = 0; i < cacheRY.length; i++) {
			userid += cacheRY[i].id + ",";
		}
	}
	var TJXLKBH = $("#TJXLKBH").val();  //条件列控编号
	var YY = $("#YY").val();   //列控原因
	var LKYXSJ = $("#LKYXSJ").val();  //有效时间
	var YJYQ = $("#YJYQ").val();  //预警要求
	var GKLBBH = $("#GKLBBH").val();  //管控类型
	var BZXX = $("#BZXX").val();   //备注说明
	var LB = $("#LB").val();//类别
	// 把选中的预警部门、预警人、审批人清空
	cacheDataSet.children("#cacheRY").text("");
	var addPost = {
		"id" : TJXLKBH,
		"acEntity.LKYXSJ" : LKYXSJ,
		"acEntity.GKLBBH" : GKLBBH,
		"acEntity.YY" : YY,
		"acEntity.YJYQ" : YJYQ,
		"acEntity.BZXX" : BZXX,
		"sprbh" : userid,
		"YJDX" : useridyj,
		"YJDXXM": usernameyj,
		"YJBM" : deptid,
		"YJBMXM": deptname,
		"LB":LB
	};
	return addPost;
}
//普通人提交
function subbtn() {
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url : "addApprovalsTJXLK.action",
		data : data(),
		dataType : "json",
		type : "post",
		success : function(data) {
			if ("success" == data.result) {
				top.$.ligerDialog.success("提交成功！");
				window.top.my_closewindow();

			} else {
				top.$.ligerDialog.error("提交失败！");
				$("#bg").removeClass("bg");
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("列控失败！" + error.status, "错误");
			$("#bg").removeClass("bg");
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
	return flag;

}