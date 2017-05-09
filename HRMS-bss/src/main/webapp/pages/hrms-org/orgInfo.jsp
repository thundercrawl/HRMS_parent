<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">部门管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">

				<div id="transfer-createOrg" style="display: none;">
				<form class="org-form org-form1 org-info" id="createOrg"
					  method="post" action="" style="margin-left: 25px;margin-bottom: 20px"  enctype="multipart/form-data">
					<div>
						<label>部门名称:</label> <input type="text"
																		 id="orgNameInput" />
					</div>
					<div>
						<label >上级部门:</label>
							<select name="parentOrg">
								<c:if test="${!(empty orgInfos)}">
									<c:forEach items="${orgInfos}" var="o">
										<option value="${o.orgId }">${o.orgName }</option>
									</c:forEach>
								</c:if>
							</select>
					</div>
					<div>
						<label>部门描述:</label> <input type="text"
																  id="orgDescInput" />
					</div>

				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary" id="createOrgSure">确定</a>
				</div>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary shiny" id="createOrgQuit">取消</a>
				</div>
				</form>
			</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门编号</span> <input type="text"
										class="form-control" placeholder="ID" id="orgIdS" value="${searchParam.orgId}"/>
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门名称</span> <input type="text"
										class="form-control" placeholder="部门名称" id="orgNameS" value="${searchParam.orgName}"/>
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">上级部门编号</span> <input type="text"
										class="form-control" placeholder="上级部门编号" id="parentOrgIdS" value="${searchParam.parentOrgId}"/>
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">上级部门名称</span> <input type="text"
										class="form-control" placeholder="上级部门名称" id="parentOrgNameS" value="${searchParam.parentOrgName}"/>
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forOrgSearch">查询</a>
								</div>
								<c:if test="${userInfo.isSM eq 1 or userInfo.isHR eq 1 }">
									<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
										<a class="btn btn-primary" class="btn btn-primary" id="addOrg">创建部门</a>
									</div>
								</c:if>
							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="orgTable.jsp"></jsp:include>
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
<script src="js/hrms-org/orgInfo.js"></script>