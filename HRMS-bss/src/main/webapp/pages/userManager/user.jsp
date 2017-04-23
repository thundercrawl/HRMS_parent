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
				
					<div id="addComMembers" style="display: none;">
						<form class="user-form user-form1 user-info" id="userIdPic"
						method="post" action="" style="margin-right: 40px;" enctype="multipart/form-data">
						<div>
						<input type="hidden" id="comIdsss"> </div>
						<div>
							<label for="userName">名字<font style='color:red'>*</font>：</label> 
							<input type="text" id="addUserName111" /> <span id="namespan" style="display: none;color: red;"  >姓名为字母和汉字,长度15</span>
						</div>
						<div>
							<label for="userPw">密码<font style='color:red'>*</font>：</label> <input type="text" id="userPw111" />
							<span id="passwordspan" style="display: none;color: red;">密码为6-18位字母数字或特殊符号</span>
						</div>
						<div>
							<label for="userPhone">手机<font style='color:red'>*</font>：</label> <input type="text"
								id="addUserPhone111" /> <span id="phonespan" style="display: none;color: red;">请输入正确格式的手机号码</span>
						</div>
						<div>
							<label for="userMail">邮箱<font style='color:red'>*</font>：</label> <input type="text"
								id="userMail111" />
						</div>
						<!-- <div>
							<label for="userMail">个人图片：</label> 
							<input type="file" id="comfile" name='file' value="请选择图片上传"> 
							<input id='commemberImg' name="memberImg" type = "text" value="请选择图片上传">
						</div> -->
					</form>
					

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreMemSure">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreMemQuit">取消</a>
						</div>
				</div>
				
				<div id="transfer-alert2" style="display: none;">
				<form class="user-form user-form1 user-info" id="companyId1"
					  method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
					<div>
						<label for="companyName">用户编号<font style='color:red'>*</font>：</label> <input type="text"
																									  id="companyNameAdd" /> <span id="namespan"></span>
					</div>
					<div>
						<label for="companyAddress">用户名称：</label> <input type="text"
																		 id="companyAddressAdd" />
					</div>
					<div>
						<label for="userOrg">用户部门<font style='color:red'>*</font>：
							<%--</label> <input type="text"
																										  id="userOrgInput" />--%>
							<select class="selectOrg" >
								<option value="部门1"/>
								<option value="部门2"/>
								<option value="部门3"/>
							</select>
							<span id="orgspan"></span>
					</div>
					<div>
						<label for="jobName">用户职位<font style='color:red'>*</font>：</label> <input type="text"
																								  id="jobNameInput" /><span id="jobspan"></span>
					</div>
					<div>
						<label for="userPhone">手机号：</label> <input type="text"
																   id="userPhoneInput" /> <span id="phonespan"></span>
					</div>
					<div>
					</div>
					<div>
						<label for="userInreoduction">用户介绍：</label> <input type="text"
																		   id="userInreoductionInput" />
					</div>
					<div>
						<label for="userPhoto">用户头像：</label> <input type="file"
																	id="file" name='file'> <input id='userPhotoImg'
																								  name="userPhotoName" value="请选择图片上传" style="margin-left: -68px;">
					</div>
				</form>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary" id="comCreSure">确定</a>
				</div>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary shiny" id="comCreQuit">取消</a>
				</div>
			</div>
				<div id="transfer-alert3" style="display: none;"></div>
				<div id="import-alert" style="display: none;">
					<p align="center">请选择需要上传的文件</p>
					<form id="excel_form" name="form1" method="post"
						action="" enctype="multipart/form-data">
						<table border="0" align="center">
							<tr>
								<td>上传文件：</td>
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
										name="userID">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">姓名</span> <input type="text"
										class="form-control" placeholder="姓名" id="userName"
										name="userName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">职位</span> <input type="text"
										class="form-control" placeholder="职位" id="jobName"
										name="jobName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">部门</span> <input type="text"
										class="form-control" placeholder="部门" id="orgName"
										name="orgName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">手机号</span> <input
										type="text" class="form-control" placeholder="手机号码"
										id="userPhone" name="userPhone" value="">
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forUserSearch">查询</a>
								</div>
								<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
									<a class="btn btn-primary" class="btn btn-primary" id="companyCreate">创建用户</a>
								</div>
								
                                <div class="input-group col-md-1 colLee" >
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="importComSearch">批量导入</a>
								</div>

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
<script src="js/virtualMember/company.js"></script>
<script src="js/virtualMember/createComMem.js"></script> 
<script src="js/pagination.js"></script>
<script src="js/hrms-user/userSearch.js"></script>