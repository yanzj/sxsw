var page = 1;
var mypath;
var isend = false; //判断当加载完成时，滚动条滑动不在加载数据
var loading = false;  //判断单次加载数据是否完成
var order_type='order_gzsj'; //排序类别，默认为order_gzsj
jQuery(function($){
	gklbList();
	mzList();
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	mypath = $("#mypath").val();
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
		var maxwidth=20;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+'···');
		}
	});
});
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page += 1;
			loading = true;
			search_or_more(page,'more',order_type);
		}
	}
});
//按不同方式排序
function order_onclick(item_type,item_value){
	$("#dadiv").html("");
	$("#div_sort div").css("color", "#386CB5");
	$("#div_sort #jt").remove();
	
	//重新赋值
	$("#"+item_type).css("color", "#FC9B71");
	$("#"+item_type).html(item_value);
	$("#"+item_type).append("<span id=\"jt\">↓</span>");
	page=1;
	isend=false;
	order_type=item_type;
	if(!loading){
		loading = true;
		search_or_more(page,'search',order_type);
	}
}

//条件搜索
function search(){
	var radio = $('input:radio[name="radio"]:checked').val();
	//获取开始结束时间
	var starttime="";
	var endtime="";
	if(radio=='time'){
		 starttime = $("#starttime").val();  //开始时间
		 endtime = $("#endtime").val();      //结束时间
		 if(endtime < starttime){
			top.my_alert("结束时间不能小于开始时间!","warn");
			return ;
		 }
	}
	page = 1;
	isend = false;
	$("#dadiv").html('');
	if(!loading){
		loading = true;
		search_or_more(page,'search',order_type);
	}
}
//数据加载
function search_or_more(page,type,order_type){
	//进入页面提示文字
    $("#div_btm").hide(); 
    
    //友好提示文字
    $("#loadover").show();
	$("#loadover").html('正在加载中...');
	
	var name = $("#name").val().trim();  //人员姓名
	if("请输入关注人姓名关键词"==name){
		name = "";
	}
	var lb = $("#lb").val();  //案件类型
	var mz = $("#mz").val();  //民族
	var value = $("#search_value").val().trim();
	if("请输入搜索关键词"==value){
		value = "";
	}
	//获取单选框值
	var radio = $('input:radio[name="radio"]:checked').val();
	//获取开始结束时间
	var starttime="";
	var endtime="";
	if(radio=='time'){
		 starttime = $("#starttime").val();  //开始时间
		 endtime = $("#endtime").val();      //结束时间
	}
	
	 //获取数据来源
	var source=$('#source').val();
	$.ajax({
		url:"payattentionListByUseridMore.action",
		data:"page="+page+"&pagesize=10&starttime="+starttime+"&endtime="+endtime+"&radio="+radio+"&name="+name+"&mz="+mz+"&lb="+lb+"&value="+value+"&source="+source+"&order_type="+order_type,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			//加载更多
			if(type=='more'&&value.length==2){
			    $("#loadover").show();
			    $("#loadover").html('数据加载完成');
			    isend = true;
			    loading = false;
			    return;
			}
			//搜索
			else if(type=='search'&&value.length==2){
			    $("#loadover").show();
			    $("#loadover").html('暂无数据');
			    loading = false;
			    return;
			}else{
				$("#loadover").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
				   $("#loadover").show();
				   $("#loadover").html('数据加载完成');
				   isend=true;
				}
				$(objArray).each(function(i,value){
					var item1 = "<div class=\"item_style\">";
					var item2="<table style=\"width: 98%;\">";
					var itemcheck="";
					//当来源为添加任务时 显示复选框
					if(source=='rwcl'){
					  if(value.ISCHECK){
						  itemcheck="<tr><td width=\"3%\" rowspan=\"6\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  checked=\"checked\"  value='"+value.RYBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/></td></tr>";
					  }else{
						  itemcheck="<tr><td width=\"3%\" rowspan=\"6\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  value='"+value.RYBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/></td></tr>";
					  }
					}
					var item3="<tr><td rowspan=\"5\"  style=\"width:13%;text-align: center;\"><img src=\""+value.XP+"\"   class=\"controlps_img\" /></td></tr>";
					var item4="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  class=\"my_info\" onclick=\"javascript:openDialog('"+ value.BD_RYBH+ "','"+value.XM+"');\">"+value.XM+"</span><span class=\"td_value\" style=\"margin-left: 30px;font-size: 14px;\">";
					if(value.GZBH!=""){
						item4 += "<img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />";
					}else{
						item4 += "<img src=\""+mypath+"images/common/fkweb_eyesongrey.png\" />";
					}
					item4 += "</span></td><td><span id=\"oneSearch_bt\" class=\"gk_span\">"+value.GKLBMC+"</span><span style=\"margin-left:10px;\">"+value.CJSJ+"&nbsp;&nbsp;&nbsp;"+value.CJRXM+"</span></td><td><span style=\"color:#F07844;font-weight:bold;\">" ;
					if(value.ZT==0){
						item4 += "列控";
					}else if(value.ZT==1){
						item4 += "禁用";
					}else if(value.ZT==3){
						item4 += "申请启用中";
					}else if(value.ZT==3){
						item4 += "申请禁用中";
					}else if(value.ZT==4){
						item4 += "申请编辑中";
					}
					item4 += "</span></tr>";
					var item5="<tr><td style=\"width: 25%\"><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"width: 30%\">户口地址：<span class=\"td_value dian\">"+value.HKSZDMC+"</span></td><td style=\"width: 20%\">出生日期：<span class=\"td_value\">"+value.CSRQ+"</span></td></tr><tr><td>护           照       号：<span class=\"td_value\">暂未开放</span></td><td>民      族：<span class=\"td_value\">"+value.MZMC+"</span></td><td>年      龄：<span class=\"td_value\">"+value.NL+"</span></td></tr>";
					var item6="<tr><td>通行证号：<span class=\"td_value\">暂未开放</span></td><td>性       别：<span class=\"td_value\">";
					if(value.XB==1){
						 item6 += "男";
					}else if(value.XB==2){
						 item6 += "女";
					}else if(value.XB==9){
						 item6 += "未知性别";
					}
					var item7="</span></td></tr></table>";			
					var item8="</div>";	
					$("#dadiv").append(item1+item2+itemcheck+item3+item4+item5+item6+item7+item8);
				});
				//限制字符个数
				$(".dian").each(function(){
					var maxwidth=20;
					if($(this).text().length>maxwidth){
						$(this).text($(this).text().substring(0,maxwidth));
						$(this).html($(this).html()+'···');
					}
				});
				loading = false;
			}
		}
	});
}
//管控类型
function gklbList(){
	 $.ajax({
		url:"loadTsdict.action",
		data:"sszdlx=GKLB",
		dataType:"json",
		beforeSend:function(){
			$("#lb").append("<option  selected='selected' value='"+-1+"'>"+"正在加载中,请稍候..."+"</option>");
		},
		success:function(data){
			$("#lb").empty();
			var text = "<option selected=\"selected\" value=''>--请选择管控类别--</option>";
		    $.each(data,function(n,value) {  
			    text +="<option value='"+value.id+"'>"+value.text+"</option>";
		    });
		    $("#lb").append(text);
		}
     });
}
//民族
function mzList(){
	 $.ajax({
		 url:"loadTsdict.action",
		 data:"sszdlx=GA_MZ",
		dataType:"json",
		beforeSend:function(){
			$("#mz").append("<option  selected='selected' value='"+-1+"'>"+"正在加载中,请稍候..."+"</option>");
		},
		success:function(data){
			$("#mz").empty();
			var text = "<option selected=\"selected\" value=''>--请选择民族--</option>";
		    $.each(data,function(n,value) {  
		    	text +="<option value='"+value.id+"'>"+value.text+"</option>";
		    });
		    $("#mz").append(text);
		}
     });
}


/**
选择函数 当模块打开的方式来源于任务模块
*/
function f_select() {
	var checkboxs = "";
	//复选框选中的预警信息列表
	$("input[name='sourcecheck']").each(function() {
		//获取选中的checkbox
		if ($(this).attr('checked') == true) {
			checkboxs += $(this).val() + ":-:";
		}
	});
	data = checkboxs;
	return data;
}
//点击名字进入详情
function openDialog(BD_RYBH,casename) {
	var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + BD_RYBH+"&casename="+casename;
	var tabid = "GDPJ" + "-" + BD_RYBH;
	this.parent.f_click(tabid,casename,url);
}
//选择时间段默认禁用，点击后取消禁用、取消样式
function undisable(type){
	if(type=="time"){
       $("#starttime").removeClass("style_disable");
       $("#starttime").attr("disabled",false);
       $("#endtime").removeClass("style_disable");
       $("#endtime").attr("disabled",false);
	}else{
	   $("#starttime").addClass("style_disable");
       $("#starttime").attr("disabled",true);
       $("#endtime").addClass("style_disable");
       $("#endtime").attr("disabled",true);
	}
}
