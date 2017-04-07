<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>工号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>年龄</th>
			<th>部门名</th>
			<th>手机号</th>
			<th>职位</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.userId}</td>
			<td class="center">${os.userName}</td>
			<c:if test="${os.sex eq 1 }">
			<td class="center">男</td>
			</c:if>
			<c:if test="${os.sex eq 0 }">
			<td class="center">女</td>
			</c:if>
			<td class="center">${os.userAge}</td>
			<td class="center">部门</td>
			<td class="center">${os.userPhone}</td>
			<td class="center">职位</td>
			
		<td>
				<input type="button" id="comChange" class="btn btn-primary" value="修改" onclick="">
				<input type="button" id="comArea" class="btn  btn-primary " value="禁用" onclick="">
				<input type="button" id="companyDel" class="btn btn-primary" value="解禁"  onclick="">
				<input type="button" id="companyDel" class="btn btn-primary" value="删除"  onclick="">
		</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>


<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/user/searchUser" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>