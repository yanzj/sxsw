var basepath;
$(function() {
	basepath = $("#basepath").val();
	var spdxbh = $("#spdxbh").val();
	// 鼠标放上去的样式
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	getMess(spdxbh); // 详情
	// 文本框默认值点击后清空，移除点击后又赋给默认值
	$("textarea[holder]").each(function() {
		var $this = $(this);
		$this.addClass("holder");
		$this.val($this.attr("holder"));
	}).live("focusin", function() {
		var $this = $(this);
		if ($this.val() == $this.attr("holder")) {
			$this.removeClass("holder");
			$this.val("");
		}
	}).live("focusout", function() {
		var $this = $(this);
		if ($this.val() == "") {
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	});

});
function getMess(spdxbh) {
	$.ajax({
		url : "approvalsQueryById.action",
		data: "spdxbh=" + spdxbh,
		dataType : "json",
		async : false,
		type : "post",
		success : function(mm) {
			$("#BD_RYBH").val(mm.BD_RYBH);
			$("#SPBH").val(mm.SPDXBH);
			$("#XM").html(mm.XM);
			if (mm.XB == 1) {
				$("#XB").html("男");
			} else if(mm.XB == 2){
				$("#XB").html("女");
			}else if(mm.XB==9){
				$("#XB").html("未知");
			}
			$("#NL").html(mm.NL);
			$("#CSRQ").html(mm.CSRQ);
			$("#MZMC").html(mm.MZMC);
			$("#ZY").html(mm.ZY);
			$("#SFZH").html(mm.SFZH);
			$("#SFZHM").val(mm.SFZH);
			$("#ZZXZ").html(mm.ZZXZ);
			$("#HKSZD").html(mm.HKSZD);
			$("#JCMC").html(mm.JCMC);
			$("#BMMC").html(mm.BMMC);
			$("#DQSJ").html(mm.DQSJ);
			if (mm.SPZT == 0) {
				$("#spzt").html("未审批");
			} else if (mm.SPZT == 1) {
				$("#spzt").html("上报");
			} else if (mm.SPZT == 2) {
				$("#spzt").html("拒绝");
			} else if (mm.SPZT == 3) {
				$("#spzt").html("通过");
			} else if (mm.SPZT == 4) {
				$("#spzt").html("打回修改");
			}
			$("#CJRXM").html(mm.CJRXM);
			$("#CJRBH").val(mm.CJRBH);
			$("#CJSJ").html(mm.CJSJ);
			if (mm.BZ != "null") {
				$("#BZ").html(mm.BZ);
			} else {
				$("#BZ").html("");
			}
			$("#YJYQ").html(mm.YJYQ);
			$("#YY").html(mm.YY);
			$("#GKLBMC1").html(mm.GKLBMC);
			$("#SPYJBH").val(mm.SPYJBH);
			$("#YJYQ").val(mm.YJYQ);
			$("#lb").val(mm.LB);
			$("#GKLBMC").html(mm.GKLBMC);
			var hisList = mm.hisLists;
			if (hisList.length > 0) {
				var itembjxx = "";
				$(hisList).each(function(i, value) {
					$("#bjxx").show();
					if (value.ZDMC == "DQSJ") {
						if(getdatetwo(value.OLD_VALUE)!=getdatetwo(value.NEW_VALUE)){ //DQSJ为'0'或‘’做判断
							itembjxx += "<div><font class=\"bjxxfont\">到期时间：</font><span class = \"bjxxspan\">由&nbsp;&nbsp;'<span style=\"color:#F07844\">"
								+ getdatetwo(value.OLD_VALUE)
								+ "</span>'&nbsp;修改为&nbsp;'<span style=\"color:#F07844\">"
								+ getdatetwo(value.NEW_VALUE)
								+ "</span>'</span></div>";
						}
					} else if (value.ZDMC == "GKLBMC") {
						$("#GKLBMC").html(value.NEW_VALUE);
						itembjxx += "<div><font class=\"bjxxfont\">管控类别：</font><span class = \"bjxxspan\">由&nbsp;&nbsp;'<span style=\"color:#F07844\">"
							+ value.OLD_VALUE
							+ "</span>'&nbsp;修改为&nbsp;'<span style=\"color:#F07844\">"
							+ value.NEW_VALUE
							+ "</span>'</span></div>";
					} else if (value.ZDMC == "YY") {
						itembjxx += "<div><font class=\"bjxxfont\">列控原因：</font><span class = \"bjxxspan\">由&nbsp;&nbsp;'<span style=\"color:#F07844\">"
							+ value.OLD_VALUE
							+ "</span>'&nbsp;修改为&nbsp;'<span style=\"color:#F07844\">"
							+ value.NEW_VALUE
							+ "</span>'</span></div>";
					} else if (value.ZDMC == "YJYQ") {
						itembjxx += "<div><font class=\"bjxxfont\">预警要求：</font><span class = \"bjxxspan\">由&nbsp;&nbsp;'<span style=\"color:#F07844\">"
							+ value.OLD_VALUE
							+ "</span>'&nbsp;修改为&nbsp;'<span style=\"color:#F07844\">"
							+ value.NEW_VALUE
							+ "</span>'</span></div>";
					} else if (value.ZDMC == "BZXX") {
						itembjxx += "<div><font class=\"bjxxfont\">备注信息：</font><span class = \"bjxxspan\">由&nbsp;&nbsp;'<span style=\"color:#F07844\">"
							+ value.OLD_VALUE
							+ "</span>'&nbsp;修改为&nbsp;'<span style=\"color:#F07844\">"
							+ value.NEW_VALUE
							+ "</span>'</span></div>";
					}
				});
                 
				$("#content").html('');
				var bjyjxx = "";
				if (mm.addYjdx.length > 0) {
					bjyjxx += "<div><font class=\"bjxxfont\">预警对象：</font><span class = \"bjxxspan\">新添加的预警对象是：&nbsp;&nbsp;";
					$(mm.addYjdx).each(function(i, value) {
						bjyjxx += value.NEW_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "</span></div>";
				}
				if (mm.deleteYjdx.length > 0) {
					bjyjxx += "<div><span class = \"bjxxspan\" style=\"margin-left:111px;\">移除的预警对象是：&nbsp;&nbsp;";
					$(mm.deleteYjdx).each(function(i, value) {
						bjyjxx += value.OLD_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "</span></div>";
				}
				if (mm.addYjbm.length > 0) {
					bjyjxx += "<div><font class=\"bjxxfont\">预警值班账号：</font><span style=\"font-size: 14px;margin-left:12px;color: #4c4c4c;\">新添加的预警值班账号是：";
					$(mm.addYjbm).each(function(i, value) {
						bjyjxx += value.NEW_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "</span></div>";
				}
				if (mm.deleteYjbm.length > 0) {
					bjyjxx += "<div><span class = \"bjxxspan\" style=\"margin-left:111px;\">移除的预警值班账号是：&nbsp;&nbsp;";
					$(mm.deleteYjbm).each(function(i, value) {
						bjyjxx += value.OLD_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "</span></div>";
				}
				$("#content").append(itembjxx + bjyjxx);
			}
			if (mm.LB == 2) {
				$("#cxxx").show();
				var itemcx = "";
				itemcx += "<div><font class=\"bjxxfont\">撤销原因：</font><span class = \"bjxxspan\">"
					+ mm.LKYY + "</span></div>";
				itemcx += "<div><font class=\"bjxxfont\">备注信息：</font><span class = \"bjxxspan\">"
					+ mm.BZXX + "</span></div>";
				$("#cxcontent").append(itemcx);
			}
			if (mm.ZT == 0) {
				if(mm.LB == 0){
					$("#zt").html("列控");
					$("#splb").html("列控");
				}else if(mm.LB == 1){
					$("#lkjl").html("列控记录");
					$("#zt").html("启用");
					$("#splb").html("启用");
				}else if(mm.LB == 2){
					$("#lkjl").html("列控记录");
					$("#zt").html("禁用");
					$("#splb").html("禁用");
				}
				else if(mm.LB ==3){
					$("#lkjl").html("列控记录");
					$("#zt").html("编辑");
					$("#splb").html("编辑");
				}
			} else if (mm.ZT == 1) {
				$("#zt").html("禁用");
				$("#splb").html("禁用");
			} else if (mm.ZT == 2) {
				$("#zt").html("申请启用中");
				$("#splb").html("启用");
			} else if (mm.ZT == 3) {
				$("#zt").html("申请禁用中");
				$("#splb").html("禁用");
			} else if (mm.ZT == 4) {
				$("#zt").html("申请编辑中");
				$("#splb").html("编辑");
			}
			var deptList = mm.yjDeptList;
			var itemyjzbzh = "";
			var YJBM = "";
			$(deptList).each(function(i, value) {
				var item1 = "<span id='" + value.YHBH + "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>" + value.YHXM + "</span>(" + value.JCMC + "-" + value.BMMC + ")&nbsp;&nbsp;";
				itemyjzbzh += item1;
				YJBM += value.YHBH + ",";
			});
			$("#YJBMMC").html(itemyjzbzh);
			$("#YJBM").val(YJBM);
			var userList = mm.yjUserList;
			var itemuser = "";
			var YJDX = "";
			$(userList).each(function(i, value) {
				var item2 = "<span id='" + value.YHBH + "' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>" + value.YHXM + "</span>(" + value.JCMC + "-" + value.BMMC+ ")&nbsp;&nbsp;";
				itemuser += item2;
				YJDX += value.YHBH + ",";
			});
			$("#YJDXMC").html(itemuser);
			$("#YJDX").val(YJDX);
			// 获取审批意见集合
			var spyjList = mm.spyjList;

			$("#lc_tab").html("");
			// 提交申请人信息 start
			var item1 = "<tr><td width=\"25px;\">";
			var bz_img = "<img src=\"" + basepath + "images/lkgl/fk_webblue.png\"/></td>";
			var item2 = "<td width=\"20%\"><span class=\"cl_cjsj\">" + mm.CJSJ + "</span></td>";
			var item3 = "<td width=\"25%\"><span class=\"my_info ry_font\" onclick=\"getCJRXM('" + mm.CJRBH + "')\">" + mm.CJRXM + "</span></td>";
			var item4 = "<td width=\"40%\"><span>" + mm.JCMC + "</span>-<span>" + mm.BMMC + "</span></td>";
			var item5 = "<td width=\"10%\" style=\"text-align: right;\"><span class=\"lc_zc_font\">提交申请</span></td></tr><tr style=\"height:25px\"></tr>";
			$("#lc_tab").append(item1 + bz_img + item2 + item3 + item4 + item5);
			// 提交申请人信息 end

			// 循环审批意见集合 start
			$(spyjList).each(function(i, value) {
				var item1 = "<tr  class=\"lc_border-bottom\"<td></td>";
				var item2 = "<td colspan=\"4\">审批人&nbsp;：<span style=\"margin-left: 10px;\"></span>";
				var spczrs = "";
				var spczrList = value.spczrList;
				$(spczrList).each(function(i, values) {
					spczrs += "<span>&nbsp;&nbsp;" + values.SPRXM + "&nbsp;&nbsp;</span>";
				});
				var item3 = "</td></tr>";
				if (value.CZZT == 0) {
					var item4 = "<tr id=\"wsp\"><td><img src=\"" + basepath + "images/lkgl/fk_webdot.png\" /></td>";
					var item5 = "<td  colspan=\"4\" ><span class=\"lc_zc_font\">未审批</span></td></tr><tr style=\"height:10px\"></tr>";
					$("#lc_tab").append(item1 + item2 + spczrs + item3 + item4 + item5);
					$("#spyjbh").val(value.SPYJBH);
				} else {
					var item4 = "<tr><td><img src=\"" + basepath + "images/lkgl/fk_webblue.png\"/></td>";
					var item5 = "<td><span class=\"cl_cjsj\">" + value.CZSJ + "</span></td>";
					var item6 = "<td><span class=\"my_info ry_font\" onclick=\"getCJRXM('" + value.CZRBH + "')\">" + value.CZRXM + "</span></td>";
					var item7 = "<td><span>" + value.CZRJCMC + "</span>-<span>" + value.CZRBMMC + "</span></td>";
					var item8 = "<td style=\"text-align: right;\"><span class=\"lc_zc_font\">";
					var CZZT = "";
					if (value.CZZT == 1) {
						CZZT = "上报";
					} else if (value.CZZT == 2) {
						CZZT = "拒绝";
					} else if (value.CZZT == 3) {
						CZZT = "通过";
					} else if (value.CZZT == 4) {
						CZZT = "打回修改";
					}
					var item9 = "</span></td></tr>";
					var item10 = "<tr><td></td> <td></td>";
					var item11 = " <td colspan=\"3\">审批意见：<span>" + value.SPYJ + "</span></td></tr>";
					$("#lc_tab").append(item1 + item2 + spczrs + item3 + item4 + item5 + item6 + item7 + item8+ CZZT + item9 + item10 + item11);
				}
			});
			// 循环审批意见集合 end

			// 判断审批状态
			if (mm.SPZT == 0) {
				$("#lc_tj_jt").show();
			}
			// 上报
			else if (mm.SPZT == 1) {
				$("#lc_sp_jt").show();
				$("#lc_sp_img").attr('src',basepath + 'images/lkgl/fk_webapprovalorg.png');
				$("#lc_sp_zx").attr('src',basepath+ 'images/lkgl/fk_webdotlineorg_rey.png');
				$("#lc_tj_zx").attr('src',basepath + 'images/lkgl/fk_webdotlineorg.png');
			} else if (mm.SPZT == 2) {
				// 拒绝
				$("#lc_pz_jt").show();
				$("#lc_sp_img").attr('src',basepath + 'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath + 'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath + 'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath + 'images/lkgl/fk_webdotlineorg.png');
			} else if (mm.SPZT == 3) {
				// 通过
				$("#lc_pz_jt").show();
				$("#lc_sp_img").attr('src',basepath + 'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath + 'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath + 'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath + 'images/lkgl/fk_webdotlineorg.png');

			} else if (mm.SPZT == 4) {
				// 打回修改
				$("#lc_tj_jt").show();
			}
			
			var pic = document.getElementById("userimg");
			pic.src = mm.XP;
			
			$("#div_spyj").hide();
			isOperate();
		}
	});
}

//审批通过
function pass() {
	var value = $("#ok").val();
	if (value == "上报") {
		sbxx();
	}
	if (value == "批准") {
		okpass();
	}
}

//有审批权限
function okpass() {
	var BD_RYBH = $("#BD_RYBH").val();
	var BD_RYXM=$("#XM").html();
	var SPBH = $("#SPBH").val();
	var YJDX = $("#YJDX").val();
	var YJBM = $("#YJBM").val();
	var CJRBH = $("#CJRBH").val();
	var SPYJBH = $("#SPYJBH").val();
	var LB = $("#lb").val();
	var SPYJ = $("#SPYJ").val();
	if (SPYJ == "请填写审批意见") {
		SPYJ = "无审批意见";
	}
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url : "isOperate.action",
		data : "spyjbh=" + SPYJBH,
		dataType : "json",
		async : false,
		success : function(data) {
			if ("isOperate" == data.result) {
				$.ajax({
					url : "approvalsModifyokpass.action",
					data : "spyjbh=" + SPYJBH + "&SPYJ=" + encodeURI(SPYJ)
					+ "&spdxbh=" + SPBH + "&cjrbh=" + CJRBH + "&LB="
					+ LB + "&yjdx=" + YJDX + "&yjzbzh=" + YJBM
					+ "&BD_RYBH=" + BD_RYBH+"&BD_RYXM="+BD_RYXM,
					dataType : "json",
					async : false,
					success : function(data) {
						top.$.ligerDialog.closeWaitting();
						$("#bg").removeClass("bg");
						if ("success" == data.result) {
							getMess(SPBH); // 详情
							$.ligerDialog.success("审批成功");
						} else {
							$.ligerDialog.error("通过失败");
						}
					}
				});
			}else{
				top.$.ligerDialog.closeWaitting();
				$("#bg").removeClass("bg");
				$.ligerDialog.success("已经有人审批！");
			}
		}
	});
}

//审批拒绝
function over() {
	var BD_RYBH = $("#BD_RYBH").val();
	var BD_RYXM =$("#XM").html();
	var LB = $("#lb").val();
	var SPBH = $("#SPBH").val();
	var CJRBH = $("#CJRBH").val();
	var SPYJBH = $("#SPYJBH").val();
	var SPYJ = $("#SPYJ").val();
	if (SPYJ == "请填写审批意见") {
		SPYJ = "无审批意见";
	}
	$.ajax({
		url : "isOperate.action",
		data : "spyjbh=" + SPYJBH,
		dataType : "json",
		async : false,
		success : function(data) {
			if ("isOperate" == data.result) {
				window.top.$.ligerDialog.confirm("确定要拒绝该审批?", function(ok) {
					if (ok) {
						$("#bg").addClass("bg");
						top.$.ligerDialog.waitting('正在提交中,请稍候...');
						$.ajax({
							url : "approvalsOver.action",
							data : "spyjbh=" + SPYJBH + "&SPYJ="+ encodeURI(SPYJ) + "&spdxbh=" + SPBH + "&cjrbh=" + CJRBH +"&BD_RYBH="+BD_RYBH+"&BD_RYXM="+encodeURI(BD_RYXM)+"&LB="+ LB,
							dataType : "json",
							async : false,
							success : function(data) {
								top.$.ligerDialog.closeWaitting();
								$("#bg").removeClass("bg");
								if ("success" == data.result) {
									getMess(SPBH); // 详情
									$.ligerDialog.success("拒绝成功！");
								} else {
									$.ligerDialog.error("拒绝失败！");
								}
							}
						});
					}
				});
			} else {
				$.ligerDialog.success("已经有人审批！");
			}
		}
	});
}

/** 打回 */
function back() {
		$("#cz_but").hide();
		$("#dhxg_but").show();
		$("input[name='box']").show();
		$("#dhxg_but").html("<input  onclick=\"okback()\" type=\"button\" style=\"background-color: #366CB4;border: 1px solid #366CB4\"  class=\"button\" value=\"确认打回\" />&nbsp; &nbsp;");
		$("#dhxg_but").append("<input  onclick=\"qxcz()\" type=\"button\" style=\"background-color: #F07844; border: 1px solid #F07844\" class=\"button\" value=\"取消操作\" />");
}
/**
 * 
 * 打回----取消操作
 * 
 */
function qxcz() {
	$("input[name='box']").each(function(){
		$(this).hide();
		$(this).attr("checked",false);
	});
	$("#cz_but").show();
	$("#dhxg_but").hide();
}
/**
 * 
 * 打回----确认打回
 * 
 */
function okback() {
	var SPBH = $("#SPBH").val();
	var CJRBH = $("#CJRBH").val();
	var SPYJ = $("#SPYJ").val();
	var SPYJBH = $("#SPYJBH").val();
	var BD_RYXM=$("#XM").html();
	if (SPYJ == "请填写审批意见") {
		SPYJ = "无审批意见";
	}
	var str = document.getElementsByName("box");
	var objarray = str.length;
	var chestr = "";
	for (var i = 0; i < objarray; i++) {
		if (str[i].checked == true) {
			chestr += str[i].value + ",";
		}
	}
	if (chestr == "") {
		$.ligerDialog.success("请选择打回要修改的项！");
	} else {
		$.ajax({
			url : "isOperate.action",
			data : "spyjbh=" + SPYJBH,
			dataType : "json",
			async : false,
			success : function(data) {
				if ("isOperate" == data.result) {
					$("#bg").addClass("bg");
					top.$.ligerDialog.waitting('正在提交中,请稍候...');
					$.ajax({
						url : "returntheone.action",
						data : "spyjbh=" + SPYJBH + "&SPYJ=" + encodeURI(SPYJ)
						+ "&spdxbh=" + SPBH + "&cjrbh=" + CJRBH+"&BD_RYXM="+BD_RYXM
						+ "&wsxxx=" + encodeURI(chestr),
						dataType : "json",
						async : false,
						success : function(data) {
							top.$.ligerDialog.closeWaitting();
							$("#bg").removeClass("bg");
							if ("success" == data.result) {
								getMess(SPBH); // 详情
								$.ligerDialog.success("打回成功");
							} else {
								$.ligerDialog.error("打回失败");
							}
						}
					});
				}else{
					$.ligerDialog.success("已经有人审批！");
				}
			}
		});
	}
}

//通过 ，继续上报
function sbxx() {
	var SPBH = $("#SPBH").val();
	var CJRBH = $("#CJRBH").val();
	var SPYJBH = $("#SPYJBH").val();
	var SPYJ = $("#SPYJ").val();
	var BD_RYXM=$("#XM").html();
	if (SPYJ == "请填写审批意见") {
		SPYJ = "无审批意见";
	}
	var url = basepath + "bussiness/aviation/util/choosekjr.jsp";
	$.ajax({
		url : "isOperate.action",
		data : "spyjbh=" + SPYJBH,
		dataType : "json",
		async : false,
		success : function(data) {
			if ("isOperate" == data.result) {
				winOpen(url, "可见人", 500, 300, '添加', '取消',function(data, dialog) {
					$("#bg").addClass("bg");
					top.$.ligerDialog.waitting('正在提交中,请稍候...');
					$.ajax({
						url : "approvalsPass.action?spyjbh="+ SPYJBH + "&SPYJ="+ encodeURI(SPYJ) + "&BD_RYXM="+ encodeURI(BD_RYXM) + "&spdxbh="+ SPBH + "&cjrbh=" + CJRBH,
						data:data,
						dataType : "json",
						type : "post",
						success : function(data) {
							top.$.ligerDialog.closeWaitting();
							$("#bg").removeClass("bg");
							if ("success" == data.result) {
								getMess(SPBH); // 详情
								$.ligerDialog.success("上报成功");
								dialog.close();
							} else {
								$.ligerDialog.error("上报失败");
							}
						},
					});
				});
			}else{
				$.ligerDialog.success("已经有人审批！");
			}
		}
	});
}

//审批意见文字 友好提醒 start
function yj_onfocus() {
	var value = $("#SPYJ").val();
	if (value == '请填写审批意见') {
		$("#SPYJ").val('');
		$("#SPYJ").css('color', 'black');
	}
}

function yj_onblur() {
	var value = $("#SPYJ").val();
	if (value == '') {
		$("#SPYJ").val('请填写审批意见');
		$("#SPYJ").css('color', 'gray');
	}
}
//审批意见文字 友好提醒 end

/**控制打开界面*/
function winOpen(url, title, width, height, button1, button2, callback) {
	window.top.$.ligerDialog.open({width : width,height : height,url : url,title : title,
		buttons : [{text : button1,onclick : function(item, dialog) {
			var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
			var data = fn();
			if (data) {
				callback(data);
				dialog.close();
			}
		}
		},{text : button2,onclick : function(item, dialog) {
			dialog.close();
		}
		}]
	});
}
//判断是否有最终的审批权限
function passOk() {
	$.ajax({
		url : "approvalsModify.action",
		dataType : "json",
		async : false,
		success : function(data) {
			if ("okpass" == data.result) {
				$("#pass").val("okpass");
			} else {
				$("#pass").val("");
				$("#ok").val("上报");
			}
		}
	});
}

//是否有操作权限
function isOperate()
{
	var SPYJBH=$("#SPYJBH").val();
	$.ajax({
		url : "isOperate.action",
		data : "spyjbh=" + SPYJBH,
		dataType : "json",
		async : false,
		success : function(data) {
			if ("isOperate" == data.result) {	
				$("#div_spyj").show();
				passOk(); // 判断是否有最终的审批权限
			}
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
	var url = basepath + "system/user/UserMess.jsp?id="+ cjrbh;
	window.top.my_openwindow("", url, 700,450, "上控人详情信息");
}