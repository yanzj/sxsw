var basepath;
var BD_RYBH;
var BD_RYXM;
jQuery(function($) {
	basepath = $("#basepath").val();
	BD_RYBH = $("#BD_RYBH").val();
	getMess(BD_RYBH);
	
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	
	
	pass();             //判断是否具有最终列控权限
});
/**
 * 获取单个列控对象详情信息
 */
function getMess(mid) {
	$.ajax({
		url : "approvalsQueryBySFZH.action?BD_RYBH=" + mid,
		dataType : "json",
		async : false,
		type : "post",
		success : function(mm) {
			$("#SPBH").val(mm.SPDXBH);
			$("#XM").html(mm.XM);
			BD_RYXM=mm.XM;
			$("#GJ").html(mm.JG);
			if (mm.XB == 1) {
				$("#XB").html("男");
			} else if(mm.XB == 2){
				$("#XB").html("女");
			} else if(mm.XB == 9){
				$("#XB").html("未知");
			}
			$("#QQ").html(mm.QQ);
			$("#NL").html(mm.NL);
			$("#CSRQ").html(mm.CSRQ);
			$("#MZMC").html(mm.MZMC);
			$("#SJHM").html(mm.SJHM);
			$("#ZY").html(mm.ZY);
			$("#SFZH").html(mm.SFZH);
			$("#ZJZZ").html(mm.ZJZZ);
			$("#JG").html(mm.JG);
			$("#ZZDZ").html(mm.ZZDZ);
			$("#DQSJ").html(mm.DQSJ);
			$("#CJRXM").html(mm.CJRXM);
			$("#CJRBH").val(mm.CJRBH);
			$("#CJSJ").html(mm.CJSJ);
			if (mm.BZ != "") {
				$("#BZ").html(mm.BZ);
			} else {
				$("#BZ").html("");
			}
			$("#GKLBMC").val(mm.GKLBMC);
			$("#SPYJBH").val(mm.SPYJBH);
			$("#JCMC").html(mm.JCMC);
			$("#BMMC").html(mm.BMMC);
			$("#CJRXM").html(mm.CJRXM);
			$("#CJRBH").val(mm.CJRBH);
			$("#CJSJ").html(mm.CJSJ);
			$("#GKLBMC1").html(mm.GKLBMC);
			$("#YJYQ").html(mm.YJYQ);
			$("#YY").html(mm.YY);
			
			$("#TJLK").hide();
			$("#CXLK").hide();
			$("#BJLK").hide();
			$("#lineTj").hide();
			$("#lineCX").hide();
			//列控状态
			var ZT = mm.ZT;
			if(ZT=="0"){
				$("#ZT").html("(列控)");
				$("#lb").html("(列控)");
				$("#CXLK").show();
				$("#BJLK").show();
				$("#lineCX").show();
				$("#LKYY").html("列控原因：");
			}
			if(ZT=="1"){
				$("#ZT").html("(禁用)");
				$("#lb").html("(禁用)");
				$("#TJLK").show();
				$("#lineTj").show();
				$("#LKYY").html("禁用原因：");
			}
			if(ZT=="2"){
				$("#ZT").html("(申请启用中)");
				$("#lb").html("(申请启用中)");
				$("#LKYY").html("启用原因：");
			}
			if(ZT=="3"){
				$("#ZT").html("(申请禁用中)");
				$("#lb").html("(申请禁用中)");
				$("#LKYY").html("禁用原因：");
			}
			if(ZT=="4"){
				$("#ZT").html("(申请编辑中)");
				$("#lb").html("(申请编辑中)");
				$("#LKYY").html("编辑原因：");
			}
			$("#RYBH").val(mm.RYBH);
			//判断是否关注
			var GZBH = mm.GZBH;	
			//关注
			if(GZBH!=null && GZBH!=""){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_focusonforaimat.png\"/>");
			}else{
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_eyesongrey.png\"/>");
			}
			// start  成功管控后的预警对象、预警部门
			//预警部门
			var deptList = mm.yjDeptList;
			var itemdept = "";
			$(deptList).each(
				function(i, value) {
					var item1 = "<span id='"+ value.YHBH + "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"
						+ value.YHXM + "</span>(" + value.JCMC + "-" + value.BMMC + ")&nbsp;&nbsp;";
					itemdept += item1;
			});
			$("#YJBMMC").html(itemdept);
			//预警对象
			var userList = mm.yjUserList;
			var itemuser = "";
			$(userList).each(function(i, value) {
				var item2 = "<span id='"+ value.YHBH+ "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"+ value.YHXM + "</span>("+ value.JCMC + "-" + value.BMMC+ ")&nbsp;&nbsp;";
				itemuser += item2;
			});
			$("#YJDXMC").html(itemuser);
			// end
			// 遍历list
			var itemtj = "";
			var list = mm.list;
			$(list).each(function(i,value){
				//提交申请人信息 start
				var itemtj1 = "<table style=\"width:100%;margin-top:10px;margin-bottom:10px;border-collapse:collapse;\"><tr style=\"border-bottom:1px solid #b2b2b2;height:40px;line-height:40px\">";
				var itemtj2 = "<td class=\"txt_value\" style=\"width:20%;\">"+value.CJSJ+"</td>";
				var itemtj3 = "";
				var itemtj4 = "<td class=\"txt_value\" style=\"width:15%;\">"+value.JCMC+"</td>";
				var itemtj5 = "<td class=\"txt_value\" style=\"width:10%;\">"+value.BMMC+"</td>";
				var itemtj6 = "<td class=\"txt_value my_info\" style=\"color:#007EE2;width:10%;\"><span id=\"CJRXM\" onclick=\"getCJRXM('"+value.CJRBH+"')\">"+value.CJRXM+"</span></td>";
				if(value.LB == '0'){
					itemtj3 += "<td class=\"txt_value\"  style=\"width:15%;color:#F07844\">列控</td>";
				}else if(value.LB =='1'){
					itemtj3 += "<td class=\"txt_value\"  style=\"width:15%;color:#F07844\">启用</td>";
				}else if(value.LB =='2'){
					itemtj3 += "<td class=\"txt_value\"  style=\"width:15%;color:#F07844\">禁用</td>";
				}else if(value.LB =='3'){
					itemtj3 += "<td class=\"txt_value\"  style=\"width:15%;color:#F07844\">编辑</td>";
				}
				var itemtj7="";
				if(value.SPZT == '0'){
					itemtj7 += "<td class=\"txt_value\"  style=\"width:10%;color:#F07844\">未审批</td>";
				}else if(value.SPZT == '1'){
					itemtj7 += "<td class=\"txt_value\"  style=\"width:10%;color:#F07844\">上报中</td>";
				}else if(value.SPZT == '2'){
					itemtj7 += "<td class=\"txt_value\"  style=\"width:10%;color:#F07844\">拒绝</td>";
				}else if(value.SPZT == '3'){
					itemtj7 += "<td class=\"txt_value\"  style=\"width:10%;color:#F07844\">通过</td>";
				}else if(value.SPZT == '4'){
					itemtj7 += "<td class=\"txt_value\"  style=\"width:10%;color:#F07844\">打回修改</td>";
				}
				var itemtj8 = "<td class=\"txt_value\" width=\"20%;\" style=\"color:#007EE2\"><span onclick=\"spdetail('"+value.SPDXBH+"')\" class = \"my_info\">收起详情>></span></td>";
				var itemtj9 = "</tr></table>";
				//判断是否需要加载 默认 需要=true 
				var item1="";
				item1+="<div id=\"div"+value.SPDXBH+"\">";
				item1+="<div id=\"is_load"+value.SPDXBH+"\" style=\"display:none\">true</div>";
				item1+="<div id=\"td_warn"+value.SPDXBH+"\" style=\"display:none;text-align:center;height:40px;line-height:40px;\">正在加载中...</div>";
				//流程信息记录
				item1+="<div id=\"lc_xxjl"+value.SPDXBH+"\"  style=\"width:100%;\"></div>";
				item1+=" </div>";
				itemtj +=itemtj1+itemtj2+itemtj3+itemtj4+itemtj5+itemtj6+itemtj7+itemtj8+itemtj9+item1;
				//提交申请人信息 end
			});
		
			$("#divXQ").append(itemtj);
			var pic = document.getElementById("userimg");
			pic.src =  mm.XP;
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});

}

/**
关注信息更改
 */
function  getGz(){
	var RYBH =$("#RYBH").val();
	var gz = $("#gz").val();
	$.ajax({
		url : "GZ.action",
		data : "GZ=" + gz + "&RYBH=" + RYBH,
		dataType : "json",
		async : false,
		type : "post",
		success : function(mm) {
			if("savsuccess" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("关注成功!","success");
			}else if("delsuccess" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("取消关注成功!","success");
			}else if("saverror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("该信息已关注!","success");
			}else if("delerror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+basepath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("该信息已取消关注!","success");
			}
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}

/**
 * 点击申请人详情
 */
function getCJRXM(cjrbh) {
	if (cjrbh == null) {
		cjrbh = $("#CJRBH").val();
	}
	var url = basepath + "system/user/UserMess.jsp?id=" + cjrbh;
	window.top.my_openwindow("", url, 700,450, "上控人详情信息");
}

/*
 * 审批历史记录 点击查看审批详情
 */
function spdetail(id)
{
	$("#td_warn"+id).html('正在加载中...');
	//判断是否需要继续加载
	var is_load=$("#is_load"+id).html();
	if(is_load=="false")
	{
		if($("#div"+id).is(":hidden"))
		{
			$("#div"+id).show();
		}
		else
		{
			$("#div"+id).hide();
		}
		return;
	}
	$("#td_warn"+id).show();
	//审批详情
	showMess(id);
}

/**
 * 显示审批流信息
 */
function showMess(spdxbh) {
	$.ajax({
		url:"showApprovalsMess.action",
		data:"spdxbh="+spdxbh,
		dataType:"json",
		type:"post",
		success:function(model){
			//预警部门
			var deptList = model.yjDeptList;
			var itemdept = "";
			$(deptList).each(
				function(i, value) {
					var item1 = "<span id='"+ value.YHBH + "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"+ value.YHXM + "</span>(" + value.JCMC + "-" + value.BMMC + ")&nbsp;&nbsp;";
					itemdept += item1;
			});
			//预警对象
			var userList = model.yjUserList;
			var itemuser = "";
			$(userList).each(
				function(i, value) {
					var item2 = "<span id='"+ value.YHBH + "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"
					+ value.YHXM + "</span>(" + value.JCMC + "-" + value.BMMC + ")&nbsp;&nbsp;";
					itemuser += item2;
			});
			// end
			var itemjtbj = "";
			var itemyj6 = "";
			var itemjb1 = "";
			var itemjb2 ="";
			//审批标记 start
			//审批标记 bj 
			var itembj1 = "<div><table style=\"width: 80%;margin:5px 0px;\">";
			var itembj2 = "";var itembj3 = "";var itembj4 = "";
			var itembj5 = "";var itembj6 = "";var itembj7 = "</tr></table>";
			//箭头标记 jtbj
			var itemjtbj0 = "<div>";
			var itemjtbj1 = "<table style=\"width:100%;margin:30px 0px 0px 30px;\">"
				var	itemjtbj2 = ""; var itemjtbj3 = ""; var itemjtbj4 = "";
				var itemjtbj5 = "</tr></table>";	
				var itemjtbj6 = "</div>";
				//判断审批状态
				if(model.SPZT==0){
					itembj2 = "<tr><td><img src=\""+basepath+"images/lkgl/fk_websubmitorg.png\"/></td>";
					itembj3 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg_rey.png\" id=\"lc_tj_zx\"/></td>";	
					itembj4 = "<td><img src=\""+basepath+"images/lkgl/fk_webapprovalgrey.png\" id=\"lc_sp_img\" /></td>";		
					itembj5 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlinegrey.png\" id=\"lc_sp_zx\" /></td>";	
					itembj6 = "<td><img src=\""+basepath+"images/lkgl/fk_webpassgrey.png\" id=\"lc_pz_img\" /></td>";	
					itemjtbj2 = "<tr><td style=\"width: 33%;\"><img id=\"lc_tj_jt\"  src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td>";
					itemjtbj3 = "<td style=\"width: 33%;\"></td> ";	
					itemjtbj4 = "<td style=\"width: 21%;\"></td> ";		
				}
				//上报   拒绝   打回修改 
				else if(model.SPZT==1||model.SPZT==2||model.SPZT==4){
					itembj2 = "<tr><td><img src=\""+basepath+"images/lkgl/fk_websubmitorg.png\"/></td>";
					itembj3 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg.png\" id=\"lc_tj_zx\"/></td>";	
					itembj4 = "<td><img src=\""+basepath+"images/lkgl/fk_webapprovalorg.png\" id=\"lc_sp_img\" /></td>";		
					itembj5 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg_rey.png\" id=\"lc_sp_zx\" /></td>";	
					itembj6 = "<td><img src=\""+basepath+"images/lkgl/fk_webpassgrey.png\" id=\"lc_pz_img\" /></td>";	
					itemjtbj2 = "<tr><td style=\"width: 33%;\"></td>";
					itemjtbj3 = "<td style=\"width: 33%;\"><img id=\"lc_sp_jt\" src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td> ";	
					itemjtbj4 = "<td style=\"width: 21%;\"></td> ";
				}
				//通过
				else if(model.SPZT==3)
				{
					itembj2 = "<tr><td><img src=\""+basepath+"images/lkgl/fk_websubmitorg.png\"/></td>";
					itembj3 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg.png\" id=\"lc_tj_zx\"/></td>";	
					itembj4 = "<td><img src=\""+basepath+"images/lkgl/fk_webapprovalorg.png\" id=\"lc_sp_img\" /></td>";		
					itembj5 = "<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg.png\" id=\"lc_sp_zx\" /></td>";	
					itembj6 = "<td><img src=\""+basepath+"images/lkgl/fk_webpassorg.png\" id=\"lc_pz_img\" /></td>";	
					itemjtbj2 = "<tr><td style=\"width: 33%;\"></td>";
					itemjtbj3 = "<td style=\"width: 33%;\"></td> ";	
					itemjtbj4 = "<td style=\"width: 21%;\"><img id=\"lc_pz_jt\" src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td> ";

				}
				itemjtbj += itembj1+itembj2+itembj3+itembj4+itembj5+itembj6+itembj7+itemjtbj0+itemjtbj1+itemjtbj2+itemjtbj3+itemjtbj4+itemjtbj5+itemjtbj6
				//审批标记 end

				//循环审批意见集合 start
				var list = model.opmodel;
				var itemsplxx = "";
				$(list).each(function(i, value) {
					var itemyj6="<tr style=\"border-bottom:1px solid gray;\" class=\"tr_height\"><td colspan=\"5\" class=\"txt_value1\" style=\"color:#9E9E9E;\"><span style=\"margin-left: 38px;margin-right:10px;\">审批人&nbsp;：</span>";
					var spczrList=value.spczrList;
					$(spczrList).each(function(i, values){
						itemyj6+="<span>&nbsp;&nbsp;"+values.SPRXM+"&nbsp;&nbsp;</span>";
					});
					itemyj6+= "</td></tr>";

					var itemyj7 = "";
					if(value.CZZT==0)
					{
						itemyj7+="<tr id=\"wsp\"><td style=\"width: 10%;text-align:center\"><img src=\""+basepath+"images/lkgl/fk_webdot.png\" /></td><td  colspan=\"4\" ><span class=\"txt_value1\" style=\"color:red\">未审批</span></td></tr><tr style=\"height:10px\"></tr>";
						itemsplxx += itemyj6+itemyj7;
					}else{
						var zt = "";
						if (value.CZZT == "1") {
							zt = "上报";
						} else if (value.CZZT == "2") {
							zt = "拒绝";
						} else if (value.CZZT == "3") {
							zt = "通过";
						} else if (value.CZZT == "4") {
							zt = "打回修改";
						}
						itemyj7 = "<tr class=\"tr_height\"><td style=\"width: 10%;text-align:center\"><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td><td style=\"width: 30%;color:#F94E4F\"class=\"txt_value1\">"+ value.CZSJ+ "</td>";
						var itemyj8 = "<td style=\"width: 15%;color:#366CB4\" class=\"txt_value1\"><span class=\"my_info\" onclick=\"getCJRXM('"+ value.CZRBH+ "')\">"+ value.CZRXM+ "</span></td>";
						var itemyj9 = "<td style=\"width: 30%;\" class=\"txt_value1\">"+ value.CZRJCMC+ "---"+ value.CZRBMMC+ "</td>";
						var itemyj10 = "<td style=\"width: 15%;color:#F94E4F\" class=\"txt_value1\">"+ zt+ "</td></tr>";
						var itemyj11="<tr><td colspan=\"5\"><span style=\"margin-left:200px;\" class=\"txt_value1\">审批意见："+value.SPYJ+"</span></td></tr>";

						itemsplxx += itemyj6+itemyj7+itemyj8+itemyj9+itemyj10+itemyj11;
					}
				});
				var itemyj2 = "";
				var itemyj1 = "<div style=\"width:95%;margin:-3px 0px 30px 0px;background-color: #F2F3F3;border-radius:7px;padding-top: 30px;padding-bottom: 30px;\">";
				itemyj2 += "<table style=\"width:100%\">";
				itemyj2 += "<tr class=\"tr_height\"><td style=\"width: 10%;text-align:center\"><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td><td style=\"width: 30%;color:#F94E4F\" class=\"txt_value1\">"+ model.CJSJ+ "</td>";
				var itemyj3 = "<td style=\"width: 15%;color:#366CB4\" class=\"txt_value1\"><span class=\"my_info\" onclick=\"getCJRXM('"+ model.CJRBH+ "')\">"+ model.CJRXM+ "</span></td>";
				var itemyj4 = "<td style=\"width: 30%;\" class=\"txt_value1\">"+ model.JCMC+ "---"+ model.BMMC+ "</td>";
				var itemyj5 = "<td style=\"width: 15%;color:#F94E4F\" class=\"txt_value1\">提交</td></tr>";
				var itemyj12 = "</table></div>";
				itemyj6 +=itemyj1+itemyj2+itemyj3+itemyj4+itemyj5+itemsplxx+itemyj12;

				//循环审批意见集合 end

				//基本列控信息 start
				if(model.LB == "2"){
					var item16 = "";
					item16 += "<table>";
					var item17 = "<tr class=\"tr_height\" style = \"border:1px solid red\">";
					item17 += "<td class=\"txt_title\">管控类型&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";
					var item18 = "<td class=\"txt_value\">"+model.GKLBMC+"</td></tr>";
					var item19 = "<tr class=\"tr_height\"><td class=\"txt_title\">撤销原因&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";
					var item20 = "<td class=\"txt_value\">"+model.YY+"</td></tr>";
					var item21 = "<td class=\"txt_title\" style=\"vertical-align:middle;\">备注说明</td>";
					var item22 = "<td class=\"txt_value\">"+model.BZXX+"</td></tr></table>";
					var item23 = "<div style=\"height:1px;margin-top:30px;,margin-bottom:30px;background-color: #F07844;\"></div";
					itemjb1+=item16+item17+item18+item19+item20+item21+item22+item23;
				}else{
					var item16 = "";
					item16 += "<table>";
					var item17 = "<tr class=\"tr_height\" style = \"border:1px solid red\">";
					item17 += "<td class=\"txt_title\">管控类型&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";
					var item18 = "<td class=\"txt_value\">"+model.GKLBMC+"</td></tr>";
					var item19 = "<tr class=\"tr_height\"><td class=\"txt_title\">列控原因&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";
					var item20 = "<td class=\"txt_value\">"+model.YY+"</td></tr>";
					var item21 = "<tr class=\"tr_height\">";
					var item22 = "<td class=\"txt_title\">预警对象&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";
					var item23 = "<td class=\"txt_value\">";
					var item24 = "</td></tr>";	
					item24 += "<tr class=\"tr_height\">";		
					var item25 = "<td class=\"txt_title\">预警单位&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";	
					var item26 = "<td class=\"txt_value\">";
					var item27 = "</td></tr>";
					item27 += "<tr class=\"tr_height\">";
					var item28 = "<td class=\"txt_title\">预警要求&nbsp;<span style=\"color:red;vertical-align: middle\">*</span></td>";	
					var item29 = "<td class=\"txt_value\">"+model.YJYQ+"</td></tr>";		
					var item30 = "<tr class=\"tr_height\" style=\"border-bottom: 1px solid red;\">";	
					var item31 = "<td class=\"txt_title\" style=\"vertical-align:middle;\">备注说明</td>";
					var item32 = "<td class=\"txt_value\">"+model.BZXX+"</td></tr></table>";
					var item33 = "<div style=\"height:1px;margin-top:30px;,margin-bottom:30px;background-color: #F07844;\"></div></div>";
					itemjb2 += item16+item17+item18+item19+item20+item21+item22+item23+itemuser+item24+item25+item26+itemdept+item27+item28+item29+item30+item31+item32+item33;
					// 基本列控信息 end
				}
				$("#lc_xxjl"+spdxbh).append(itemjtbj+itemyj6+itemjb1+itemjb2);
				$("#is_load"+spdxbh).html("false");
				$("#td_warn"+spdxbh).hide();
		},error:function(error){
			alert("获取单个信息失败****" + error.status);
		}
	});

}

/**
 * 列控对象点击详情
 */
function getRYXM() {
	var casename = $("#XM").html();
	var url = basepath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + BD_RYBH;
	var tabid = "GDPJ" + "-" + BD_RYBH;
	this.parent.f_click(tabid, casename, path + url);
}

function commomTj(url,title,type){
	var width=640;
	var height=520;
	if(type=="cxlk")
	{
		width=610;
		height=350;
	}
	winOpen(url, title, width, height, '提交', '取消', function(data,dialog){
		if ("okpass" == $("#pass").val()) {
			LKDXTG(data,type);
		}else{
			LKDXTJ(data,type);
		}
	});
}
//列控对象通过---有审批权限
function LKDXTG(data,type){
	var tip = "";
	var tip1 = "";
	if(type=="tjlk"){
		tip = "您具有审批权,确定启用此信息成为列控对象？";
		tip1 = "启用";
	}else if(type=="bjlk"){
		tip = "您具有审批权,确定编辑此列控对象？";
		tip1 = "编辑";
	}else if(type=="cxlk"){
		tip = "您具有审批权,确定禁用此列控对象？";
		tip1 = "撤销";
	}
	window.top.$.ligerDialog.confirm(tip, "提示",function(ok) {
		if (ok) {
			window.top.$.ligerDialog.close();
			$("#bg").addClass("bg");
			top.$.ligerDialog.waitting('正在提交中,请稍候...');
			$.ajax({
				url:"approvalsModifyokpass.action",
				data:data,
				dataType:"json",
				type:"post",
				success:function(mm){
					if ("success" == mm.result) {
						$("#divXQ").html("");
						getMess(BD_RYBH);
						top.$.ligerDialog.success(tip1+"成功！");
					} else {
						top.$.ligerDialog.error(tip1+"失败！");
					}
				},error:function(error){
					top.$.ligerDiloag.error(tip1+"失败！" + error.status,"错误");
				}
			});
			$("#bg").removeClass("bg");
			window.top.$.ligerDialog.closeWaitting();
		}
	});
}
//列控对象提交---没有审批权限
function LKDXTJ(data){
	window.top.$.ligerDialog.close();
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url:"AddlkPass.action",
		data:data,
		dataType:"json",
		type:"post",
		success:function(mm){
			if("success"==mm.result){
				top.$.ligerDialog.success("提交成功！");
				$("#divXQ").html("");
				getMess(BD_RYBH);
			}else{
				top.$.ligerDialog.error("提交失败！");
			}
		},error:function(error){
			$.ligerDialog.error("列控失败！"+error.status,"错误");
		}
	});
	$("#bg").removeClass("bg");
	window.top.$.ligerDialog.closeWaitting();
}
//撤销列控对象
function cxlkdxClick(){
	var url = basepath + "bussiness/aviation/lkgl/lkdx/lkdxcxAdd.jsp?BD_RYBH="+BD_RYBH+"&BD_RYXM="+BD_RYXM;
	commomTj(url,"禁用列控","cxlk");
}

//启用列控对象
function tjlkdxClick(){
	var url = basepath + "bussiness/aviation/lkgl/lkdx/lkdxtjAdd.jsp?BD_RYBH="+BD_RYBH+"&type=tjlk&BD_RYXM="+BD_RYXM;
	commomTj(url,"启用列控","tjlk");
}
//编辑列控对象
function bjlkdxClick(){
	var url = basepath + "bussiness/aviation/lkgl/lkdx/lkdxtjAdd.jsp?BD_RYBH="+BD_RYBH+"&type=bjlk&BD_RYXM="+BD_RYXM;;
	commomTj(url,"编辑列控","bjlk");
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
