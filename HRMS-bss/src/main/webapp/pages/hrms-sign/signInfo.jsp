<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">考勤管理</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
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
									<span class="input-group-addon">用户名称</span> <input type="text"
										class="form-control" placeholder="用户名称" id="userName"
										name="userName" value="${searchParam.userName}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门</span> <input type="text"
										class="form-control" placeholder="部门" id="orgName"
										name="orgName" value="${searchParam.orgName}">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">开始时间</span> <input
										type="text" class="form-control" placeholder="开始时间"
										id="startTime" name="startTime" value="${searchParam.startTime}">
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">结束时间</span> <input
										type="text" class="form-control" placeholder="结束时间"
										id="endTime" name="endTime" value="${searchParam.endTime}">
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">迟到</span>
									<c:if test="${searchParam.isLater eq 1}">
										<input
												type="checkbox" class="form-control" placeholder="迟到"
												id="isLater" style="width: 40px;height: auto" value="1" name="isLater" checked="checked">
									</c:if>
									<c:if test="${searchParam.isLater ne 1}">
										<input type="checkbox" class="form-control" placeholder="迟到"
												id="isLater" style="width: 40px;height: auto" value="1" name="isLater">
									</c:if>
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">早退</span>
									<c:if test="${searchParam.isEarly eq 1}">
										<input type="checkbox" class="form-control" placeholder="早退"
												id="isEarly" style="width: 40px;height: auto" value="1" name="isEarly" checked="checked">
									</c:if>
									<c:if test="${searchParam.isEarly ne 1}">
										<input type="checkbox" class="form-control" placeholder="早退"
											   id="isEarly" style="width: 40px;height: auto" value="1" name="isEarly">
									</c:if>
								</div>

								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forSignSearch">查询</a>
								</div>
								<c:if test="${userInfo.isHR eq 1 }">
									<div class="input-group col-md-1 colLee" >
										<a href="javaScript:void(0);" class="btn btn-primary"
											id="importSignExcel">批量导入</a>
									</div>
								</c:if>
							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="signTable.jsp"></jsp:include>
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
<script src="js/hrms-sign/signInfo.js"></script>
