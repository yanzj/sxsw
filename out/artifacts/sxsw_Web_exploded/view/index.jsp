	<%@ page language="java" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();

	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) request.getSession().getAttribute("userid");//用户id
	String username = (String) request.getSession().getAttribute("username");//用户名
	String typeid = (String) request.getSession().getAttribute("itemid");//所属id
	String logintype = (String) request.getSession().getAttribute("logintype");//登陆方式
	String ssxmbh = (String) request.getSession().getAttribute("ssxmbh");//所属项目编号
	String ssxmlx = (String) request.getSession().getAttribute("ssxmlx");//所属项目类型
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>山西省人社税务数据核对系统</title>
<%-- <link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" /> --%>
<style type="text/css">
#winpop {
	width: 200px;
	height: 80px;
	position: fixed;
	z-index: 10;
	right: 555px;
	top: 35px;
	border: 1px solid #999999;
	margin: 0;
	padding: 1px;
	overflow: hidden;
	background: url(http://www.niutw.com/images/bg.png) #FFFFFF
}

#winpop .title {
	width: 100%;
	height: 20px;
	line-height: 20px;
	background: #FFCC00;
	font-weight: bold;
	text-align: center;
	font-size: 12px;
}

#winpop .con {
	width: 100%;
	height: 80px;
	line-height: 80px;
	font-weight: bold;
	font-size: 12px;
	color: #FF0000;
	text-decoration: underline;
	text-align: center
}

#silu {
	font-size: 13px;
	color: #999999;
	position: absolute;
	right: 0;
	text-align: right;
	text-decoration: underline;
	line-height: 22px;
}

.close {
	position: absolute;
	right: 4px;
	top: -1px;
	color: #FFFFFF;
	cursor: pointer
}

.yj {
	width: 300px;
	height: 50px;
	/*  border: 2px solid #000000; */
	-moz-border-radius: 15px;
	-webkit-border-radius: 15px;
	border-radius: 15px;
}

.yj_tswz {
	text-decoration: underline;
	cursor: pointer;
	color: red;
}

.yj_xq {
	text-decoration: underline;
	cursor: pointer;
	color: red;
}
</style>

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/index.css" />
<link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/clock.js"></script>
<script type="text/javascript" src="<%=basePath%>js/index.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/grsz/mymessage/mymessage.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript">
  	var uid = "1";
	var tab = null;
	var accordion = null;
	var logintype = "1";
	var typeid = "1";
	var mypath = "1";
	
	$(function() {

		$(".tswz").live("mouseover", function() {
			$(this).addClass("yj_tswz");
		});
		$(".tswz").live("mouseout", function() {
			$(this).removeClass("yj_tswz");
		});

	    $(".yjxq").live("mouseover", function() {
			$(this).addClass("yj_xq");
		});
		$(".yjxq").live("mouseout", function() {
			$(this).removeClass("yj_xq");
		});

		//布局
		$("#layout1").ligerLayout({
			leftWidth : 190,
			height : '100%',
			heightDiff : -34,
			space : 4,
			onHeightChanged : f_heightChanged
		});

		var height = $(".l-layout-center").height();

		//Tab
		$("#framecenter").ligerTab({
			height : height
		});

		//面板
		$("#accordion1").ligerAccordion({
			height : height - 24,
			speed : null
		});

		$(".l-link").hover(function() {
			$(this).addClass("l-link-over");
		}, function() {
			$(this).removeClass("l-link-over");
		});

		tab = $("#framecenter").ligerGetTabManager();
		accordion = $("#accordion1").ligerGetAccordionManager();
		tick();//时间
		remind();
		getTopMenu();
		$("#passform").ligerForm();
		if(logintype == "CSYJLB"){
			csyjlb();
		}else if(logintype == "CSYJXQ"){//预警详情
			csyjxq();
		}if(logintype == "CSXXLB"){//我的消息列表
			csxxlb();
		}else if(logintype == "CSXXXQ"){//我的消息详情
			openDialog(typeid,"<%=ssxmbh%>","<%=ssxmlx%>",'0'); 
		}else if(logintype == "CSGKLB"){//管控列表
			csgklb();
		}else if(logintype == "CSHBLB"){//安检列表
			cshblb();
		}else if(logintype == "CSAJLB"){//案件列表
			csajlb();
		}else if(logintype == "CSPCLB"){//盘查列表
			cspclb();
		}
	});

    /*
      获取顶级菜单信息
     */
    function getTopMenu(){
        $.ajax({
            url: baseUrl+"/sys/menu/nav",
            type: "get",
            dataType: 'json',
            success:function(data){
                var $item = [];
                $.each(data.menuList,function(index,item){
                    var temp = {"id":item.menuId,"text":item.name,"img":"../"+item.icon,click:myitemclick1};
                    $item.push(temp);
                    // if(index===0){
                    //     myitemclick1(temp);
                    // }
                });
                $("#toolbar").ligerToolBar({ items:$item });
            }
        });
    }

	//cs端跳转页面链接start
	//预警列表
	function csyjlb(){
		window.f_addTab("CSYJLB"+uid,"预警信息",mypath+"bussiness/aviation/yjxx/EarlywarningTaList.jsp?wd=true");
	}
	//预警详情
	function csyjxq(){
		$.ajax({
			url:"earlywarningModify.action",
			data:"id="+typeid,
			dataType:"json",
			type:"post",
			success:function(data){
				if("success"==data.result){
					window.f_addTab("CSYJXQ"+typeid,"预警详情",mypath+"bussiness/aviation/yjxx/EarlywarningDetail.jsp?YJBH="+typeid);
				}else{
					$.ligerDialog.error("跳转详情失败！");
				}
			}
		});
	}
	//我的消息列表
	function csxxlb(){
		window.f_addTab("CSXXLB"+uid,"我的消息",mypath+"bussiness/aviation/grsz/mymessage/MymessagesTabList.jsp");
	}
	//管控列表
	function csgklb(){
		window.f_addTab("CSGKLB"+uid,"管控人员信息",mypath+"bussiness/aviation/xxcx/gkdd/gkddTabList.jsp");
	}
	//案件列表
	function csajlb(){
		window.f_addTab("CSAJLB"+uid,"案事件信息",mypath+"bussiness/aviation/xxcx/asj/AjsTabList.jsp");
	}
	//安检列表
	function cshblb(){
		window.f_addTab("CSHBLB"+uid,"安检信息",mypath+"bussiness/aviation/xxcx/hbxx/SecurityInfoTabList.jsp");
	}
	//盘查列表
	function cspclb(){
		window.f_addTab("CSPCLB"+uid,"盘查信息",mypath+"bussiness/aviation/xcpc/pclb/PclbListTab.jsp");
	}
	//cs端跳转页面链接end
	

	//调整预警
	function tzyj() {
		window.f_addTab("111","预警信息",mypath+"bussiness/aviation/yjxx/EarlywarningList.jsp?welcomeJsp=welcome");
		$("#remind").hide();
	}
	function tzyj1(itemid){
					$.ajax({
							url:"mymessageModify.action",
							data:"id="+itemid,
							dataType:"json",
							success:function(data){
								if("success"==data.result){
									window.parent.f_addTab(itemid,"预警详情","<%=basePath%>bussiness/aviation/yjxx/EarlywarningDetail.jsp?itemid="+itemid);
								}else{
									$.ligerDialog.error("跳转详情失败！");
								}
							}
						});
	} 
	            
	
	function tzyjClose()
	{
	   $("#remind").hide();
	}
	
	 //未读消息列表
	function wdxx() {
		window.f_addTab("222","我的消息",mypath+"bussiness/aviation/grsz/mymessage/MymessageList.jsp?welcomeJsp=index");
		$("#remind").hide();
	}
	//未读消息详情
	function wdxx1(id,itemid,type) {
					$.ajax({
							url:"mymessageModify.action",
							data:"id="+id,
							dataType:"json",
							success:function(data){
								if("success"==data.result){
									if("taskes"==type){
										window.parent.f_addTab(itemid,"任务详情",+"<%=basePath%>bussiness/aviation/rwcl/fbrw/FbrwMess.jsp?id="+itemid);
									}else if("approvals"==type){
										window.parent.f_addTab(itemid,"审批详情","<%=basePath%>bussiness/aviation/grsz/approvals/ApprovalsEdit.jsp?itemid="+itemid);
									}else if("approvalscondition"==type){
										window.parent.f_addTab(itemid,"审批详情","<%=basePath%>bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEdit.jsp?itemid="
														+ itemid);
							}
						} else {
							$.ligerDialog.error("跳转详情失败！");
						}
					}
				});
	}

	function f_heightChanged(options) {
		if (tab)
			tab.addHeight(options.diff);
		if (accordion && options.middleHeight - 24 > 0)
			accordion.setHeight(options.middleHeight - 24);
	}
	function f_addTab(tabid, text, url) {
		tab.addTabItem({
			tabid : tabid,
			text : text,
			url : url
		});
	}
	function f_click(tabid,text,value)
    {
         f_addTab(tabid, text, value);
    }
	function getSelectedTabId() {
		$tabIndex = tab.getSelectedTabItemID();
		$("#tabid").val($tabIndex);
		return $tabIndex;
	}

	function my_removeTab(tabid) {
		tab.removeTabItem(tabid);
	}

	/*
	   弹出的提示框
	  cont 要显示的内容
	  type 类型
	 */
	function my_alert(cont, type) {
		$.ligerDialog.alert(cont, "提示", type);
	}
	var manager, manger1;
	function my_openwindow(id, url, mwid, mhei, tit) {
		getSelectedTabId();
		$("#diaid").val(id);
		manager = $.ligerDialog.open({
			name : id,
			url : url,
			width : mwid,
			height : mhei,
			modal : true,
			isResize : true,
			title : tit,
			allowClose : true,
			isHidden : false
		});
	}

	function my_closewindow() {
		manager.close();
	}

	function my_openwindow1(id, url, mwid, mhei, tit) {
		getSelectedTabId();
		manager1 = $.ligerDialog.open({
			name : id,
			url : url,
			width : mwid,
			height : mhei,
			modal : true,
			isResize : true,
			title : tit,
			allowClose : true,
			isHidden : false
		});
	}

	function my_closewindow1() {
		manager1.close();
	}

	function my_addData(data) {
		var tempid = $("#tabid").val();
		document.getElementById(tempid).contentWindow.addData(data);
	}

	function my_editData(data) {
		var tempid = $("#tabid").val();
		document.getElementById(tempid).contentWindow.editData(data);
	}

	function my_addData1(data) {
		var tempid = $("#diaid").val();
		document.getElementById(tempid).contentWindow.addData(data);
	}

	function my_editData1(data) {
		var tempid = $("#diaid").val();
		document.getElementById(tempid).contentWindow.editData(data);
	}

	function my_loadData(data) {
		var tempid = $("#diaid").val();
		document.getElementById(tempid).contentWindow.loadDatas(data);
	}
	function my_loadData1() {
		var tempid = $("#tabid").val();
		document.getElementById(tempid).contentWindow.loadDatas();
	}
	
	
</script>


</head>
<!-- onload="setInterval('getMess()',30000)" -->

<body style="padding:0px;background-color: #e5e5e5;">
	<div id="pageloading"></div>
	<div id="topmenu" class="l-topmenu">
		<div style="width: 100%;margin: 0px auto; ">
			<div>
				<div style="float:left;">
					<img style="margin-top:10px;height:60px;margin-left:10px;"
						src="../images/indextop/fk_webtoplogo.png" />
				</div>
				<div style="float:left;margin-left:20px;">
					<div style="margin-top:15px;">
						<img src="../images/indextop/fk_webtopnametxt.png"/>
					</div>
					<!--<div style="margin-top:-2px;">
						<img style="" src="images/indextop/fk_webtopAIT.png" />
					</div>-->
				</div>
				<div style="font-size:14px;float:right;margin-right:10px;">
					<div style="margin-top:-10px;height:60px;line-height:80px;">
						<a href="" class="l-link2" onclick="return modifyPassword();">修改密码</a>
						<span class="space">|</span> <a href="" class="l-link2"
							onclick="return openUserMess();">用户信息</a> <span class="space">|</span>
						<a href="" class="l-link2" onclick="return modifyUserInfo();">修改信息</a>
						<span class="space">|</span> <a href="login.jsp" class="l-link3" 
							onclick="return userSignOut();">注销&关闭</a>
						<audio id="loginSound"> <source src="sound.mp3"
							type="audio/mpeg"> <source src="sound.ogg"
							type="audio/ogg"></audio>
					</div>
					<div style="color:white;height:30px;line-height:25px;padding-left:15px;">
						<label id="labelwelcome"></label>
							admin
						<label id="my_clock" style="float:right;"></label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="yj" id="remind"
		style="clear:both;height:130px; width:300px; line-height:32px; position:fixed; z-index:9999; right: 20px; bottom:30px;background-color: white;display: none; ">
		<div
			style="width: 100%; height:30px; line-height: 30px;background: url(../images/xxtxbj.jpg); border-radius:10px 10px 0px 0px;">
			<div
				style="width: 160px;margin-left: 12px; color: white; font-size: 15px;float: left;">预警消息提醒：</div>
			<div style="float: right; margin-right: 10px" onclick="tzyjClose()">
				<img style="width: 28px; height: 28px" src="../images/deletered.png" />
			</div>
		</div>
		<div style="margin-top: 10px;text-align:center;">
			<span class="tswz" id="xxts"
				style="font-size:15px"></span>
		</div>
		<div style="width: 100%;text-align:right;">
			<span
				style="color: #66A8DA;font-size: 14px;"
				class="yjxq" id="yjxq"></span>
		</div>
		<!--   <div style="height: 0.1px; width: 100%; border: 0.1px solid #66A8DA; margin-top: 10px"></div> -->
	</div>
	<!-- <div class="wdxx" id="wdxxts"
		style="height:130px; width:300px; line-height:32px; position:fixed; z-index:9999; right: 20px; bottom:30px;background-color: white; ">
		<div
			style="width: 100%; height:30px; line-height: 30px;background: url(images/xxtxbj.jpg); border-radius:10px 10px 0px 0px;">
			<div
				style="width: 160px;margin-left: 12px; color: white; font-size: 15px;float: left;">未读消息提醒：</div>
			<div style="float: right; margin-right: 10px" onclick="wdxxClose()">
				<img style="width: 28px; height: 28px" src="images/deletered.png"/>
			</div>
		</div>
		<div style="margin-top: 15px">
			<span class="tswz" style="margin-left: 30px; font-size:15px"
				onclick="wdxx()"> 未读消息提示.... </span>
		</div>
		<div style="width: 100%;">
			<span
				style="color: #66A8DA;margin-right:15px; font-size: 14px; float: right;" class="yjxq">>>详情</span>
		</div>
	</div> -->
	<div
		style="margin: 0; padding: 0; background: url(../images/headbg.gif); height: 28px; overflow: hidden; border-bottom: 1px solid #8db2e3; width: 100%; margin: 0px auto;">
		<div id="toolbar"
			style="height: 27px;line-height:27px; width: 100%; float: left; margin-top: 1px;padding-left:10px;padding-top: 2px"></div>
	</div>
	<div id="layout1"
		style="clear:both;width: margin:0 auto; margin-top:4px;width: 100%; margin: 0px auto;">
		<div position="left" title="功能列表" id="accordion1"
			style=" background-color: #f4f4f4 ">
			<ul id="treeMenu" style="margin-top:3px;background-color: #f4f4f4 ">
			</ul>
		</div>
		<div position="center" id="framecenter">
			<div tabid="home" title="系统门户">
				<iframe frameborder="0" name="home" id="home" src="welcomeempty.jsp"></iframe>
			</div>
		</div>

	</div>
	<div style="height:32px; line-height:32px; text-align:center;">
		Copyright © 2018-2019</div>
	<div style="display:none"></div>
	<input type="hidden" id="tabid" />
	<input type="hidden" id="diaid" />
	<div id="XGMM" class="dialogCtrlPanl" title="修改密码框"
		style="display:none" align="center">
		<form action="" id="passform">
			<table class="ctrlPanlGrid">
				<tr>
					<td align="right" style="height:27px;padding:4px"><font
						size="2">原密码：</font></td>
					<td style="height:27px;padding:4px"><input type="password"
						id="oldpass" /></td>
				</tr>
				<tr>
					<td align="right" style="height:27px;padding:4px"><font
						size="2">新密码：</font></td>
					<td style="height:27px;padding:4px"><input type="password"
						id="newpass" /></td>
				</tr>
				<tr>
					<td align="right" style="height:27px;padding:4px"><font
						size="2">确认密码：</font></td>
					<td style="height:27px;padding:4px"><input type="password"
						id="newpass1" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="cacheDataSet" style="display:none">
		<i id="cacheYJ"></i> <i id="cacheDept"></i> <i id="cacheRY"></i>

	</div>
</body>

</html>
