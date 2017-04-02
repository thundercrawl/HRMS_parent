<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="class_item_fg">
	<table
		class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
		<thead>
			<tr>
				<th>推送编号</th>
				<th>消息内容</th>
				<th>推送范围</th>
				<th>接收者</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>消息类型</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="queryitem_fy">
			<c:if test="${!(empty paginator.list)}">
				<c:forEach items="${paginator.list}" var="project">
					<tr>
						<td class="center">${project.emsId}</td>
						<td class="center">${project.msgContent}</td>
						<td class="center">
							<c:if
								test="${project.sendType=='1'}">全量推送</c:if> 
								<c:if
								test="${project.sendType=='2'}">按公司推送</c:if>
								<c:if
								test="${project.sendType=='3'}">按个人推送</c:if></td>
						<td class="center">${project.sendPre}</td>
						<td class="center">${project.adminId}</td>
						<td class="center">${project.createTime}</td>
						<td class="center" 
							value="${project.emsType}"><c:if
								test="${project.emsType=='1'}">系统消息</c:if> 
								<c:if
								test="${project.emsType=='2'}">社区消息</c:if>
								<c:if
								test="${project.emsType=='3'}">其他消息</c:if>
								</td>
						<td><a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit updateitem"
							value="${project.emsId}"><i class="fa fa-edit"></i>修改</a>
						</td>

					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="../common/paginator.jsp">
		<jsp:param value="filter/ems/showEmsInfo" name="url" />
		<jsp:param value="ems_page_info" name="loadCmp" />
		<jsp:param value="query_emsparams" name="formParam" />
	</jsp:include>
</div>
<link href="css/walletItem.css" rel="stylesheet">
<script src="js/ems/emsPageI.js"></script>