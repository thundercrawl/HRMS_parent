<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>公司</th>
			<th>会员名称</th>
			<th>挂账时间</th>
			<th>生效时间</th>
			<th>失效时间</th>
			<th>挂账产品类型</th>
			<th>挂账产品</th>
			<th>操作人</th>
			<th>状态</th>
			<th>金额</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
		<td class="center">${os.companyName}</td>
			<td class="center">${os.userName}</td>
			<td class="center">${os.createTime}</td>
			<td class="center">${os.effectTime}</td>
			<td class="center">${os.lapsedTime}</td>
			<td class="center">${os.productTypeName}</td>
			<td class="center">${os.productName}</td>
			<td class="center">${os.adminName}</td>
			<td class="center">
			<c:if test="${os.status==0}">未结清</c:if>
			<c:if test="${os.status==1}">已结清</c:if>
			</td>
			<td class="center">${os.fee}</td>
		 	<td class="center">
		 	<c:if test="${os.adminId==adminId }">
		 	<button type="button" class="btn btn-primary shiny"  id="versionDelete" onclick="bookDelete(${os.bookId})">删除</button>
            </c:if>
	<%--		<button type="button" class="btn btn-primary shiny"  id="versionChange" onclick="versionChange(${os.versionId})">修改</button>
			<button type="button" class="btn btn-primary shiny"  id="getVersionUrl" onclick='getVersionUrl(${os.versionId})'>获取Url</button></td> --%>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/billSearch/getBillSearch" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>