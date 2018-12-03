<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = request.getParameter("ssxmbh");
	String rwcjr = request.getParameter("rwcjr");
    String currentuserid = (String)request.getSession().getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>任务详情</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>	
<script type="text/javascript"
	src="<%=basePath%>js/jquery.lightbox.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script src="<%=basePath%>js/UploadFailUtil.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>js/btnQuery.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/rwcl/rw_detail_new.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<link rel="stylesheet" href="<%=basePath%>css/jquery.lightbox.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>css/jquery.lightbox.packed.css" type="text/css" />	
<style>
.tab_style {
	width: 180px;
	height: 100%;
	font-size: 14px;
}

.input_style {
	height: 28px;
	background: #F2F2F2;
	border: 1px solid #E6E6E6;
}
 a:hover{ background-color:#FFF;
 		  border: 0px solid #E6E6E6;
 }
td {
	font-size: 12px;
	color: gray;
}
</style>
</head>
<body>
	<div style="width:100%;min-height: 40px;overflow:auto;line-height:40px;background-color: #C7D7EE;margin-top: 20px;">
		<div style="width: 98%;">
			<div style="float: left;width: 50%;font-size: 13px;font-weight: bold;"> 
				<span id="RWMC" style="margin-left: 10px;"></span>
			</div>
			<span id="bjywc" style="font-size: 15px;font-weight: bold;color:#F07844;display:none;">已完成</span>
			<div
				style="float: right;width: 37%;text-align: center;font-size:13px;">
				<span id="CJSJ"></span>&nbsp;<span id="CJRBM"></span>-<span
					id="CJRZW"></span>&nbsp;<span
					class='float_style' id="CJRBH"
					style="margin-right: 20px;color: #366CB4;" onclick="getCjrxx()"></span>
			</div>
	    </div>
	</div>
	<div
		style="width: 98%;margin-bottom: 20px;margin-top: 10px; font-size: 14px;line-height: 25px; padding-left: 20px;">
		<div>
			<span class="td_text">完成时间</span><span style="color:#F07844;" class="td_value" id="RWWCSJ"></span>
		</div>
		<div>
			<span class="td_text">催办次数</span><span style="color:#F07844;" class="td_value" id="CBCS"></span>
		</div>
		<div>
			<span class="td_text">任务内容</span><span class="td_value" id="RWNR"></span>
		</div>
		<div>
			<span class="td_text">执&nbsp;行&nbsp;人</span><span id="zxr_div" style="border: 0px solid #F07844;width:85%;"></span>
		</div>
	</div>
	<div 
		style="width: 98%;margin-bottom: 10px;margin-top: 10px; font-size: 14px;line-height: 25px; padding-left: 20px;">
		<input id="gjrw" type="button" class="search_input_style float_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="addJiaoliu()" value="跟进任务" /> <input id="jghb"
			type="button" class="search_input_style float_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="addJieguo()" value="结果汇报" />
			<input id="tijiaoRW"
			type="button" class="search_input_style float_style"
			style="background-color:#00008B;border: 1px solid #00008B;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="tijiaoRW()" value="提交任务"/>
	</div>
	<div id="wclqq"
		style="width: 98%;margin-bottom: 10px;margin-top: 10px; font-size: 14px;line-height: 25px; padding-left: 20px;">
		<input id="oneSearch_bt" type="button" class="search_input_style float_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="addTiX()" value="催办" /> <input id="oneSearch_bt"
			type="button" class="search_input_style float_style "
			style="background-color: #00008B;border: 1px solid #00008B;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="addRenyuan()" value="增派人员" />
	</div>
	<div id="wclrw"
		style="width: 98%;margin-bottom: 10px;margin-top: 10px; font-size: 14px;line-height: 25px; padding-left: 20px;">
		<input id="oneSearch_bt" type="button" class="search_input_style float_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-right: 40px;"
			onclick="chuliRW()" value="处理任务" />
	</div>

	<div id="div_tab" style="height:30px;line-height:30px; margin-top: 40px;border-bottom: 1px solid #b2b2b2;margin-bottom: 20px;text-align: center;font-weight: bold;">
		<div style="width:180px;height:28px;float: left;">
			<div id="ckzl_bnt" onclick="tab_onclick('ckzl_bnt','ckzl_bnt')" class="tab_style float_style" style="color:#F07844;border-bottom: 2px solid #F07844;">
				参考信息(<span id="ckzllist">0</span>)
			</div>
		</div>
		<div style="width: 1px;float: left; height:20px;background-color: #b2b2b2;margin-top: 5px;"></div>
		<div style="width:180px;height:28px;float: left;">
			<div id="rwjl_bnts" onclick="tab_onclick('rwjl_bnts','rwjl_bnt')" class="tab_style float_style" style="margin:0 auto;float:left;">
				<div id="rwjl_bnt" style="width:auto;height:28px;float:left;margin-left: 18px;">
					任务交流&nbsp;(<span id="rwjlCount">0</span>)
				</div>
				<div id="rwjlround_l" style="background:url(<%=basePath%>images/fk_webunreadbg_l.png) no-repeat;height:16px;width:24px;float:left;margin-top:0px;font-size:12px;text-align:center;line-height:16px;display:none;">
					<span style="color:#fff">99+</span>
				</div>
				<div id="rwjlround_s" style="background:url(<%=basePath%>images/fk_webunreadbg_s.png) no-repeat;height:16px;width:16px;float:left;margin-top:0px;font-size:10px;text-align:center;line-height:16px;display:none;">
					<span style="color:#fff" id="rwjlwdCount"></span>
				</div>
			</div>
		</div>
		<div style="width: 1px;float: left; height:20px;background-color: #b2b2b2;margin-top: 5px;"></div>
		<div style="width:180px;height:28px;float: left;">
			<div id="cljg_bnts" onclick="tab_onclick('cljg_bnts','cljg_bnt')" class="tab_style float_style" style="margin:0 auto;float:left;">
				<div id="cljg_bnt" style="width:auto;height:28px;float:left;margin-left: 18px;">
					处理结果&nbsp;(<span id="jghbCount">0</span>)
				</div>
				<div id="jghbround_l" style="background:url(<%=basePath%>images/fk_webunreadbg_l.png) no-repeat;height:16px;width:24px;float:left;margin-top:0px;font-size:12px;text-align:center;line-height:16px;display:none;">
					<span style="color:#fff">99+</span>
				</div>
				<div id="jghbround_s" style="background:url(<%=basePath%>images/fk_webunreadbg_s.png) no-repeat;height:16px;width:16px;float:left;margin-top:0px;font-size:10px;text-align:center;line-height:16px;display:none;">
					<span style="color:#fff" id="jghbwdCount"></span>
				</div>
			</div>
		</div>
	</div>
	<div id="ckzl" style="width:97%;font-size: 14px;margin: 10px auto;">
		<div id="ckzl_div" style="clear: both; margin-top: 10px"></div>
		<div id="ckzl_loadover" class="div_bottom"></div>
	</div>
	<div id="rwjl" style="width: 97%;border: 1px solid #D1D1D1;margin-left: 10px;padding: 6px;display: none;margin-bottom: 10px">
		<div id="rwjl_div" style="clear: both; margin-top: 10px"></div>
		<div id="rwjl_loadover" class="div_bottom"></div>
	</div>
	<div id="cljg" style="width: 97%;border: 1px solid #D1D1D1;margin-left: 10px;padding: 6px;display: none;margin-bottom: 10px">
		<div id="cljg_div" style="clear: both; margin-top: 10px"></div>
		<div id="cljg_loadover" class="div_bottom"></div>
	</div>

	<!-- <div id="bottom_div">
		参考信息 start
		<div id="ckzl_div" name="bottom_div" style="width:97%;font-size: 14px;margin: 0px auto;">
			<div id="ckzl_loadover" class="div_bottom"></div>
		</div>
		参考信息 end 
		任务交流 start
		<div id="rwjl_div" name="bottom_div" style="width:100%;font-size: 14px;display: none;">
			<div id="rwjl_loadover" class="div_bottom"></div>
		</div>
		任务交流 end
		处理结果 start
		<div id="cljg_div" name="bottom_div" style="width:100%;font-size: 14px;display: none">
			<div id="cljg_loadover" class="div_bottom"></div>
		</div>
		处理结果  end 
	</div> -->
	<input type="hidden" id="id" value="<%=id%>"/>	
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<input type="hidden" id="CJRBHID" value="" />
	<input type="hidden" id="currentuserid" value="<%=currentuserid %>"/>
	<span id="RWZT" style="display: none"></span>
	<input type="hidden" id="rwcjr" value="<%=rwcjr %>"/>

</body>
</html>
