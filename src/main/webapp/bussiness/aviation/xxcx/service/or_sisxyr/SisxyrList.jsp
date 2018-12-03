<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SIS系统主要嫌疑人详情页面</title>
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<style type="">
.txt_title {
	font-size: 14px;
	color:#b2b2b2;
	width:90px;
	display: inline-block;
}
.txt_value{
	color: #4d4d4d;
	font-size: 14px;
}

tr
{
 height: 25px;
}
</style>
</head>
<body style="padding-left: 40px;">
	<div style="padding-top: 30px;"> 
	    <div style="float: left; width: 148px; height: 184px;"><img  style="width: 148px; height: 184px;" src="${xpurl} " id="user_img"/></div>
	    <div style="float: left;margin-left: 30px;width:75%;">
	       <div style="font-size: 24px; font-weight: bold;">${sessionScope.sisxyrlist[0].XM }</div>
	       <div style="font-size: 18px; font-weight: bold; color:#ef7844; margin-top: 12px;">${sessionScope.sisxyrlist[0].ZJHM }</div>
	       <div style="border:1px solid #b2b2b2;border-radius: 5px;margin-top: 10px;">
	           <div style="margin: 10px 0px 10px 20px;"><span style="font-size: 18px;color: #4c4c4c;width: 220px;display: inline-block;">SIS系统嫌疑人</span><span style="font-size: 18px;color: #ef7844">(${fn:length(sisxyrlist)})</span></div>
	       </div>
	    </div>
	    <div style="clear:both;"></div>
    </div>
	<div id="dadiv" style="margin-top:30px; border-radius: 0px;" class="item_style">
		<c:forEach var="item" items="${sisxyrlist}" varStatus="s">
			<table style="width: 98%;border-collapse: collapse;">
			  <tr style="height: 35px; line-height: 35px;">
			    <td rowspan="13"  valign="top">
				    <div style="border: 1px solid #F07844;border-radius: 30px;height:30px;width: 30px;background-color: #F07844;text-align: center;line-height:30px; margin-left: 8px; margin-right: 8px;">
					<span style="color: white;font-size: 18px;font-weight: bold;"><c:out value="${s.count }"></c:out></span>
				    </div>
			    </td>
			    <td colspan="3" style=" border-bottom: 1px solid #b2b2b2"><span style="font-size: 15px; font-weight: bold; ">人员详情信息</span></td>
			  </tr>
			  <tr style="height: 10px;"></tr>
			  <tr>
			    <td style="width: 288px;"><span class="txt_title">绰号</span><span class="txt_value">${item.BMCH}</span></td>
			    <td style="width: 288px;"><span class="txt_title">人员类别</span><span class="txt_value">${item.RYLB }</span></td>
			  </tr> 
			  <tr>
			    <td><span class="txt_title">联系电话</span><span class="txt_value">${item.LXDH }</span></td>
			    <td><span class="txt_title">原始电话</span><span class="txt_value">${item.YS_LXDH }</span></td>
			    <td><span class="txt_title">人员编号</span><span class="txt_value">${item.RYBH}</span></td>
			  </tr>
			  <tr>
			    <td><span class="txt_title">指纹编号</span><span class="txt_value">${item.SZZWBH}</span></td>
			    <td colspan="2"><span class="txt_title">工作单位</span><span class="txt_value">${item.DWMC}</span></td>
			  </tr>
			  <tr>
			    <td colspan="3"><span class="txt_title">户籍所在地</span><span class="txt_value">${item.QHNXXDZ}</span></td>
			  </tr>
			  <tr> 
			    <td colspan="3"><span class="txt_title">家庭地址</span><span class="txt_value">${item.DZMC}</span></td>
			  </tr>
			  <tr style="height: 35px; line-height: 35px;">
			    <td colspan="3" style=" border-bottom: 1px solid #b2b2b2"><span style="font-size: 15px; font-weight: bold; ">涉案情况</span></td>
			  </tr>
			  <tr>
			    <td><span class="txt_title">涉案类别</span><span class="txt_value">${item.AJLBMC}</span></td>
			    <td><span class="txt_title">采集人</span><span class="txt_value">${item.CJR}</span></td>
			    <td><span class="txt_title">采集时间</span><span class="txt_value">${item.LRSJ }</span></td>
			  </tr>
			  <tr>
			    <td colspan="2"><span class="txt_title">采集单位</span><span class="txt_value">${item.ZZJGMC}</span></td>
			  </tr>
			  <tr>
			    <td><span class="txt_title">简要案情</span></td>
			  </tr>
			  <tr>
			    <td colspan="3" class="txt_value">${item.QTXX}</td>
			  </tr>
			</table>	
		</c:forEach>
	</div>
</body>
</html>
