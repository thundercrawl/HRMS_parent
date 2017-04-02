<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="my-table" style="display:none;">
	<thead>
		<tr>
			<th></th>
			<th>用户名</th>
			<th>手机号</th>
			<th>创建时间</th>
			<!-- <th class="mkwidth">项目名</th> -->
		</tr>
	</thead>
	<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.userName}</td>
			<td class="center">${os.userPhone}</td>
			<td class="center">${os.creatTime}</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>	
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/readCard/getBossCardSearch" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>