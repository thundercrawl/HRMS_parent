<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">系统管理/版本管理</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div id="transfer-alert2" style="display: none;">
					<table>
						<tr>
							<td>功能介绍：</td>
							<td><input type="text" id="versionDscChange" /></td>
						</tr>
						<tr>
							<td>是否强制更新：</td>
							<td><div class="dataTables_length"
									id="simpledatatable_length">
									<select name="simpledatatable_length"
										aria-controls="simpledatatable" class="form-control input-sm"
										id=forceUpdateChange>
										<option value="1">是</option>
										<option value="0">否</option>
										<option value="2" id = "Option2">版本不稳定不提示更新</option>
									</select>
								</div></td>
						</tr>
					</table>
					<div class="input-group col-md-3 colLee"
						style="display: inline-block;">
						<a class="btn btn-primary" id="versionChangeSure">确定</a>
					</div>
					<div class="input-group col-md-3 colLee"
						style="display: inline-block;">
						<a class="btn btn-primary" id="versionChangeQuit">取消</a>
					</div>
					
					
				</div>
				<div id="addPdialog2" style="display: none;">
				<span id="vurl"></span>
				</div>
				<div id="addPdialog" style="display: none;">
					<form style="margin-right: 20px;"action="" id="addVersion" enctype="multipart/form-data">
						<table>
							<tr>
								<td>版本号：</td>
								<td><input type="text" id="versionNumber2"></td>
							</tr>
							<tr>
								<td>功能介绍：</td>
								<td><input type="text" id=versionDsc></td>
							</tr>
							<tr>
								<td>APP类型：</td>
								<td><select id="versionType" name="versionType" style="width:142px">
  <option value ="1" select="select">IOS</option>
  <option value ="2" onclick = "hideOption()" >Android</option>
</select></td>
							</tr>
							<tr id="forAnd" Style="display:none;">
							<td>URL：</td>
								<td>URL<input type="radio"  name="ver" value="" id="verIos" onclick="forAndUrl()"/>
								上传APK<input type="radio"  name="ver" value="" id="verAndroid" onclick="forAndApk()"/></td>
							</tr>
							<tr id="apdid" style="display:none;">
								<td>APK：</td>
								<td><input type="file" id="files" name='files'>
							</tr>
							<tr id="iosid">
								<td>请填写URL：</td>
								<td><input type="text" id="url"></td>
							</tr>
							<tr>
								<td>是否强制更新：</td>
								<td><div class="dataTables_length"
										id="simpledatatable_length">
										<select name="simpledatatable_length"
											aria-controls="simpledatatable" class="form-control input-sm"
											id=forceUpdate>
											<option value="1">是</option>
											<option value="0">否</option>
											<option value="2" id = "Option1">版本不稳定不提示更新</option>
										</select>
									</div></td>
							</tr>
						</table>
					</form>

					<div class="input-group col-md-3 colLee"
						style="display: inline-block;">
						<a class="btn btn-primary" id="VersionCreSure">确定</a>
					</div>
					<div class="input-group col-md-3 colLee"
						style="display: inline-block;">
						<a class="btn btn-primary" id="VersionCreQuit">取消</a>
					</div>
				</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">版本ID</span> <input type="text"
										class="form-control" placeholder="ID" id="versionId"
										name="versionId">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">版本号</span> <input type="text"
										class="form-control" placeholder="number" id="versionNumber"
										name="versionNumber">
								</div>

								<div class="input-group col-md-1 colLee"
									style="display: inline-block;">

									<a class="btn btn-primary" id="forVersionSearch">查询</a>
								</div>
								<div class="input-group col-md-1 colLee"
									style="display: inline-block;">
									<a class="btn btn-primary" id="versionAdd">添加版本</a>
								</div>

							</form>
							<input type="hidden" value="" id="versionSearchCondition">
							<input type="hidden" value="" id="versionAddCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="versionTable.jsp"></jsp:include>
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
<script src="js/version/version.js"></script>
<script src="js/pagination.js"></script>

