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
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
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
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<input type="hidden" name="pageNum" id="pageNum" value="" />
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件" name="example" id="example">
								</div>
							</div>
							<button type="button" class="btn btn-warning" id="search">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<form id="delForm">
							<button type="button" class="btn btn-danger"
								style="float: right; margin-left: 10px;" id="delChoice">
								<i class=" glyphicon glyphicon-remove"></i> 删除
							</button>
							<button type="button" class="btn btn-primary"
								style="float: right;" onclick="window.location.href='user/save'">
								<i class="glyphicon glyphicon-plus"></i> 新增
							</button>
							<br>
							<hr style="clear: both;">
							<div class="table-responsive">
								<table class="table  table-bordered">
									<thead>
										<tr>
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
										<tr>
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
			    goPage(1,"");
            	
			    
			    //全选或全不选
			    $("#selectAll").click(function(){
			    	var flag = $("#selectAll").prop("checked");
			    	$(".check").prop("checked",flag);
			    })//全选或全不选
			    
			    //删除选中的用户
			    $("#delChoice").click(function(){
			    	layer.confirm("确认修改",  {icon: 3, title:'提示'}, function(cindex){
			    	$.ajax({
			    		url:"user/delChoiceDo",
			    		data:$("#delForm").serialize(),
			    		type:"post",
			    		dataType:"json",
			    		success:function(result){
			    			if(result.msg == "OK"){
			    				layer.msg("删除成功", {time:1500, icon:6, shift:6}, function(){
			    					location.href = "user/list";
			    				});
			    				
			    			}else{
			    				layer.msg("删除失败", {time:1500, icon:5, shift:6}, function(){});
			    			}
			    		}//success
			    	})//ajax
			    	});//layer弹层
			    })//删除选中的用户
			    
			    
			    //删除当前用户
			    $(document).on("click",".delete",function(event){
			    	var uid = $(event.currentTarget).attr("data-uid");
			    	layer.confirm("确认修改",  {icon: 3, title:'提示'}, function(cindex){
			    	$.ajax({
			    		url:"user/deleteDo",
			    		data:{"uid":uid},
			    		dataType:"json",
			    		type:"post",
			    		success:function(result){
			    			if(result.msg == "OK"){
			    				layer.msg("删除成功", {time:1000, icon:6, shift:6}, function(){
			    					location.href = "user/list";
			    				});
			    				
			    			}else{
			    				layer.msg("删除失败", {time:1000, icon:5, shift:6}, function(){});
			    			}
			    		}//success
			    	})//ajax
			    	});//layer弹层
			    })//删除当前用户
			    
			   
			   //模糊查询并分页
			   $("#search").click(function(){
				   var pageNum = $("#pageNum").val();
				   var example = $("#example").val();
				   goPage(pageNum,example);
				   
			   })//模糊查询并分页
			   
			   //跳转至修改页面
			   $(document).on("click",".edit",function(event){
				   var uid = $(event.currentTarget).attr("data-uid");
				   layer.confirm("确认修改",  {icon: 3, title:'提示'}, function(cindex){
					   
					   layer.close(cindex);
					   location.href = "user/edit?uid="+uid;
					});//layer弹层
			   })//跳转至修改页面
			   
			   //跳转至个人角色展示页面
			   $(document).on("click",".assign",function(event){
				   var uid = $(event.currentTarget).attr("data-uid");
					layer.confirm("确认进行角色分配",  {icon: 3, title:'提示'}, function(cindex){
					   
					   layer.close(cindex);
					   location.href = "user/assignRole?uid="+uid;
					});//layer弹层
			   });
			   
            });//入口
            
            
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            
            //获取信息以及跳转页面
            function goPage(page,example){
            	
            	$.ajax({
			    	url:"user/listDo",
			    	data:{"pageNum":page,"example":example},
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
			    					      <button type="button" class="assign btn btn-success btn-xs" data-uid=`+obj.uid+`><i class=" glyphicon glyphicon-check"></i></button>
			    					      <button type="button" class="edit btn btn-primary btn-xs" data-uid=`+obj.uid+` ><i class=" glyphicon glyphicon-pencil"></i></button>
			    						  <button type="button" class="delete btn btn-danger btn-xs" data-uid=`+obj.uid+` ><i class=" glyphicon glyphicon-remove"></i></button>
			    					  </td>
			    	                </tr>
			    				`;
			    			})//each
			    			$("#userList").html(tbodyHtml);
			    			$("#pageList").empty();
			    			var pageListHtml = "";
			    			var aobj1 = "";
			    			if(result.pageInfo.pageNum != 1){
			    				aobj1 = "<li><a class='' href= 'javascript:void(0)' onclick='goPage("+result.pageInfo.prePage+",\""+example+"\")'>上一页</a></li>";
			    			}else{
			    				aobj1 = "<li class='disabled'><a class='page' href= 'javascript:void(0)'>上一页</a></li>";
			    				
			    			}
			    			
			    			pageListHtml += aobj1;
			    			for(var i = 1 ; i <= result.pageInfo.pages ; i++){
			    				var aObj2 = "";
			    				if(result.pageInfo.pageNum == i){
			    					aObj2 = "<li class='active' ><a class='page' href= 'javascript:void(0)' onclick='goPage("+i+",\""+example+"\")'>"+i+"</a></li>";
			    				}else{
				    				aObj2 = "<li ><a class='page' href= 'javascript:void(0)' onclick='goPage("+i+",\""+example+"\")'>"+i+"</a></li>";
			    				}
			    				
			    				pageListHtml += aObj2;
			    			}
			    			var aobj3 ="";
			    			if(result.pageInfo.pageNum == result.pageInfo.pages){
			    				aobj3 = "<li class='disabled'><a  href= 'javascript:void(0)' >下一页</a></li>";
			    			}else{
			    				aobj3 = "<li><a class='page' href= 'javascript:void(0)' onclick='goPage("+result.pageInfo.nextPage+",\""+example+"\")'>下一页</a></li>";
			    			}
			    			
			    			pageListHtml += aobj3;
			    			$("#pageList").html(pageListHtml);
			    			$("#pageNum").val(result.pageInfo.pageNum);
			    		}else{
			    			alert("NO");
			    		}
			    	}//success
			    })//进入页面加载用户数据
            }
        </script>
</body>
</html>
