<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="class_item_fg">
	<table
		class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
		<thead>
			<tr>
				<th>公司名称</th>
				<th>科目名称</th>
				<th>金额</th>
				<th>是否允许退款</th>
				<th>是否允许提现</th>
				<th>是否允许转账</th>
				<th>生效时间</th>
				<th>失效时间</th>
			</tr>
		</thead>
		<tbody id="queryitem_fy">
			<c:if test="${!(empty paginator.list)}">
				<c:forEach items="${paginator.list}" var="project">
					<tr id="${project.walletId}tr">
						<td class="center">${project.companyName}</td>
						<td class="center">${project.itemName}</td>
						<td class="center">${project.fee}</td>
						<td class="center">
							<c:if test="${project.refundstatus=='0'}">否</c:if>
							<c:if test="${project.refundstatus=='1'}">是</c:if></td>
						<td class="center">
							<c:if test="${project.withDarwstatus=='0'}">否</c:if>
							<c:if test="${project.withDarwstatus=='1'}">是</c:if></td>
						<td class="center">
							<c:if test="${project.transferstatus=='0'}">否</c:if>
							<c:if test="${project.transferstatus=='1'}">是</c:if></td>
						<td class="center">${project.effectTime}</td>
						<td class="center">${project.loseTime}</td>

					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="../common/paginator.jsp">
		<jsp:param value="filter/wallet/compall" name="url" />
		<jsp:param value="company_wallet_info" name="loadCmp" />
		<jsp:param value="company_wallet_ip" name="formParam" />
	</jsp:include>
</div>
<script src="js/walletitem/companyWalletfirst.js"></script>