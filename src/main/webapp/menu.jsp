<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="${APP_PATH}/">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<ul style="padding-left:0px;" class="list-group">
					<li class="list-group-item tree-closed" >
						<a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a> 
					</li>
					<li class="list-group-item tree-closed">
						<span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理 <span class="badge" style="float:right">3</span></span> 
						<ul style="margin-top:10px;display:none;">
							<li style="height:30px;">
								<a href="user/list"><i class="glyphicon glyphicon-user"></i> 用户维护</a> 
							</li>
							<li style="height:30px;">
								<a href="role/list"><i class="glyphicon glyphicon-king"></i> 角色维护</a> 
							</li>
							<li style="height:30px;">
								<a href="permission.html"><i class="glyphicon glyphicon-lock"></i> 许可维护</a> 
							</li>
						</ul>
					</li>
					
				</ul>
			</div>
        </div>
        <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
        <script type="text/javascript">
            $(function () {
            	 $(".list-group-item").click(function(){
                     // jquery对象的回调方法中的this关键字为DOM对象
                     // $(DOM) ==> JQuery
 				    if ( $(this).find("ul") ) { // 3 li
 						$(this).toggleClass("tree-closed");
 						if ( $(this).hasClass("tree-closed") ) {
 							$("ul", this).hide("fast");
 						} else {
 							$("ul", this).show("fast");
 						}
 					}
 				});
			    
            });
        </script>
</body>
</html>