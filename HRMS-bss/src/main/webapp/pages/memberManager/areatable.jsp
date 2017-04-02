<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>项目名称</th>
			<th>办公室名称</th>
			<th>门牌号</th>
			<th>所属层楼</th>
			<th>租期起始时间</th>
			<th>租期终止时间</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.projectname}</td>
			<td class="center">${os.officename}</td>
			<td class="center">${os.doornumber}</td>
			<td class="center">${os.floor}</td>
			<td class="center">${os.starttime}</td>
			<td class="center">${os.endtime}</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>	
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/member/getAreaSearch?companyId=${ companyId}&companyName=${companyName }" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParamName"/>
</jsp:include>
