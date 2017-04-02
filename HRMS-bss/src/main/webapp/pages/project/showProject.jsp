<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">项目（地）信息</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="" id="meetingfrom">
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">项目名称</span>
                     <input type="text" class="form-control" placeholder="项目名称" id="findInput" name="findInput">
                  </div>
                    <div  class="input-group col-md-1 colLee" >
                    <a href="javaScript:void(0);" class="btn btn-primary" id="findproject">查询</a>
                    <span id="textspan" style=" position: absolute; right: -210px; top: 7px;color: red;display: none;">请输入合法的项目名称</span>
                  </div>
                  <div  class="input-group col-md-1 colLee" >
                       <a href="javaScript:void(0);" class="btn btn-primary shiny" id="addProject">添加</a>
                   </div>
                  <div  class="input-group col-md-1 colLee" >
                       <a href="javaScript:void(0);" class="btn btn-primary shiny" id="exportProject">导出查询结果</a>
                   </div>
                   
                  
                </form>
                    <input type="hidden" id="formParam" value=""/>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="project.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
