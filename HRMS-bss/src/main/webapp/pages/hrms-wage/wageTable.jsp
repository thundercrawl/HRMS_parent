<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>姓名</th>
			<th>电话</th>
			<th>部门</th>
			<th>基本工资</th>
			<th>话费补贴</th>
			<th>五险一金</th>
			<th>其他补贴</th>
			<th>其他补贴说明</th>
			<th>操作人</th>
			<th>创建时间</th>
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
				<td class="center">${os.baseWage}</td>
				<td class="center">${os.subsidyPhone}</td>
				<td class="center">${os.subsidyIns}</td>
				<td class="center">${os.subsidyOther}</td>
				<td class="center">${os.subsidyOtherDesc}</td>
				<td class="center">${os.createUserName}</td>
				<td class="center">${os.createTime}</td>
				<td>
					<input type="button" class="btn btn-primary updateWage" data-userId="${os.userId}" data-wageId="${os.wageId}" value="调整薪资"  >
				</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<div id="transfer-alertWage" style="display: none;">
	<form class="wage-form wage-form1 wage-info" id="alterWage"
		  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
		<div>
			<label >基本工资:</label> <input type="number"
										 id="baseWageInput" />
		</div>
		<div>
			<label >话费补贴:</label> <input type="number"
										 id="subsidyPhoneInput" />
		</div>
		<div>
			<label >其他补贴:</label> <input type="number"
										 id="subsidyOtherInput" />
		</div>
		<div>
			<label >其他补贴描述:</label> <input type="text" size="256"
										 id="subsidyOtherDescInput" />
		</div>
	</form>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" class="btn btn-primary" id="alterWageSure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" class="btn btn-primary shiny" id="alterWageQuit">取消</a>
	</div>
</div>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/wage/searchWage" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
</div>

<script src="js/hrms-wage/wageTable.js"></script>
<script src="js/pagination.js"></script>