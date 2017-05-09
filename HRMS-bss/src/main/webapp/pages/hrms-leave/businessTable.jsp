<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>审批流水号</th>
			<th>提交人</th>
			<th>提交时间</th>
			<th>审核人</th>
			<th>审核时间</th>
			<th>审核状态</th>
			<th>出差事由</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
			<tr>
				<td class="center">${os.leaveCode}</td>
				<td class="center">${os.userName}</td>
				<td class="center">${os.upTime}</td>
				<td class="center"><a href="javaScript:void(0);" data-param="${os.approveUserName}" class="searchApproveUser">${os.approveUserName}</a></td>
				<td class="center">${os.approveTime}</td>
				<td class="center">${os.leaveStatus}</td>
				<td class="center">${os.leaveContent}</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/leave/searchBusiness" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
</div>

<script src="js/hrms-leave/businessTable.js"></script>
<script src="js/pagination.js"></script>