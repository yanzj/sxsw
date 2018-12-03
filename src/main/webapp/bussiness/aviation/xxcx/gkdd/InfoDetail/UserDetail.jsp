<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cjrbh = request.getParameter("cjrbh");
%>

<!DOCTYPE HTML >
<html>
  <head>
    <title>创建人详细信息页面</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>  
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script>   
    <style type="text/css">
      .lxfs_style
      {
        height: 15px;line-height: 15px; padding-left: 6px;vertical-align: middle;margin-top:10px;
      }
      .lxfs_title_style
      {
        width:100%; background-color:#c7d8ee;margin-top: 15px; height: 24px;line-height: 24px;
      }
      img{
      	vertical-align: middle;height: 15px;width:20px;margin:0px 20px 0px 25px;
      }
      .lxfs_span{
      	vertical-align: middle;
      }
      .lxfs_img{
      	margin-bottom: 20px;
      }
    </style>
    
    <script type="text/javascript">
        jQuery(function ($){
            var cjrbh = "<%=cjrbh %>";
            getMess(cjrbh);
        });
   /**
     获取单个的信息
  */
  function  getMess(cjrbh){
 
     $.ajax({
		url:"queryByCJRBH.action", 
		data:"cjrbh="+cjrbh, 
		dataType:"json", 
	    async:false,
		type:"post",
		success:function (mm) {
	        $("#loginname").html(mm.YHDLYHM);
	        $("#username").html(mm.YHXM);
	        $("#sex").html(mm.YHXB==0?'男':'女');
	        $("#age").html(mm.NL);
	        $("#dept").html(mm.BMMC);
	        $("#role").html(mm.JSMC);
            $("#phonepublic").html(mm.BMZJHM);
            $("#mobilepublic").html(mm.BMSJH);
            $("#phoneprivate").html(mm.GRZJHM);
            $("#mobileprivate").html(mm.GRSJH);
            $("#emailpublic").html(mm.BMYXDZ);
            $("#emailprivate").html(mm.GRYXDZ);
			$("#remark").html(mm.BZXX);
			
			var newuserimg = mm.newuserimg; //文件不存在
			var basepath = $("#basepath").val();
			var newuserimgt = basepath + newuserimg;
			var pic = document.getElementById("userimg");
 			pic.src = newuserimgt; 
		}, 
		error:function (error) {
			alert("获取单个信息失败****" + error.status);
	}});
  } 
  
 
    </script>
  </head>
  <body style="color: #4c4c4c;font-size: 15px;">
  <div style="height: 30px;line-height:30px; width: 100%; text-align: center;color:#EE7642;background-color: #c7d8ee;margin-top: 25px">警员详情</div>
	 <div style="padding: 20px;">
	  <div style="float: left; width: 32%;"><img src="" class="head" id="userimg" style="width:130px; height:150px; margin-left: 10px;"/></div>
	  <div style="float: left;width:67%;">
	     <div style="color: #4c4c4c;font-size: 24px;"><span id="username"></span></div>
	     <div style="margin-top: 10px;">&nbsp;<span id="sex"></span><span id="age" style="margin-left: 20px;"></span></div>
	     <div style="margin-top: 7px;">&nbsp;太原国际武宿机场<span id="dept" style="margin-left: 20px;"></span><span id="role" style="margin-left: 20px;"></span><span id="roleid" style="margin-left: 20px;"></span></div>
	     <div class="lxfs_title_style">&nbsp;常用联系方式</div>
	      <div class="lxfs_style"><img src="<%=basePath%>images/common/fk_phoneicon1.png" ><span id="phoneprivate" class="lxfs_span"></span></div>
	      <div class="lxfs_style"><img src="<%=basePath%>images/common/fk_phoneicon.png"><span id="mobileprivate" class="lxfs_span"></span></div>
	      <div class="lxfs_style lxfs_img"><img src="<%=basePath%>images/common/fk_mailicon.png"><span id="emailprivate" class="lxfs_span"></span></div>
	       <div class="lxfs_title_style">&nbsp;部门联系方式</div>
	      <div class="lxfs_style"><img src="<%=basePath%>images/common/fk_phoneicon1.png" ><span id="phonepublic" class="lxfs_span"></span></div>
	      <div class="lxfs_style"><img src="<%=basePath%>images/common/fk_phoneicon.png"><span id="mobilepublic" class="lxfs_span"></span></div>
	       <div class="lxfs_style lxfs_img"><img src="<%=basePath%>images/common/fk_mailicon.png"><span id="emailpublic" class="lxfs_span"></span></div>
	        <div class="lxfs_title_style">&nbsp;描述</div>
	      <div style="font-size: 14px;margin-top: 5px;">&nbsp;&nbsp;&nbsp;<span  id="remark" ></span></div>
	  </div>
	 </div>
	 
	 <input type="hidden" id="basepath" value="<%=basePath%>">
	 <input id="mypath" type="hidden" value="<%=path %>"/>
  </body>
</html>
