<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
      
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script>  
    <script  type="text/javascript"  src="<%=basePath  %>js/btnQuery.js" ></script> 
    <script  type="text/javascript">
    
    jQuery(function($){
        my_initGrid();
    		$("#begintime").ligerDateEditor({ showTime: false, labelWidth: 100 });
    		$("#endtime").ligerDateEditor({ showTime: false, labelWidth: 100 });
        $(".my_info").live("mouseover",function(){
			  $(this).addClass("my_info_mess");
			});
		$(".my_info").live("mouseout",function(){
			  $(this).removeClass("my_info_mess");
		});
    });
    function my_initGrid(){
    	var basepath = "<%=basePath%>";
    	window['g']=$("#maingrid").ligerGrid({
    		checkbox: true,
    		rowHeight:50,
    		height:"100%",
    		heightDiff:-10,
    		url:"inventorysAlllist.action",
    		columns: [
			{ display: '盘查人证照', name: 'PCRZZ', width:"30%",
				render:function(item){
					var userimg = "";
        		    userimg = basepath  +item.PCRZZ;
    				var temp = "<img src =\""+userimg+"\" height=\"50px\" width=\"50px\" />";
    				return  temp;
				}
			},
			{ display: '盘查人姓名', name: 'RYXM', width:"10%",
				render:function(item){
					var temp = "<span title="+item.RYXM+">"+item.RYXM+"</span>";
					return  temp;
				}
			},
    		{ display: '创建人姓名', name: 'CJRXM', width:"10%",
    			render:function(item){
    				var temp = "<span title="+item.CJRXM+">"+item.CJRXM+"</span>";
    				return  temp;
    			}
    		},
    		{ display: '创建人所属部门', name: 'CJRSSBM', width:"15%",
    			render:function(item){
    				var temp = "<span title="+item.CJRSSBM+">"+item.CJRSSBM+"</span>";
    				return  temp;
    			}
    		},
    		{ display: '创建时间', name: 'CJSJ', width:"20%",
    			render:function(item){
    				var temp = "<span title="+item.CJSJ+">"+item.CJSJ+"</span>";
    				return  temp;
    			}
    		}
    		],
    		pageSize:10,
    		root:"listmodel",
    		record:"record",
    	 	enabledSort:false,
    	 	rownumbers:true,
    	 	title:"盘查列表",
    		});
    }
    /**选择函数*/
	 function f_select(){
		 var data = g.getSelecteds();
	 	 return data;
       } 
    </script>
</head>
<body >
<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
					<td align="center" class="ser_cont">开始时间:</td>
					<td><input ltype="date" id="begintime" value="" />
					</td>
					<td align="center" class="ser_cont">&nbsp;&nbsp;结束时间:</td>
					<td><input ltype="date" id="endtime" value="" /></td>
					<tr>
				</tr>
				<tr>
					<td align="center" class="ser_cont">&nbsp;&nbsp;盘查人姓名:</td>
					<td><input type="text" id="pcname" value="" />
					</td>
					
						<td align="center" class="ser_cont">&nbsp;&nbsp;创建人姓名:</td>
					<td><input type="text" id="cjname" value="" />
					</td>
					
					<td class="ser_cont">&nbsp;&nbsp;<input type="button"
						id="searchBtn" value="查询" class="btn" />
					</td>
					<td class="ser_cont"><input type="button" id="clearBtn"
						value="清空" class="btn" />
					</td>
				</tr>
			</table>
		</form>
	</div>
<div id="maingrid"></div>
<input type="hidden" id="mypath" value="<%=basePath%>"/>
</body>
</html>
