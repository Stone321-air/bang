<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<base href="${APP_PATH}/">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

   <!--  导航 -->
	<jsp:include page="/nav.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
         <!--  菜单 -->
		<jsp:include page="/menu.jsp"></jsp:include>
    
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline" id="assignForm">
				<input type="hidden" name="uid" id="uid" value="" />
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select class="form-control" id="unAssignSelect" name="giveRids" multiple size="10" style="width:200px;overflow-y:auto;">
                        
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li class="btn btn-default glyphicon glyphicon-chevron-right" id="give"></li>
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-chevron-left" id="take" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select class="form-control" id="assignSelect" name="takeRids" multiple size="10" style="width:200px;overflow-y:auto;">
                        
                       
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
	<script src="script/docs.min.js"></script>
        <script type="text/javascript">
        var temp = location.search;
    	var uid = temp.split("=")[1];
    	$("#uid").val(uid)
    	
            $(function () {
           
			    //进入页面展示当前用户已被分配的权限及未被分配的权限
			    show();
			    //进入页面展示当前用户已被分配的权限及未被分配的权限
			    
			    //批量或是单个分配权限
			    $("#give").click(function(){
			    	var selectVal = $("#unAssignSelect").val();
			    	
			    	if(selectVal == null || selectVal == ""){
			    		layer.msg("请至少选择一条数据", {time:1500, icon:5, shift:6}, function(){});
	    				return;
			    	}
			    	
			    	$.ajax({
			    		url:"userrole/assignDo",
			    		data:$("#assignForm").serialize(),
			    		type:"post",
			    		dataType:"json",
			    		success:function(result){
			    			if(result.msg == "OK"){
			    				layer.msg("角色分配成功", {time:1500, icon:6, shift:6}, function(){
			    					show();
			    				});
			    			}else{
			    				layer.msg("角色分配失败", {time:1500, icon:5, shift:6}, function(){});
			    			}
			    		}//success
			    	})//ajax
			    });//分配权限
			    
			    //批量或是单个回收权限
			    $("#take").click(function(){
					var selectVal = $("#assignSelect").val();
			    	
			    	if(selectVal == null || selectVal == ""){
			    		layer.msg("请至少选择一条数据", {time:1500, icon:5, shift:6}, function(){});
	    				return;
			    	}
			    	
			    	$.ajax({
			    		url:"userrole/deleteDo",
			    		data:$("#assignForm").serialize(),
			    		dataType:"json",
			    		type:"post",
			    		success:function(result){
			    			if(result.msg == "OK"){
			    				layer.msg("角色回收成功", {time:1500, icon:6, shift:6}, function(){
			    					show();
			    				});
			    			}else{
			    				layer.msg("角色回收失败", {time:1500, icon:6, shift:6}, function(){});
			    			}
			    		}//success
			    	})//
			    });//批量或是单个回收权限
			    
            });//入口
            
            
            function show(){
            	$.ajax({
			    	url:"role/assignRoleShow",
			    	data:{"uid":$("#uid").val()},
			    	type:"post",
			    	dataType:"json",
			    	success:function(result){
			    		if(result.msg == "OK"){
			    			layer.msg("加载中", {time:500, icon:16, shift:5}, function(){
			    				//填充未分配角色信息
			    				var unAssignRoleSelectHtml = "";
			    				$.each(result.unAssignRoleList,function(index,unAssignRole){
			    					unAssignRoleSelectHtml += `<option value=`+unAssignRole.rid+`>`+unAssignRole.rname+`</oprion>`;
			    				})//each
			    				$("#unAssignSelect").html(unAssignRoleSelectHtml);
			    				
			    				//填充已分配角色信息
			    				var assignRoleSelectHtml = "";
			    				$.each(result.assignRoleList,function(index,assignRole){
			    					assignRoleSelectHtml +=`<option value=`+assignRole.rid+`>`+assignRole.rname+`</oprion>`;
			    				})//each
			    				$("#assignSelect").html(assignRoleSelectHtml);
			    				
			    			});//layer弹层
			    		}
			    	}//success
			    })
            }
        </script>
  </body>
</html>
