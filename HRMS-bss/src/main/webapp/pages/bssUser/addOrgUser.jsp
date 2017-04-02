<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">用户组织管理</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
			   <a href="javaScript:void(0);" id="backorg" orgname="${orgname}" orgpage="${page}">组织管理</a><span>/${orgname}</span>
			</div>
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">用户名称</span>
                     <input type="text" class="form-control" placeholder="用户名称" id="orguserName" name="orderId">
                  </div>
                  <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="findOrguser">查询</a>
                  </div>
	<div class="input-group col-md-2 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="addOrguser">添加成员</a>
                   </div>
                   <div class="input-group col-md-1 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-danger shiny" id="deleteOrguser">删除成员</a>
                    </div>
                   <div class="input-group col-md-5 colLee" style="display:inline-block;">
                    <span id="textspan" style="display: none;color: red">请输入合法的用户名称</span>
                    </div>
                    
                    
                  
                </form>
					<div id="orgusertable" style="margin-top: 8px;">
						<jsp:include page="showAddOrgUser.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script>
var orgid = ${orgid};
</script>