<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>工号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>年龄</th>
			<th>部门名</th>
			<th>手机号</th>
			<th>职位</th>
			<th>状态</th>
			<c:if test="${userInfo.isHR eq 1 }">
				<th>操作</th>
			</c:if>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<%--<td class="center"  ><u style="color: #00a6fc">${os.userID}</u></td>--%>
			<%--<td class="center"><a href="javaScript:void(0);" onclick="showPersonMessage(${os.userID})">${os.userID}</a> </td>--%>
			<td class="center"><a href="javaScript:void(0);" class="showPersonalPage" data-userId="${os.userID}">${os.userID}</a> </td>
			<td class="center">${os.userName}</td>
			<c:if test="${os.userSex eq 1 }">
				<td class="center">男</td>
			</c:if>
			<c:if test="${os.userSex eq 2 }">
				<td class="center">女</td>
			</c:if>
			<td class="center">${os.userAge}</td>
				<td class="center"><a href="javaScript:void(0);" class="searchOrg" data-orgName="${os.orgName}">${os.orgName}</a></td>
			<td class="center">${os.userPhone}</td>
			<td class="center">${os.jobName}</td>
			<td class="center">${os.workStatusMessage}</td>
				<c:if test="${os.hasRole eq 1 }">
				<td>
						<input type="button" class="btn btn-primary resetPwd" data-userID="${os.userID}" value="重置密码"  >
						<input type="button" class="btn btn-primary alter" data-userID="${os.userID}" value="修改" >
						<c:if test="${os.workStatus eq 0 }">
							<input type="button" data-userID="${os.userID}" class="btn btn-primary unlockUser" value="解禁"  >
						</c:if>
						<c:if test="${os.workStatus eq 1 }">
							<input type="button"  data-userID="${os.userID}" class="btn  btn-primary lockUser" value="禁用" >
						</c:if>
						<c:if test="${os.orgID ne 0}">
							<input type="button" data-userID="${os.userID}"  data-orgId="${os.orgID}" class="btn btn-primary deleteFromOrg" value="移出部门"  >
						</c:if>
						<input type="button" data-userID="${os.userID}" class="btn btn-primary deleteUser" value="删除"  >
				</td>
			</c:if>

			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/user/searchUser" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
<div id="transfer-alert1" style="display: none;">
	<form class="user-form user-form1 user-info" id="alterUser"
		  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
		<div>
			<label for="alterUserName">用户名称<font style='color:red'>*</font>：</label> <input type="text"
																							id="alterUserNameInput" /> <span id="alterNameSpan"></span>
		</div>
		<div>
			<label for="alterUserPhone">手机号码<font style='color:red'>*</font>：</label> <input type="text"
																							 id="alterUserPhoneInput" /> <span id="alterPhoneSpan"></span>
		</div>
		<div>
			<label for="alterUserEmail">用户邮箱<font style='color:red'>*</font>：</label> <input type="text"
																							 id="alterUserEmailInput" /> <span id="alterEamilSpan"></span>
		</div>
		<div>
			<label for="alterUserBirth">出生年月<font style='color:red'>*</font>：</label> <input type="text"
																							 id="alterUserBirthInput" /> <span id="alterBirthSpan"></span>
		</div>
		<div>
			<label for="alterUserSex">性别<font style='color:red'>*</font>：</label>
			<input type="radio" name="sex" value="1" /> 男
			<input type="radio" name="sex" value="2" /> 女

		</div>
	</form>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" class="btn btn-primary" id="alterUserSure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" class="btn btn-primary shiny" id="alterUserQuit">取消</a>
	</div>
</div>
</div>



<script src="js/hrms-user/comTable.js"></script>
<script src="js/pagination.js"></script>