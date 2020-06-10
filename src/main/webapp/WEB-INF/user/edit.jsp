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
		
		<!-- 操作区域 -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" id="editForm">
				<input type="hidden" name="uid" id="uid" value=""/>
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label>
					<input type="text" class="form-control" id="uaccount" name="uaccount" value="">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control" id="uname" name="uname" value="">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" id="ueamail" name="ueamail" value="">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="button" class="btn btn-success" id="edit"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
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
	<script src="script/docs.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
        <script type="text/javascript">
           var temp = location.search;
           var uid = temp.split("=")[1];
           
           $(function(){
        	   //初始化编辑页面
        	   $.ajax({
        		   url:"user/initEditDo",
        		   data:{"uid":uid},
        		   type:"post",
        		   dataType:"json",
        		   success:function(result){
        			  
        			   if(result.msg == "OK"){
        				   layer.msg("加载中", {time:1000, icon:16, shift:5}, function(){
        					   $("#uaccount").val(result.user.uaccount);
        					   $("#uname").val(result.user.uname);
        					   $("#ueamail").val(result.user.ueamail);
        					   $("#uid").val(result.user.uid);
        				   });
        			   }else{
        				   layer.msg("加载失败", {time:1000, icon:5, shift:6}, function(){});
        			   }
        		   }//success
        	   })//ajax
        	 //初始化编辑页面
        	 
        	 //提交编辑信息
        	 $("#edit").click(function(){
        		 
        		var uaccount = $("#uaccount").val(); 
        		var uname = $("#uname").val();
 				var ueamail = $("#ueamail").val();
 				

 				var zzUname = /^[\u4e00-\u9fa5a-zA-Z]{3,6}$/;
 				var zzUaccount = /^[a-zA-Z]\w{2,5}$/;
 				var zzEamail = /^(\w+\.)*\w+@\w+(\.\w+)+$/;

 				if (!zzUaccount.test(uaccount)) {
 					layer.msg("登录账户错误，以字母开头，长度为3~6", {time:1500, icon:5, shift:6}, function(){});
     				return;
 				}
 				if (!zzUname.test(uname)) {
 					layer.msg("用户名错误，长度为3~6", {time:1500, icon:5, shift:6}, function(){});
     				return;
 				}
 				
 				if (!zzEamail.test(ueamail)) {
 					layer.msg("邮箱格式错误，请认真检查", {time:1500, icon:5, shift:6}, function(){});
     				return;
 				}
        		 
        		 $.ajax({
        			 url:"user/editDo",
        			 data:$("#editForm").serialize(),
        			 dataType:"json",
        			 type:"post",
        			 success:function(result){
        				 
        				 if(result.msg = "OK"){
        					 layer.msg("修改成功", {time:1000, icon:6, shift:6}, function(){
        						 location.href = "user/list"
        					 });
        				 }else{
        					 layer.msg("修改失败", {time:1000, icon:5, shift:6}, function(){});
        				 }
        				 
        				 
        			 }//success
        		 })//ajax
        		 
        	 })//提交编辑信息
        	 
        	 
           })//入口
        </script>
  </body>
</html>