		//查找资料点击事件
        function selectzl(){
    		var s= $("#s").val();
    	   	f_selectTeam(s);
        }
        //上传附件
        function uploadfj(){
        	var id = $("#id").val();
        	openFileUploadPages(id,"exchange");
        }
        //验证非空
        function checkData(){
        	var infodesc = $("#infodesc").val();
      		if(infodesc == null || infodesc == ""){
      			$.ligerDialog.warn("内容不能为空！");
      			return false;
      		}
   			return true;
   		}
        //组装发送到后台的数据
        function addPost(){
        	var infodesc = $("#infodesc").val();
        	var ssxmbh = $("#ssxmbh").val();
        	var id = $("#id").val();
        	var cjrbh = $("#cjrbh").val();
        	//预警信息
			var zlidsyj = $("#zlidsyj").val();
			var zltypeyj = $("#zltypeyj").val();
			
			//盘查
			var zlidspc = $("#zlidspc").val();
			var zltypepc = $("#zltypepc").val();
			
			//关注
			var zlidsgz = $("#zlidsgz").val();
			var zltypegz = $("#zltypegz").val();
			
			//管控人员
			var zlidsgk = $("#zlidsgk").val();
			
			//案事件信息
			var zlidsasj = $("#zlidsasj").val();
			
			var dataPost = {"model.PLJTNR":infodesc,"model.JLPLBH":id,"model.SSXMBH":ssxmbh,"zlids":zlidsyj,"zlidstwo":zlidsgz,"zlidsthree":zlidspc,"zltype":zltypeyj,"zltypetwo":zltypegz,"zltypethree":zltypepc,"cjrbh":cjrbh,"zlidsgk":zlidsgk,"zlidsasj":zlidsasj};
			return dataPost;
        }
        /**提交验证*/
        function f_validate() { 
            if (checkData()) {
                $.ligerDialog.waitting('正在保存中,请稍候...');
                 return addPost();
            }
            return null;
        }
       