<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">订单管理/订单查询</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div >
				<form id="queryForm">
					<div>
						<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">订单编号</span>
							<input type="text" class="form-control" placeholder="订单编号" id="orderId" name="orderId" value="${orderId }">
						</div>
						<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">公司名称</span>
							<input type="text" class="form-control" placeholder="公司名称" id="companyName" name="companyName" value="${companyName }">
						</div>
						<div class="input-group col-md-5" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">下单时间</span>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择起始时间" id="orderStartTime" name="orderStartTime" value="${orderStartTime }" />
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择终止时间" id="orderEndTime" name="orderEndTime" value="${orderEndTime }" />
						</div>
					</div>
					<div>
						<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">会员名称</span>
							<input type="text" class="form-control" placeholder="会员名称" id="userName" name="userName"  value="${userName }" >
						</div>
						<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">订单状态</span>
							<input type="hidden" class="form-control" placeholder="订单状态" id="orderStatus" value="0" name="orderStatus">
							<div class="btn-group form-control" style="padding: 0;">
							<button type="button" class="btn btn-default form-control dropdown-toggle"
								 data-toggle="dropdown"><span id="orderStatusSpan" value="0" >所有</span><span class="caret" style="margin-left: 5px;"></span></button>
							   <input type="hidden"  id="orderStatusInput" value="${status}" name="orderStatusInput">
							   <ul class="dropdown-menu" role="menu" id="selectStatus">
							   	<%-- <c:forEach items="${statusMap }" var="status">
							   		<li data-value="${status.key }"><a>${status.value }</a></li>
							   	</c:forEach> --%>
							   	<li data-value="0"><a>所有</a></li>
							   	<li data-value="1"><a>交易成功</a></li>
							   	<li data-value="2"><a>记录删除</a></li>
							   	<li data-value="3"><a>交易关闭</a></li>
							   	<li data-value="4"><a>交易保留</a></li>
							   	<li data-value="5"><a>交易等待</a></li>
							   	<li data-value="6"><a>交易签订</a></li>
							   	<li data-value="7"><a>交易履行中</a></li>
							   	<li data-value="8"><a>未付款</a></li>
							   </ul>
							</div>
						</div>
						 <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a class="btn btn-primary" id="queryBtn">查询</a>
	</div>
						
					</div>
					</form>
      </div>
					<div id="projectable">
						<jsp:include page="order.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

