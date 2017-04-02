<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="projectable_asset">
	<thead>
		<tr>
			<th>订单编号</th>
			<th>在租公司</th>
			<th>在租人姓名</th>
			<th>在租人手机</th>
			<th>所属项目</th>
			<th>门牌号</th>
			<th>租用起始时间</th>
			<th>租用结束时间</th>
			<th>实际结束时间</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="BssAsset">
				<tr>
					<td class="center">${BssAsset.orderNo}</td>
					<td class="center">${BssAsset.companyName}</td>
					<td class="center">${BssAsset.userName}</td>
					<td class="center">${BssAsset.userPhone}</td>
					<td class="center">${BssAsset.projectName}</td>
					<td class="center">${BssAsset.houseNumber}</td>
					<td class="center">${BssAsset.startTime}</td>
					<td class="center">${BssAsset.endTime}</td>
					<td class="center">${BssAsset.actualEndTime}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/inRentAsset/showAsset?assetType=${assetType }" name="url" />
	<jsp:param value="projectable_asset" name="loadCmp" />
	<jsp:param value="formParam" name="formParam" />
</jsp:include>

