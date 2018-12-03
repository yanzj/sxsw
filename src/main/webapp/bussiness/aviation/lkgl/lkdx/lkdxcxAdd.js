var cacheRY;
var cacheDataSet;
jQuery(function($) {
	var BD_RYBH = $("#BD_RYBH").val();
	pass(); // 判断是否有最终的审批权限
	cacheDataSet = $(window.parent.document).find("#cacheDataSet");
	getMess(BD_RYBH,type); // 获取编辑项的初始值

});	
function getMess(BD_RYBH,type){
	$.ajax({
		url : "qylkdxQuery.action",
		dataType : "json",
		async : false,
		type : "post",
		data : "BD_RYBH=" + BD_RYBH,
		success : function(mm) {
			$("#GKLBBH").val(mm.GKLBBH);
			$("#DQSJ").val(mm.DQSJ);
			$("#YJYQ").val(mm.YJYQ);
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
	var LB = "2";     //撤销
	// 得到传给action的值
	var sprbh = "";
	var sprxm = "";
	if (cacheRY) {
		for (var i = 0; i < cacheRY.length; i++) {
			sprbh += cacheRY[i].id + ",";
			sprxm += cacheRY[i].name +",";
		}
	}
	var BD_RYBH = $("#BD_RYBH").val();
	var BD_RYXM=$("#BD_RYXM").val();
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
