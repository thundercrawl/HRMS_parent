<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">销售员编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">中介客户编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">中介编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">客户姓名</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">公司名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">联系地址</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">联系电话</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">电子邮箱</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">行业名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">办公人数</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">意向房源（项目）</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">租赁开始日期</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">租赁结束日期</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">销售客户状态</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">处理时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">备注</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">申请时间</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td class=" " style="white-space: nowrap;">${c.salesman.wecUserId}</td>
					<td class=" " style="white-space: nowrap;">${c.mediaryCustId}</td>
					<td class=" " style="white-space: nowrap;">${c.intermediary.mediaryId}</td>
					<td class=" " style="white-space: nowrap;">${c.custName}</td>
					<td class=" " style="white-space: nowrap;">${c.companyName}</td>
					<td class=" " style="white-space: nowrap;">${c.contactAddr}</td>
					<td class=" " style="white-space: nowrap;">${c.contactTel}</td>
					<td class=" " style="white-space: nowrap;">${c.contactEmail}</td>
					<td class=" " style="white-space: nowrap;">${c.tradeName}</td>
					<td class=" " style="white-space: nowrap;">${c.peopleCnt}</td>
					<td class=" " style="white-space: nowrap;">${c.project.projectName}</td>
					<td class=" " style="white-space: nowrap;">${c.rentBeginDateStr}</td>
					<td class=" " style="white-space: nowrap;">${c.rentEndDateStr}</td>
					<td class=" " style="white-space: nowrap;">${c.statusStr}</td>
					<td class=" " style="white-space: nowrap;">${c.statusTimeStr}</td>
					<td class=" " style="white-space: nowrap;">${c.remark}</td>
					<td class=" " style="white-space: nowrap;">${c.applyTimeStr}</td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input
	value="salesman=${salesman}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/wec/showWecMediaryCustomer?salesman=${salesman}"
		name="url" />
	<jsp:param value="wecmediarycustomer_table" name="loadCmp" />
</jsp:include>
<script src="js/wec/wecmediarycustomer.js"></script>
<script src="js/pagination.js"></script>