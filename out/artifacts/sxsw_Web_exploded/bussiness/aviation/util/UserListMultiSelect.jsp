<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ids = request.getParameter("ids");
String SelectDept = request.getParameter("SelectDept");
String rwcl = request.getParameter("rwcl");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath %>"/>
    <title>选择用户列表页面(可用多选)</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" />
    <script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script type="text/javascript" src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
  	<script type="text/javascript">
		var treemanager;
		var manager = "";
		var curr_corpid="defaults";
		var cache={defaults:{}};
		$(function () {
		    
        	$("#layout").ligerLayout({ leftWidth: 250, allowLeftResize: false, allowLeftCollapse: true, space: 2 });
			$("#tree").ligerTree({
                url: "corpSelectedQuery.action",
                onSelect: onSelect,
                idFieldName: 'id',
                parentIDFieldName: 'pid',
                checkbox: false,
                itemopen: false
            });
			/* treemanager = $("#tree").ligerGetTreeManager(); */
			
			window['g'] = $("#maingrid").ligerGrid({
				url: "userQueryListchoose.action?SelectDept="+"<%=SelectDept%>"+"&rwcl="+"<%=rwcl%>",
				parms: [
			       		{ name: 'showsubdivision', value: $("#chk1").ligerCheckBox().getValue() }
			      		],
				checkbox: true,
				frozenCheckbox:false,//放置拖拽表格变形
				columns: [
				{ display: '用户姓名', name: 'YHBH',isSort:true,hide:true},
				{ display: '登陆名', name: 'YHDLYHM', minWidth:30 ,width:"18%",isSort:true,
					render:function(item){
						return "<span id='"+item.YHBH+"' class=\"my_info\"  onclick=\"javascript:openDialog('"+item.YHBH+"');\">" + item.YHDLYHM + "</span>";
					}
				},
				{ display: '用户姓名', name: 'YHXM', minWidth: 30 ,width:"18%",isSort:true},
				{ display: '职务', name: 'ZWMC', minWidth: 30 ,width:"15%",isSort:true},
				{ display: '性别', name: 'YHXB', minWidth: 20 ,width:"9%",
					render: function (item){
				    	if (item.YHXB == '0') return '男';
				        return '女';
		        	}
				},
				{ display: '移动电话', name: 'YDDH', minWidth: 100 ,width:"18%",isSort:true},
				{ display: '办公电话', name: 'BGDH', minWidth: 100 ,width:"18%",isSort:true}
				],
				pageSize:10,
				width: '100%',
                height: '100%',
                heightDiff:-8,
				root:"listmodal",
				record:"record",
				alternatingRow:true,
				isChecked: f_isChecked,
				onCheckRow:onChecked,
				onLoadData:loadCache
			});
			
			$("#serchform").ligerForm();
			$("#searchBtn").click(function(){
				var username = $("#username").val();
				g.setOptions({newPage:1});
				g.setOptions({
				       parms: [
				       		{ name: 'username', value: username },
				       		{ name: 'showsubdivision', value: $("#chk1").ligerCheckBox().getValue() }
				      		]
				});
				g.loadData();
			});
			$("#clearBtn").click(function(){
				$("#username").val("");
				g.setOptions({newPage:1});
				g.setOptions({
				       parms: [
				       		{ name: 'username', value: "" },
				      		]
						 });
				g.loadData();
			});
			
			$(".my_info").live("mouseover",function(){
			  $(this).addClass("my_info_mess");
			});
			$(".my_info").live("mouseout",function(){
			  $(this).removeClass("my_info_mess");
			});
		});
		var datas = "";
		function onSelect(note) {
			var SelectDept = "<%=SelectDept%>";
		    if(SelectDept=="yjzbzh"){
			    var url = "userQueryListchoose.action?corpid="+note.data.id+"&SelectDept=yjzbzh"+"&rwcl="+"<%=rwcl%>";
	            g.set('url',url);
		    }else{
		     	var url = "userQueryListchoose.action?corpid="+note.data.id+"&rwcl="+"<%=rwcl%>";
	            g.set('url',url);
		    }
            //判断此部门id(note.data.id)是否存在，不存在则初始化为{}
          	cache[note.data.id]=cache[note.data.id]||{};
          	curr_corpid=note.data.id;
        } 
        //加载数据判断是否是勾选
	    function f_isChecked(rowdata){
	    	var inDef=false;
	    	var inCorpid=false;
	    	inDef=cache["defaults"][rowdata.YHBH];
	    	if(inDef){
	    		var name=cache["defaults"][rowdata.YHBH]["name"];
	    		if(name==""||name==null){
	    			cache["defaults"][rowdata.YHBH]={id:rowdata.YHBH,name:rowdata.YHXM};
	    		}
	    	}
	    	inCorpid=cache[curr_corpid][rowdata.YHBH];
            return inDef||inCorpid;
        }
		/**
		  打开详细信息窗口的方法
		*/
		function  itemmess(){
			var selected = g.getSelected();
			if (!selected) { top.my_alert('请选择数据行',"warn"); return; }
			var id = (g.getSelectedRow()).id; 
			window.top.my_openwindow("useredit","system/user/UserMess.jsp?id="+id,700,450,"用户详细信息");
		}
		
		 /*打开详细信息*/
	   function openDialog(id){
	     window.top.my_openwindow("userinfomess","system/user/UserMess.jsp?id="+id,700,450,"用户详细信息");
	   }
	   //当勾选触发
	  function onChecked(checked,data,rowid,rowdata){
	   		if(checked){
	   		      /**将选中的放入缓存，格式为cache[部门id(默认为defaults)][人员id]={id:人员id,name:人员姓名}
	   		      							 cache.defaults.人员id={id:人员id,name:人员姓名}
	   		         cache={defaults:{},"某部门id":{"某人员id":{id:"某人员id",name:"某人员姓名"},....}}*/
	   		      cache[curr_corpid][data.YHBH]={id:data.YHBH,name:data.YHXM};
	   		//取消勾选
	   		}else{
	   			  delete cache["defaults"][data.YHBH];
	   			  //delete删除指定对象的指定属性
	   	     	  delete cache[curr_corpid][data.YHBH];
	   	     	  
	   		}
	   }
	   //加载前一次被勾选项
	   function loadCache(){
	    //通过.selected样式来区分
	   	var json=$(window.parent.document).find("#cacheDataSet").children(".selected").text();
	   	if(json!=""){
	   		var data=JSON.parse(json);
	   		for(var i=0;i<data.length;i++){
	   		    cache["defaults"][data[i].id]=data[i];
	   		}
	   	}
	   }
		
 	/**
    选择函数
    */
   function f_select(){
   		 var arr=[];
          for(var pro1 in cache){
           for(var pro2 in cache[pro1]){
            	arr.push(cache[pro1][pro2]);
           }
          }
		  return arr;
        }
  	</script>
  	<style type="text/css">
  		.l-layout-left{
    			overflow: auto !important;
    			}
    	.l-tree{
      		width:240px !important;
      	}
  	</style>
</head>
<body style="padding: 0px;overflow:hidden;">
        <div id="layout" style="margin-top: -1px; margin-left: -1px">
            <div position="left" title="组织架构">
                <div id="treediv" style="width: 250px; height: 100%; margin: -1px; float: left; border: 1px solid #ccc; overflow: auto;">
                    <ul id="tree"></ul>
                </div>
            </div>
            <div position="center" title="人员信息">
            	<div id="toolbar" class="searchDiv">
            		<form id="serchform">
	            		<table>
	            			<tr>
	            				<td class="ser_tit">用户姓名：</td>
	            				<td class="ser_cont"><input type="text" id="username" value=""/></td>
	            				<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
	            				<td class="ser_cont"><input type="button" id="clearBtn" value="清空" class="btn"/></td>
	            				&nbsp;<td><input type="checkbox" name="chk1" id="chk1" checked="checked" /></td><td>是否显示子部门人员</td>
	            			</tr>
	            		</table>
            		</form>
            	</div>
                <div id="maingrid" style="margin-top: -1px; margin-left: -1px"></div>
            </div>
        </div>
</body>
</html>
