<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">工资管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">

				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">用户名称</span> <input type="text"
										class="form-control" placeholder="用户名称" id="userName" value="${searchParam.userName}"/>
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">手机号码</span>
									<input type="text" class="form-control" placeholder="手机号码" id="userPhone" value="${searchParam.userPhone}"/>
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门名称</span>
									<input type="text" class="form-control" placeholder="部门名称" id="orgName" value="${searchParam.orgName}"/>
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forWageSearch">查询</a>
								</div>
								<c:if test="${userInfo.isFINANCE eq 1}">
									<div class="input-group col-md-1 colLee" >
										<a href="javaScript:void(0);" class="btn btn-primary"
										   id="importWageExcel">批量导入</a>
									</div>
								</c:if>
							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="wageTable.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>

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
<script src="js/jquery/jquery.form.js"></script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/hrms-wage/wageInfo.js"></script>