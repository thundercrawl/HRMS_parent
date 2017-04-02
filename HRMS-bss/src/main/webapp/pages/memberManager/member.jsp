<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">客户关系管理/会员管理</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div id="addPdialog" style="display: none;">
					<form class="user-form user-form1 user-info" id="userId1"
						method="post" action="" style="margin-right: 40px;" enctype="multipart/form-data">
						<div>
							<label for="userName">名字：</label> <input type="text"
								id="addUserName" /> <span id="namespan" style="display: none;color: red;"  >请输入正确的姓名</span>
						</div>
						<div>
							<label for="userPw">密码：</label> <input type="text" id="userPw" />
							<span id="passwordspan" style="display: none;color: red;">密码为6-18位字母数字或特殊符号</span>
						</div>
						<div>
							<label for="userPhone">手机：</label> <input type="text"
								id="addUserPhone" /> <span id="phonespan" style="display: none;color: red;">请输入正确格式的手机号码</span>
						</div>
						<div>
							<label for="userMail">邮箱：</label> <input type="text"
								id="userMail" />
						</div>
						<div>
							<label for="userMail">个人图片：</label> <input type="file" id="file"
								name='file'> <input id='memberImg' name="memberImg"
								value="请选择图片上传">
						</div>

					</form>
					

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreSure">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreQuit">取消</a>
						</div>
				</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司ID</span> <input type="text"
										class="form-control" placeholder="ID" id="nomalCompanyId"
										name="nomalCompanyId" value="${nomalCompanyId }">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">会员ID</span> <input type="text"
										class="form-control" placeholder="ID" id="userId"
										name="userId" value="${userId }">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">会员名字</span> <input type="text"
										class="form-control" placeholder="名字" id="userName"
										name="userName" value="${userName }">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">手机号</span> <input type="text"
										class="form-control" placeholder="手机号" id="userPhone"
										name="userPhone" value="${userPhone }">
								</div>

								<div class="input-group col-md-1 colLee">
									<a class="btn btn-primary" id="forMemSearch">查询</a>
								</div>
								<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
									<a type="button" class="btn btn-primary" id="memberCreate">创建会员</a>
								</div>
								<div class="input-group col-md-1 colLee">
									<a type="button" class="btn btn-primary" id="export">导出</a>
								</div>

							</form>
							<input type="hidden" value="" id="formParam">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="table.jsp"></jsp:include>
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
<script src="js/virtualMember/mem.js"></script>
<script src="js/virtualMember/check.js"></script>
<script src="js/pagination.js"></script>

