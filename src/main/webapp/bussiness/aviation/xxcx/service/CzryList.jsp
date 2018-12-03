<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) request.getSession().getAttribute("userid");//用户id
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>全国人员信息查询页面</title>
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<style>
.td_value {
	color: black;
	margin-left: 5px;
	
}

.txt_title {
	width: 112px;
	color: #b2b2b2;
	font-size: 14px;
}

.txt_value {
	font-size: 14px;
	color: #44c4c4c;
}

.tr_height {
	height: 28px;
}

/*修改模块按钮，文字样式 */
.but_style {
	width: 80dp;
	height: 80dp;
}

.zj_style {
	color: #cf7844;
	font-size: 14px;
	margin-left: 15px;
}

.but_txt_style {
	font-size: 14px;
	color: 4c4c4c;
	margin-top: 30px;
}

.but_img_style {
	width: 25%;
	float: left;
	text-align: center;
	margin-top: 36px;
}
.div_span{
	margin-right: 15px;
}
.div_size{
	color: #366AB3;
	font-size: 18px;
}
.div_red{
	color: red;
}
</style>
<script type="text/javascript">
	//全国常住人员信息
	function searchcz(){
		$("#dadiv").html("");
		var sfzh = $("#cardId").val();
		var userid = "<%=userid%>";
		if(!checksfzhm(sfzh)){
			alert("请输入正确的身份证号!");
			return;
		}else{
			$("#dadiv").append("<div style=\" clear: both; width: 98%;text-align: center;margin-top: 20px; margin-bottom: 20px;font-size: 14px;color: #346DB2;\">努力加载中...</div>");
		}
		
		
		$.ajax({
			url:"czryQueryList.action",
			data:"sfzh="+sfzh+"&userid="+userid,
			dataType:"json",
			type:"post",
			success:function(data){
				var value=data.result;
				var objArray = JSON.parse(value);
				$("#dadiv").html("");
				if(null != objArray && ""!= objArray){
					$(objArray).each(function (i, value) { 
						var item = "<div style=\"margin:25px 0px; padding-left: 20px;\">";
						item += "<div style=\"float: left; width: 240px;height: 400px;\"><img src=\""+value.XP+"\" class=\"head\" id=\"userimg\" style=\"width:240px; height:300px;\" /></div>";
						item += "<div style=\"float: left;padding-left: 40px;width: 650px;\">";
						item += "<div style=\"height: 45px;\"><span id=\"XM\" style=\"height:45px;line-height:45px;font-size: 24px;color: #333333;font-weight: bold;\">"+ value.XM+ "</span></div>";
						item += "<div style=\"height: 20px;margin-top: 10px;\">";
						item += "<span class=\"div_span div_size\" onclick=\"searchwf('"+value.BD_RYBH+"','"+value.wffzcount+"','"+value.XP+"')\">违法犯罪信息<span class=\"div_red\">("+value.wffzcount+")</span></span>";
						item += "<span class=\"div_span div_size\" onclick=\"searchzt('"+value.BD_RYBH+"','"+value.ztrycount+"','"+value.XP+"')\">在逃人员信息<span class=\"div_red\">("+value.ztrycount+")</span></span>";
						item += "<span class=\"div_span div_size\" onclick=\"searchsis('"+value.BD_RYBH+"','"+value.sisxyrcount+"','"+value.XP+"')\">SIS嫌疑人<span class=\"div_red\">("+value.sisxyrcount+")</span></span>";
						item += "<span class=\"div_size\" onclick=\"searchjzas('"+value.BD_RYBH+"','"+value.jzascount+"','"+value.XP+"')\">警综嫌疑人<span class=\"div_red\">("+value.jzascount+")</span></span>";
						item += "</div>";
						item += "<div style=\"height: 20px;margin-top: 10px;\">";
						item += "<span class=\"div_span div_size\" onclick=\"searchqlzd('"+value.BD_RYBH+"','"+value.qlzdcount+"','"+value.XP+"')\">情报七类重点人员信息<span class=\"div_red\">("+value.qlzdcount+")</span></span>";
						item += "<span class=\"div_size\" onclick=\"searchkss('"+value.BD_RYBH+"','"+value.kssgycount+"','"+value.XP+"')\">看守所关押人员信息<span class=\"div_red\">("+value.kssgycount+")</span></span>";
						item += "</div>";
						item += "</div>";
						item += "<div style=\"float: left;padding-left: 40px;\">";
						item += "<table style=\"margin-top: 10px;\">";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">曾用名</td>";
						item += "<td class=\"txt_value\" colspan=\"3\"><span id=\"CYM\">"+ value.CYM+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">性别</td>";
						item += "<td class=\"txt_value\" style=\"width: 256px;\"><span id=\"XB\">";
						if(value.XB == 1){
							item += "男";
						}else if(value.XB == 2){
							item += "女";
						}else{
							item += "";
						}
						item += "</span></td>";
						item += "<td class=\"txt_title\" style=\"width: 90px;\">民族</td>";
						item += "<td class=\"txt_value\"><span id=\"MZ\">"+ value.MZMC+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">出生日期</td>";
						item += "<td class=\"mycla\"><span id=\"CSRQ\">"+ value.CSRQ+ "</span></td>";
						item += "<td class=\"txt_title\">年龄</td>";
						item += "<td class=\"txt_value\"><span id=\"NL\">"+ value.NL+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">身高</td>";
						item += "<td class=\"txt_value\"><span id=\"SG\">"+ value.SG+ "</span></td>";
						item += "<td class=\"txt_title\">婚姻状况</td>";
						item += "<td class=\"txt_value\"><span id=\"HYZK\">"+ value.HYZKMC+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">文化程度</td>";
						item += "<td class=\"txt_value\"><span id=\"WHCD\">"+ value.WHCDMC+ "</span></td>";
						item += "<td class=\"txt_title\">兵役状况</td>";
						item += "<td class=\"txt_value\"><span id=\"BYQK\">"+ value.BYQK+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">职业</td>";
						item += "<td class=\"txt_value\"><span id=\"ZY\">"+ value.ZY+ "</span></td>";
						item += "<td class=\"txt_title\">服务处所</td>";
						item += "<td class=\"txt_value\"><span id=\"FWCS\">"+ value.FWCS+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">籍贯国家</td>";
						item += "<td class=\"txt_value\"><span id=\"JGGJ\">" + value.JGGJMC + "</span></td>";
						item += "<td class=\"txt_title\">籍贯市县</td>";
						item += "<td class=\"txt_value\"><span id=\"JGSSX\">"+ value.JGSSXMC+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">出生地址</td>";
						item += "<td class=\"txt_value\" colspan=\"3\"><span id=\"CSDXZ\">"+ value.CSDXZ+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">户籍住址</td>";
						item += "<td class=\"txt_value\" colspan=\"3\"><span id=\"HKSZD\">"+ value.HKSZDMC+ "</span></td>";
						item += "</tr>";
						item += "<tr class=\"tr_height\">";
						item += "<td class=\"txt_title\">现居地址</td>";
						item += "<td class=\"txt_value\" colspan=\"3\"><span id=\"ZZDZ\">"+ value.ZZXZ+ "</span></td>";
						item += "</tr>";
						item += "</table>";
						item += "</div>";
						item += "<div style=\clear: both;\"></div>";
						item += "</div>";
						item += "<div style=\"width: 98%;float: left;height: 40px; line-height: 40px; background-color: #F2F2F2;padding-left: 20px;margin: 10px 0px;\">";
						item += "<div style=\"width: 34%;float: left;\">";
						item += "<span class=\"txt_title\">身份证号</span><span class=\"zj_style\" id=\"GMSFZHM\">"+ value.SFZH+ "</span>";
						item += "</div>";
						item += "<div style=\"width: 33%;float: left;\">";
						item += "<span class=\"txt_title\">护照号码</span><span class=\"zj_style\"></span>";
						item += "</div>";
						item += "<div style=\"width: 33%;float: left;\">";
						item += "<span class=\"txt_title\">同行证号</span><span class=\"zj_style\"></span>";
						item += "</div>";
						item += "</div>";
						$("#dadiv").append(item);
					});
				}else{
					$("#dadiv").append("<div style=\" clear: both; width: 98%;text-align: center;margin-top: 20px; margin-bottom: 20px;font-size: 14px;color: #346DB2;\">无常住人员信息！</div>");
				}
			}
		}); 
	}
	//全国违法犯罪信息
	function searchwf(id,count,url){
		if(count>0){
			window.parent.f_click("GA_WFFZ"+id,"全国违法犯罪信息","<%=basePath%>wffzQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无违法犯罪信息！");
		}
	}
	//全国在逃人员信息
	function searchzt(id,count,url){
		if(count>0){
			window.parent.f_click("GA_ZTRY"+id,"全国在逃人员信息","<%=basePath%>ztryQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无在逃信息！");
		}
		
	}
	//SIS系统主要嫌疑人信息
	function searchsis(id,count,url){
		if(count>0){
			window.parent.f_click("GA_SIS"+id,"SIS系统信息","<%=basePath%>sisxyrQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无SIS系统嫌疑人信息！");
		}
	}
	//警综嫌疑人信息
	function searchjzas(id,count,url){
		if(count>0){
			window.parent.f_click("GA_JZAS"+id,"警综嫌疑人信息","<%=basePath%>jzasxyrQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无警综嫌疑人信息！");
		}
	}
	//七类重点人员信息
	function searchqlzd(id,count,url){
		if(count>0){
			window.parent.f_click("GA_QLZD"+id,"七类重点人员信息","<%=basePath%>qlzdxyrQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无七类重点人员信息！");
		}
	}
	//看守所关押人员信息
	function searchkss(id,count,url){
		if(count>0){
			window.parent.f_click("GA_KSSGY"+id,"看守所关押人员信息","<%=basePath%>kssgyryQueryList.action?rybh="+id+"&xpurl="+url);
		}else{
			top.my_alert("无看守所关押人员信息！");
		}
	}
	function checksfzhm(value){
		/**18位身份证最后一位可能为字母X*/	
		var email =/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)|[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
		if(!email.test(value)){
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div style="padding-left: 20px;">
		<span style="margin-right: 10px;">身份证号</span><input type="text" id="cardId" value=""  class="search_input_style" style="width: 230px;color: gray;height:22px;"/>
		<input type="button" style="background-color: #F07844;border: 1px solid #F07844;height:25px;color: white;width: 120px; margin-left: 10px;border-radius: 5px;" value="常住人员" onclick="searchcz()"/>
	</div>
	<div id="dadiv" style="clear: both;"></div>
</body>
</html>
