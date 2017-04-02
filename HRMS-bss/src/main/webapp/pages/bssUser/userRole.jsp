<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">角色管理</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="" id="roleform">
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">角色名称</span>
                     <input type="text" class="form-control" placeholder="角色名称" id="rolename" name="roleName">
                  </div>
                   <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="findproject">查询</a>
	</div>
                  <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="addRole">添加</a>
	</div>
	<div class="input-group col-md-5 colLee" style="display:inline-block;">
                    <span id="textspan" style=" display: none;color:red">请输入正确的角色名称</span>
	</div>
                  
                </form>
                    <input type="hidden" id="formParam" value>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="showUserRole.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>