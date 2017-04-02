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
		<tr><th></th>
			<th>手机号</th>
			<th>姓名</th>
			<th>门的名称</th>
			<th>终端名称</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="os">
				<tr>
					<td>
						<div class="checkbox">
							<label> <input type="checkbox" id="blankCheckbox"
								value="${os.doorId.doorId}" name="tt" aria-label="...">
							</label>
						</div>
					</td>
					<td class="center">${os.userId.userPhone}</td>
					<td class="center">${os.userId.userName}</td>
					<td class="center">${os.doorId.doorName}</td>
					<td class="center">${os.doorId.deviceSys.stationName}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/readCard/getLostCardSearch?userName=${userName}" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
