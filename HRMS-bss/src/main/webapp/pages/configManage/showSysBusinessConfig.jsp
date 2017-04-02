<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">系统管理/业务相关配置</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form id="queryForm" onsubmit="return false">
						<!-- <div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">参数code</span>
							<input type="text" class="form-control" placeholder="参数code" id="orderId" name="orderId">
						</div> -->
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">参数名称</span>
							<input type="text" class="form-control" placeholder="参数名称" id="paramNameInput" name="productName">
						</div>
						<!-- <div class="input-group col-md-5" style="display: inline-table;">
							<span class="input-group-addon">创建时间</span>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择起始时间" id="startTime" name="startTime"/>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择终止时间" id="endTime" name="endTime"/>
						</div> -->
						<%-- <div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">参数值</span>
							<input type="text" class="form-control" placeholder="参数值" id="buyerName" name="buyerName">
						</div>
						<div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">操作员</span>
							<input type="text" class="form-control" placeholder="操作员" id="sellerName" name="sellerName">
						</div>
						<div class="input-group col-md-2" style="display: inline-table;">
							<span class="input-group-addon">订单状态</span>
							<input type="hidden" class="form-control" placeholder="订单状态" id="orderStatus" value="0" name="orderStatus">
							<div class="btn-group form-control" style="padding: 0;">
							<button type="button" class="btn btn-default form-control dropdown-toggle"
								 data-toggle="dropdown"><span>所有</span><span class="caret" style="margin-left: 5px;"></span></button>
							   <ul class="dropdown-menu" role="menu" id="orderStatusUl">
							   	<c:forEach items="${statusMap }" var="status">
							   		<li data-value="${status.key }"><a>${status.value }</a></li>
							   	</c:forEach>
							   </ul>
							</div>
						</div> --%>
						
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a class="btn btn-primary" id="queryBtn">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a class="btn btn-primary" id="addParam">新增</a>
						</div>
					</form>
					<div id="projectable">
						<jsp:include page="sysBusinessConfig.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
