<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">订单押金</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="" id="forid">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">会员名称</span> <input type="text"
								class="form-control" placeholder="请输入会员名全称" id="userName"
								value="${search.userName }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">会员手机号</span> <input type="text"
								class="form-control" placeholder="请输入会员手机号" id="userPhone"
								value="${search.userPhone }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">公司名称</span> <input type="text"
								class="form-control" placeholder="请输入公司名全称" id="companyName"
								value="${ search.companyName}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">订单编号</span> <input type="text"
								class="form-control" placeholder="订单编号" id="orderNo"
								name="orderNo" value="${search.orderNo }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">操作人（下单人）</span> <input type="text"
								class="form-control" placeholder="操作人（下单人）" id="salerName"
								name="salerName" value="${search.salerName }">
						</div>
						<div class="input-group col-md-5"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">下单（出账）时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;" readonly
								placeholder="选择起始时间" id="orderStartTime" name="orderStartTime"
								value="${search.orderStartTime }" /> <input type="text"
								class="form-control form_datetime" style="width: 50%;" readonly
								placeholder="选择终止时间" id="orderEndTime" name="orderEndTime"
								value="${search.orderEndTime }" />
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">类型</span><select name="unit"
								id="status" class="form-control" type="select">
								<c:if test="${search.status==null||search.status==''}">
									<option value="">全部</option>
									<option value="1">订单</option>
									<option value="2">挂账</option>
								</c:if>
								<c:if test="${search.status!=null&&search.status!=''}">
									<c:if test="${search.status==1}">
										<option value="1">订单</option>
										<option value="2">挂账</option>
										<option value="">全部</option>
									</c:if>
									<c:if test="${search.status==2}">
										<option value="2">挂账</option>
										<option value="1">订单</option>
										<option value="">全部</option>
									</c:if>
									<c:if test="${search.status==null}">
										<option value="">全部</option>
										<option value="1">订单</option>
										<option value="2">挂账</option>
									</c:if>
									</c:if>
							</select>
						</div>
						<div class="input-group col-md-1 colLee">
							<a href="javaScript:void(0);" class="btn btn-primary"
								id="finddeposit" onclick="finddeposit()"
								style="margin-left: 14px;">查询</a>
						</div>

					</form>
					<input type="hidden" value="" id="bluetoothCondition">
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="deposit.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<script src="js/pagination.js"></script>
