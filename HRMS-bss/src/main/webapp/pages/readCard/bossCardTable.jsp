<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="my-table">
	<thead>
		<tr>
			<th></th>
			<th>项目地</th>
			<th>门名</th>
			<th>门牌号</th>
			<!-- <th class="mkwidth">项目名</th> -->
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="os">
				<tr>
					<td>
						<div>
						<input type="checkbox" id="blankCheckbox"
								value="${os[1].doorId}" name="tt" class="checkTt" aria-label="...">
						</div>
					</td>
					<td class="center">${os[1].project.projectName}</td>
					 <td class="center">${os[1].doorName}</td>
					<td class="center">${os[1].doorNumber}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/readCard/getBossSearch?projectId=${projectId}&doorNumber=${doorNumber}" name="url"/>
	<jsp:param value="bossId" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
