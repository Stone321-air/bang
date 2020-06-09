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
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<div class="btn-group">
				  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i> andy<span class="caret"></span>
				  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
						<li class="divider"></li>
						<li><a href="index.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
					  </ul>
			    </div>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<ul style="padding-left:0px;" class="list-group">
					<li class="list-group-item tree-closed" >
						<a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a> 
					</li>
					<li class="list-group-item">
						<span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理 <span class="badge" style="float:right">3</span></span> 
						<ul style="margin-top:10px;">
							<li style="height:30px;">
								<a href="user.html" style="color:red;"><i class="glyphicon glyphicon-user"></i> 用户维护</a> 
							</li>
							<li style="height:30px;">
								<a href="role.html"><i class="glyphicon glyphicon-king"></i> 角色维护</a> 
							</li>
							<li style="height:30px;">
								<a href="permission.html"><i class="glyphicon glyphicon-lock"></i> 许可维护</a> 
							</li>
						</ul>
					</li>
					
				</ul>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<form id="delForm">
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" id="delChoice"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='add.jsp'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" id="selectAll"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody id="userList">
               
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination" id="pageList">
								
							 </ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
            </form>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
	<script src="script/docs.min.js"></script>
        <script type="text/javascript">
            $(function () {
            	//进入页面加载用户数据
			    goPage();
            	//左侧导航下拉框
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			    
			    //全选或全不选
			    $("#selectAll").click(function(){
			    	var flag = $("#selectAll").prop("checked");
			    	$(".check").prop("checked",flag);
			    })//全选或全不选
			    
			    //删除选中的用户
			    $("#delChoice").click(function(){
			    	$.ajax({
			    		url:"user/delChoice",
			    		data:$("#delForm").serialize(),
			    		type:"post",
			    		dataType:"json",
			    		success:function(result){
			    			if(result.msg == "OK"){
			    				layer.msg("删除成功", {time:1500, icon:6, shift:6}, function(){});
			    				location.href = "user.jsp";
			    			}else{
			    				layer.msg("删除失败", {time:1500, icon:5, shift:6}, function(){});
			    			}
			    		}//success
			    	})//ajax
			    })//删除选中的用户
			    
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            function goPage(page){
            	$.ajax({
			    	url:"user/list",
			    	data:{"pageNum":page},
			    	type:"post",
			    	dataType:"json",
			    	success:function(result){
			    		$("#userList").empty();
			    		var tbodyHtml = "";
			    		if(result.msg == "OK"){
			    			
			    			$.each(result.useres,function(index,obj){
			    				tbodyHtml += `
			    					<tr>
			    	                  <td>`+
			    	                 ((index+1) + (result.pageInfo.pageNum - 1 )* result.pageInfo.pageSize)+`</td>
			    					  <td><input type="checkbox" class="check" name="uids" value=`+obj.uid+`></td>
			    	                  <td>`+obj.uname+`</td>
			    	                  <td>`+obj.uaccount+`</td>
			    	                  <td>`+obj.ueamail+`</td>
			    	                  <td>
			    					      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
			    					      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
			    						  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
			    					  </td>
			    	                </tr>
			    				`;
			    			})//each
			    			$("#userList").html(tbodyHtml);
			    			$("#pageList").empty();
			    			var pageListHtml = "";
			    			var aobj1 = "<li><a class='page' href= 'javascript:void(0)' onclick='goPage("+result.pageInfo.prePage+")'>上一页</a></li>";
			    			pageListHtml += aobj1;
			    			for(var i = 1 ; i <= result.pageInfo.pages ; i++){
			    				var aObj2 = "<li><a class='page' href= 'javascript:void(0)' onclick='goPage("+i+")'>"+i+"</a></li>";
			    				pageListHtml += aObj2;
			    			}
			    			var aobj3 = "<li><a class='page' href= 'javascript:void(0)' onclick='goPage("+result.pageInfo.nextPage+")'>下一页</a></li>";
			    			pageListHtml += aobj3;
			    			$("#pageList").html(pageListHtml);
			    		}else{
			    			alert("NO");
			    		}
			    	}//success
			    })//进入页面加载用户数据
            }
        </script>
  </body>
</html>
