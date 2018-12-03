var mypath;
var page = 1;//当前页面
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var loading = false;//判断单次加载数据是否完成
jQuery(function($){
	mypath = $("#mypath").val();
	mzQueryList();     //获取民族下拉框值
	GKLBBHQueryList(); //获取人员类别下拉框值
	//文本框默认值点击后清空，移除点击后又赋给默认值
	$("input[holder]").each(function(){
		var $this = $(this);
		$this.addClass("holder");
		$this.val($this.attr("holder"));
	}).live("focusin",function(){
		var $this = $(this);
		if($this.val()==$this.attr("holder")){
			$this.removeClass("holder");
			$this.val("");
		}
	}).live("focusout",function(){
		var $this = $(this);
		if($this.val()==""){
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	}); 

	//限制字符个数
	$(".dian").each(function(){
		var maxwidth=18;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+'····');
		}
	});

	//鼠标移上去变色
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});

	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			search();
		}
	});
});

//搜索
function search(){
	var begintime = $("#begintime").val();  //开始时间
	var endtime = $("#endtime").val();      //结束时间
	if(endtime < begintime){
		top.my_alert("结束时间不能小于开始时间!","warn");
		return ;
	}
	$("#dadiv").html('');
	page=1;
	isend=false;
	if(!loading){
		loading = true;
		search_or_more(page,'search');
	}
}
//加载更多
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			search_or_more(page,'more');
		}
	}
});

//搜索/加载更多
function search_or_more(page,type){
	//进入页面提示文字
	$("#div_btm").hide();  

	//友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');
	var data = "page="+page+"&pagesize=10";
	var GKLBMC = $("#LKLB").val();   //人员类别
	var GMSFZHM=$("#SFZH").val().trim();  //身份证号
	var RYXM=$("#XM").val().trim();     //姓名
	data += "&GKLBMC="+GKLBMC+"&GMSFZHM="+GMSFZHM+"&RYXM="+RYXM;
	var RYXB=$("#XB").val().trim();     //姓别
	var MZMC = $("#MZ").val();         //民族
	var ZZXZ=$("#ZZXZ").val().trim();  //住址
	var cjrxm = $("#cjrxm").val().trim();   //申请人
	data += "&RYXB=" + RYXB+"&MZMC="+MZMC+"&ZZXZ="+ZZXZ+"&cjrxm="+cjrxm;
	var province = $("#province").val();//省份
	var city = $("#city").val();	//地区
	var county = $("#county").val();//县市
	data += "&province="+province+"&city="+city+"&county="+county;
	//获取多选框的值
	var checkbox="";
	$("input:checkbox[name='checkbox']:checked").each(function() {
		checkbox += $(this).val() + ",";
	});
	//选择时间段
	var begintime = $("#begintime").val();  //开始时间
	var endtime = $("#endtime").val();      //结束时间
	if(begintime!=null){
		$("#time").attr("checked",true);
	}
	//获取单选框值
	var radio = $('input:radio[name="radio"]:checked').val();
	data += "&checkbox="+checkbox+"&radio="+radio+"&begintime="+begintime+"&endtime="+endtime,
	$.ajax({
		url:"gdjzApprovalsQueryList.action",
		data:data,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			//加载更多
			if(type=='more' && value .length==2){
				$("#div_bottom").show();
				$("#div_bottom").html('数据加载完成');
				isend=true;
				loading = false;
				return;
			}
			//搜索
			else if(type=='search' && value.length==2){
				$("#div_bottom").show();
				$("#div_bottom").html('暂无数据');
				loading = false;
				return;
			}else{
				$("#div_bottom").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#div_bottom").show();
					$("#div_bottom").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function (i, value) { 
					var item1 = "<div class=\"item_style\">";
					var item2="<table>";
					var item3="<tr><td  rowspan=\"5\" width=\"10%;\"><img class=\"controlps_img\" src=\""+value.XP+"\"  class=\"controlps_img\" /></td></tr>";
					var item4="<tr><td width=\"28%;\" style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  class=\"my_info\" onclick=\"openDialog('"+value.SPDXBH+"','"+value.XM+"')\">"+value.XM+"</span></td><td style=\"width:32%;\"><span id=\"oneSearch_bt\" class=\"gk_span\" style=\"display: none;\">"+value.GKLBMC+"</span><span>申请时间：</span><span class=\"td_value\">"+value.CJSJ+"&nbsp;&nbsp;&nbsp; <span style = \"color:#007EE2;\" class = \"my_info\" onclick=\"getCJRXM('"+value.CJRXM+"')\">"+value.CJRXM+"</span></span></td>";
					var item5="";
					if(value.countSFCZ == 0){
						item5 += "<td class = \"my_info\" style=\"text-align:center;color:#007EE2;font-weight:bold;\" >已操作</td></tr>";
					}else{
						item5 += "<td class = \"my_info\" style=\"text-align:center;color:red;font-weight:bold;\" >未操作</td></tr>";
					}
					
					
					var item6="<tr><td><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"width: 30%\">出生日期：<span class=\"td_value\">"+value.CSRQ+"</span></td>";
					var item7="";
					if(value.SPZT=='0'){
						item7 += "<td colspan=\"2\" style=\"width:20%;text-align:center\">未审批</td></tr>";
					}
					if(value.SPZT=='1'){
						item7 += "<td colspan=\"2\" style=\"width:20%;text-align:center\">审批中</td></tr>";                      
					}
					if(value.SPZT=='2'){
						item7 += "<td colspan=\"2\" style=\"width:20%;text-align:center\">已拒绝</td></tr>";
					}
					if(value.SPZT=='3'){
						item7 += "<td colspan=\"2\" style=\"width:20%;text-align:center\">已批准</td></tr>"; 
					}
					if(value.SPZT=='4'){
						item7 += "<td colspan=\"2\" style=\"width:20%;color:#ef7844;font-weight:bold;text-align:center\">打回修改</td></tr>";
					}
					var item8="</tr><tr><td>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：<span class=\"td_value\">"+value.MZMC+"</span></td><td>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：<span class=\"td_value\">"+value.NL+"</span></td><td></td></tr>";
					var item9="";
					item9+="<tr><td>户口地址：<span class=\"dian td_value\">"+value.HKSZD+"</span></td>";
					item9+="<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：";
					if(value.XB=='1'){
						item9+="<span class=\"td_value\">男</span>";
					}
					if(value.XB=='2'){
						item9+="<span class=\"td_value\">女</span>";
					}
					if(value.XB=='9'){
						item9+="<span class=\"td_value\">未知</span>";
					}
					item9+="</td></tr>";
					var item10=" </table>";			
					var item11="</div>";

					$("#dadiv").append(item1 +item2+item3+item4+item5+item6+item7+item8+item9+item10+item11);
				});
				//限制字符个数
				$(".dian").each(function(){
					var maxwidth=18;
					if($(this).text().length>maxwidth){
						$(this).text($(this).text().substring(0,maxwidth));
						$(this).html($(this).html()+'····');
					}
				});
				loading = false;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("数据加载失败！" + error.status,"错误");
		}
	});
}


/**点击需审批人进入详情*/
function openDialog(itemid,itemdesc) {
	window.parent.f_click(itemid,itemdesc,mypath + "bussiness/aviation/grsz/approvalsObject/ApprovalsEdit.jsp?spdxbh=" + itemid);
}

//上控人基本信息
function getCJRXM(cjrbh){
	if(cjrbh==null){
		cjrbh=$("#CJRBH").val();
	}
	var url = mypath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上控人详情信息");
}
//获取民族下拉框
function mzQueryList() {
	$.ajax({
		url : "loadTsdict.action",
		data: "sszdlx=GA_MZ",
		dataType : "json",
		async : true,
		type:"post",
		beforeSend : function() {
			$("#MZ").append("<option  selected='selected' value='" + -1 + "'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#MZ").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"\">--请选择民族--</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#MZ").append(text);
		}
	});
}
//获取管控类别下拉框
function GKLBBHQueryList() {
	$.ajax({
		url : "loadTsdict.action",
		data:"sszdlx=GKLB",
		dataType : "json",
		async : true,
		type:"post",
		beforeSend : function() {
			$("#LKLB").append("<option  selected='selected' value='" + -1 + "'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#LKLB").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"\">--请选择列控类别--</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#LKLB").append(text);
		}
	});
}
//选择时间段默认禁用，点击后取消禁用、取消样式
function undisable(type){
	if(type=="time"){
		$("#begintime").removeClass("style_disable");
		$("#begintime").attr("disabled",false);
		$("#endtime").removeClass("style_disable");
		$("#endtime").attr("disabled",false);
	}else{
		$("#begintime").addClass("style_disable");
		$("#begintime").attr("disabled",true);
		$("#endtime").addClass("style_disable");
		$("#endtime").attr("disabled",true);
	}
}

