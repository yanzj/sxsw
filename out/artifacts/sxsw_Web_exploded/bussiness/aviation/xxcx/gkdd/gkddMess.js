var rybh;
var mypath;	//项目访问路径
jQuery(function ($){
	rybh = $("#rybh").val();
	mypath = $("#mypath").val();
	getMess(rybh);
	getConaction(rybh);
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
});
/**
 * 获取单个的信息
 */
function  getMess(BD_RYBH){
	$.ajax({
		url:"identityInfoDetail.action",
		data:"BD_RYBH="+BD_RYBH, 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			$("#XM").html(mm.XM);
			$("#CYM").html(mm.CYM);
			var xb=mm.XB;
			if(xb=='1')
			{
				xb="男";
			}
			else if(xb=='2')
			{
				xb="女";
			}
			$("#XB").html(xb);
			$("#MZ").html(mm.MZMC);
			$("#NL").html(mm.NL);
			$("#CSRQ").html(mm.CSRQ);
			$("#SG").html(mm.SG);
			$("#HYZK").html(mm.HYZKMC);
			$("#WHCD").html(mm.WHCDMC);
			$("#BYQK").html(mm.BYQK);
			$("#GMSFZHM").html(mm.SFZH);
			$("#FWCS").html(mm.FWCS);
			$("#JGGJ").html(mm.JGGJMC);
			$("#JGSSX").html(mm.JGSSXMC);
			$("#CSDXZ").html(mm.CSDXZ);
			$("#HKSZD").html(mm.HKSZDMC);
			$("#ZZXZ").html(mm.ZZXZ);
			$("#ZY").html(mm.ZY);
			$("#GXSJ").html(mm.GXSJ);

			$("#GKLBMC").html(mm.GKLBMC);
			$("#CJRXM").html(mm.CJRXM);
			$("#CJSJ").html(mm.CJSJ);
			$("#CJRBH").val(mm.CJRBH);
			if(mm.ZT==0){
				$("#ZT").html("(列控)");
			}else if(mm.ZT==1){
				$("#ZT").html("(禁用)");
			}else if(mm.ZT==2){
				$("#ZT").html("(申请启用中)");
			}else if(mm.ZT==3){
				$("#ZT").html("(申请禁用中)");
			}else if(mm.ZT==4){
				$("#ZT").html("(申请编辑中)");
			}

			var RYBH=mm.RYBH;
			$("#RYBH").val(RYBH);
			//临时管控对象
			if(RYBH!=null && RYBH!=""){
				//判断是否关注
				var GZBH = mm.GZBH;	
				//关注
				if(GZBH!=null && GZBH!=""){
					$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\"/>");
				}else{
					$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				}
			} else{
				$("#lsgk_div").hide();
			}
			var pic = document.getElementById("userimg");
			pic.src = mm.XP;

			//标签数量
			var item="";
			var lsgkcount = mm.lsgkcount;
			if(lsgkcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
			}
			var tjlkcount = mm.tjlkcount;
			if(tjlkcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
			}
			var ztrycount = mm.ztrycount;
			if(ztrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
			}
			var wffzcount = mm.wffzcount;
			if(wffzcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
			}
			var zjrycount = mm.zjrycount;
			if(zjrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
			}
			var siscount = mm.siscount;
			if(siscount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
			}
			var kssrycount = mm.kssrycount;
			if(kssrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
			}
			var qlzdcount = mm.qlzdcount;
			if(qlzdcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
			}
			$("#sf_div").html(item);
			/*关联信息*/
			//航班信息
			var flightcount = mm.flightcount;
			if(flightcount>0){
				$("#div_flight").html("(<span id=\"flight_count\" >"+flightcount+"</span>)");
				$("#flight").attr("src",mypath+"images/xxcx/fk_webiconplanecolor.png");
				$("#flight_style").addClass("style_font_black");
			}else{
				$("#flight_style").addClass("style_font_gray");
				$("#flight_style").addClass("my_info");
			}
			//关注人
			var gzcount = mm.gzcount;
			if(gzcount>0){
				$("#div_gz").html("(<span id=\"gz_count\">"+gzcount+"</span>)");
				$("#gzr").attr("src",mypath+"images/xxcx/fk_webicon_eyesonnocolor.png");
				$("#gzr_style").addClass("style_font_black");
			}else{
				$("#gzr_style").addClass("style_font_gray");
				$("#gzr_style").addClass("my_info");
			}
			//盘查信息
			var pccount = mm.pccount;
			if(pccount>0){
				$("#div_pc").html("(<span id=\"pc_count\" >"+pccount+"</span>)");
				$("#pcxx").attr("src",mypath+"images/xxcx/fk_webiconpollingcolor.png");
				$("#pcxx_style").addClass("style_font_black");
			}else{
				$("#pcxx_style").addClass("style_font_gray");
			}
			//违法信息
			var count = wffzcount+zjrycount+siscount+kssrycount;
			if(count>0){
				$("#div_wffz").html("(<span id=\"wffz_count\" >"+count+"</span>)");
				$("#wfxx").attr("src",mypath+"images/xxcx/fk_webicon_crimerecordcolor.png");
				$("#wfxx_style").addClass("style_font_black");
			}else{
				$("#wfxx_style").addClass("style_font_gray");
			}
			//在逃信息
			if(ztrycount>0){
				$("#div_ztry").html("(<span id=\"ztry_count\" >"+ztrycount+"</span>)");
				$("#ztxx").attr("src",mypath+"images/xxcx/fk_webfleecolor.png");
				$("#ztxx_style").addClass("style_font_black");
			}else{
				$("#ztxx_style").addClass("style_font_gray");
			}
			//情报七类
			if(qlzdcount>0){
				$("#div_qbqlzdry").html("(<span id=\"qbqlzdry_count\" >"+qlzdcount+"</span>)");
				$("#qbql").attr("src",mypath+"images/xxcx/fk_webinteligencecolor1.png");
				$("#qbql_style").addClass("style_font_black");
			}else{
				$("#qbql_style").addClass("style_font_gray");
			}
		}, 
		error:function (error) {
			top.my_alert("获取单个信息失败****" + error.status);
		}
	});
} 

/**
 * 关注信息更改
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
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("关注成功!","success");
				var count = $("#gz_count").html();
				$("#gz_count").html(eval(count)+1);
				if($("#gz_count").html()>0){
					$("#gzr").attr("src",mypath+"images/xxcx/fk_webicon_eyesonnocolor.png");
					$("#gzr_style").addClass("style_font_black");
				}
			}else if("delsuccess" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("取消关注成功!","success");
				$("#gz_count").html($("#gz_count").html()-1);
				if($("#gz_count").html()==0){
					$("#gzr").attr("src",mypath + "images/xxcx/fk_webicon_eyesoncolor.png");
					$("#gzr_style").addClass("style_font_gray");
				}
			}else if("saverror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("该信息已关注!","success");
			}else if("delerror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("该信息已取消关注!","success");
			}
		},
		error : function(error) {
			top.my_alert("获取单个信息失败****" + error.status);
		}
	});
}

/**
 *上控人点击详情
 */
function getCJRXM(type,id){
	var cjrbh;
	if("sfcjr" == type){
		cjrbh=$("#CJRBH").val();
	}else{
		cjrbh=id;
	}
	var url = mypath + "system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"详情信息");
}

/**
 *航班信息详情
 */
function openflight(){
	if($("#flight_count").html()>0){
		var tabid = "FLIGHT" + "-" + rybh;
		this.parent.f_click(tabid,"航班信息",mypath + "flightQueryAllList.action?page=1&pagesize=10&BD_RYBH=" + rybh);
	}else{
		top.my_alert("暂无数据!","success");
	}
}	 

/**
 *关注人列表展示
 */
function gzrList(){
	if($("#gz_count").html()>0){
		var RYBH =$("#RYBH").val();
		var url = mypath + "findzgrByssxmbhlx.action?page=1&pagesize=10&ssxmlx=controlledpeople&ssxmbh=" + RYBH;
		var tabid = "GZR" +"-"+RYBH;
		this.parent.f_click(tabid,"关注人", url);
	}else{
		top.my_alert("暂无数据!","success");
	}
}

/*
 *列控信息
 */
function openLKDetail() {
	var XM=$("#XM").html();
	var ids = "";
	var url = "bussiness/aviation/lkgl/lkdx/lkdxMess.jsp?BD_RYBH=" + rybh+"&casename="+XM+"&ids="+ids;
	var tabid = "LK" + "-" + rybh+"-"+ids;
	this.parent.f_click(tabid,XM,mypath + url);
}
/*
 * 盘查信息 
 */
function openPcxx(){
	if($("#pc_count").html()>0){
		var ids = "";
		var url = "bussiness/aviation/xcpc/pclb/PclbList.jsp?BD_RYBH=" + rybh+"&searchTj=pcxx";
		var tabid= "PC"+"-"+ids;
		window.parent.f_click(tabid,"盘查信息",mypath + url);
	}else{
		top.my_alert("暂无数据!","success");
	}
}
/*
 * 精神病史
 */
function openJSbs(){
	top.my_alert("暂未开放!","success");
}

/*
 * 全网查询
 */
function openQwcx(){
	top.my_alert("暂未开放!","success");
}
//全国违法犯罪信息
function searchwf(id,count,url){
	if($("#wffz_count").html()>0){
		var url=$("#userimg").attr("src");   //人员头像
		window.parent.f_click("GA_ZTRY"+rybh,"违法信息",mypath+"controlCrimeQueryList.action?rybh="+rybh+"&xpurl="+url);
	}else{
		top.my_alert("暂无数据!","success");
	}
} 
//全国在逃人员信息
function searchzt(){
	if($("#ztry_count").html()>0){
		var url=$("#userimg").attr("src");   //人员头像
		window.parent.f_click("GA_ZTRY"+rybh,"全国在逃人员信息",mypath+"ztryQueryList.action?rybh="+rybh+"&xpurl="+url);
	}else{
		top.my_alert("暂无数据!","success");
	}
}
//七类重点人员信息
function searchqlzd(){
	if($("#qbqlzdry_count").html()>0){
		var url=$("#userimg").attr("src");   //人员头像
		window.parent.f_click("GA_QLZD"+rybh,"七类重点人员信息",mypath+"qlzdxyrQueryList.action?rybh="+rybh+"&xpurl="+url);
	}else{
		top.my_alert("暂无数据!","success");
	}
}

/**
 * 手动添加联系方式
 */
function conactionAdd(){
	var url = mypath + "bussiness/aviation/xxcx/gkdd/contactinfo/ContactinfoAdd.jsp?bd_rybh="+rybh;
	winOpen(url, "添加联系信息", 600,360, '提交', '取消', function(data, dialog) {
		$.ajax({
			url : "contactionAdd.action",
			data : data,
			dataType : "json",
			type : "post",
			success : function(data) {
				if ("success" == data.result) {
					top.$.ligerDialog.success("添加联系信息成功！");
					getConaction(rybh);
				} else {
					top.$.ligerDialog.error("添加联系信息失败！");
				}
			},
			error : function(error) {
				top.$.ligerDialog.error("添加联系信息失败！" + error.status,"错误");
			}
		});
	});
}

/**
 * 查询人员联系方式
 */
function getConaction(BD_RYBH){
	$("#lx_div").html("");
	$.ajax({
		url:"contactionQueryListMore.action",
		data:"bd_rybh="+BD_RYBH+"&page=1&pagesize=3", 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			var value = mm.msg;
			var objArray = JSON.parse(value);
			$(objArray).each(function (i, value) { 
				var item = "<div style=\"padding-left:20px;padding-top:13px;height: 60px;\" onmouseover=\"this.className='div_table_over'\" onmouseout=\"this.className='div_table_out'\">";
				item+="<table style=\"font-size:14px;\">";
				item+="<tr style=\"height: 20px;line-height: 20px;\">";
				item+="<td rowspan=\"3\" style=\"width: 28px;color:#ef7844;font-weight: bold;\"><span>"+(i+1)+"</span></td>";
				item+="<td style=\"width: 106px;\">"+value.CJSJ+"</td>";
				item+="<td style=\"width: 138px;\">";
				if("sdAdd" == value.SSXMLX){
					item+="手动添加";
				}
				item+="</td><td style=\"width: 24px;\"><img src=\""+mypath+"images/xxcx/fk_phoneicon.png\" style=\"height: 14px;width: 15px;\"/></td>";
				item+="<td style=\"width: 180px;\">"+value.LXDH+"</td>";
				item+="<td style=\"width: 24px;\"><img src=\""+mypath+"images/xxcx/fk_qqicon.png\" style=\"height: 14px;width: 15px;\"/></td>";
				item+="<td style=\"width: 350px;\">"+value.QQ+"</td>";
				item+="<td style=\"width: 126px;\"></td></tr>";
				item+="<tr style=\"height: 5px;\"><td colspan=\"8\"></td></tr>";
				item+="<tr style=\"height: 22px;line-height: 22px;\"><td>"+value.DWMC+"</td>";
				item+="<td style=\"color: #366AB3;\" class=\"my_info\" onclick=\"getCJRXM('lxcjr','"+value.CJRBH+"')\">"+value.CJRXM+"</td>";
				item+="<td><img src=\""+mypath+"images/xxcx/fk_address.png\"/></td>";
				item+="<td colspan=\"3\">"+value.JZDZ+"</td><td></td></tr></table>";
				item+="</div>";
				$("#lx_div").append(item);
			});
		}, 
		error:function (error) {
			top.my_alert("获取单个信息失败****" + error.status);
		}
	});
}
/**
 * 查看更多联系方式
 */
function openConaction(){
	window.parent.f_click("RYLX"+rybh,"人员联系信息",mypath+"contactionQueryList.action?bd_rybh="+rybh+"&page=1&pagesize=10");
}
/**
 * 更新公安信息
 */
function updateInfo(){
	var sfzh = $("#GMSFZHM").html();
	top.$.ligerDialog.waitting('正在加载中,请稍候...');
	$.ajax({
		url : "czryUpdateInfo.action",
		data : "sfzh="+sfzh+"&rybh="+rybh,
		dataType : "json",
		type : "post",
		success : function(data) {
			var endtime = new Date().getTime();
			var time = endtime - data.starttime;
			setTimeout(function (){top.$.ligerDialog.closeWaitting();}, time);
			if ("success" == data.result) {
				top.$.ligerDialog.success("更新公安数据成功！");
				getMess(rybh);
				getConaction(rybh);
			} else {
				top.$.ligerDialog.error("更新出错，请再次更新避免数据出错！");
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("更新出错，请再次更新避免数据出错！" + error.status,"错误");
		}
	});
}

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
