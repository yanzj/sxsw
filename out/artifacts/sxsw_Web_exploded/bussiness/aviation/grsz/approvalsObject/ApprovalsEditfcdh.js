var cacheDept;
var cacheYJ;
var cacheRY;
var cacheDataSet;
$(function() {
	var itemid = $("#itemid").val();
	// 鼠标放上去的样式
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	getMess(itemid); //详情
	GKLBBHQueryList();
	cacheDataSet = $(window.top.document).find("#cacheDataSet");
	$("input[origin]").on("focusin",function(){
		$(this).attr("style","");
	}).on("focusout",function(){
		var $this=$(this);
		if($this.val()==$this.attr("origin")||$this.val()==''){
			$this.attr("style","border:2px solid red");
		}else{
			$this.attr("style","");
		}
	});
});


function getMess(mid) {
	var basepath = $("#mypath").val();
	$.ajax({
		url : "approvalsQueryById.action",
		data : "spdxbh=" + mid,
		dataType : "json",
		async : false,
		type : "post",
		success : function(mm) {
			$("#XM").html(mm.XM);
			if (mm.XB == 1) {
				$("#XB").html("男");
			} else if(mm.XB == 2){
				$("#XB").html("女");
			}else if(mm.XB==9){
				$("#XB").html("未知");
			}
			$("#SFZH").html(mm.SFZH);
			$("#NL").html(mm.NL);
			$("#CSRQ").html(mm.CSRQ);
			$("#MZMC").html(mm.MZMC);
			$("#MZ").val(mm.MZ);
			$("#ZY").html(mm.ZY);
			$("#DQSJ").val(mm.DQSJ);
			$("#BD_RYBH").val(mm.BD_RYBH);
			$("#ZZXZ").html(mm.ZZXZ);
			$("#HKSZD").html(mm.HKSZD);
			$("#LB").val(mm.LB);
			$("#SPZT").val(mm.SPZT);
			$("#SPYJBH").val(mm.SPYJBH);
			if(mm.SPZT == 0){
				$("#spzt").html("未审批");
			}
			else if(mm.SPZT ==1){
				$("#spzt").html("上报");
			}
			else if(mm.SPZT == 2){
				$("#spzt").html("审批");
			}
			else if(mm.SPZT == 3){
				$("#spzt").html("通过");
			}
			else if(mm.SPZT == 4){
				$("#spzt").html("打回修改");
			}
			$("#CJRBH").val(mm.CJRBH);
			$("#CJRXM").html(mm.CJRXM);
			$("#CJSJ").html(mm.CJSJ);
			$("#BZXX").val(mm.BZ);
			$("#YJYQ").val(mm.YJYQ);
			$("#YJDXMC").val(mm.YJDXMC);
			$("#sdescyj").html(mm.YJDXMC);
			$("#YJBMMC").val(mm.YJBMMC);
			$("#sdescyjzbzh").html(mm.YJBMMC);
			$("#YY").val(mm.YY);
			$("#GKLBMC").html(mm.GKLBMC);
			$("#GKLBMC1").val(mm.GKLBMC);
			$("#JCMC").html(mm.JCMC);
			$("#BMMC").html(mm.BMMC);
			//预警值班账号
			var deptList = mm.yjDeptList;
			var itemyjzbzh = "";
			var arrDept = [];
			$(deptList).each(function(i, value) {
				arrDept	.push({
					id : value.YHBH,
					name : value.YHXM
				});
				var item1 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
					+ value.YHBH + "zbzh'>"
					+ value.YHXM+ " <img src='"
					+ basepath + "images/delete.png' onclick=\"removeUser('"
					+ value.YHBH + "','" + value.YHXM
					+ "','yjzbzh')\" style=\"cursor:pointer\" /></span>&nbsp;&nbsp;";
				itemyjzbzh += item1;
			});
			cacheDept = arrDept;
			$("#sdescyjzbzh").html(itemyjzbzh);
			//预警对象
			var userList = mm.yjUserList;
			var itemuser = "";
			var arrYJ = [];
			$(userList).each(function(i, value) {
				arrYJ.push({
					id : value.YHBH,
					name : value.YHXM
				});
				var item2 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
					+ value.YHBH + "yj'>"
					+ value.YHXM+ " <img src='"
					+ basepath + "images/delete.png' onclick=\"removeUser('"
					+ value.YHBH + "','" + value.YHXM
					+ "','yjry')\" style=\"cursor:pointer\" /></span>&nbsp;&nbsp;";
				itemuser += item2;
			});
			cacheYJ = arrYJ;
			$("#sdescyj").html(itemuser);

			$(window.top.document).find("#cacheDataSet").children("#cacheYJ").text(JSON.stringify(arrYJ));
			$(window.top.document).find("#cacheDataSet").children("#cacheDept").text(JSON.stringify(arrDept));
			$("#YJYQ").val(mm.YJYQ);
			$("#SPRYBH").val(mm.SPRYBH);
			$("#ZZLJ").val(mm.ZZLJ);
			//获取审批意见集合
			var spyjList=mm.spyjList;

			//提交申请人信息 start
			var item1="<tr><td width=\"25px;\">";
			var bz_img="<img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
			var item2="<td width=\"20%\"><span class=\"cl_cjsj\">"+mm.CJSJ+"</span></td>";
			var item3="<td width=\"25%\"><span class=\"my_info ry_font\" onclick=\"getCJRXM('"+ mm.CJRBH+ "')\">"+mm.CJRXM+"</span></td>";
			var item4="<td width=\"40%\"><span>"+mm.JCMC+"</span>-<span>"+mm.BMMC+"</span></td>";
			var item5="<td width=\"10%\" style=\"text-align: right;\"><span class=\"lc_zc_font\">提交申请</span></td></tr><tr style=\"height:25px\"></tr>";
			$("#lc_tab").append(item1+bz_img+item2+item3+item4+item5);
			//提交申请人信息 end

			//循环审批意见集合 start
			$(spyjList).each(function(i, value){
				var item1="<tr  class=\"lc_border-bottom\"<td></td>";
				var item2="<td colspan=\"4\">审批人&nbsp;：<span style=\"margin-left: 10px;\"></span>";
				var spczrs="";
				var spczrList=value.spczrList;
				$(spczrList).each(function(i, values){
					spczrs+="<span>&nbsp;&nbsp;"+values.SPRXM+"&nbsp;&nbsp;</span>";
				});
				var item3="</td></tr>";
				if(value.CZZT==0){
					var item4="<tr id=\"wsp\"><td><img src=\""+basepath+"images/lkgl/fk_webdot.png\" /></td>";
					var item5="<td  colspan=\"4\" ><span class=\"lc_zc_font\">未审批</span></td></tr><tr style=\"height:10px\"></tr>";
					$("#lc_tab").append(item1+item2+spczrs+item3+item4+item5);
					$("#spyjbh").val(value.SPYJBH);
				}else{
					var item4="<tr><td><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
					var item5="<td><span class=\"cl_cjsj\">"+value.CZSJ+"</span></td>";
					var item6="<td><span class=\"my_info ry_font\" onclick=\"getCJRXM('"+ value.CZRBH+ "')\">"+value.CZRXM+"</span></td>";
					var item7="<td><span>"+value.CZRJCMC+"</span>-<span>"+value.CZRBMMC+"</span></td>";
					var item8="<td style=\"text-align: right;\"><span class=\"lc_zc_font\">";
					var CZZT="";
					if(value.CZZT==1)
					{
						CZZT="上报";
					}
					else if(value.CZZT==2)
					{
						CZZT="拒绝";
					}
					else if(value.CZZT==3)
					{
						CZZT="通过";
					}
					else if(value.CZZT==4)
					{
						CZZT="打回修改";
					}
					var item9="</span></td></tr>";
					var item10="<tr><td></td> <td></td>";
					var item11=" <td colspan=\"3\">审批意见：<span>"+value.SPYJ+"</span></td></tr>";
					$("#lc_tab").append(item1+item2+spczrs+item3+item4+item5+item6+item7+item8+CZZT+item9+item10+item11);
				}
			});
			//循环审批意见集合 end

			//判断审批状态
			if(mm.SPZT==0)
			{
				$("#lc_tj_jt").show();
			}
			//上报
			else if(mm.SPZT==1)
			{
				$("#lc_sp_jt").show();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg_rey.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==2)
			{
				//拒绝
				$("#lc_pz_jt").show();
				$("#div_spyj").hide();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==3)
			{
				//通过
				$("#lc_pz_jt").show();
				$("#div_spyj").hide();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');

			}
			else if(mm.SPZT==4)
			{
				//打回修改
				$("#lc_tj_jt").show();
			}
			var pic = document.getElementById("userimg");
			pic.src = mm.XP;
			var mystring = mm.WSXXX;
			var myarray = mystring.split(",");
			var needOrigin=[];
			for (var i = 0; i < myarray.length; i++) {
				if (myarray[i] == "列控原因") {
					$("#YYBZ").html("待完善");
					needOrigin.push("YY");
				} else if (myarray[i] == "管控类型") {
					$("#GKLBMCBZ").append("待完善");
					needOrigin.push("GKLBMC1");
				} else if (myarray[i] == "预警对象") {
					$("#YJDXMCBZ").append("待完善");
					needOrigin.push("sdescyj");
				} else if (myarray[i] == "预警值班账号") {
					$("#YJBMMCBZ").append("待完善");
					needOrigin.push("sdescyjzbzh");
				} else if (myarray[i] == "预警要求") {
					/*$("#YJYQBZ").parent().addClass("td_tit_Report1");*/
					$("#YJYQBZ").append("待完善");
					needOrigin.push("YJYQ");
				} else if (myarray[i] == "到期时间") {
					$("#DQSJBZ").append("待完善");
					needOrigin.push("DQSJ");
				}else if (myarray[i] == "备注说明") {
					$("#BZXXBZ").append("待完善");
					needOrigin.push("BZXX");
				}
			}

			for(var i=0;i<needOrigin.length;i++){
				var temp=$("#"+needOrigin[i]);
				temp.attr("origin",temp.val());
				temp.attr("style", "border:2px solid red");
			}

		}
	});
}
function passUP() {
	if ($("#sdesc").html()=="") {
		top.$.ligerDialog.warn("请选择审批人");
		return false;
	}

	var userid = "";
	var username = "";
	var yjzbzhid = "";
	var yjzbzhxm = "";
	var useridyj = "";
	var usernameyj = "";
		for (var i = 0; i < cacheRY.length; i++) {
			userid += cacheRY[i].id + ",";
			username += cacheRY[i].name + ",";
		}
	if (cacheYJ) {
		for (var i = 0; i < cacheYJ.length; i++) {
			useridyj += cacheYJ[i].id + ",";
			usernameyj += cacheYJ[i].name + ",";
		}
	}
	if (cacheDept) {
		for (var i = 0; i < cacheDept.length; i++) {
			yjzbzhid += cacheDept[i].id + ",";
			yjzbzhxm += cacheDept[i].name + ",";
		}
	}
	var itemid = $("#itemid").val();
	var BD_RYBH = $("#BD_RYBH").val();
	var BD_RYXM= $("#XM").html();
	var LB = $("#LB").val();
	var YY = $("#YY").val();
	var YJYQ = $("#YJYQ").val();
	var GKLBBH = $("#GKLB").val();
	var CJSJ = $("#CJSJ").html();
	var DQSJ = $("#DQSJ").val();
	var BZXX = $("#BZXX").val();
	var SPZT = $("#SPZT").val();
	var CJRBH = $("#CJRBH").val();
	var SPYJBH = $("#SPYJBH").val();
	var addPost = {
			"BD_RYBH": BD_RYBH,
			"BD_RYXM": BD_RYXM,
			"spdxbh" : itemid,
			"appObject.LB" : LB,
			"appObject.YY" : YY,
			"YJDX" : useridyj,
			"YJDXXM" : usernameyj,
			"YJBM" : yjzbzhid,
			"YJBMXM" : yjzbzhxm,
			"spyjbh" : SPYJBH,
			"appObject.SPDXBH" :itemid,
			"appObject.BD_RYBH":BD_RYBH,
			"appObject.YJYQ" : YJYQ,
			"appObject.GKLBBH" : GKLBBH,
			"appObject.DQSJ" : DQSJ,
			"appObject.SPZT" : SPZT,
			"appObject.CJRBH" : CJRBH,
			"appObject.CJSJ" : CJSJ,
			"appObject.WSXXX" : "",
			"appObject.BZXX" : BZXX,
			"sprbh" : userid,
			"sprxm" : username
	};
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url : "updateApprovals.action",
		data : addPost,
		dataType : "json",
		type : "post",
		success : function(data) {
			top.$.ligerDialog.closeWaitting();
			$("#bg").removeClass("bg");
			cacheDataSet.children("#cacheRY").text("");
			if ("success" == data.result) {
				top.$.ligerDialog.success("更新成功！");
				$("#tj").hide();
				window.parent.f_remove_click(itemid);
			} else {
				top.$.ligerDialog.error("更新失败！");
			}
		},
		error : function(error) {
			dialog.close();
			$("#bg").removeClass("bg");
			top.$.ligerDialog.error("更新失败！" + error.status, "错误");
		}
	});
}
/** 控制打开界面 */
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
		        			   callback(data);
		        			   dialog.close();
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


function GKLBBHQueryList() {
	var GKLBMC = $("#GKLBMC1").val();
	$.ajax({
		url : "loadTsdict.action",
		data: "sszdlx=GKLB",
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#GKLB").append(
					"<option  selected='selected' value='" + -1 + "'>"
					+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#GKLB").empty();
			$.each(data, function(n, value) {
				var text = "";
				if (value.text == GKLBMC) {
					text += "<option selected=\"selected\" value='" + value.id + "'>" + value.text + "</option>";
				} else {
					text = "<option value='" + value.id + "'>" + value.text + "</option>";
				}
				$("#GKLB").append(text);
			});
		}
	});
}
/**
 * 点击申请人详情
 */
function getCJRXM(cjrbh) {
	var path = $("#mypath").val();
	if (cjrbh == null) {
		cjrbh = $("#CJRBH").val();
	}
	var url = path + "system/user/UserMess.jsp?id="+ cjrbh;
	window.top.my_openwindow("", url, 700,450, "上控人详情信息");
}