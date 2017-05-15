<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>用户姓名</th>
			<th>考勤类型</th>
			<th>考勤时间</th>
			<th>考勤状态</th>
			<th>记录人</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
			<tr>
				<td class="center">${os.userName}</td>
				<td class="center">${os.signType}</td>
				<td class="center">${os.signTime}</td>
				<td class="center">${os.signStatus}</td>
				<td class="center"><a href="javaScript:void(0);" class="searchUser" data-userName="${os.createUserName}">${os.createUserName}</a></td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/sign/searchSign?userName=${searchParam.userName}&orgName=${searchParam.orgName}
&startTime=${searchParam.startTime}&endTime=${searchParam.endTime}&isLater=${searchParam.isLater}
&isEarly=${searchParam.isEarly}" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
</div>

<script src="js/hrms-sign/signTable.js"></script>
<script src="js/pagination.js"></script>