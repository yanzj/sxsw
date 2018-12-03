<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
<script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
<script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
<script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script>  
<script  type="text/javascript"  src="<%=basePath  %>js/btnQuery.js" ></script> 
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style type="text/css">
.item_style {
	width: 95%;
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	margin: 10px 0px 10px 10px;
	padding: 6px;
}
.td_span{
	margin-right:20px;
	font-family: 兰亭中黑;
	font-size: 16px;
	font-weight: bold;
	vertical-align: middle;
}
.td_img{
	margin-right:10px;
	vertical-align: middle;
}
</style>
<script  type="text/javascript">
    jQuery(function($){
        $(".my_info").live("mouseover",function(){
		    $(this).addClass("my_info_mess");
		});
		$(".my_info").live("mouseout",function(){
	     	$(this).removeClass("my_info_mess");
	    });
    });
    //点击名字进入详情
	function openDialog(cjrbh) {
		var url = "<%=basePath%>system/user/UserMess.jsp?id="+cjrbh;
		window.top.my_openwindow("",url,700,450,"关注人详情信息");
	}
	var loading = false;	//判断单次加载数据是否完成
	var isend = false;
	var page = 1;
	//滚动加载更多数据
	$(window).scroll(function() {
		if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
			if(!isend && loading == false){
				page = page+1;
				loading = true;
				userlist(page);
			}
			
		}
	});
	function userlist(page){
		$("#div_btm").hide();
		var ssxmbh = $("#SSXMBH").val();
		$.ajax({
			url:"findzgrByssxmbhlxMore.action",
			data:"page="+page+"&pagesize=10"+"&ssxmlx=controlps&ssxmbh="+ssxmbh,
			dataType:"json",
			type:"post",
			success:function(data){
				var value=data.msg;
				if(value.length==2){
				    $("#loadover").show();
				    $("#loadover").html('数据加载完成');
				    isend=true;
				    return;
				}else{
				    $("#loadover").hide();
					var objArray = JSON.parse(value);
					if(objArray.length<10){
					    $("#loadover").show();
					    $("#loadover").html('数据加载完成');
					    isend=true;
					}
	   			 	$(objArray).each(function (i, value) { 
		   			 	var item = "<div class=\"item_style\"><input type=\"hidden\" value=\""+value.SSXMBH+"\"/><table width=\"99%;\">";
						var item1 = "<tr><td rowspan=\"3\" style=\"text-align: center;width: 120px;\">"; 
						var item2 = "<img src=\"<%=basePath %>"+value.CJRTX+"\" style=\"width: 96px;height: 96px;border-radius:50%;background-color:#B3B3B3;margin:0px 24px;\"/></td>";
 						var item3 = "<td style=\"font-size: 18px;font-weight: bold;width: 30%; text-align: left; color:#366cb3;\"><span>"+value.CJRXM+"</span></td>";
 						var item4 = "<td rowspan=\"2\" colspan=\"2\" style=\"text-align: right;margin-right: 10px;font-size: 14px;\"><span style=\"margin-right: 10px;\">"+value.CJSJ+"</span>关注</td></tr>";
						var item5 = "<tr><td colspan=\"3\" style=\"font-family:兰亭纤黑;font-size: 16px;font-weight: bold;\">";	
						var item6 = "<span>"+value.JCMC+"</span><span style=\"margin:0px 30px 0px 40px;\">"+value.DICT+"</span><span>"+value.ZWMC+"</span></td></tr>"; 
						var item7 = "<tr style=\"border-top:1px solid #b2b2b2;color: #4A4A4A;height: 40px;\">";		
						var item8 = "<td style=\"width:30%;\"><img src=\"<%=basePath %>images/common/fk_phoneicon1.png\" class=\"td_img\"/><span class=\"td_span\">"+value.MOBILE+"</span></td>";
						var item9 = "<td style=\"width:30%;\"><img src=\"<%=basePath %>images/common/fk_phoneicon.png\" class=\"td_img\"/><span class=\"td_span\">"+value.PHONE+"</span></td>";
						var item10 = "<td style=\"width:30%;\"><img src=\"<%=basePath %>images/common/fk_mailicon.png\" class=\"td_img\"/><span class=\"td_span\">"+value.MAIL+"</span></td></tr></table></div>";
						$("#bigDiv").append(item+item1+item2+item3+item4+item5+item6+item7+item8+item9+item10);
	   			 	});
	   				loading = false;
				}
			}
		});
	}
    </script>
</head>
<body style="padding:0px;">
	<div style="height:25px;background-color: #ef7844;"></div>
	<div id="bigDiv">
		<c:forEach var="item" items="${findzgrlist}" varStatus="status">
			<div class="item_style">
				<input type="hidden" value="${item.SSXMBH }" id="SSXMBH"/>
				<table width="99%;" height="120px;">
					<tr>
						<td rowspan="3" style="text-align: center;width: 120px;">
							<img src="<%=basePath %>${item.CJRTX}" style="width: 96px;height: 96px;border-radius:50%;background-color:#B3B3B3;margin:0px 24px;" /></td>
						<td style="font-size: 18px;font-weight: bold;width: 30%; text-align: left; color:#366cb3;"><span class="my_info" onclick="openDialog('${item.CJRBH}')">${item.CJRXM }</span></td>
						<td rowspan="2" colspan="2" style="text-align: right;margin-right: 10px;font-size: 14px;"><span style="margin-right: 10px;">${item.CJSJ}</span>关注</td>
					</tr>
					<tr>
						<td colspan="3" style="font-family:兰亭纤黑;font-size: 16px;font-weight: bold;">
							<span>${item.JCMC }</span>
							<span style="margin:0px 30px 0px 40px;">${item.DICT }</span>
							<span>${item.ZWMC }</span>
						</td>
					</tr>
					<tr style="border-top:1px solid #b2b2b2;color: #4A4A4A;height: 40px;">
						<td style="width:30%;"><img src="<%=basePath %>images/common/fk_phoneicon1.png" class="td_img"/><span class="td_span">${item.MOBILE }</span></td>
						<td style="width:30%;"><img src="<%=basePath %>images/common/fk_phoneicon.png" class="td_img"/><span class="td_span">${item.PHONE }</span></td>
						<td style="width:30%;"><img src="<%=basePath %>images/common/fk_mailicon.png" class="td_img"/><span class="td_span">${item.MAIL }</span></td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(findzgrlist)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(findzgrlist)==0}">无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
</body>
</html>
