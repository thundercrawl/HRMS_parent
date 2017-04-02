<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info" id="cabinet_table">
	<thead>
		<thead>
		<tr role="row">
			<th>用户名称</th>
			<th>用户手机号</th>
			<th>公司名称</th>
			<th>项目名</th>
			<th>门编号</th>
			<th>开门时间</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td style="white-space: nowrap;">${c.userName}</td>
					<td style="white-space: nowrap;">${c.userPhone}</td>
					<td style="white-space: nowrap;">${c.companyName}</td>
					<td style="white-space: nowrap;">${c.projectName}</td>
					<td style="white-space: nowrap;">${c.doorName}</td>
					<td style="white-space: nowrap;">${c.createTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param  value="filter/thirdparty/bluetoothdoor/findBluetoothdoor?userName=${userName.replace(' ','+')}&userPhone=${userPhone}&companyName=${companyName}&doorName=${doorName}&startTime=${startTime.replace(' ','+')}&endTime=${endTime.replace(' ','+')}&projectId=${projectId}"	name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>


<script src="js/thirdparty/bluetoothdoor.js"></script>