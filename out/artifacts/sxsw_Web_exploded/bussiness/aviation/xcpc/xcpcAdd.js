var pcjgbh;
var pcbh;
jQuery(function($) {
	pcbh = $("#pcbh").val();
	pcjgbh = $("#pcjgbh").val();
	if(pcjgbh ==""){
		pcjgbh = $("#id").val();
//		$("#subbutton").click(function(){
//			add();
//		});
	}else{
		getMess(pcbh);
//		$("#subbutton").click(function(){
//			update();
//		});
	}
});

function upload(){
	openFileUploadImages(pcjgbh,"interrogations");
}

//根据盘查结果编号查询盘查结果信息
function getMess(id){
	$.ajax({
		url:"fingPcjgById.action", 
		data:"pcbh="+id, 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			$("#txry").val(mm.TXRY); //同行人员
			$("#sjhm").val(mm.SJHM); //电话号码
			$("#zzdz").val(mm.ZZDZ); //暂住地址
			$("#gzqk").val(mm.GZQK); //工作情况
			$("#xdwp").val(mm.XDWP); //携带物品
			$("#jtgj").val(mm.JTGJ); //交通工具
			$("#cxmd").val(mm.CXMD); //出行目的
			$("#cfd").val(mm.CFD); //出发地
			$("#mdd").val(mm.MDD); //目的地
			$("#czhbxx").val(mm.CZHBXX); //航班信息
			$("#hbh").val(mm.HBH); //航班编号
			$("#hbsj").val(mm.HBSJ); //航班时间
			$("#bzxx").val(mm.BZXX); //备注信息
			
			//附件显示
			$("#image").empty();  //图片
			$("#voice").empty();  //语音
			var mypath = $("#mypath").val();
			var att = mm.attlist;
			$.each(att,function(index,item){
				var oclick="attDelete('"+item.FJBH+"','"+item.SSXMBH+"','"+item.SSXM_TYPE+"');";
				var bder="0";
				var hurl="javascript:void(0)";
				var fwqlj = item.FWQLJ;
				var filenameArrimg = fwqlj.substring(fwqlj.lastIndexOf("////")+1, fwqlj.length);
				if(fwqlj.indexOf("filenotfound") > 0){
					fwqlj = fwqlj.substring(10);
				}else{
					fwqlj = fwqlj.substring(34);
				}
				var fwq =fwqlj.split("\\\\");
				var fwqname = fwq[fwq.length-1];
				var url = mypath + item.FWQLJ;
				var filenameArr = fwqname.split(".");
				var str = "";
				if(filenameArr[1].toUpperCase() == "AMR"){
					url = url.replace(".amr",".mp3");
					str="<a href="+url+" target=\"_blank\" onclick=\"editor('"+filenameArrimg+"')\">"+item.SCSDWJM+"</a>  <a href="+hurl+" onclick="+oclick+"  border="+bder+" >reco<img   border="+bder+" title=\"删除\" src=\""+mypath+"/images/delete.png\"/></a>;&nbsp;";
					$("#voice").append(str);
				}else{
					str="<a href="+url+" target=\"_blank\">"+item.SCSDWJM+"</a>  ";
					str="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\"><img src=\""+url+"\" style=\"width: 100px;height: 100px\" /><img src=\""+mypath+"/images/common/fkweb_closeicon.png\" onclick="+oclick+" style=\"position:absolute;top:0;right:0; margin-top: 5px;margin-right:5px;width: 15px;height: 15px;\"/></div>";
					$("#image").append(str);
				}
			});
		}, 
		error:function (error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}

//提交数据
function f_validate(){
	var txry = $("#txry").val(); //同行人员
	var sjhm = $("#sjhm").val(); //电话号码
	var zzdz = $("#zzdz").val(); //暂住地址
	var gzqk = $("#gzqk").val(); //工作情况
	var xdwp = $("#xdwp").val(); //携带物品
	var jtgj = $("#jtgj").val(); //交通工具
	var cxmd = $("#cxmd").val(); //出行目的
	var cfd = $("#cfd").val(); //出发地
	var mdd = $("#mdd").val(); //目的地
	var czhbxx = $("#czhbxx").val(); //航班信息
	var hbh = $("#hbh").val(); //航班编号
	var hbsj = $("#hbsj").val(); //航班时间
	var bzxx = $("#bzxx").val(); //备注信息
	var dataPost = {"model.PCJGBH" : pcjgbh,"model.SSPCBH":pcbh,"model.TXRY":txry,"model.XDWP":xdwp,"model.CZHBXX":czhbxx,"model.SJHM":sjhm,
			"model.JTGJ":jtgj,"model.CXMD":cxmd,"model.ZZDZ":zzdz,"model.HBH":hbh,"model.HBSJ":hbsj,"model.CFD":cfd,"model.MDD":mdd,
			"model.GZQK":gzqk,"model.BZXX":bzxx
	};
	return dataPost;
}
