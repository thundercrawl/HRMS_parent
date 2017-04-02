<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info" id="cabinet_table">
	<thead>
		<thead>
		<tr role="row">
			<th>类型</th>
			<th>公司名称</th>
			<th>会员名称</th>
			<th>保证金</th>
			<th>操作人</th>
			<th>订单编号</th>
			<th>订单总金额</th>
			<th>下单时间</th>
			<th>状态</th>
			<th>挂账产品类型</th>
			<th>挂账产品名称</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td style="white-space: nowrap;">${c.type}</td>
					<td style="white-space: nowrap;">${c.companyName}</td>
					<td style="white-space: nowrap;">${c.userName}</td>
					<td style="white-space: nowrap;">${c.fee}</td>
					<td style="white-space: nowrap;">${c.adminName}</td>
					<td style="white-space: nowrap;">${c.orderNo}</td>
					<td style="white-space: nowrap;">${c.totalPrice}</td>
					<td style="white-space: nowrap;">${c.orderTime}</td>
					<td style="white-space: nowrap;">${c.statusName}</td>
					<td style="white-space: nowrap;">${c.productTypeName}</td>
					<td style="white-space: nowrap;">${c.productName}</td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param  value="filter/deposit/finddeposit?userName=${search.userName }&userPhone=${search.userPhone }&companyName=${search.companyName }&orderNo=${search.orderNo }&salerName=${search.salerName }&orderStartTime=${search.orderStartTime }&orderEndTime=${search.orderEndTime }&status=${search.status }"	name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
<script src="js/deposit/deposit.js"></script>

