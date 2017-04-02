<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>会员ID</th>
			<th>姓名</th>
			<th>身份证号码</th>
			<th>电话</th>
			<th>性别</th>
			<th>年龄</th>
			<th>邮箱</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.userId}</td>
			<td class="center">${os.userName}</td>
			<td class="center">${os.userIdcard}</td>
			<td class="center">${os.userPhone}</td>
			<td class="center">${os.userSex}</td>
			<td class="center">${os.userAge}</td>
			<td class="center">${os.userMail}</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>	
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/member/companyDetails" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>