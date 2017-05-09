<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">用户管理</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">

				<div id="transfer-alert2" style="display: none;">
				<form class="user-form user-form1 user-info" id="companyId1"
					  method="post" action="" style="margin-left: 25px;margin-bottom: 20px"  enctype="multipart/form-data">
					<div>
						<label for="userName">用户名称:</label> <input type="text"
																		 id="userNameInput" />
					</div>
					<div>
						<label for="userPhone">手机号:</label> <input type="text"
																   id="userPhoneInput" /> <span id="phonespan"></span>
					</div>
					<div>
						<label for="userSex">性别:</label>
							<input type="radio" checked="checked" name="userSexInput" value="1"/>男
							<input type="radio" name="userSexInput" value="2"/>女
							<span id="sexspan"></span>
					</div>
					<div>
						<label for="userOrg">用户部门:</label>
							<%--</label> <input type="text"
																										  id="userOrgInput" />--%>
							<select name="selectOrg">
								<%--<option selected="selected" value="1">最高部门</option>--%>
								<c:if test="${!(empty orgInfos)}">
									<c:forEach items="${orgInfos }" var="o">
										<option value="${o.orgId }">${o.orgName }</option>
									</c:forEach>
								</c:if>
							</select>
					</div>
					<div>
						<label for="userRole">用户权限:</label>
						<%--</label> <input type="text"
                                                                                                      id="userOrgInput" />--%>
						<select name="selectRole">
							<%--<option selected="selected" value="1">最高部门</option>--%>
							<c:if test="${!(empty roleInfos)}">
								<c:forEach items="${roleInfos}" var="o">
									<option value="${o.roleId }">${o.roleName }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div>
						<label for="userManager">部门经理:</label>
						<input type="radio" name="userManagerInput" value="1"/>是
						<input type="radio" checked="checked" name="userManagerInput" value="0"/>不是
						<span id="managerSpan"></span>
					</div>
					<div>
						<label for="jobName">用户职位:</label></label> <input type="text"
																								  id="jobNameInput" /><span id="jobspan"></span>
					</div>
					<div>
						<label for="userEmail">用户邮箱:</label></label> <input type="text"
																										 id="userEmailInput" /> <span id="eamilSpan"></span>
					</div>
					<div>
						<label for="userCard">身份证号:</label></label> <input type="text"
																											id="userCardInput" /> <span id="cardSpan"></span>
					</div>
					<div>
						<label for="userBirth">出生年月:</label></label> <input type="text"
																										 id="userBirthInput" /> <span id="birthSpan">格式2001-01-01</span>
					</div>
					<div>
						<label for="userWork">入职时间:</label></label> <input type="text"
																											id="userWorkInput" /> <span id="workSpan">格式2001-01-01</span>
					</div>
					<%--<div>
						<label for="userPhoto">用户头像</label>
							<form name="form1" method="post" enctype="multipart/form-data" action="http://localhost:8080/filter/image/upload?relId=${userInfo.user}">
								<input type="file" name="imgFile" value="请选择图片上传" style="width:160px;" />
								<input type="submit" name="Submit" value="上传" />
							</form>
					</div>--%>

				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary" id="userCreSure">确定</a>
				</div>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary shiny" id="userCreQuit">取消</a>
				</div>
				</form>
			</div>
				<div id="transfer-alert3" style="display: none;"></div>
				<div id="import-alert" style="display: none;">
					<p align="center">请选择需要上传的文件</p>
					<form id="excel_form" name="form1" method="post"
						action="" enctype="multipart/form-data">
						<table border="0" align="center">
							<tr>
								<td>上传文件</td>
								<td><input name="file" type="file" size="20" id="excelfile"></td>
							</tr>
							<tr>
								<td align="center"><input type="submit" name="submit" class="btn btn-primary" value="提交" id="excelsure">
									<input type="reset" name="reset" class="btn btn-primary" value="重置"></td>
							</tr>
						</table>
					</form>
				</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">工号</span> <input type="text"
										class="form-control" placeholder="ID" id="userID"
										name="userID" value="${searchParam.userID}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">姓名</span> <input type="text"
										class="form-control" placeholder="姓名" id="userName"
										name="userName" value="${searchParam.userName}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">职位</span> <input type="text"
										class="form-control" placeholder="职位" id="jobName"
										name="jobName" value="${searchParam.jobName}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门</span> <input type="text"
										class="form-control" placeholder="部门" id="orgName"
										name="orgName" value="${searchParam.orgName}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">手机号</span> <input
										type="text" class="form-control" placeholder="手机号码"
										id="userPhone" name="userPhone" value="${searchParam.userPhone}">
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forUserSearch">查询</a>
								</div>
								<c:if test="${userInfo.isHR eq 1 }">
									<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
										<a class="btn btn-primary" class="btn btn-primary" id="userCreate">创建用户</a>
									</div>
									<div class="input-group col-md-1 colLee" >
										<a href="javaScript:void(0);" class="btn btn-primary"
										   id="importUserExcel">批量导入</a>
									</div>
								</c:if>
							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="comtable.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script src="js/jquery/jquery.form.js"></script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/hrms-user/user.js"></script>
