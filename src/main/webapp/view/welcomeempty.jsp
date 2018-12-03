<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>" />
<title>我的首页</title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/xxcx/gkdd/gkddList.js"></script>	
<script>
jQuery(function($){
      //文本框默认值点击后清空，移除点击后又赋给默认值
        getMess();
	    $("input[holder]").each(function(){
	        var $this = $(this);
	        $this.addClass("holder");
	        $this.val($this.attr("holder"));
	    }).on("focusin",function(){
	        var $this = $(this);
	        if($this.val()==$this.attr("holder")){
	          $this.removeClass("holder");
	          $this.val("");
	        }
	    }).on("focusout",function(){
	        var $this = $(this);
	        if($this.val()==""){
	            $this.val($this.attr("holder"));
	            $this.addClass("holder");
	        }
	    }); 
	    
	    
	    var height=$(document).height()-450;
	    var margintop=height/2+"px";
	    $("#big_div").css("margin-top",margintop);
});

function search(){
	var RYXM=$("#XM").val().trim();  //姓名
	var GMSFZHM=$("#SFZH").val().trim();  //身份证号
	if(RYXM=="输入姓名" && GMSFZHM=="输入身份证号"){
	   	top.$.ligerDialog.success("请输入人员查询的条件来进行查询！");
	    return false;
	}
	var mypath = $("#mypath").val();
	window.parent.f_addTab(GMSFZHM,"管控人员信息",mypath+"bussiness/aviation/xxcx/gkdd/gkddList.jsp?RYXM="+RYXM+"&GMSFZHM="+GMSFZHM+"&welcomeJsp=welcome");
}
function wdyjSearch(){
	var mypath = $("#mypath").val();
	window.parent.f_addTab("111","预警信息",mypath+"bussiness/aviation/yjxx/EarlywarningList.jsp?welcomeJsp=welcome");

}
function wdrwSearch(){
	var mypath = $("#mypath").val();
	window.parent.f_addTab("222","我的消息",mypath+"bussiness/aviation/grsz/mymessage/MymessageList.jsp?welcomeJsp=welcome");

}
//跳转列控管理 -- 列控对象管理列表界面 
function dqtxSearch(){
	var mypath = $("#mypath").val();
	window.parent.f_addTab("333","列控对象管理",mypath+"bussiness/aviation/lkgl/lkdx/lkddList.jsp?welcomeJsp=welcome");

}
//跳转列控管理 -- 条件性列控管理列表界面 
function dqlktjSearch(){
	var mypath = $("#mypath").val();
	window.parent.f_addTab("333","条件性列控管理",mypath+"bussiness/aviation/lkgl/tjxlk/tjxlkList.jsp?welcomeJsp=welcome");

}
function getMess() {
		/* $.ajax({
			url : "yjCount.action",
			dataType : "json",
			async : false,
			type : "post",
			success : function(mm) {
			   $("#wdyjxxx").html(mm.myyjCount);
			   $("#wdrwxxx").html(mm.myrwCount);
			   $("#dqlkdxxx").html(mm.myDqtxCount);
			   $("#dqlktjxx").html(mm.myDqlktjCount);
			}
		});   */
	}
</script>
<style type="text/css">
body {
	background-color: #f4f4f4;
	/*margin-right:0px;
	padding: 0px;
	
	background-image: url('./images/login/logoname.png');
	background-repeat:no-repeat;
	background-size:100% 100%;
	-moz-background-size:100% 100%;}*/
	
}

.holder {
	font-family: 纤黑;
	color: #808080;
	font-size: 18px;
}

.input {
	border: 1px solid #D1EAFF;
	width: 268px;
	height: 48px;
	background-color: #D1EAFF;
}

.input1 {
	border: 1px solid #307FCA;
	width: 200px;
	height: 48px;
	background-color: #307FCA;
	font-family: 中黑;
	color: #fafafa;
	font-size: 24px;
}

.div {
	border: 1px solid #424854;
	width: 264px;
	height: 192px;
	background-color: #fff7f3;
	text-align: center;
	cursor: pointer;
}

.font {
	font-family: 纤黑;
	color: #5a2b35;
	font-size: 24px;
}

.font1 {
	font-family: 中黑;
	color: #ef7844;
	font-size: 36px;
}
.font2{
    font-family: 特黑;
	color: #5a2b35;
	font-size: 32px;
	font-weight: 900;
}
.div-img{
	width: 98%;
	margin: 0px auto;
	text-align: center;
	}
.div-img img{

}	
</style>
</head>

<body style="padding-left: 32px;" onload="setInterval('getMess()',30000)">
		<div
			style="font-family: 黑体;color:#f2ac7e;font-weight: 900;font-size:36px;text-align: center;height: 120px;line-height: 120px;">
			欢迎使用山西省人社税务数据核对系统</div>
			<div class="div-img">
				<img src="<%=basePath%>images/login/2.png" />
			</div>
		<!-- <div style="margin-top:12px;">
			<div
				style="float:left;border:1px solid #424854;width:316px;height:400px;background-color: #fff7f3;text-align: center;box-shadow:8px 8px 4px;">
				<div
					style="font-family: 特黑;color:#2f7fca;font-weight: 900;font-size:36px;text-align: center;margin-top:70px;">人员查询</div>
				<div style="margin-top:21px;">
				    <input type="hidden" id="starttime"><input type="hidden" id="endtime"><input type="hidden" id="GKLBBH">
					<input type="hidden" id="MZ"><input type="hidden" id="XB"><input type="hidden" id="ZZDZ">
					<input class="input" type="text" id = "XM" holder="&nbsp;&nbsp;&nbsp;输入姓名" />
				</div>
				<div
					style="font-family: 中黑;color:#666666;font-size:24px;font-weight:bold;height:40px;line-height: 40px;">或者</div>
				<div>
					<input class="input" type="text" id = "SFZH" holder="&nbsp;&nbsp;&nbsp;输入身份证号" />
				</div>
				<div style="margin-top:44px;">
					<input class="input1" type="button" value="查询关联信息" onclick = "search('index_xtmh')"/>
				</div>
			</div>
			<div class="div" style="float:left;margin-left:20px;">
				<input style="margin-top:48px;width:228px;" class="input"
					type="text" holder="&nbsp;&nbsp;&nbsp;输入航班号" /> <input
					style="margin-top:8px;" class="input1" type="button" value="查询航班信息" />
			</div>
			<div class="div" style="float:left;margin-left:20px;">
			 	<div style="margin-top:56px;" onclick="dqlktjSearch()">
					<font class="font">您添加的到期提醒</font>
					<div class="font1">列控条件消息</div>
					<div class="font2">(<span id="dqlktjxx"></span>)</div>
				</div>
			</div>
			<div class="div" style="float:left;margin-left:20px;">
				<div style="margin-top:56px;" onclick="wdyjSearch()">
					<font class="font">您收到的未读</font>
					<div class="font1">预警消息</div>
					<div class="font2">(<span id="wdyjxxx"></span>)</div>
				</div>
			</div>
			<div class="div" style="float:left;margin-left:20px;margin-top:0px">
				<div style="margin-top:56px;" onclick="dqtxSearch()">
					<font class="font">您添加的到期提醒</font>
					<div class="font1">列控对象消息</div>
					<div class="font2">(<span id="dqlkdxxx"></span>)</div>
				</div>
			</div>
			<div class="div" style="float:left;margin-left:20px;margin-top:0px">
				<div style="margin-top:56px;" onclick="wdrwSearch()">
					<font class="font">您收到的未读</font>
					<div class="font1">任务消息</div>
					<div class="font2" >(<span id="wdrwxxx"></span>)</div>
				</div>
			</div>
		</div> -->
	<input type="hidden" id="mypath" value="<%=basePath %>" />
</body>
</html>
