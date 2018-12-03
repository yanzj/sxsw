var page = 1;//当前页面
var rybh;
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var mypath;
var loading = false;  //判断单次加载数据是否完成
jQuery(function ($){
	rybh = $("#rybh").val();
	mypath = $("#mypath").val();
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
});
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			getConaction(page,rybh);
		}
	}
});

/**
 * 查询联系信息
 * @param age
 */
function getConaction(age,id){
	$("#lx_div").html();
	//进入页面提示文字
	$("#div_btm").hide(); 
	//友好提示文字
	$("#loadover").show();
	$("#loadover").html('正在加载中...');
	$.ajax({
		url:"contactionQueryListMore.action",
		data:"bd_rybh="+id+"&page="+age+"&pagesize=10", 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			var value = mm.msg;
			//加载更多
			if(value.length==2){
				$("#loadover").show();
				$("#loadover").html('数据加载完成');
				isend = true;
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
					var item = "<div style=\"padding-left:20px;padding-top:13px;height: 60px;\" onmouseover=\"this.className='div_table_over'\" onmouseout=\"this.className='div_table_out'\">";
					item+="<table style=\"font-size:14px;\">";
					item+="<tr style=\"height: 20px;line-height: 20px;\">";
					item+="<td rowspan=\"3\" style=\"width: 28px;color:#ef7844;font-weight: bold;\"><span>"+(i+1+(age-1)*10)+"</span></td>";
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
				loading = false;
			}
		}, 
		error:function (error) {
			top.my_alert("获取单个信息失败****" + error.status);
		}
	});
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
					page = 1;
					getConaction(page,rybh);
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