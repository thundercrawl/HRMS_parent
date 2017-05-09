<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>部门编号</th>
			<th>部门名称</th>
			<th>上级部门名称</th>
			<th>创建时间</th>
			<th>创建者</th>
			<th>部门经理</th>
			<th>部门描述</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<%--<td class="center"  ><u style="color: #00a6fc">${os.userID}</u></td>--%>
			<%--<td class="center"><a href="javaScript:void(0);" onclick="showPersonMessage(${os.userID})">${os.userID}</a> </td>--%>
			<td class="center">${os.orgId}</td>
				<td class="center">${os.orgName}</td>
				<td class="center"><a href="javaScript:void(0);" data-param="${os.parentOrgName}" class="searchParentOrg">${os.parentOrgName}</a></td>
				<td class="center">${os.createTime}</td>
			<%--<td class="center"><a href="filter/user/getUserFromOrg?userName=${os.createUserName}" data-param="${os.createUserName}" id="searchCreateUser">${os.createUserName}</a></td>--%>
				<td class="center"><a href="javaScript:void(0);" data-param="${os.createUserName}" class="searchCreateUser">${os.createUserName}</a></td>
				<td class="center"><a href="javaScript:void(0);" data-param="${os.orgManagerName}" class="searchOrgManager">${os.orgManagerName}</a></td>
			<td class="center">${os.orgDesc}</td>

		<td>
			<input type="button" class="btn btn-primary searchMember"  data-orgName="${os.orgName}" value="部门成员" >
			<c:if test="${os.hasRole eq 1 }">
				<input type="button" class="btn btn-primary addMember" data-orgID="${os.orgId}" value="添加成员" >
				<input type="button" class="btn btn-primary alterOrg" data-orgID="${os.orgId}" value="修改" >
				<input type="button" data-orgID="${os.orgId}" class="btn btn-primary deleteOrg" value="删除"  >
			</c:if>
			<%--<c:if test="${os.hasRole eq 0 }">
				<input type="button" disabled="true" class="btn btn-primary" value="添加成员" >
				<input type="button" disabled="true" id="alter" class="btn btn-primary" value="修改" >
				<input type="button" disabled="true" class="btn btn-primary" value="删除"  >
			</c:if>--%>
		</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/org/searchOrg" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
</jsp:include>
<%--修改部门信息--%>
<div id="transfer-alertOrg" style="display: none;">
	<form class="org-form org-form1 org-info" id="alterOrg"
		  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
		<div>
			<label >部门名称:</label> <input type="text"
													  id="orgNameInputA" />
		</div>
		<div>
			<label >上级部门:</label>
			<select name="parentOrgA">
				<c:if test="${!(empty orgInfos)}">
					<c:forEach items="${orgInfos}" var="o">
						<option value="${o.orgId }">${o.orgName }</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
		<div>
			<label >部门描述:</label> <input type="text"
													  id="orgDescInputA" />
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
<%--输入会员名称，查询会员--%>
<div id="transfer-inputMember" style="display: none;">
	<form class="member-form member-form1 member-info" id="inputMember"
		  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
		<div>
			<label >成员名称:</label> <input type="text"
										 id="memberNameInput" value="%%"/>
		</div>
	</form>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" href="javaScript:void(0);" class="btn btn-primary" id="inputMemberSure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee"
		 style="margin: 2px 0; display: inline-block;">
		<a type="button" class="btn btn-primary shiny" id="inputMemberQuit">取消</a>
	</div>
</div>
<%--选择成员--%>

<div id="transfer-addMember" style="display: none">
		<form class="member-form member-form2 member-info" id="addMember"
			  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
		<div>
			<label >用户名称：</label>
			<select name="userIdSelect" id="selectTab">

				<%--<c:if test="${!(empty userBaseInfos)}">
					<c:forEach items="${userBaseInfos}" var="o">
						<option value="${o.userId }">${o.userName }</option>
					</c:forEach>
				</c:if>--%>
			</select>
		</div>
		<div>
			<label >用户职位：</label>
			<input type="text" id="addMemberJobName"/>
		</div>
		<div>
			<label >是否为经理：</label>
			<input type="radio" name="isManager" value="1"/>是
			<input type="radio" name="isManager" checked="checked" value="0"/>不是
		</div>

	</form>
		<div class="input-group col-md-3 colLee"
			 style="margin: 2px 0; display: inline-block;">
			<a type="button" class="btn btn-primary" id="addMemberSure">确定</a>
		</div>
		<div class="input-group col-md-3 colLee"
			 style="margin: 2px 0; display: inline-block;">
			<a type="button" class="btn btn-primary shiny" id="addMemberQuit">取消</a>
		</div>

</div>
</div>

<script src="js/hrms-org/orgTable.js"></script>
<script src="js/pagination.js"></script>