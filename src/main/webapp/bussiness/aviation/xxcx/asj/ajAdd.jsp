<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String flightcode = request.getParameter("flightcode");
	String flightdate = request.getParameter("flightdate");
	String dept = request.getParameter("dept");
	String dest = request.getParameter("dest");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script  type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style type="text/css">
.div1 {
	width: 100%;
	height: 25px;
	margin-top: 10px;
	background-color: #C7D9EF;
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 10px;
	text-align: center;
	line-height: 25px;
	color: #ef7844;
}

tr {
	line-height: 35px; /*设置行高*/
}

.input_style {
	width: 350px;
	height: 25px;
	background: #F2F2F2;
	margin-left: 10px;
	border: 0px solid #960;
	font-size: 13px;
}

.textarea_style {
	width: 350px;
	height: 60px;
	margin-top: 8px;
	background: #F2F2F2;
	margin-left: 10px;
	border: 0px solid #960;
	font-size: 13px;
}

.text_style {
	padding-right: 10px;
	font-size: 13px;
}
</style>
<script>
	var loading = false;  //判断单次添加数据是否完成
	jQuery(function($) {
		 ajlbList();
		 $("#subbutton").click(function(){
	 		f_validate();
		 });
	});
	//提交数据
	function f_validate(){
		var flightcode = "<%=flightcode%>"; //航班号
		var flightdate = "<%=flightdate%>"; //航班时间
		var dept = "<%=dept%>";
		var dest = "<%=dest%>";
		alert(dept+"===="+dest);
		var BARXM = $("#BARXM").val();	//报案人姓名
		var BARSFZHM = $("#BARSFZHM").val();	//报案人身份证号
		var BARLXDH = $("#BARLXDH").val();	//报案人联系电话
		var AJLBBH = $("#AJLBBH").val();	//案件类别
		if(AJLBBH == ""){
			$("#lx_msg").html("不能为空!");
			return false;
		}
		var MC = $("#MC").val();	//案件名称
		if(MC == ""){
			$("#case_msg").html("不能为空!");
			return false;
		}
		var AFSJ = $("#AFSJ").val();	//案发时间
		var AFDD = $("#AFDD").val();	//案件地址
		if(AFDD == ""){
			$("#address_msg").html("不能为空!");
			return false;
		}
		var ZYAQ = $("#ZYAQ").val();	//案件详情
		var dataPost = {"model.MC" : MC,"model.AFSJ":AFSJ,"model.AFDD":AFDD,"model.ZYAQ":ZYAQ,"model.BARXM":BARXM,"model.SSWP":"","model.BZXX":"",
				"model.BARSFZHM":BARSFZHM,"model.BARLXDH":BARLXDH,"model.AJLBBH":AJLBBH,"model.HBH":flightcode,"model.HBSJ":flightdate,"model.DEPT":dept,"model.DEST":dest
		};
		if(loading == false){
			loading = true;
			$.ajax({
				url : "pceventsAdd.action",
				data : dataPost,
				dataType : "json",
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						top.$.ligerDialog.success("添加案事件信息成功！");
						window.top.my_closewindow();
						loading = false;
					} else {
						top.$.ligerDialog.error("添加案事件信息失败！");
						loading = false;
					}
				},
				error : function(error) {
					top.$.ligerDialog.error("添加案事件信息失败！" + error.status,"错误");
					loading = false;
				}
			});
		}
	}
	
	//案件类型
	function ajlbList(){
		 $.ajax({
    		url:"loadTsdict.action",
    		data:"sszdlx=AJLB",
    		dataType:"json",
    		beforeSend:function(){
    			$("#AJLBBH").append("<option  selected='selected' value='"+-1+"'>"+"正在加载中,请稍候..."+"</option>");
    		},
    		success:function(data){
    			$("#AJLBBH").empty();
    			var text = "<option selected=\"selected\" value=''>--请选择案件类型--</option>";
    		    $.each(data,function(n,value) {  
    		     	text +="<option value='"+value.id+"'>"+value.text+"</option>";
    		  	});
    		    $("#AJLBBH").append(text);
    		}
	     });
	}
    /**判断身份证号码 正则表达式*/
    function card_validate(){
    	var BARSFZHM = $("#BARSFZHM").val();
    	if(BARSFZHM != ""){
    		if(!checksfzhm(BARSFZHM)){
        		$("#card_msg").html("格式不正确!");
           		$("#BARSFZHM").val("");
        	}else{
        		$("#card_msg").html("");
        	}
    	}
    }
	/**验证身份证号码 正则表达式*/
	function checksfzhm(value){
		/**18位身份证最后一位可能为字母X*/	
		var email18 =/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
		if(!email18.test(value)){
			return false;
		}
		return true;
	}
	/**验证联系方式*/
	function phone_validate(){
		var BARLXDH = $("#BARLXDH").val();	
		if(BARLXDH != ""){
			if(!checkPhoneNum(BARLXDH)){
				$("#phone_msg").html("格式不正确!");
           		$("#BARLXDH").val("");
			}else{
				$("#phone_msg").html("");
			}
		}
	}
	/**手机验证*/
    function checkPhoneNum(value){
		var tel=/^1[3|4|5|8][0-9]\d{4,8}$/;
		if(!tel.test(value)){
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="div1">报案人信息</div>
	<div style="padding-left: 30px">
		<table>
			<tr>
				<td class="text_style">姓名</td>
				<td><input type="text" id="BARXM" class="input_style" /></td>
			</tr>
			<tr>
				<td class="text_style">身份证号</td>
				<td><input type="text" id="BARSFZHM" class="input_style" onblur="card_validate();"/>
					<span id="card_msg" style="mfont-size:15pt;margin-left: 2px;color: red"></span>
				</td>
			</tr>
			<tr>
				<td class="text_style">联系电话</td>
				<td><input type="text" id="BARLXDH" class="input_style" onblur="phone_validate();"/>
					<span id="phone_msg" style="mfont-size:15pt;margin-left: 2px;color: red"></span>
				</td>
			</tr>
		</table>
	</div>
	<div class="div1">案件信息</div>
	<div style="padding-left: 30px">

		<table>
			<tr>
				<td class="text_style">案件类别</td>
				<td><select class="input_style" id="AJLBBH"></select>
					<span id="lx_msg" style="mfont-size:15pt;margin-left: 2px;color: red">*</span>
				</td>
			</tr>
			<tr>
				<td class="text_style">案件名称</td>
				<td><input class="input_style" type="text" id="MC"/>
					<span id="case_msg" style="mfont-size:15pt;margin-left: 2px;color: red">*</span>
				</td>
			</tr>
			<tr>
				<td class="text_style">案发时间</td>
				<td>
					<input id="AFSJ"  class="Wdate" style="width: 350px;height: 25px;margin-left: 10px;border: 1px solid #F2F2F2;background-color:#F2F2F2;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
				</td>
			</tr>
			<tr>
				<td class="text_style">案件地址</td>
				<td><input class="input_style" type="text" id="AFDD" />
					<span id="address_msg" style="mfont-size:15pt;margin-left: 2px;color: red">*</span>
				</td>
			</tr>
			<tr>
				<td class="text_style">案件详情</td>
				<td><textarea class="textarea_style" id="ZYAQ"></textarea></td>
			</tr>
		</table>
	</div>
	<input class="search_input_style"
		style="width:100px;height:30px;background-color: #F07844;float:right;border: 1px solid #F07844; margin-top: 20px;margin-right: 35px;color:white; "
		id="subbutton" type="button" value="保存" />
		
</body>
</html>