<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="js/jquery/jquery.form.js"></script>
  <script src="js/configManage/ofcSpaceType.js"></script>
<script src="js/pagination.js"></script>

<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">系统管理/资产参数配置/资产种类</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form id="queryForm">
					<div>
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">空间类别编号</span>
							<input type="text" class="form-control" placeholder="空间类别编号" id="pId" name="pId">
						</div>
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">空间类别名称</span>
							<input type="text" class="form-control" placeholder="空间类别名称" id="paramName" name="paramName">
						</div>
						<!-- <div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">项目编号</span>
							<input type="text" class="form-control" placeholder="项目编号" id="productName" name="productName">
						</div> -->
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
							<a class="btn btn-primary" id="queryBtn">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
							<a class="btn btn-primary" id="addParam">新增</a>
						</div>
					</div>
					</form>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="ofcSpaceType.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<script type="text/javascript">
var message='<%=request.getAttribute("message")%>';

</script>
<!--/row-->
