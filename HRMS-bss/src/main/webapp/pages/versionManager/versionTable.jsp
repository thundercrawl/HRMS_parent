<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>版本号</th>
			<th>终端</th>
			<th>功能介绍</th>
			<th>创建时间</th>
			<th>操作员</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.versionNumber}</td>
			<c:if test="${os.versionType==2}">
			  <td class="center">Android</td>
			 </c:if>
			<c:if test="${os.versionType==1}">
			  <td class="center">IOS</td>
			 </c:if>
			
			<td class="center">${os.updateTips}</td>
			<td class="center">${os.createTime}</td>
			<td class="center">${os.operName}</td>
			<input type="hidden" id="${os.versionId}" value="${os.url}"/>
			<input type="hidden" id="${os.versionId}" value="${os.url}"/>
			<input type="hidden" id="${os.versionId}type" value="${os.versionType}"/>
			<td class="center"><button type="button" class="btn btn-primary shiny"  id="versionDelete" onclick="versionDelete(${os.versionId})">删除</button>
			<button type="button" class="btn btn-primary shiny"  id="versionChange" onclick="versionChange(${os.versionId})">修改</button>
			<button type="button" class="btn btn-primary shiny"  id="getVersionUrl" onclick='getVersionUrl(${os.versionId})'>获取Url</button></td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/version/getVersionSearch" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>