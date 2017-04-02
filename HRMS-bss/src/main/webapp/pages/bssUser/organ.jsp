<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">组织管理</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="" id="orgform">
                  <div class="input-group col-md-3" style="display: inline-table;">
                     <span class="input-group-addon">组织名称</span>
                     <input type="text" class="form-control" placeholder="组织名称" id="orgName" name="orgName">
                  </div>
                  
                  <div class="input-group col-md-1 colLee" style="display:inline-block;">
					<a href="javaScript:void(0);" class="btn btn-primary" id="findOrgan">查询</a>
                 </div>
				<div class="input-group col-md-1 colLee" style="display:inline-block;">
					 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="addOrgan">添加</a>
               	</div>
               	 <div class="input-group col-md-5 colLee" style="display:inline-block;">
                    <span id="textspan" style="display: none;color: red">请输入合法的组织名称</span>
                 </div>
                   
                </form>
                    <input type="hidden" id="formParam" value>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="showOrgan.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>