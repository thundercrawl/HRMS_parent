<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">工位</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="" id="workform">
				  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">工位名称</span>
                    <input type="text" class="form-control" placeholder="工位名称" id="workname" name="sname">
                  </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">项目名称</span>
                     <input type="text" class="form-control" placeholder="项目名称" id="projectname" readonly="true">
                     <input type="hidden" id="findprojectid" name="projectId" value="0">
                     <ul class="project_ul" id="project_ul"></ul>
                   </div>
                  <div class="input-group col-md-1 colLee">
                    <a href="javaScript:void(0);" class="btn btn-primary" id="findwork">查询</a>
                    <span id="textspan" style=" position: absolute; right: -210px; top: 7px;color: red;display: none;">请输入合法的工位名称</span>
                  </div>
                  <div class="input-group col-md-1 colLee">
                    <a href="javaScript:void(0);" class="btn btn-primary shiny" id="addWork">添加</a>
                  </div>
                 <!--  <div style="position: absolute; left: 959px; top: 48px; width: 54px; height: 31px; z-index: 99;">
                    <a href="javaScript:void(0);" class="btn btn-primary shiny" id="addWorkPic">添加图片</a>
                  </div> -->
				</form>
				    <input type="hidden" id="formParam" value=""/>
					<div id="projectable" style="margin-top: 11px;">
						<jsp:include page="work.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/project/workfirst.js"></script>