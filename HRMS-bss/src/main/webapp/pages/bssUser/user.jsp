<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">用户管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<!-- <div class="box-header well" data-original-title=""
				style="color: #2fa4e7;padding-top: 0;padding-bottom: 0;line-height: 36px;">
				<span style="margin-top:0;"> 用户管理</span><i class="glyphicon glyphicon-user"></i>
			</div> -->
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div">
					<form action="" id="usergroup">
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">用户姓名</span> <input type="text"
								class="form-control" placeholder="用户姓名" id="adminRname"
								name="adminRname" value="${ adminRname}">
						</div>
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">组织名称</span> <input type="text"
								class="form-control" placeholder="组织名称" id="orgName"
								name="orgName" readonly="readonly" value="${orgName }">
							<ul class="project_ul" id="project_ul"></ul>
						</div>


						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary" id="findproject">查询</a></div>
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary" id="addUser">添加</a>
						</div>
						<div  class="input-group col-md-1 colLee" style="display: inline-block;">
                       <a href="javaScript:void(0);" class="btn btn-primary shiny" id="exportProject">导出查询结果</a>
                           </div>
						<div class="input-group col-md-5 colLee" style="display: inline-block;">
							 <span id="textspan" style="display: none; color: red">请输入合法的用户姓名</span>
						</div>
					</form>
					<input type="hidden" id="formParam" value="" />
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="showUser.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/bssUser/user.js"></script>