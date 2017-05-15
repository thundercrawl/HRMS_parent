<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>姓名</th>
			<th>手机号码</th>
			<th>部门</th>
			<th>职位</th>
			<th>月份</th>
			<th>基本工资</th>
			<th>补贴</th>
			<th>五险一金</th>
			<th>请假扣除款</th>
			<th>出差补贴款</th>
			<th>考勤扣除款</th>
			<th>总额</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
			<tr>
				<td class="center">${os.userName}</td>
				<td class="center">${os.userPhone}</td>
				<td class="center">${os.orgName}</td>
				<td class="center">${os.jobName}</td>
				<td class="center">${os.billDate}</td>
				<td class="center">${os.baseWage}</td>
				<td class="center">${os.subsidy}</td>
				<td class="center">${os.subsidyIns}</td>
				<td class="center">${os.leaveDeduction}</td>
				<td class="center">${os.businessSubsidy}</td>
				<td class="center">${os.signDeduction}</td>
				<td class="center">${os.subBill}</td>
				<td>
					<input type="button" class="btn btn-primary showDetail" data-billId="${os.billId}" value="查看详情"  >
				</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/wage/searchFinanceBill" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
</div>

<script src="js/hrms-wage/billTable.js"></script>
<script src="js/pagination.js"></script>