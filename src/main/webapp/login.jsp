<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<base href="${APP_PATH}/"/>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" role="form" id="loginForm">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="uaccount" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="password" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  
        <a class="btn btn-lg btn-success btn-block"  id="login"> 登录</a>
      </form>
    </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script>
    	$(function(){
    		//登录
    		$("#login").click(function(){
    			var uaccount = $("#uaccount").val();
    			var zzUaccount = /^[a-zA-Z]\w{2,5}$/;
    			if(!zzUaccount.test(uaccount)){
    				layer.msg("登录账户错误，以字母开头，长度为3~6", {time:1500, icon:5, shift:6}, function(){});
    				return ;
    			}
    			var password = $("#password").val();
    			var zzPassword = /^\w{6,12}$/;
    			if(!zzPassword.test(password)){
    				layer.msg("密码错误，长度为6~12", {time:1500, icon:5, shift:6}, function(){});
    				return;
    			}
    			$.ajax({
    				url:"user/login",
    				type:"post",
    				data:{"uaccount":uaccount,"password":password},
    				dataType:"json",
    				success:function(result){
    					if(result.msg == "OK"){
    						layer.msg("登录成功", {time:2000, icon:6, shift:6}, function(){});
    						location.href = "main.jsp";
    					}else{
    						layer.msg("登录失败", {time:1500, icon:5, shift:6}, function(){});
    					}
    				}//success
    			})//ajax
    		})//登录
    	})//入口
    </script>
  </body>
</html>