<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
		    <th><input type="checkbox" onclick="check(this)">&nbsp;全选/全不选</th>
			<th>敏感关键词</th>
            <th>创建时间</th>
            <th>创建者</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
		    <td><input type="checkbox" name="check" value="${project.sensitiveId}"></td>
			<td>${project.sensitiveName}</td>
			<td>${project.createTime}</td>
			<td>${project.operName}</td>
			<td>
			  <a href="javaScript:void(0)" class="btn btn-info btn-xs updateScene" data-id="${project.sensitiveId}" 
			  sname="${project.sensitiveName}"><i class="fa fa-trash-o"></i>修改</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/forum/showcolation?name=" name="url"/>
	<jsp:param value="colationtable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
<script src="js/forum/showColation.js"></script>
<script src="js/pagination.js"></script>
