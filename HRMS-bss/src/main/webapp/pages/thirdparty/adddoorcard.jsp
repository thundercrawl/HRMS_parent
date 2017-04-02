<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">添加授权</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<font style="color: red;">*请先填写订单编号</font><br>
				<div>
					<form action="">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">订单编号</span> <input type="text"
								class="form-control" placeholder="请输入订单编号" id="orderid"
								value="${orderid}">
						</div>
						
						<div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"  onclick="findordermessage()">确定</a>
		</div>
						

					</form>
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="showordermessage.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
