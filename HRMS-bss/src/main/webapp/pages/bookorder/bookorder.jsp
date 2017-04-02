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
				<th>科目名称</th>
				<th>创建时间</th>
				<th>是否允许退款</th>
				<th>是否允许提现</th>
				<th>是否允许转账</th>
				<th>科目介绍</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="queryitem_fy">
			<%-- <c:if test="${!(empty paginator.list)}">
				<c:forEach items="${paginator.list}" var="project">
					<tr id="${project.walletItemId}tr">
						<td class="center" id="${project.walletItemId}name">${project.walletItemName}</td>
						<td class="center" id="${project.walletItemId}time">${project.createTime}</td>
						<td class="center" id="${project.walletItemId}refu" value="${project.refundStatus}">
							<c:if test="${project.refundStatus=='0'}">否</c:if>
							<c:if test="${project.refundStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}with" value="${project.withdrawStatus}">
							<c:if test="${project.withdrawStatus=='0'}">否</c:if>
							<c:if test="${project.withdrawStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}tran" value="${project.transferStatus}">
							<c:if test="${project.transferStatus=='0'}">否</c:if>
							<c:if test="${project.transferStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}desc">${project.walletItemDesc}</td>
						<td>
							<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updateitem" value="${project.walletItemId}"><i class="fa fa-edit"></i>修改</a>
							<a href="javaScript:void(0);" class="btn btn-danger btn-xs deleteitem" value="${project.walletItemId}"><i class="fa fa-trash-o"></i>删除</a>
						</td>

					</tr>
				</c:forEach>
			</c:if> --%>
		</tbody>
	</table>
	<jsp:include page="../common/paginator.jsp">
		<jsp:param value="filter/wallet/all" name="url" />
		<jsp:param value="wallet_item_info" name="loadCmp" />
		<jsp:param value="wallt_item_ip" name="formParam" />
	</jsp:include>

<link href="css/walletItem.css" rel="stylesheet">
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/bookorder/bookorderfirst.js"></script>
