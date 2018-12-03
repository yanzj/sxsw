var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
$(function() {
	pass();            //判断是否有最终的审批权限
	//GKLBBHQueryList(); //获取管控类别下拉框
	//对提交的数据做验证
	$("#subbutton").click(function() {
		
		//验证，必填项的验证，未填加红框提醒，文本框默认字，点击--字清空，移除点击后又赋默认值
		$("input[required]").each(function(){
			var $this = $(this);
			$this.addClass("holder");
			//此处做判断，是再次点提交按钮时，写上的值会清空，变成默认值
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
		f_validate();
     });
	$(".my_info").on("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").on("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	
});

/**提交验证*/
function f_validate() {
	return passSubmit();
}

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
/*//获取管控类别下拉框
function GKLBBHQueryList() {
	$
	.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GKLB"),
		dataType : "json",
		async : true,
		type:"post",
		beforeSend : function() {
			$("#LKLB").append(
					"<option  selected='selected' value='" + -1 + "'>"
					+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#LKLB").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"请选择列控类别\">请选择列控类别</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>"
				+ value.text + "</option>";
			});
			$("#LKLB").append(text);
		}
	});
}*/
//完成
function passSubmit() {
	/**判断必选项是否都填*/
    if(!flag()){
    	return false;
    }	
	if ("okpass" == $("#pass").val()) {
		window.top.$.ligerDialog.confirm("您具有审批权,是否确定此信息成为列控对象？", "提示",
				function(ok) {
					if (ok) {
						$("#bg").addClass("bg");
						top.$.ligerDialog.waitting('正在提交中,请稍候...');
						$.ajax({
							url : "approvalsModifyokpass.action",
							data : data(),
							dataType : "json",
							type : "post",
							success : function(data) {
								top.$.ligerDialog.closeWaitting();
								if ("success" == data.result) {
									top.$.ligerDialog.success("列控成功！");
									window.top.my_closewindow();
								} else {
									top.$.ligerDialog.error("列控失败！");
									$("#bg").removeClass("bg");
								}
							},
							error : function(error) {
								dialog.close();
								top.$.ligerDialog.error("网络状况不佳，列控失败！" + error.status,
										"错误");
								$("#bg").removeClass("bg");
							}
						});
					}
				});
	} else {
		subbtn();
	}
}

//对数据封装
function data() {
	//得到传给action的值   
	var yjzbzhid = "";
	var yjzbzhname="";
	var yjdxid = "";
	var yjdxname="";
	var userid = "";
	var username = "";
	if (cacheDept) {
		for (i = 0; i < cacheDept.length; i++) {
			yjzbzhid += cacheDept[i].id + ",";
			yjzbzhname+=cacheDept[i].name + ",";
		}
	}
	if (cacheRY) {
		for (i = 0; i < cacheRY.length; i++) {
			userid += cacheRY[i].id + ",";
			username +=cacheRY[i].name +",";
		}
	}
	if (cacheYJ) {
		for (i = 0; i < cacheYJ.length; i++) {
			yjdxid += cacheYJ[i].id + ",";
			yjdxname+= cacheYJ[i].name + ",";
		}
	}
	var GKLBBH = $("#LKLB").val();
	if (GKLBBH == "请选择列控类别") {
		GKLBBH = "";
	}
	var BZXX = $("#BZXX").val();
	var YY = $("#YY").val();
	var YJYQ = $("#YJYQ").val();
	var DQSJ = $("#DQSJ").val();
	if(DQSJ == 0){
		DQSJ = "";
	}
	var passok = $("#pass").val();
	//把选中的预警部门、预警人、审批人清空
	cacheDataSet.children("#cacheDept").text("");
	cacheDataSet.children("#cacheYJ").text("");
	cacheDataSet.children("#cacheRY").text("");
    var SPDXBH = $("#SPDXBH").val();
    var BD_RYBH = $("#BD_RYBH").val();
    var BD_RYXM = $("#BD_RYXM").val();
	var addPost = {
		"BD_RYBH":BD_RYBH,
		"BD_RYXM":BD_RYXM,
		"spdxbh" : SPDXBH,
		"appObject.DQSJ" : DQSJ,
		"appObject.GKLBBH" : GKLBBH,
		"appObject.BZXX" : BZXX,
		"appObject.YY" : YY,
		"sprbh" : userid,
		"sprxm" :username,
		"LB":"0",
		"yjdx" : yjdxid,
		"yjdxname":yjdxname,
		"yjzbzh" : yjzbzhid,
		"yjzbzhname":yjzbzhname,
		"appObject.YJYQ" : YJYQ,
		"passok" : passok,
		"appObject.WSXXX" : ""
		
	};
	return addPost;
}
//普通人提交
function subbtn() {
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url : "AddlkPass.action",
		data : data(),
		dataType : "json",
		type : "post",
		success : function(data) {
			top.$.ligerDialog.closeWaitting();
			if ("success" == data.result) {
				top.$.ligerDialog.success("提交成功！");
				window.top.my_closewindow();
			} else {
				top.$.ligerDialog.error("网络状况不佳，提交失败！");
				$("#bg").removeClass("bg");
			}
		},
		error : function(error) {
			dialog.close();
			top.$.ligerDialog.error("网络状况不佳，提交失败！" + error.status, "错误");
			$("#bg").removeClass("bg");
		}
	});
}

function uploadfj() {
	openFileUploadPage();
}
function openFileUploadPage() {
	var basePath = $("#mypath").val();
	var rmd = new Date().getTime();
	window.top.$.ligerDialog
			.open({
				title : '附件上传',
				name : 'winselector' + rmd,
				width : 400,
				height : 200,
				url : 'bussiness/aviation/util/ImageUploadLK.jsp',
				buttons : [
						{
							text : '上传',
							onclick : function(item, dialog) {
								var fn = dialog.frame.ajaxFileUpload
										|| dialog.frame.window.ajaxFileUpload;
								var data = fn(function(data) {
									$("#ZZLJ").val(data.msg);
									var img = data.msg;
									$
											.ajax({
												url : "LKtxIsExis.action",
												data : {
													RYTXLJ : img
												},
												dataType : "json",
												type : "post",
												success : function(data) {
													var mm = data.msg;
													var url = basePath + mm;
													$("#img")
															.html(
																	"<a href=\""
																			+ url
																			+ "\" target=\"_blank\"><img src = \""
																			+ url
																			+ "\" style=\"width:120px;height:180px;\"></a>");
												},
												error : function(error) {
													top.$.ligerDialog.error(
															error.status, "错误");
												}
											});
									dialog.close();
								});
							}
						}, {
							text : '取消',
							onclick : function(item, dialog) {
								dialog.close();
							}
						} ]
			});
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


/**判断必选项是否都填*/
function flag(){
	var flag;
	$("input[required]").each(function(){
		if($(this).val()==""||$(this).val()=="此项是必填项，请填写"){
			flag=false;
			return false;
		}else{
			flag=true;
		}
	});
	
	var GKLBBH = $("#LKLB").val();
	if (GKLBBH == "请选择列控类别") {
		top.$.ligerDialog.warn("请选择管控类别！");
		flag=false;
	}
	
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
			$("#sdesc").attr("style","width:580px;min-height: 30px;background-color: #F2F2F2;border:2px dashed red;");
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