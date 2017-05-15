<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>审批流水号</th>
			<th>提交人</th>
			<th>开始时间</th>
			<th>结束时间</th>
			<th>提交时间</th>
			<th>审核状态</th>
			<th>事由</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
			<tr>
				<td class="center" class="showApprove" data-leaveId="${os.leaveId}">${os.leaveCode}</td>
				<td class="center">${os.userName}</td>
				<td class="center">${os.startTime}</td>
				<td class="center">${os.endTime}</td>
				<td class="center">${os.upTime}</td>
				<td class="center">待审核</td>
				<td class="center">${os.leaveContent}</td>
				<td>
					<input type="button" class="btn btn-primary showApprove" data-leaveId="${os.leaveId}" value="查看详情"  >
					<input type="button" class="btn btn-primary pass" data-leaveId="${os.leaveId}" value="通过"  >
					<input type="button" class="btn btn-primary reject" data-leaveId="${os.leaveId}" value="驳回" >
				</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<div id="transfer-showApprove" style="display: none;">
	<form class="detail-form detail-form1 detail-info" id="approveDetail"
		  method="post" action="" style="margin-left: 25px;margin-bottom: 20px"  enctype="multipart/form-data">
		<div >
			<label style="float: left">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</label>
			<p id="userName"/>
		</div>
		<div >
			<label style="float: left">手机号码:</label>
			<p id="userPhone"/>
		</div>
		<div >
			<label style="float: left">部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门:</label>
			<p id="orgName"/>
		</div>
		<div >
			<label style="float: left">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位:</label>
			<p id="jobName"/>
		</div>
		<div >
			<label style="float: left">流水编号:</label>
			<p id="leaveCodeD"/>
		</div>
		<div >
			<label style="float: left">开始时间:</label>
			<p id="startTime"/>
		</div>
		<div >
			<label style="float: left">结束时间:</label>
			<p id="endTime"/>
		</div>
		<div >
			<label style="float: left">提交时间:</label> <p id="upTime"/>
		</div>
		<div >
			<label style="float: left">事&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由:</label><p id="leaveContent" style="overflow-x: auto"></p>
		</div>
		<div class="input-group col-md-3 colLee"
			 style="margin: 2px 0; display: inline-block;">
			<a type="button" class="btn btn-primary" id="approvePass">通过</a>
		</div>
		<div class="input-group col-md-3 colLee"
			 style="margin: 2px 0; display: inline-block;">
			<a type="button" class="btn btn-primary" id="approveReject">驳回</a>
		</div>
		<div class="input-group col-md-3 colLee"
			 style="margin: 2px 0; display: inline-block;">
			<a type="button" class="btn btn-primary" id="approveQuit">取消</a>
		</div>
	</form>
</div>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/leave/searchApprove" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
</div>

<script src="js/hrms-leave/approveTable.js"></script>
<script src="js/pagination.js"></script>