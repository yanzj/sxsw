var mypath = "";
//滑动加载数据
var isendrwjl=false;  //判断任务交流当加载完成时，滚动条滑动不在加载数据
var isendcljg=false;  //判断处理结果当加载完成时，滚动条滑动不在加载数据
var bpagerwjl = 1;
var bpagecljg = 1;
var loadingrwjl = false;	//判断任务交流单次加载数据是否完成
var loadingcljg = false;    //判断处理结果单次加载数据是否完成
jQuery(function ($){
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	mypath = $("#mypath").val();
	var taskesid = $("#id").val();
	var currentuserid = $("#currentuserid").val();
	var rwcjr = $("#rwcjr").val();
	//获取任务详情信息
	getMess(taskesid,currentuserid);
	//获取参考资料集合
	getCkzlList(taskesid,rwcjr,"upload");
	//获取任务的参考资料数量,任务交流数量，结果处理数量
	getTaskCount(taskesid);
	//获取跟进任务未读数量,结果汇报未读数量
	getrwjlwdCount(taskesid);


});
/**
获取参考信息内容
 */
function getCkzlList(ids,rwcjr,type){
	if(type=="upload"){
		$("#ckzl_div").html('');
	}
	//友好提示文字
	$("#ckzl_loadover").show();
	$("#ckzl_loadover").html("正在加载中...");
	var id=ids;
	$.ajax({
		url:"ckzlQuerylistById.action",
		data:"rwbh="+id+"&path="+mypath+"&rwcjr="+rwcjr,
		dataType : "json",
		async : true,
		type : "post",
		success : function(data) {
			var value = data.msg;
			var objArray = JSON.parse(value);
			$(objArray).each(function(i, values) {
				//预警信息数量
				var yjList=values.yj_zlList;
				//盘查信息数量
				var pcList=values.pc_zllist;
				//关注人信息数量
				var ryList=values.ry_zllist;
				//管控人员信息数量
				var gkList=values.gk_zllist;
				//案事件信息数量
				var asjList=values.asj_zllist;
				//附件图片数量
				var tplist=values.tp_fjlist;
				//附件语音数量
				var yyfjlist=values.yy_fjlist;
				//图片资料
				if(tplist.length>0){
					$("#ckzl_div").append("<div style=\"height:30px;line-height:30px;font-size:14px;font-weight:bold\">图片资料("+tplist.length+")</div>");
					$("#ckzl_div").append("<div id=\"paramsTest\" class=\"pictures\" style=\"width:98%;\">");
					$(tplist).each(function(i,value){
						var item1 ="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\">";
						var item2 ="<a  href=\""+mypath+value.FWQLJ+"\" rel=\"lightbox-tour\"><img src=\""+mypath+value.FWQLJ+"\" style=\"width: 100px;height: 100px\"  border=\"0\" /></a>";
						var item3 = "</div>";
						$("#paramsTest").append(item1+item2+item3);	
						//$("#ckzl_div").append(item1+item2+item3);
					});
					$("#ckzl_div").append("</div>");
					$(".pictures a").lightbox();
					$.Lightbox.construct({
						show_linkback: false,
						show_helper_text:false,
						opacity: 0.9,
						text: {
							image: '图片'
						}
					});		
				}
				//语音信息
				if(yyfjlist.length>0){	
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold;\">语音信息("+yyfjlist.length+")</div>");
					$(yyfjlist).each(function(i,value){
						var item1 ="<div style=\"background-color: #D1D1D1;width:150px;height:30px;margin:5px;border:0px solid black;\">";
						var item2 ="<table width=\"100%\" height=\"80%\" border=\"0\">";
						var item3 ="<tr><td><img height=\"30\" width=\"33\" src=\""+mypath+"images/common/fk_voiceicon3.png\" /></td>";
						var YYLJ = value.FWQLJ.replace('.amr', '.mp3');
						var item4 ="<td><a href=\""+YYLJ+"\" onclick=\"openYY('"+value.FWQLJ+"','"+YYLJ+"');\" target=\"_Blank\">&nbsp;&nbsp;&nbsp;<span style=\"font-size: 20px;color: black;\">"+value.YYWJ+"秒</span></a></td></tr>";
						var item5 = "</table>";
						var item6 = "</div>";
						$("#ckzl_div").append(item1+item2+item3+item4+item5+item6);	
					});

				}
				//参考资料-预警信息
				if(yjList.length>0){
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold\">预警信息("+yjList.length+")</div>");
				}
				var itemyj="";
				itemyj=ckzl_yjxx(itemyj,yjList);
				$("#ckzl_div").append(itemyj);

				//参考资料-盘查信息
				var itempc="";
				itempc=ckzl_pcxx(itempc,pcList);
				if(pcList.length>0){
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold\">盘查信息("+pcList.length+")</div>");
				}
				$("#ckzl_div").append(itempc);

				//参考资料-关注人		
				var itemry="";
				itemry=ckzl_ryxx(itemry,ryList);
				if(ryList.length>0){
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold\">关注人("+ryList.length+")</div>");
				}
				$("#ckzl_div").append(itemry);

				//参考资料-管控人员
				var itemgk="";
				itemgk=ckzl_gkxx(itemgk,gkList);
				if(gkList.length>0){
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold\">管控人员("+gkList.length+")</div>");
				}
				$("#ckzl_div").append(itemgk);
				//参考资料-案事件信息
				var itemasj="";
				itemasj=ckzl_asjxx(itemasj,asjList);
				if(asjList.length>0){
					$("#ckzl_div").append("<div style=\"clear:both;height:30px;line-height:30px;font-size:14px;font-weight:bold\">案事件信息("+asjList.length+")</div>");
				}
				$("#ckzl_div").append(itemasj);
			});
			if(value.length == 430){
				$("#ckzl_loadover").html("暂无数据");
			}else{
				$("#ckzl_loadover").html("数据加载完成");
			}
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}
//预警详情
function openDialogyj(YJBH,i,BD_RYBH){
	if(i == 0 && i !=""){
		$("#"+YJBH).html("已读");
		$("#"+YJBH).attr("style","none");
		$.ajax({
			url:"earlywarningModify.action",
			data:"id="+YJBH,
			dataType:"json",
			type:"post",
			success:function(data){
				if("success"==data.result){
					window.parent.f_click(YJBH,"预警详情",mypath+"bussiness/aviation/yjxx/EarlywarningDetail.jsp?YJBH="+YJBH);
				}else{
					$.ligerDialog.error("跳转详情失败！");
				}
			}
		});
	}else{
		window.parent.f_click(YJBH,"预警详情",mypath+"bussiness/aviation/yjxx/EarlywarningDetail.jsp?YJBH="+ YJBH);

	}


}
/**
获取单个的信息
 */
function getMess(mid,currentuserid) {
	$.ajax({
		url : "taskesQueryById.action",
		data:"id="+mid,
		dataType : "json",
		async : false,
		type : "post",
		success : function(data) {
			var value = data.msg;
			var objArray = JSON.parse(value);
			var RWMC="";
			var RWNR="";
			var CJSJ="";
			var CJRBH="";
			var CJRBM="";
			var CJRZW="";
			var RWWCSJ="";
			var CJRBHID="";
			var CBCS="";
			$(objArray).each(function (i, value) { 
				RWMC=value.RWMC; 
				RWNR=value.RWNR;
				CJSJ=value.CJSJ;
				CJRBH=value.CJRBH;
				CJRBM=value.CJRBM;
				CJRZW=value.CJRZW;
				RWWCSJ=value.RWWCSJ;
				CJRBHID=value.CJRID;
				RWZT=value.RWZT;
				CBCS=value.CBCS;
				var listmodelinfo = value.listmodel;
				$(listmodelinfo).each(function(k,atk){
					var item1="<span class=\"td_value\" >"+atk.BMMC+"&nbsp;<span style=\"font-size: 14px;color:blue;\" class=\"float_style\" onclick=\"getZxrxx('"+atk.YHBH+"')\">"+atk.YHXM+"</span></span>&nbsp;&nbsp;";				
					$("#zxr_div").append(item1);
				});
				var rwzt=RWZT;
				var rwtype='';
				if(currentuserid == CJRBHID){
					rwtype = 'wfc';
				}else{
					rwtype = 'wjs';
				}
				//隐藏已完成字段
				$("#bjywc").hide();
				//隐藏发送提醒,增派人员按钮
				$("#wclqq").hide();
				//隐藏处理任务按钮
				$("#wclrw").hide();
				//隐藏跟进任务按钮
				$("#gjrw").hide();
				//隐藏结果汇报
				$("#jghb").hide();
				//隐藏提交任务按钮
				$("#tijiaoRW").hide();
				//我发出未处理页面
				if(rwtype =='wfc' && rwzt == 0){
					$("#wclqq").show();
					$("#gjrw").show();
					$("#jghb").show();
					$("#tijiaoRW").show();
				}
				//我发出进行中页面
				if(rwtype =='wfc' && rwzt == 1){
					$("#gjrw").show();
					$("#jghb").show();
					$("#tijiaoRW").show();
					document.getElementById('rwjlround_l').style.display = 'block';//显示
					document.getElementById('rwjlround_s').style.display = 'block';//显示
					document.getElementById('jghbround_l').style.display = 'block';//显示
					document.getElementById('jghbround_s').style.display = 'block';//显示
				}
				//我发出已完成页面
				if(rwtype == 'wfc' && rwzt == 2){
					$("#bjywc").show();
					document.getElementById('rwjlround_l').style.display = 'block';//显示
					document.getElementById('rwjlround_s').style.display = 'block';//显示
					document.getElementById('jghbround_l').style.display = 'block';//显示
					document.getElementById('jghbround_s').style.display = 'block';//显示
				}
				//我接受未处理页面
				if(rwtype == 'wjs' && rwzt == 0){
					$("#gjrw").show();
					$("#jghb").show();
					document.getElementById('rwjlround_l').style.display = 'block';//显示
					document.getElementById('rwjlround_s').style.display = 'block';//显示
					document.getElementById('jghbround_l').style.display = 'block';//显示
					document.getElementById('jghbround_s').style.display = 'block';//显示
				}
				//我接受进行中页面
				if(rwtype == 'wjs' && rwzt == 1){
					$("#gjrw").show();
					$("#jghb").show();
					document.getElementById('rwjlround_l').style.display = 'block';//显示
					document.getElementById('rwjlround_s').style.display = 'block';//显示
					document.getElementById('jghbround_l').style.display = 'block';//显示
					document.getElementById('jghbround_s').style.display = 'block';//显示
				}
				//我接受已完成页面
				if(rwtype == 'wjs' && rwzt == 2){
					$("#bjywc").show();
					document.getElementById('rwjlround_l').style.display = 'block';//显示
					document.getElementById('rwjlround_s').style.display = 'block';//显示
					document.getElementById('jghbround_l').style.display = 'block';//显示
					document.getElementById('jghbround_s').style.display = 'block';//显示
				}


			});
			$("#RWMC").html(RWMC);
			$("#RWNR").html(RWNR);
			$("#CJSJ").html(getdate(CJSJ));
			$("#CJRBH").html(CJRBH);
			$("#CJRBM").html(CJRBM);
			$("#CJRZW").html(CJRZW);
			$("#RWZT").html(RWZT);
			$("#CBCS").html(CBCS);
			if(RWWCSJ==0){
				$("#RWWCSJ").html("无期限");
			}else{
				$("#RWWCSJ").html(getdatetwo(RWWCSJ));
			}
			$("#CJRBHID").val(CJRBHID);
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}
/**
 * 获取任务的参考资料数量,任务交流数量，结果处理数量
 */
function getTaskCount(taskesid){
	$.ajax({
		url : "TaskCountbyID.action",
		data:"id="+taskesid,
		dataType : "json",
		async : true,
		type : "post",
		success : function(data) {
			var mm = data.taskesModel;
			$("#ckzllist").html(mm.CKZLCOUNT);
			$("#rwjlCount").html(mm.RWJLCOUNT);
			$("#jghbCount").html(mm.JGJLCOUNT);
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}
//tab点击事件
function tab_onclick(item,itemtype) {
	//修改样式
	$("#div_tab div").css("border-bottom", "");
	$("#div_tab div").css("color", "black");

	$("#" + item).css("border-bottom", "2px solid #F07844");
	$("#" + itemtype).css("color", "#F07844");

	if(item=="ckzl_bnt"){
		$("#rwjl").hide();
		$("#cljg").hide();
		$("#ckzl").show();
	}else if(item=="rwjl_bnts"){
		$("#cljg").hide();
		$("#ckzl").hide();
		$("#rwjl").show();
		document.getElementById('rwjlround_l').style.display = 'none';//隐藏_l
		document.getElementById('rwjlround_s').style.display = 'none';//隐藏_s
		sxgjrw();
		RWJLCountToZero(rwid);
	}else if(item=="cljg_bnts"){
		$("#rwjl").hide();
		$("#ckzl").hide();
		$("#cljg").show();
		document.getElementById('jghbround_l').style.display = 'none';//隐藏_l
		document.getElementById('jghbround_s').style.display = 'none';//隐藏_s
		sxcljg();
		CLJGCountToZero(rwid);
	}
}

////刷新跟进任务
function sxgjrw(){
	$("#rwjl_div").html('');
	bpagerwjl = 1;
	isendrwjl = false;
	if(!loadingrwjl){
		loadingrwjl = true;
		getRwjlList(bpagerwjl,"search");
	}
}
//刷新处理结果
function sxcljg(){
	$("#cljg_div").html('');
	bpagecljg = 1;
	isendcljg = false;
	if(!loadingcljg){
		loadingcljg = true;
		getCljgList(bpagecljg,"search");
	}
}
/**
获取处理结果内容
 */
function getCljgList(age,type){
	$(document).scrollTop(0); 
	//友好提示文字
	$("#cljg_loadover").show();
	$("#cljg_loadover").html("正在加载中...");

	var id = $("#id").val();
	var rwzt = $("#RWZT").html();
	//获取任务创建人
	var CJRBHID = $("#CJRBHID").val();
	//获取当前登陆人id
	var currentuserid =$("#currentuserid").val();
	$.ajax({
		url:"cljgcommentlist.action",
		data:"rwbhtwo="+id+"&path="+mypath+"&bpage="+age+"&apage=10"+"&yybm=taskresults",
		dataType : "json",
		async : true,
		type : "post",
		success : function(data) {
			var value = data.msg;
			if(type=="more" && value.length==2){
				$("#cljg_loadover").show();
				$("#cljg_loadover").html('数据加载完成');
				isendcljg = true;
				loadingcljg = false;
				return;
			}else if(type=="search" && value.length==2){
				$("#cljg_loadover").show();
				$("#cljg_loadover").html('暂无数据');
				isendcljg = true;
				loadingcljg = false;
				return;
			}else{
				$("#cljg_loadover").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#cljg_loadover").show();
					$("#cljg_loadover").html('数据加载完成');
					isendcljg=true;
				}
				$(objArray).each(function(i, value) {
					var attinfo = value.alist;
					var item1 = "<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:auto;clear: both;border:0px solid #F00;\">";
					var item2="<div class=\"box\" style=\"margin-top: 10px;border:0px solid #EEEE00;\">";
					var item3="<div style=\"float: left;width: 15%;margin-bottom: 10px;border:0px solid #EEEE00;\">";
					var item4="<div style=\"margin-bottom: 10px;text-align: center;\">";
					var item5="<img src=\""+mypath+value.clrtx+"\" class=\"head\" style=\"width: 100px;height: 100px\"/>";
					var item6="</div>";	
					var item7="<div style=\"text-align: center;font-size: 14px;\">"+value.clrxm+"</div>";
					var item8="<div style=\"text-align: center;font-size: 14px;\">"+value.BMMC+"-"+value.ZWMC+"</div>";	
					var item9="</div>";
					var item10="<div style=\"float: left;width: 84%;border:0px solid #EEEE00;\">";
					var item11="<div style=\"border-bottom:1px solid #b2b2b2;height: 30px;line-height: 30px;margin-bottom: 15px\">";
					var item12="<div style=\"float: left;\">"+value.JGCLSJ+"</div>";
					var itemdd="<div style=\"float: right; color: #366CB4;\">";
					var itemff = "";
					if(rwzt == 2){
						itemff = "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
					}else{
						if(CJRBHID == currentuserid){
							itemff = "<span id=\""+value.RWCLJGBH+"dh\" class=\"float_style\" onclick=\"DaHuiJG('"+value.ISRESULT+"','"+value.RWCLJGBH+"','"+value.CLJGMS+"','"+value.clrxm+"','"+value.CLRBH+"')\">" +
							"<input type=\"button\" class=\"search_input_style float_style\" style=\"background-color:#00008B;border: 1px solid #00008B;height:30px;color: white;width: 120px;margin-right: 5px;\" value=\"重新汇报\"/></span>";
						}else if(CJRBHID != currentuserid){
							itemff = "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
						}
					}
					var itemee="</div>";
					var item13="</div>";
					var item14="<div>"+value.CLJGMS+"</div>";


					var item15="<div class=\"pictures\">";
					var item16="";
					$(attinfo).each(function(x,atp) { 
						if(atp.WJLX==0){
							item16 +="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\"><a href=\""+atp.FWQLJ+"\" rel=\"lightbox-"+value.JGCLSJ+"\"><img src=\""+atp.FWQLJ+"\"  style=\"width: 100px;height: 100px\" /></a></div>";
						}
					});
					var item17 ="</div>";

					var item18 ="<div style=\"clear:both;\" class=\"minute\">";
					var item19 ="";
					$(attinfo).each(function(j,aty) { 
						if(aty.WJLX==1){
							var YYLJ = aty.FWQLJ.replace('.amr', '.mp3');
							item19 +="<a href=\""+YYLJ+"\" onclick=\"openYY('"+aty.FWQLJ+"','"+YYLJ+"');\"  target=\"_Blank\">"+aty.YYWJ+"秒;</a>";
						}
					});
					var item20 ="</div>";


					//预警信息
					var yjlistinfo =value.yj_zlList;
					//参考资料-预警信息
					var itemaa="";
					itemaa=ckzl_yjxx(itemaa,yjlistinfo);

					//盘查信息
					var pclistinfo =value.pc_zllist;
					//参考资料-盘查信息
					var itembb= " ";
					itembb=ckzl_pcxx_other(itembb,pclistinfo);

					//人员信息
					var rylistinfo =value.ry_zllist;
					//参考资料-人员信息
					var itemcc= " ";
					itemcc=ckzl_ryxx(itemcc,rylistinfo);

					//管控人员信息
					var gklistinfo = value.gk_zllist;
					//参考资料-管控人员
					var itemgk="";
					itemgk=ckzl_gkxx(itemgk,gklistinfo);

					//案事件
					var asjlistinfo = value.asj_zllist;
					//参考资料-案事件
					var itemasj="";
					itemasj=ckzl_asjxx(itemasj,asjlistinfo);

					var item21 ="<div style=\"clear: both; margin-top:15px;\"></div>";
					var item22 ="</div>";
					var item23 ="</div>";
					var item24 ="</div>";
					var item25 ="<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:0px auto;clear: both;\" ></div>";
					$("#cljg_div").append(item1 +item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+itemdd+itemff+itemee+item13+item14+item15+item16+item17+item18+item19+item20+itemaa+itembb+itemcc+itemgk+itemasj+item21+item22+item23+item24+item25);

				});
				$(".pictures a").lightbox();
				$.Lightbox.construct({
					show_linkback: false,
					show_helper_text:false,
					opacity: 0.9,
					text: {
						image: '图片'
					}
				});		
				loadingcljg = false;
			}
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}

/**
获取任务交流数据
 */
function getRwjlList(age,type){
	$(document).scrollTop(0); 
	//友好提示文字
	$("#rwjl_loadover").show();
	$("#rwjl_loadover").html("正在加载中...");

	var id = $("#id").val();
	var rwzt = $("#RWZT").html();
	//获取当前登陆人id
	var currentuserid =$("#currentuserid").val();
	$.ajax({
		url:"gjrwcommentlist.action",
		data:"ssxmbh="+id+"&ssxmlx=taskes"+"&path="+mypath+"&bpage="+age+"&apage=10"+"&yybm=exchange",
		dataType : "json",
		async : true,
		type : "post",
		success : function(data) {
			var value = data.msg;
			if(type=="more" && value.length==2){
				$("#rwjl_loadover").show();
				$("#rwjl_loadover").html('数据加载完成');
				isendrwjl = true;
				loadingrwjl = false;
				return;
			} else if(type=="search" && value.length==2){
				$("#rwjl_loadover").show();
				$("#rwjl_loadover").html('暂无数据');
				isendrwjl = true;
				loadingrwjl = false;
				return;
			} else{
				$("#rwjl_loadover").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#rwjl_loadover").show();
					$("#rwjl_loadover").html('数据加载完成');
					isendrwjl = true;
				}
				$(objArray).each(function(i, value) {
					var attinfo = value.alist;
					var clistinfo = value.clist;
					var item1 = "<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:auto;clear: both;border:0px solid #F00;\">";
					var item2 = "<div class=\"box\" style=\"margin-top: 10px;border:0px solid #EEEE00;\">";
					var item3 = "<div style=\"float: left;width: 15%;margin-bottom: 10px\">";
					var item4 = "<div style=\"margin-bottom: 10px;text-align: center\">";	
					var item5 = "<img src=\""+value.CJZTX+"\" class=\"head\" style=\"width: 100px;height: 100px;\" />";
					var item6 = "</div>";
					var item7 = "<div style=\"text-align: center;font-size: 14px;\">"+value.CJZMC+"</div>";
					var item8 = "<div style=\"text-align: center;font-size: 14px;\">"+value.BMMC+"-"+value.ZWMC+"</div>";
					var item9 = "</div>";
					var item10 = "<div style=\"float: left;width: 84%;border:0px solid #EEEE00;\">";
					var item11 = "<div style=\"border-bottom:1px solid #b2b2b2;height: 30px;line-height: 30px;margin-bottom: 15px;\">";
					var item12 = "<div style=\"float: left;\">"+value.PLSJ+"</div>";
					var item13 = "<div style=\"float: right; color: #366CB4;\">";
					var item14 = "<span>回复<span style=\"color:#F07844;\">(<span id=\""+value.JLPLBH+"huifuCount\">"+value.ZPLCOUNT+"</span>)</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					var item15 = "";
					if(rwzt == 2){
						item15 = "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
					}else{
						if(value.FCZBH == currentuserid){
							if(value.ISRESULT==1){
								item15 = "<span id=\""+value.JLPLBH+"sb\" style=\"color: #8B7D6B;\" >提交结果汇报</span>";
							}
							if(value.ISRESULT !=1){
								item15 = "<span id=\""+value.JLPLBH+"sb\" class=\"float_style\" onclick=\"tijiaoJG('"+value.FCZBH+"','"+value.PLJTNR+"','"+value.SSXMBH+"','"+value.JLPLBH+"')\">提交结果汇报</span>";
							}

						}else if(value.FCZBH != currentuserid){
							item15 = "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
						}
					}
					var item16 = "</div>";
					var item17 = "</div>";
					var item18 = "<div>"+value.PLJTNR+"</div>";


					var item19 = "<div class=\"pictures\" >";
					var item20 = "";
					$(attinfo).each(function(x,atp) { 
						if(atp.WJLX==0){
							item20 +="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\"><a href=\""+atp.FWQLJ+"\" rel=\"lightbox-"+value.PLSJ+"\"><img src=\""+atp.FWQLJ+"\"  style=\"width: 100px;height: 100px\" /></a></div>";
						}
					});
					var item21 = "</div>";
					var item22 = "<div style=\"clear:both;\" class=\"minute\">";
					var item23 = "";
					$(attinfo).each(function(j,aty) { 
						if(aty.WJLX==1){
							var YYLJ = aty.FWQLJ.replace('.amr', '.mp3');
							item23 +="<a  href=\""+YYLJ+"\" onclick=\"openYY('"+aty.FWQLJ+"','"+YYLJ+"')\"  target=\"_Blank\">"+aty.YYWJ+"秒;</a>";
						}
					});
					var item24 = "</div>";
					//预警信息
					var yjlistinfo =value.yj_zlList;
					//参考资料-预警信息
					var itemaa= " ";
					itemaa=ckzl_yjxx(itemaa,yjlistinfo);

					//盘查信息
					var pclistinfo =value.pc_zllist;
					//参考资料-盘查信息
					var itembb= " ";
					itembb=ckzl_pcxx_other(itembb,pclistinfo);

					//人员信息
					var rylistinfo =value.ry_zllist;
					//参考资料-人员信息
					var itemcc= " ";
					itemcc=ckzl_ryxx(itemcc,rylistinfo);

					//管控人员
					var gklistinfo = value.gk_zllist;
					//参考资料-管控人员
					var itemdd="";
					itemdd=ckzl_gkxx(itemdd,gklistinfo);

					//案事件信息
					var asjlistinfo = value.asj_zllist;
					//参考资料-案事件
					var itemee="";
					itemee=ckzl_asjxx(itemee,asjlistinfo);


					var item25 = "<div style=\"clear: both; margin-top:15px;\"></div>";
					var item26 = "</div>";
					var item27 = "<div style=\"margin-bottom:10px;margin-left:15%; margin-right: 1%;\">";
					var item28 = "<div style=\"clear: both; border-bottom:1px solid #b2b2b2; margin-bottom:10px;\"></div>";

					var item29 = "";
					var item30 = "";
					var item31 = "";
					var item32 = "";
					var item33 = "";
					if(rwzt == 2){
						item32 = "<div id=\""+value.JLPLBH+"11\" style=\"text-align:right;margin-top:10px;width:98%;display:none;\">";
						item33 = "";
					}else{
						item29 = "<div>";
						item30 = "<input type=\"text\" class=\"input_style\" style=\"width:98%;padding-left:5px;color:gray;\" onfocus=\"aa('"+value.JLPLBH+"')\" id=\""+value.JLPLBH+"\" value=\"交流一下吧~\" />";
						item31 = "</div>";
						item32 = "<div id=\""+value.JLPLBH+"11\" style=\"text-align:right;margin-top:10px;width:98%;display:none;\">";
						item33 = "<input type=\"button\" class=\"search_input_style\" value=\"发表\" style=\"background-color:#F07844;border:1px solid #F07844;height:28px;color:white;width:100px;\" onclick=\"pinglun('"+value.JLPLBH+"','"+value.FCZBH+"','"+value.CJZMC+"')\"/>";
					}
					var item34 = "</div>";
					var item35 = "</div>";
					//个人评论s
					var item36 = "<div class=\"personnal\" id=\""+value.JLPLBH+"pl\" style=\"margin-bottom:10px;margin-left:15%;margin-right:1%;\">"; 
					var item37 = "";
					$(clistinfo).each(function(k,atk){
						if(atk.FCZBH == ""){
							item37 +="<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:10px auto;clear: both;\" ></div>";
							item37 += "<div class=\"smallheads\" style=\"float: left;\">";
							item37 += "<img src=\""+atk.CJZTX+"\" class=\"smallhead\" style=\"width: 50px;height: 50px;\"/>";
							item37 += "</div>";
							item37 += "<div class=\"talks\" style=\"float: left;\">";
							item37 += "<font color=\"#46A3B2\">"+atk.CJZMC+"</font>&nbsp;&nbsp;:"+atk.PLJTNR+"<br/>";
							item37 += "<span style=\"line-height:28px;\"><font color=\"#868686\">"+atk.PLSJ+"</font>&nbsp;&nbsp;<a onclick=\"huifu('"+atk.FCZBH+"','"+value.JLPLBH+"')\"><font color=\"#46A3B2\" style=\"display:none;\">回复</font></a></span>";
							item37 += "</div>";
							item37 += "<div style=\"clear:both;\"></div>";
						}
						else{
							item37 +="<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:10px auto;clear: both;\" ></div>";
							item37 += "<div class=\"smallheads\" style=\"float: left;\">";
							item37 += "<img src=\""+atk.CJZTX+"\"  class=\"smallhead\" style=\"width: 50px;height: 50px;\"/>";
							item37 += "</div>";
							item37 += "<div class=\"talks\" style=\"float: left;\">";
							item37 += "<font color=\"#46A3B2\">"+atk.CJZMC+"</font>&nbsp;&nbsp;:"+atk.PLJTNR+"<br/>";
							item37 += "<span style=\"line-height:28px;\"><font color=\"#868686\">"+atk.PLSJ+"</font>&nbsp;&nbsp;<a onclick=\"huifu('"+atk.FCZBH+"','"+value.JLPLBH+"')\"><font color=\"#46A3B2\" style=\"display: none;\">回复</font></a></span>";
							item37 += "</div>";
							item37 += "<div style=\"clear:both;\"></div>";
						}
					});
					var item38 = "</div>";
					//个人评论end
					var item39 = "</div>";
					var item40 = "</div>";
					var item41 = "</div>";
					var item42 ="<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:0px auto;clear: both;\" ></div>";
					$("#rwjl_div").append(item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+item13+item14+item15+item16+item17+item18+item19+item20+item21+item22+item23+item24+itemaa+itembb+itemcc+itemdd+itemee+item25+item26+item27+item28+item29+item30+item31+item32+item33+item34+item35+item36+item37+item38+item39+item40+item41+item42);
				});
				$(".pictures a").lightbox();
				$.Lightbox.construct({
					show_linkback: false,
					show_helper_text:false,
					opacity: 0.9,
					text: {
						image: '图片'
					}
				});	
				loadingrwjl = false;
			} 
		},
		error : function(error) {
			alert("获取任务交流数据失败****" + error.status);
		}
	});
}

//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(isendrwjl && $("#rwjl").is(':visible')){
			return;
		}else if(isendcljg && $("#cljg").is(':visible')){
			return;
		}
		//加载任务交流
		if($("#rwjl").is(':visible') && !loadingrwjl){
			loadingrwjl = true;
			bpagerwjl = bpagerwjl+1;
			getRwjlList(bpagerwjl,"more");
		}
		//加载处理结果
		if($("#cljg").is(':visible') && !loadingcljg){
			loadingcljg = true;
			bpagecljg = bpagecljg+1;
			getCljgList(bpagecljg,"more");
		}
	}
});

//添加任务交流(判断任务是否已提交)
function addJiaoliu(){
	var id=$("#id").val(); 
	$.ajax({
		url:"IStaskSubmit.action",
		data:"ssxmbh="+id,
		dataType:"json",
		async:true,
		type:"post",
		success:function(data){
			var mm = data.taskesModel;
			var cjrbh = mm.CJRBH;
			var n = mm.RWZT;
			switch (n)
			{
			case 2:
				$.ligerDialog.question("该任务已提交！");
				break;
			case 1:
				addJiaoliuTwo(cjrbh);
				break;
			case 0:
				addJiaoliuThree(cjrbh);
				break;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error(error.status, "错误");
		}

	});
}
//添加任务交流(任务状态是1)
function addJiaoliuTwo(cjrbh){
	var id=$("#id").val(); 
	var url = mypath+"bussiness/aviation/rwcl/clzrw/RwjlAdd.jsp?ssxmbh="+id+"&cjrbh="+cjrbh;
	winOpen(url, "", 750, 500, '提交', '取消', function(data, dialog) {
		$.ajax({
			url : "RwjlAdd.action",
			data : data,
			dataType : "json",
			async : true,
			type : "post",
			success : function(data) {
				if ("success" == data.result) {
					sxgjrw();
					getTaskCount(id);
					top.$.ligerDialog.success("添加交流评论信息成功!");
					RwjltoMymessages(id);
					RWJLWDSLAddcount(id);
				} else {
					top.$.ligerDialog.error("添加交流评论信息失败！");
				}
			},
			error : function(error) {
				top.$.ligerDialog.error("添加交流评论信息失败！" + error.status, "错误");
			}
		});
	}); 
}
//添加任务交流(任务状态是0)
function addJiaoliuThree(cjrbh){
	var currentuserid = $("#currentuserid").val();
	var id=$("#id").val(); 
	var url = mypath+"bussiness/aviation/rwcl/clzrw/RwjlAdd.jsp?ssxmbh="+id+"&cjrbh="+cjrbh;
	winOpen(url, "", 750, 500, '提交', '取消', function(data, dialog) {
		$.ajax({
			url : "RwjlAdd.action",
			data : data,
			dataType : "json",
			async : true,
			type : "post",
			success : function(data) {
				if ("success" == data.result) {
					sxgjrw();
					getTaskCount(id);
					RwjltoMymessages(id);
					RWJLWDSLAddcount(id);
					if(currentuserid == cjrbh){
						top.$.ligerDialog.success("添加交流评论信息成功!");
					}else{
						top.$.ligerDialog.success("添加交流评论信息成功,任务开始");
						window.top.f_addTab(window.top.getSelectedTabId(),"ssss","bussiness/aviation/rwcl/wclrw/WclrwTabList.jsp");
						window.top.my_closewindow();
					}

				} else {
					top.$.ligerDialog.error("添加交流评论信息失败！");
				}
			},
			error : function(error) {
				top.$.ligerDialog.error("添加交流评论信息失败！" + error.status, "错误");
			}
		});
	}); 
}
//添加结果汇报(判断该任务是否已提交)
function addJieguo(){
	var id=$("#id").val(); 
	$.ajax({
		url:"IStaskSubmit.action",
		data:"ssxmbh="+id,
		dataType:"json",
		async:true,
		type:"post",
		success:function(data){
			var mm = data.taskesModel;
			var n = mm.RWZT;
			var cjrbh = mm.CJRBH;
			switch (n){
			case 2:
				$.ligerDialog.question("该任务已提交！");
				break;
			case 1:
				addJieguoTwo(cjrbh);
				break;
			case 0:
				addJieguoThree(cjrbh);
				break;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error(error.status, "错误");
		}

	});
}
//添加结果汇报（任务状态是1）
function addJieguoTwo(cjrbh){
	var id=$("#id").val();
	var url = "bussiness/aviation/rwcl/clzrw/CljgAdd.jsp?rwbhtwo="+id+"&pre=0"+"&cjrbh="+cjrbh;
	winOpen(url,' ',750,500,'提交','取消',function(data){
		$.ajax({
			url:"CljgAdd.action", 
			data:data,
			dataType:"json", 
			async : true,
			type:"post",
			success:function (mm) {
				if("success"==mm.result){
					sxcljg();
					getTaskCount(id);
					top.$.ligerDialog.success("添加处理结果成功!");
					CljgtoMymessages(id);
					CLJGWDSLAddcount(id);
				}else{
					top.my_alert("添加处理结果失败!");
				}
			}, 
			error:function (error) {
				top.my_alert("添加处理结果失败!" + error.status,"error");
			}
		});
	});
}
//添加结果汇报（任务状态是0）
function addJieguoThree(cjrbh){
	var currentuserid = $("#currentuserid").val();
	var id=$("#id").val();
	var url = "bussiness/aviation/rwcl/clzrw/CljgAdd.jsp?rwbhtwo="+id+"&pre=0"+"&cjrbh="+cjrbh;
	winOpen(url,' ',750,500,'提交','取消',function(data){
		$.ajax({
			url:"CljgAdd.action", 
			data:data,
			dataType:"json", 
			async : true,
			type:"post",
			success:function (mm) {
				if("success"==mm.result){
					sxcljg();
					getTaskCount(id);
					CljgtoMymessages(id);
					CLJGWDSLAddcount(id);
					if(currentuserid == cjrbh){
						top.$.ligerDialog.success("添加处理结果成功!");
					}else{
						top.$.ligerDialog.success("添加处理结果成功,任务开始");
						window.top.f_addTab(window.top.getSelectedTabId(),"ssss","bussiness/aviation/rwcl/wclrw/WclrwTabList.jsp");
						window.top.my_closewindow();
					}

				}else{
					top.my_alert("添加处理结果失败!");
				}
			}, 
			error:function (error) {
				top.my_alert("添加处理结果失败!" + error.status,"error");
			}
		});
	});
}
function aa(id) {
	document.getElementById(id).focus();
	$("#" + id + "11").show();
	var value = $("#" + id).val().trim();
	if (value == "交流一下吧~") {
		$("#" + id).val("");
	}
}

//发表评论
function pinglun(itemid,FCZBH,CJZMC) {
	var newcontent = $("#" + itemid).val();
	var value = $.trim(newcontent); 
	if( value == ""|| value == null){
		$.ligerDialog.warn("评论内容不能为空！");
		return false;
	}else{
		var id = $("#id").val();
		$.ajax({
			url : "RwjlHuiFuAdd.action",
			data:"model.PLJTNR="+newcontent+"&model.SSXMBH="+id+"&JSZBH="+FCZBH+"&SJPLBH="+itemid+"&path="+mypath,
			dataType : "json",
			async : true,
			type : "post",
			success : function(data) {
				$.ligerDialog.success("发表成功！");
				var currentuserid = $("#currentuserid").val();
				if(currentuserid != FCZBH){
					PingluntoMymessages(id,FCZBH,CJZMC);
				}
				//
				var value = $("#"+itemid+"huifuCount").html();
				var count = parseInt(value)+1;
				$("#" +itemid+"huifuCount").html(count);
				//
				var value=data.msg;
				var objArray = JSON.parse(value);
				$("#" + itemid+"pl").html("");
				$(objArray).each(function (i, value) { 
					if(value.JSZBH==""){
						$("#" + itemid+"pl").append("<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:10px auto;clear: both;\" ></div><div class='smallheads' style=\"float: lefat;\"><img src=\""+value.CJZTX+"\" class=\"smallhead\"   style=\"width: 50px;height: 50px\"/> </div> <div class=\"talks\"  style=\"float: left;\"><font color=\"#46A3B2\">"+value.CJZMC+"</font>&nbsp;&nbsp;:"+value.PLJTNR+"<br /><span style=\"line-height:28px;\"><font color=\"#868686\">"+value.PLSJ+"</font>&nbsp;&nbsp;<a onclick=\"huifu('"+value.FCZBH +"','"+itemid+"')\"><font color=\"#46A3B2\" style=\"display: none;\">回复</font></a></span> </div><div style=\"clear: both;\"></div>");
						$("#"+itemid).val("交流一下吧~");
						$("#"+itemid+"11").hide();
					}else{
						$("#" + itemid+"pl").append("<div style=\"border-bottom:1px solid #b2b2b2; width:97%;margin:10px auto;clear: both;\" ></div><div class=\"smallheads\" style=\"float: left;\"><img src=\""+value.CJZTX+"\" class=\"smallhead\"  style=\"width: 50px;height: 50px\"/></div><div class=\"talks\"  style=\"float: left;\"><font color=\"#46A3B2\">"+value.CJZMC+"</font>&nbsp;&nbsp;&nbsp;&nbsp;:"+value.PLJTNR+"<br /><span style=\"line-height:28px;\"><font color=\"#868686\">"+value.PLSJ +"</font>&nbsp;&nbsp;<a onclick=\"huifu('"+value.FCZBH +"','"+itemid+"')\"><font color=\"#46A3B2\"  style=\"display: none;\">回复</font></a></span></div><div style=\"clear: both;\"></div>");
						$("#"+itemid).val("交流一下吧~");
						$("#"+itemid+"11").hide();
					}

				});  
			},
			error : function(error) {
				$.ligerDialog.error("发表失败！");
			}
		});
		return true;
	}
}
//点击查看发布人信息
function getCjrxx(){
	var CJRID = $("#CJRBHID").val();
	var url = mypath+"system/user/UserMess.jsp?id="+CJRID;
	window.top.my_openwindow("",url,700,450,"发布人详情信息");
}
//打开语音
function openYY(filename,YYLJ){
	var str= filename.split("/");
	var filename=str[str.length-1];
	$.ajax({
		url:"amrtompthree2.action",
		data:"filename="+filename,
		type:"post",
		dataType:'json',
		async : false,
		success:function(msg){
			YY(YYLJ);
			alert(success.status);

		},
		error:function(error){
			alert(error.status);
		}
	});
}
function YY(YYLJ){
	var item = "<a href=\""+YYLJ+"\"   target=\"_Blank\"></a>";
}
//提交结果汇报
function tijiaoJG(FCZBH,PLJTNR,SSXMBH,JLPLBH){
	$.ligerDialog.confirm('你确定要提交结果汇报吗？', function (yes){
		if(yes){
			$.ajax({
				url:"CljgTijiao.action",
				data:"taskresults.RWBH="+SSXMBH+"&taskresults.CLRBH="+FCZBH+"&taskresults.CLJGMS="+PLJTNR+"&taskresults.RWCLJGBH="+JLPLBH+"&taskresults.ISRESULT=1",
				type:"post",
				dataType:'json',
				async : true,
				success:function (mm) {
					if("success"==mm.result){
						changISRESULT(JLPLBH);
						CljgtoMymessages(SSXMBH);
						CLJGWDSLAddcount(SSXMBH);
					}else{
						$.ligerDialog.error("提交失败!");
					}
				}, 
				error:function (error) {
					top.my_alert("提交失败!" + error.status,"error");
				}
			});

		}
	});

}
//提交任务
function tijiaoRW(){
	var id = $("#id").val();
	$.ligerDialog.confirm('你确定要提交该任务吗？', function (yes) { 
		if(yes){
			$.ajax({
				url : "rwtijiao.action",
				data:"rwid="+id,
				dataType : "json",
				async : true,
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						var tabid = window.top.getSelectedTabId();
						$.ligerDialog.success("提交成功！");
						window.top.f_addTab("222","已完成列表","WclqqAlllist.action?apage=15&bpage=1&rwtype=wfc&rwzt=2&lb=lb&path"+mypath);
						window.top.my_removeTab(tabid);
					} else {
						$.ligerDialog.error("提交失败！ ");

					}
				}
			});
		}
	});
}

//点击查看执行人信息
function getZxrxx(yhbh){
	var url = mypath+"system/user/UserMess.jsp?id="+yhbh;
	window.top.my_openwindow("",url,700,450,"执行人详情信息");
}
//提交结果汇报成功后改变ISRESULT字段状态
function changISRESULT(JLPLBH){
	var taskesid = $("#id").val();
	$.ajax({
		url:"changISRESULT.action",
		data:"model.JLPLBH="+JLPLBH,
		type:"post",
		dataType:'json',
		async : true,
		success:function (mm) {
			if("success"==mm.result){
				$.ligerDialog.success("提交成功!");
				$("#"+JLPLBH+"sb").html("");
				$("#"+JLPLBH+"sb").append("<span id=\"${item.JLPLBH}sb\" style=\"color: #8B7D6B;\" >提交结果汇报</span>");
				$("#"+JLPLBH+"sb").removeAttr("onclick");
				$("#"+JLPLBH+"sb").removeClass("float_style");
				//刷新数量
				getTaskCount(taskesid);
			}else{
				$.ligerDialog.error("提交失败!");
			}
		}, 
		error:function (error) {
			top.my_alert("提交失败!" + error.status,"error");
		}
	});
}
//催办
function addTiX(){
	var id=$("#id").val();
	$.ligerDialog.confirm('你确定要催办吗？', function (yes) { 
		if(yes){
			$.ajax({
				url : "tixchuliAdd.action",
				data:"id="+id,
				dataType : "json",
				async : true,
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						$.ligerDialog.success("催办成功！");
						//
						var value = $("#CBCS").html();
						var count = parseInt(value)+1;
						$("#CBCS").html(count);
						//
						addTiXbyAscending(id);
					} else {
						$.ligerDialog.error("催办失败！ ");

					}
				}
			});
		}
	});
}
//增派人员
function addRenyuan(){
	var id=$("#id").val();
	var url = "bussiness/aviation/rwcl/wclqq/UserAdd.jsp?id="+id;
	winOpen(url,'',550,350,'添加','取消',function(data){
		$.ajax({
			url:"UserAdd.action", 
			data:data,
			dataType:"json", 
			async : true,
			type:"post",
			success:function (mm) {
				if("success"==mm.result){
					$.ligerDialog.success("增派人员成功!");
					history.go();

				}else{
					$.ligerDialog.error("增派人员失败!");
					history.go();
				}
			}, 
			error:function (error) {
				$.ligerDialog.error("增派人员失败!" + error.status,"error");
			}});
	});
}
//处理任务
function chuliRW(){
	$.ligerDialog.confirm('确定要处理该任务吗？', function (yes) { 
		if(yes){
			var id = $("#id").val();
			$.ajax({
				url : "chulirenwu.action",
				data:"id="+id,
				dataType : "json",
				async : true,
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						$.ligerDialog.success("处理成功！");
						window.top.f_addTab(window.top.getSelectedTabId(),"ssss","bussiness/aviation/rwcl/wclrw/WclrwTabList.jsp");
						window.top.my_closewindow();
					} else {
						$.ligerDialog.error("处理失败！ ");
					}
				}
			});
		}
	});
}
//打回结果
function DaHuiJG(ISRESULT,RWCLJGBH,CLJGMS,clrxm,CLRBH){
	var ssxmbh =$("#id").val();
	$.ligerDialog.confirm('你确定要重新汇报吗？', function (yes){
		if(yes){
			if(ISRESULT==0){
				var url = "bussiness/aviation/rwcl/jg_huibao.jsp?RWCLJGBH="+RWCLJGBH+"&ssxmbh="+ssxmbh+"&CLRBH="+CLRBH;
				winOpen(url,' ',750,400,'确认','取消',function(data){
					$.ajax({
						url:"JG_huibaoOFjghb.action?CLJGMS="+CLJGMS, 
						data:data,
						dataType:"json", 
						async : true,
						type:"post",
						success:function (mm) {
							if("success"==mm.result){
								$.ligerDialog.success("重新汇报成功!");
								sxcljg();
								getTaskCount(ssxmbh);
								CxhbtoMymessages(ssxmbh,clrxm,CLRBH);
								CLJGWDSLSubtractcount(ssxmbh,CLRBH);
							}else{
								$.ligerDialog.error("重新汇报失败!");
							}
						}, 
						error:function (error) {
							$.ligerDialog.error("重新汇报失败!" + error.status,"error");
						}});
				});
			}else if(ISRESULT==1){
				var url = "bussiness/aviation/rwcl/jg_huibao.jsp?RWCLJGBH="+RWCLJGBH+"&ssxmbh="+ssxmbh;
				winOpen(url,' ',750,400,'确认','取消',function(data){
					$.ajax({
						url:"JG_huibao.action", 
						data:data,
						dataType:"json", 
						async : true,
						type:"post",
						success:function (mm) {
							if("success"==mm.result){
								$.ligerDialog.success("重新汇报成功!");
								sxcljg();
								getTaskCount(ssxmbh);
								CxhbtoMymessages(ssxmbh,clrxm,CLRBH);
								CLJGWDSLSubtractcount(ssxmbh,CLRBH);
							}else{
								$.ligerDialog.error("重新汇报失败!");
							}
						}, 
						error:function (error) {
							$.ligerDialog.error("重新汇报失败!" + error.status,"error");
						}});
				});
			}
		}
	});
}

//参考资料-预警信息(公共方法)
function ckzl_yjxx(item,yjList){
	//预警信息
	if(yjList.length>0){
		$(yjList).each(function(i, value){
			item +="<div class=\"item_style\" style=\"margin-bottom: 30px;\">";
			item +="<table width=\"99%;\">";
			item +="<tr><td rowspan=\"3\" style=\"width: 13%;text-align: center;\"><img src=\""+mypath+value.XP+"\"  style=\"width: 100px;height: 100px\"/></td>";
			item +="<td><span style=\"margin-right:20px;\">"+value.YJSJ+"&nbsp;</span>";
			item +="</td></tr>";
			item +="<tr style=\"border-bottom:1px solid #b2b2b2;color: #4A4A4A\">";
			item +="<td style=\"font-size: 19px;font-weight: bold;width: 30%;\"><span class=\"float_style\"  onclick=\"javascript:openDialogyj('"+ value.YJBH+ "','"+ value.SFCK+ "','"+value.BD_RYBH+"');\"  >"+value.YJNR+"</span></td>";
			item +="<td style=\"width: 20%;\"></td>";
			item +="<td style=\"font-size: 15px;font-weight: bold;width: 30%; text-align: right; margin-right: 23px;\">来源：<span   class=\"float_style\"  onclick=\"xcpcDetail('"+ value.YJLYBH+ "','"+ value.XM+ "','"+value.YJLY+"','"+value.BD_RYBH+"')\" >";
			item +="";
			if(value.YJLY=='inventoryinfo'){
				item +="现场盘查  >></span></td>";
			}else if(value.YJLY=='checkin'){
				item +="值机信息  >></span></td>";
			}else if(value.YJLY=='security'){
				item +="安检信息  >></span></td>";
			}else if(value.YJLY=='boarding'){
				item +="登机信息  >></span></td>";
			}
			item +="</tr><tr>";
			item +="<td style=\"font-size: 16px;color: #EF7844;\" colspan=\"2\"><span class=\"float_style\" style=\"margin-right: 10px;\" onclick=\"openDialog('"+ value.BD_RYBH+ "','"+ value.XM+ "')\">"+value.XM+"</span>";
			if(value.lsgkcount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
			}
			if(value.tjlkcount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
			}
			if(value.ztrycount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
			}
			if(value.wffzcount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
			}
			if(value.zjrycount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
			}
			if(value.siscount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
			}
			if(value.kssrycount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
			}
			if(value.qlzdcount > 0){
				item +="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
			}
			item +="</td>";
			item +"<td></td>";
			item += "<td style=\"font-size: 14px;text-align: right;margin-right: 23px;\"><span class=\"float_style\" onclick=\"getTaskes('"+value.YJBH+"','"+value.XM+"','"+value.YJYY+"','"+mypath+value.XP+"')\">发布任务 </span></td>";
			item += "</tr>";
			item += "</table>";
			item += "</div>";
		});
	}

	return item;
}
//参考资料-盘查信息(任务交流，处理结果的公共方法)
function ckzl_pcxx_other(item,pcList){
	//盘查信息
	if(pcList.length>0){
		$(pcList).each(function(i, value){
			item += "<div class=\"item_style\" style=\"margin-bottom: 30px;\">";
			item += "<div style=\"width:230px;height:90px;float:left;\">";
			item += "<table style=\"width:90%\">";
			item += "<tr><td align=\"center\" colspan=\"2\" style=\"padding-top:30px;\"><span style=\"font-size: 20px;color: #4d4d4d;\">"+value.CJSJ+"</span></td></tr>";
			item += "<tr><td align=\"center\" style=\"padding-top:12px;\"><span style=\"font-size: 16px; color: #4d4d4d;\">"+value.JCMC+"</span></td><td align=\"center\" style=\"text-align: left;padding-top:12px;\"><span style=\"font-size: 16px; color: #366cb3;\">"+value.CJRXM+"</span></td></tr>";
			item += "</table>";
			item += "</div>";
			item += "<div style=\"float:left;height:124px;width:1px;border-right:1px solid #b2b2b2\"></div>";
			item += "<div style=\"width:380px;float:left;\"><table style=\"width: 100%;\">";
			item += "<tr><td rowspan=\"4\" style=\"margin-right:20px;text-align: center;\"><img style=\"width:124px;height:124px;\" src=\""+mypath+value.XP+"\" id=\"userimg\"   class=\"controlps_img\" /></td>";
			item += "<td style=\"width:350px;border-bottom:1px solid #b2b2b2;margin-bottom:6px;  font-size: 19px;color: #EF7844;font-weight: bold;\"><span class=\"float_style\" style=\"vertical-align: middle;\" onclick=\"pancharenxq('"+value.PCBH+"','"+value.XM+"');\">"+value.XM+"</span><span>";
			if(value.lsgkcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
			}
			if(value.tjlkcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
			}
			if(value.ztrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
			}
			if(value.wffzcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
			}
			if(value.zjrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
			}
			if(value.siscount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
			}
			if(value.kssrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
			}
			if(value.qlzdcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
			}
			item += "</span><span class=\"td_value\">";
			item +="</span></td></tr>";
			item += "<tr style=\"margin-top:16px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">身份证号</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.SFZH+"</span></td>";
			item += "</tr><tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">户口地址</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.HKSZD+"</span></td></tr>";
			item += "<tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">民 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.MZMC+"</span></td></tr>";
			item += "</table></div>";
			item += "<div style=\"float:left;width:1px;height:124px;margin:0 10px;background-color: #b2b2b2;\"></div>";
			item += "<div><table style=\"width:120px;\"><tr style=\"width:100px;border-bottom:1px solid #b2b2b2;\"><td style=\"padding-bottom:12px;padding-top:10px;width:168px;color: #386CB5;\"><span class=\"float_style style_font\" " +
			"onclick=\"sb('"+value.PCBH+"')\">信息上报</span><span style=\"margin-left: 20px\" class=\"float_style\" onclick=\"fprw('"+value.XM+"','"+value.PCBH+"','"+value.GKLBMC+"')\">分配任务</span></td></tr><tr>";
			item += "<tr></table></div><div style=\"clear: both;\"></div>";
			item += "</div>";
		});
	}
	return item;
}
//参考资料-人员信息(公共方法)
function ckzl_ryxx(item,ryList){
	if(ryList.length>0){
		$(ryList).each(function(i, value){
			item += "<div class=\"item_style\" style=\"margin-bottom: 30px;\">";
			item +="<table style=\"width: 99%;\">";
			item +="<tr><td rowspan=\"5\"  style=\"width:10%;text-align: center;\"><img src=\""+mypath+value.XP+"\"   class=\"controlps_img\" /></td></tr>";
			item +="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  onclick=\"javascript:openDialog('"+ value.BD_RYBH+ "','"+value.XM+"')\"  class=\"float_style\" >"+value.XM+"</span><span class=\"td_value\" style=\"margin-left: 30px;font-size: 14px;\">";
			item += "</span></td><td><span><span id=\"oneSearch_bt\" class=\"gk_span\">"+value.GKLBMC +"</span>"+value.CJSJ+"&nbsp;&nbsp;&nbsp;"+value.CJRXM+"</span></td>";
			item +="<td><span style=\"color:#F07844;font-weight:bold;\">";
			if(value.ZT==0){
				item +="列控";
			}else if(value.ZT==1){
				item +="禁用";
			}else if(value.ZT==2){
				item +="申请启用中";
			}else if(value.ZT==3){
				item +="申请禁用中";
			}else if(value.ZT==4){
				item +="申请编辑中";
			}
			item += "</span></td></tr>";
			item +="<tr><td style=\"width: 31%\"><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"width: 38%\">户口地址：<span class=\"td_value dian\">"+value.HKSZDMC+"</span></td><td style=\"width: 28%\">出生日期：<span class=\"td_value_other\">"+value.CSRQ+"</span></td></tr><tr><td>护           照       号：<span class=\"td_value\">暂未开放</span></td><td>民      族：<span class=\"td_value\">"+value.MZMC+"</span></td><td>年      龄：<span class=\"td_value\">"+value.NL+"</span></td></tr>";
			item +="	<tr><td>通行证号：<span class=\"td_value\">暂未开放</span></td><td>性       别：<span class=\"td_value\">";
			if(value.XB==1){
				item += "男";
			}else if(value.XB==2){
				item += "女";
			}else{
				item += "";
			}
			item += "</span></td></tr></table></div>";	
		});
	}
	return item;
}
//参考资料-管控人员（公共方法）
function ckzl_gkxx(item,gkList){
	if(gkList.length>0){
		$(gkList).each(function(i, value){
			item += "<div class=\"item_style\" style=\"margin-bottom: 30px;\">";
			item +="<table style=\"width: 99%;\">";
			item +="<tr><td rowspan=\"5\"  style=\"width:10%;text-align: center;\"><img src=\""+mypath+value.XP+"\"   class=\"controlps_img\" /></td></tr>";
			item +="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  onclick=\"javascript:openDialog('"+ value.BD_RYBH+ "','"+value.XM+"')\"  class=\"float_style\" >"+value.XM+"</span><span class=\"td_value\" style=\"margin-left: 30px;font-size: 14px;\">";
			item += "</span></td><td><span><span id=\"oneSearch_bt\" class=\"gk_span\">"+value.GKLBMC +"</span>"+value.CJSJ+"&nbsp;&nbsp;&nbsp;"+value.CJRXM+"</span></td>";
			item +="<td><span style=\"color:#F07844;font-weight:bold;\">";
			if(value.ZT==0){
				item +="列控";
			}else if(value.ZT==1){
				item +="禁用";
			}else if(value.ZT==2){
				item +="申请启用中";
			}else if(value.ZT==3){
				item +="申请禁用中";
			}else if(value.ZT==4){
				item +="申请编辑中";
			}
			item += "</span></td></tr>";
			item +="<tr><td style=\"width: 31%\"><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"width: 38%\">户口地址：<span class=\"td_value dian\">"+value.HKSZDMC+"</span></td><td style=\"width: 28%\">出生日期：<span class=\"td_value_other\">"+value.CSRQ+"</span></td></tr><tr><td>护           照       号：<span class=\"td_value\">暂未开放</span></td><td>民      族：<span class=\"td_value\">"+value.MZMC+"</span></td><td>年      龄：<span class=\"td_value\">"+value.NL+"</span></td></tr>";
			item +="	<tr><td>通行证号：<span class=\"td_value\">暂未开放</span></td><td>性       别：<span class=\"td_value\">";
			if(value.XB==1){
				item += "男";
			}else if(value.XB==2){
				item += "女";
			}else{
				item += "";
			}
			item += "</span></td></tr></table></div>";	
		});
	}
	return item;
}
//参考资料-案事件（公共方法）
function ckzl_asjxx(item,asjList){
	if(asjList.length>0){
		$(asjList).each(function(i,value){
			item += "<div class=\"item_style\" style=\"margin-bottom: 30px;\">";
			item += "<table style=\"text-align:center;margin-top: 10px;margin-bottom: 10px;width:98%; line-height: 30px;\">";
			item += "<tr><td width=\"5%\" rowspan=\"5\"> <input type=\"checkbox\" id=\"flightcheck\" /></td>";
			item += "<td style=\"text-align:left;\" colspan=\"5\"><span  style=\"color: #EF7844;font-size: 18px;padding: 0px 10px ;color: white;background-color: #EF7844;border-radius:2px;margin-right: 12px;\">"+value.AJLBMC+"</span>";
			item += "<span style=\"font-size: 18px;\">"+value.MC+"</span></td></tr><tr style=\"font-size: 17px;border-bottom:1px solid  #b2b2b2;\">";
			item +=	"<td colspan=\"2\" style=\"text-align:left;\" ><span style=\"margin-right: 90px;\">"+value.HBSJ+"</span><span style=\"color: #386CB5;\">"+value.HBH+"</span></td>";
			item += "<td  colspan=\"2\" style=\"text-align:center;\"><span style=\"margin:0px 20px;\">"+value.DEPT+"</span><span class=\"td_text\">---></span><span style=\"margin:0px 20px;\">"+value.DEST+"</span></td>";
			item +=	"<td style=\"text-align:right;\"	><span style=\"margin-right: 10px;color: #386CB5;\" class=\"float_style\" onclick=\"addAj('"+value.HBH+"','"+value.HBSJ+"','"+value.DEPT+"','"+value.DEST+"')\">添加案事件</span></td></tr>";
			item += "<tr style=\"text-align:left;line-height: 20px;\"><td style=\"width: 30%;\"><span class=\"td_text\">报&nbsp;&nbsp;案&nbsp;&nbsp;人</span><span class=\"td_value\">"+value.BARXM +"</span></td>";
			item += "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:50px;background-color: #b2b2b2;\"></div></td>";
			item += "<td style=\"width: 30%;\"  class=\"td_text\">报案时间<span class=\"td_value\">"+value.AFSJ+"</span></td>";
			item += "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:50px;background-color: #b2b2b2;\"></div></td><td style=\"width: 30%;\" class=\"td_text\">案件详情</td></tr>";
			item += "<tr style=\"text-align:left;line-height: 20px;\"><td  class=\"td_text\">身份证号<span class=\"td_value\">"+value.BARSFZHM+"</span></td><td  class=\"td_text\">报案地点<span class=\"td_value\">"+value.AFDD+"</span></td>";
			item += "<td class=\"td_value\" rowspan=\"2\" style=\"text-align: left;\"><span>"+value.ZYAQ +"</span></td></tr>";
			item += "<tr style=\"text-align:left;line-height: 20px;\"><td  class=\"td_text\">联系电话<span class=\"td_value\">"+value.BARLXDH+"</span></td></tr></table></div>";
		});
	}
	return item;

}
//向任务执行人（任务创建人）发送任务交流消息提醒
function RwjltoMymessages(rwid){
	$.ajax({
		url:"RwjltoMymessages.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async : true,
		success:function (mm) {}, 
		error:function (error) {
			top.my_alert("发送任务交流消息提醒失败!" + error.status,"error");
		}
	});
}
//向任务执行人（任务创建人）发送处理结果消息提醒
function CljgtoMymessages(rwid){
	$.ajax({
		url:"CljgtoMymessages.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async : true,
		success:function (mm) {}, 
		error:function (error) {
			top.my_alert("发送处理结果消息提醒失败!" + error.status,"error");
		}
	});
}
//点击重新汇报，消息提醒上报人
function CxhbtoMymessages(rwid,clrxm,CLRBH){
	$.ajax({
		url:"CxhbtoMymessages.action",
		data:"rwid="+rwid+"&clrxm="+clrxm+"&CLRBH="+CLRBH,
		type:"post",
		dataType:'json',
		async : true,
		success:function (mm) {
			if("success"==mm.result){
				$.ligerDialog.success("消息提醒成功!");
			}else{
				$.ligerDialog.error("消息提醒失败!");	
			}
		}, 
		error:function (error) {
			top.my_alert("消息提醒上报人失败!" + error.status,"error");
		}
	});

}
//点击发表成功后 ,消息提醒这条任务交流信息的发布人
function PingluntoMymessages(rwid,FCZBH,CJZMC){
	$.ajax({
		url:"PingluntoMymessages.action",
		data:"rwid="+rwid+"&FCZBH="+FCZBH+"&CJZMC="+CJZMC,
		type:"post",
		dataType:'json',
		async : true,
		success:function (mm) {
			if("success"==mm.result){
				$.ligerDialog.success("消息提醒成功!");
			}else{
				$.ligerDialog.error("消息提醒失败!");	
			}
		}, 
		error:function (error) {
			top.my_alert("消息提醒失败!" + error.status,"error");
		}
	});
}
//每添加一条跟进任务，数量+1
function RWJLWDSLAddcount(rwid){
	$.ajax({
		url:"RWJLWDSLAddcount.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:true,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("跟进任务，数量+1失败!" + error.status,"error");
		}
	});
}
//每添加一条结果汇报，数量+1
function CLJGWDSLAddcount(rwid){
	$.ajax({
		url:"CLJGWDSLAddcount.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:true,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("结果汇报，数量+1失败!" + error.status,"error");
		}
	});

}
//登录人点击后，跟进任务未读数量更新为0
function RWJLCountToZero(rwid){
	$.ajax({
		url:"RWJLCountToZero.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:true,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("跟进任务未读数量更新为0失败!" + error.status,"error");
		}
	});

}
//登录人点击后，结果汇报未读数量更新为0
function CLJGCountToZero(rwid){
	$.ajax({
		url:"CLJGCountToZero.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:true,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("结果汇报未读数量更新为0失败!" + error.status,"error");
		}
	});

}
//获取跟进任务未读数量,结果汇报未读数量
function getrwjlwdCount(rwid){
	$.ajax({
		url:"QueryrwjlwdCount.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:false,
		success:function(data){
			var mm = data.usernreadcountModel;
			if(mm.RWJLWDSL > 0){
				if(mm.RWJLWDSL > 99){
					document.getElementById('rwjlround_s').style.display = 'none';//隐藏_s
				}else{
					$("#rwjlwdCount").html(mm.RWJLWDSL);
					document.getElementById('rwjlround_l').style.display = 'none';//隐藏_l
				}

			}else{
				document.getElementById('rwjlround_s').style.display = 'none';
				document.getElementById('rwjlround_l').style.display = 'none';
			}
			if(mm.CLJGWDSL > 0){
				if(mm.CLJGWDSL > 99){
					document.getElementById('jghbround_s').style.display = 'none';//隐藏_s
				}else{
					$("#jghbwdCount").html(mm.CLJGWDSL);
					document.getElementById('jghbround_l').style.display = 'none';//隐藏_l
				}

			}else{
				document.getElementById('jghbround_l').style.display = 'none';
				document.getElementById('jghbround_s').style.display = 'none';
			}

		},
		error:function(error){
			top.my_alert("获取跟进任务未读数量,结果汇报未读数量失败!" + error.status,"error");
		}
	});
}
//每次重新汇报成功后，结果汇报数量-1
function CLJGWDSLSubtractcount(rwid,CLRBH){
	$.ajax({
		url:"CLJGWDSLSubtractcount.action",
		data:"rwid="+rwid+"&CLRBH="+CLRBH,
		type:"post",
		dataType:'json',
		async:true,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("每次重新汇报成功后,数量-1失败!" + error.status,"error");
		}
	});

}
//任务催办成功后数量添加+1
function addTiXbyAscending(rwid){
	$.ajax({
		url:"addTiXbyAscending.action",
		data:"rwid="+rwid,
		type:"post",
		dataType:'json',
		async:false,
		success:function(mm){

		},
		error:function(error){
			top.my_alert("任务催办成功后添加+1失败!" +error.status,"error");

		}

	});
}
//来源详情
function xcpcDetail(yjlybh,xm,type){
	var url = "";
	if("inventoryinfo" == type){
		url = "pcxxMess.action?pcbh=" + yjlybh;
		var tabid = "PCLB" + "-" + yjlybh;
		this.parent.f_click(tabid,xm,mypath + url);
	}else if("checkin" == type || "security" == type || "boarding" == type){
		url = "flightQueryAllList.action?page=1&pagesize=10&lkid=" + yjlybh;
		var tabid = type + "LB-" + yjlybh;
		this.parent.f_click(tabid,xm,mypath + url);
	}

} 
//分配任务
function getTaskes(itemid,name,gklbmc,userimg){
	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+itemid+"&itemtype=earlywarning&name="+name+"&gklbmc="+gklbmc+"&userimg="+userimg+"&fbrw=fbrw";
	window.top.my_openwindow(itemid+"zy",url,630,600,"发布任务");
}
//点击盘查人进入详情
function pancharenxq(id,xm){
	var url = mypath+"pcxxMess.action?pcbh="+id;
	var tabid = "PCLB" + "-" + id;
	this.parent.f_click(tabid,xm,url);
}
/**上报信息 */
function sb(pcbh){
	var url = mypath+"bussiness/aviation/xcpc/pclb/ShangbaoxxAdd.jsp?pcbh="+pcbh;
	winOpen(url, "信息上报", 560,420, '提交', '取消', function(data, dialog) {
		$.ajax({
			url:"shangbao.action", 
			data:data,
			dataType:"json", 
			type:"post",
			success:function (mm) {
				if("error"==mm.result){
					top.my_alert("上报失败!","error");
				}else{
					top.my_alert("上报成功!","success");
					window.top.my_closewindow();
				}
			}, 
			error:function (error) {
				top.my_alert("上报失败!" + error.status,"error");
			}});
	});
}
/**分配任务*/
function fprw(ryxm,pcbh,gklbmc){
	var userimg=$("#userimg").attr("src");
	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+pcbh+"&itemtype=inventorys&name="+ryxm+"&gklbmc="+gklbmc+"&userimg="+userimg;
	window.top.my_openwindow("",url,630,600,"发布任务");

}
//参考资料-盘查信息(公共方法)
function ckzl_pcxx(item,pcList){
	//盘查信息
	if(pcList.length>0){
		$(pcList).each(function(i, value){
			item += "<div class=\"item_style\" >";
			item += "<div style=\"width:230px;height:100px;float:left;\">";
			item += "<table style=\"width:100%\">";
			item += "<tr><td align=\"center\" colspan=\"2\" style=\"padding-top:40px;\"><span style=\"font-size: 20px;color: #4d4d4d;\">"+value.CJSJ+"</span></td></tr>";
			item += "<tr><td align=\"center\" style=\"padding-top:16px;\"><span style=\"font-size: 18px; color: #4d4d4d;\">"+value.JCMC+"</span></td><td align=\"center\" style=\"text-align: left;padding-top:16px;\"><span style=\"font-size: 18px; color: #366cb3;\">"+value.CJRXM+"</span></td></tr>";
			item += "</table>";
			item += "</div>";
			item += "<div style=\"float:left;height:124px;width:1px;border-right:1px solid #b2b2b2\"></div>";
			item += "<div style=\"width:500px;float:left;\"><table style=\"width: 100%;\">";
			item += "<tr><td rowspan=\"4\" style=\"margin-right:20px;text-align: center;\"><img style=\"width:124px;height:124px;\" src=\""+mypath+value.XP+"\" id=\"userimg\"   class=\"controlps_img\" /></td>";
			item += "<td style=\"width:350px;border-bottom:1px solid #b2b2b2;margin-bottom:6px;  font-size: 19px;color: #EF7844;font-weight: bold;\"><span class=\"float_style\" style=\"vertical-align: middle;\" onclick=\"pancharenxq('"+value.PCBH+"','"+value.XM+"');\">"+value.XM+"</span><span>";
			if(value.lsgkcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
			}
			if(value.tjlkcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
			}
			if(value.ztrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
			}
			if(value.wffzcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
			}
			if(value.zjrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
			}
			if(value.siscount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
			}
			if(value.kssrycount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
			}
			if(value.qlzdcount > 0){
				item += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
			}
			item += "</span><span class=\"td_value\">";
			item +="</span></td></tr>";
			item += "<tr style=\"margin-top:16px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">身份证号</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.SFZH+"</span></td>";
			item += "</tr><tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">户口地址</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.HKSZD+"</span></td></tr>";
			item += "<tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">民 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.MZMC+"</span></td></tr>";
			item += "</table></div>";
			item += "<div style=\"float:left;width:1px;height:124px;margin:0 10px;background-color: #b2b2b2;\"></div>";
			item += "<div><table><tr style=\"border-bottom:1px solid #b2b2b2;\"><td style=\"padding-bottom:12px;padding-top:10px;width:168px;color: #386CB5;\"><span class=\"float_style style_font\" " +
			"onclick=\"sb('"+value.PCBH+"')\">信息上报</span><span style=\"margin-left: 20px\" class=\"float_style\" onclick=\"fprw('"+value.XM+"','"+value.PCBH+"','"+value.GKLBMC+"')\">分配任务</span></td></tr><tr>";
			item += "<tr></table></div><div style=\"clear: both;\"></div>";
			item += "</div>";
		});
	}
	return item;
}
//点击名字进入详情
function openDialog(BD_RYBH,casename) {
	var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + BD_RYBH+"&casename="+casename;
	var tabid = "GDPJ" + "-" + BD_RYBH;
	this.parent.f_click(tabid,casename,url);
}

//弹出页面
function winOpen(url,title,width,height,button1,button2,callback) {
	window.top.$.ligerDialog.open({width:width,height:height,url:url,title:title,
		buttons:[{text:button1,onclick:function(item, dialog) {
			var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
			var data = fn();
			if (data) {
				callback(data);
				dialog.close();
			}
		}
		},{
			text:button2,
			onclick:function(item, dialog) {
				dialog.close();
			}
		} ]
	});
}