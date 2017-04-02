<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">项目详情</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">楼层编号</span> <input type="text"
								class="form-control" placeholder="楼层编号" id="floorCode"
								name="orderId">
						</div>

						<div class="input-group col-md-1 colLee">
							<a href="javaScript:void(0);" class="btn btn-primary" id="findDetail">查询</a>
						</div>
						<div class="input-group col-md-1 colLee">
							<a href="javaScript:void(0);" class="btn btn-primary" id="addDetail">添加</a>
						</div>
						<div class="input-group col-md-5 colLee">
							<span id="textspan" style="margin-top: -43px; margin-left: 6px;color: red;display: none;">请输入合法的楼层编号</span>
						</div>
					</form>
					<input type="hidden" id="formParam" value="" />
					<div id="details" style="margin-top: 11px;">
						<jsp:include page="details.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>