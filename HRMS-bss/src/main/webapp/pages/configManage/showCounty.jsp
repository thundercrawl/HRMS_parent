<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">系统管理/行政配置/区县</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form id="queryForm">
					<div>
						<!-- <div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">县编号</span>
							<input type="text" class="form-control" placeholder="县编号" id="orderId" name="orderId">
						</div>
						<div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">市编号</span>
							<input type="text" class="form-control" placeholder="市编号" id="orderId" name="orderId">
						</div> -->
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">县名</span>
							<input type="text" class="form-control" placeholder="县名称" id="paramNameInput" name="productName">
						</div>
	<div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a class="btn btn-primary" id="queryBtn">查询</a>
	</div>
	<div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a class="btn btn-primary" id="addParam">新增</a>
	</div>
					</div>
					</form>
					<div id="projectable">
						<jsp:include page="county.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
