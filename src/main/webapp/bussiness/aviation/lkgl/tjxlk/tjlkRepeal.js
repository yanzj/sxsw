var cacheDataSet;
var cacheRY;
jQuery(function($) {
	cacheDataSet = $(window.parent.document).find("#cacheDataSet");
	pass();             //判断是否具有最终列控权限
});	
/**提交验证*/
function f_validate() {
	/**判断必选项是否都填*/
	check();
	if(!flag()){
		return false;
	}else{
		return data();
	}
}
//对提交的数据做验证
function check(){
		//验证，必填项的验证，未填加红框提醒，文本框默认字，点击--字清空，移除点击后又赋默认值
		$("input[required]").each(function() {
			var $this = $(this);
			$this.addClass("holder");
			//此处做判断，是再次点提交按钮时，写上的值会清空，变成默认值
			if ($(this).val() == "" || $(this).val() == "此项是必填项，请填写") {
				$this.val($this.attr("holder"));
				$this.attr("style", "border:2px dashed red;");
			}
		}).on("focusin", function() {
			var $this = $(this);
			if ($this.val() == $this.attr("holder")) {
				$this.removeClass("holder");
				$this.val("");
				$this.attr("style", "")
			}
		}).on("focusout", function() {
			var $this = $(this);
			if ($this.val() == "" || $this.val() == "此项是必填项，请填写") {
				$this.attr("style", "border:2px dashed red;")
				$this.val($this.attr("holder"));
				$this.addClass("holder");
			}
	});
}
//对数据封装
function data() {
	//得到传给action的值   
	var userid = "";
	if (cacheRY) {
		for (i = 0; i < cacheRY.length; i++) {
			userid += cacheRY[i].id + ",";
		}
	}
	var YY = $("#CXYY").val();
	var BZXX = $("#BZXX").val();
	var TJXLKBH=$("#TJXLKBH").val();
	var TJXXBH=$("#TJXXBH").val();
	var TJSPBH=$("#TJSPBH").val();

	//把选中的预警部门、预警人、审批人清空
	cacheDataSet.children("#cacheRY").text("");
	var addPost = {
			"TJXLKBH" : TJXLKBH,
			"TJXXBH" : TJXXBH,
			"TJSPBH":TJSPBH,
			"BZXX" : BZXX,
			"YY" : YY,
			"sprbh" : userid,
			"LB":"2"  //类别 =2 撤销
	};
	return addPost;
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