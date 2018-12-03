var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
var form;
$(function() {
	mzQueryList();      //民族下拉框
	GKLBBHQueryList();  //管控类别下拉框
	var pass=$("#pass").val();
	if ("okpass" == pass) {
		$("#spry").hide();
	} 
	cacheDataSet = $(window.parent.document).find("#cacheDataSet");
});

/**提交验证*/
function f_validate() {
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

	/**判断必选项是否都填*/
	if(!flag()){
		return false;
	}
	var LKYXSJ = $("#LKYXSJ").val();  //有效时间
	var time = new Date().getTime();
	if(Date.parse(LKYXSJ)<time){
		top.$.ligerDialog.warn("到期时间已过，请重填");
		return false;
	}
	/**判断身份证号码 正则表达式*/
	/*var GMSFZHM = $("#SFZH").val();
	if(GMSFZHM!=""){
		if (!checksfzhm(GMSFZHM)) {
			top.$.ligerDialog.warn("请正确输入身份证号码！");
			$("#SFZH").attr("style","border:2px dashed red");
			return false;
		}
	}*/
	return data();
}

//对数据封装
function data() {
	//得到传给action的值
	var deptid = "";
	var userid = "";
	var useridyj = "";
	if (cacheDept) {
		for (var i = 0; i < cacheDept.length; i++) {
			deptid += cacheDept[i].id + ",";
		}
	}
	if (cacheRY) {
		for (var i = 0; i < cacheRY.length; i++) {
			userid += cacheRY[i].id + ",";
		}
	}
	if (cacheYJ) {
		for (var i = 0; i < cacheYJ.length; i++) {
			useridyj += cacheYJ[i].id + ",";
		}
	}
	var MZ = $("#MZ").val(); //人员类别
	if (MZ == "请选择民族") {
		MZ = "";
	}
	var XB = $("#XB").val();
	var LKLB = $("#LKLB").val();
	if (LKLB == "请选择列控类别") {
		LKLB = "";
	}
	var XM = $("#XM").val();
	var ZZ = $("#ZZ").val();
	var JG = "";
	var province = $("#province").val();
	var city = $("#city").val();
	var county = $("#county").val();
	if(province !="" && city !="" && county !=""){
		JG = county;
	}else if(province !="" && city !=""){
		JG = city.substring(0,4);
	}else if(province !=""){
		JG = province.substring(0,2);
	}
	var SFZH = $("#SFZH").val();
	var QT = $("#QT").val();
	var LKYXSJ = $("#LKYXSJ").val();
	var BZXX = $("#BZXX").val();
	var LKYY = $("#LKYY").val();
	var YJYQ = $("#YJYQ").val();
	//把选中的预警部门、预警人、审批人清空
	cacheDataSet.children("#cacheDept").text("");
	cacheDataSet.children("#cacheYJ").text("");
	cacheDataSet.children("#cacheRY").text("");
	var dataPost = {
			//添加至条件审批表中 start  caEntity
			"caEntity.MZ" : MZ,  
			"caEntity.XM" : XM,
			"caEntity.XB" : XB,
			"caEntity.ZZ" : "%"+ZZ+"%",
			"caEntity.JG" : JG+"%",
			"caEntity.SFZH" : SFZH,
			"caEntity.QT" : QT,
			//添加至条件审批表中 end   caEntity

			//添加至审批条件性表 start
			"acEntity.LKYXSJ" : LKYXSJ,
			"acEntity.GKLBBH" : LKLB,
			"acEntity.YY" : LKYY,
			"YJDX" : useridyj,
			"YJBM" : deptid,
			"acEntity.YJYQ" : YJYQ,
			"sprbh" : userid,
			"acEntity.BZXX" : BZXX,
			"LB":"0"  //类别 =0 列控
				//添加至审批条件性表  end
	};
	return dataPost;
}

//获取民族下拉框
function mzQueryList() {
	$.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GA_MZ"),
		dataType : "json",
		async : true,
		type:"post",
		beforeSend : function() {
			$("#MZ").append("<option  selected='selected' value='" + -1 + "'>"+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#MZ").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"请选择民族\">请选择民族</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#MZ").append(text);
		}
	});
}
//获取管控类别下拉框
function GKLBBHQueryList() {
	$.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GKLB"),
		dataType : "json",
		async : true,
		type:"post",
		beforeSend : function() {
			$("#LKLB").append("<option  selected='selected' value='" + -1 + "'>"+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#LKLB").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"请选择列控类别\">请选择列控类别</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#LKLB").append(text);
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

/**验证身份证号码 正则表达式*/
function checksfzhm(value) {
	/**18位身份证最后一位可能为字母X*/
	var email18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	if (!email18.test(value)) {
		return false;
	}
	return true;
}


/**控制打开界面*/
function winOpen(url, title, width, height, button1, button2, callback) {
	window.top.$.ligerDialog.open({
		width : width,
		height : height,
		url : url,
		title : title,
		buttons : [
		           {
		        	   text : button1,
		        	   onclick : function(item, dialog) {
		        		   var fn = dialog.frame.f_validate
		        		   || dialog.frame.window.f_validate;
		        		   var data = fn();
		        		   if (data) {
		        			   callback(data, dialog);
		        		   }
		        	   }
		           }, {
		        	   text : button2,
		        	   onclick : function(item, dialog) {
		        		   dialog.close();
		        	   }
		           } ]
	});
}
