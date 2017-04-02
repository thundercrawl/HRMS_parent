<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">小储物柜编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">大储物柜编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">公司名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">会员名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">所属项目</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">租用时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">到期时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">操作</th>
		<!-- 	<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">取出时间</th> -->
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td class=" " style="white-space: nowrap;">${c.cabinetDetailNo}</td>
					<td class=" " style="white-space: nowrap;">${c.code}</td>
					<td class=" " style="white-space: nowrap;">${c.companyName}</td>
					<td class=" " style="white-space: nowrap;">${c.userName}</td>
					<td class=" " style="white-space: nowrap;">${c.projectName}</td>
					<td class=" " style="white-space: nowrap;">${c.cabinetTime}</td>
					<td class=" " style="white-space: nowrap;">${c.endTime}</td>
				    <td class=" " style="white-space: nowrap;"> 
				   <a href="javaScript:void(0);" class="btn btn-info btn-xs "
						onclick="resetRecord(${c.hireId})">
						<i class="fa fa-edit"></i>重置
					</a></td>
				<%-- 	<td class=" " style="white-space: nowrap;">${c.outTime}</td> --%>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input value="" style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/cabinethire/showcabinethire?code=${code}&cabinetdetailid=${cabinetdetailid}&username=${username}&companyname=${companyname}&projectid=${projectid}&fromstarttime=${fromstarttime}&tostarttime=${tostarttime}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<script src="js/thirdparty/cabinethire.js"></script>