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

  <!--  导航 -->
	<jsp:include page="/nav.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
         <!--  菜单 -->
		<jsp:include page="/menu.jsp"></jsp:include>
		
		<!-- 操作区域 -->
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
<form action="" id="delForm">
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" id="delChoice"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" id="selectAll"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody id="roleList">
                
                
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
            	//页面初始加载第一页数据
            	goPage(1,"");
            	
            	//全选或全不选
            	$("#selectAll").click(function(){
            		$(".check").prop("checked",$(this).prop("checked"));
            		
            	})//全选或全不选
            	
            	//删除选中
            	$("#delChoice").click(function(){
            		layer.confirm("确认修改",  {icon: 3, title:'提示'}, function(cindex){
            		$.ajax({
            			url:"role/delChoiceDo",
            			data:$("#delForm").serialize(),
            			type:"post",
            			dataType:"json",
            			success:function(result){
            				if(result.msg == "OK"){
            					layer.msg("加载成功", {time:1000, icon:6 , shift:6}, function(){});
            				}else{
            					layer.msg("加载失败", {time:1000, icon:5, shift:6}, function(){});
            				}
            			}//success
            		})//ajax
            		});//layer弹层
            	})//删除选中
            	
            });
            
            
            
            /*
           	函数：获取每页的值
            */
            function goPage(pageNum,example){
            	$.ajax({
            		url:"role/listDo",
            		data:{"pageNum":pageNum,"example":example},
            		type:"post",
            		dataType:"json",
            		success:function(result){
            			
            			if(result.msg == "OK"){
            				layer.msg("加载中", {time:500, icon:16, shift:5}, function(){
            					/**
            					生成表内容
            					*/
            					var roleListHtml = "";
            					$.each(result.roleList,function(index,role){
            						roleListHtml += `
            							<tr>
            		                  <td>`+((index+1) + result.pageInfo.pageSize*(result.pageInfo.pageNum - 1))+`</td>
            						  <td><input type="checkbox" class="check" name="rids" value=`+role.rid+`></td>
            		                  <td>`+role.rname+`</td>
            		                  <td>
            						      <button type="button" class="btn btn-success btn-xs" data-rid=`+role.rid+`><i class=" glyphicon glyphicon-check"></i></button>
            						      <button type="button" class="edit btn btn-primary btn-xs" data-rid=`+role.rid+`><i class=" glyphicon glyphicon-pencil"></i></button>
            							  <button type="button" class="delete btn btn-danger btn-xs" data-rid=`+role.rid+`><i class=" glyphicon glyphicon-remove"></i></button>
            						  </td>
            		                </tr>`
            					})//each
            					$("#roleList").html(roleListHtml);
            					/**
            					生成页码标签
            					*/
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
    			    			
            					
            					
            				});//layer
            			}else{
            				layer.msg("加载失败", {time:1000, icon:5, shift:6}, function(){});
            			}
            		}//success
            	})//ajax
            }
           
        </script>
  </body>
</html>
