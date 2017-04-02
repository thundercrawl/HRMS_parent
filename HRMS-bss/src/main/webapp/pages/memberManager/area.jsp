<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">客户关系管理/公司管理/公司场地</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""></div>
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div id="addPdialog" style="display: none;">
					<form class="user-form user-form1 user-info" id="userId1"
						method="post" action="">
						<div>
							<label for="userName">名字：</label> <input type="text"
								id="addUserName" /> <span id="namespan"></span>
						</div>
						<div>
							<label for="userPw">密码：</label> <input type="text" id="userPw" />
							<span id="passwordspan"></span>
						</div>
						<div>
							<label for="userPhone">手机：</label> <input type="text"
								id="addUserPhone" /> <span id="phonespan"></span>
						</div>
						<div>
							<label for="userMail">邮箱：</label> <input type="text"
								id="userMail" />
						</div>
						<div>
							<label for="userMail">个人图片：</label> <input type="file" id="files"
								name='files'> <input id='memberImg' name="memberImg"
								value="请选择图片上传">
						</div>
						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a type="button" class="btn btn-primary" id="memCreSure">确定</a>
						</div>
						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a type="button" class="btn btn-primary" id="memCreQuit">取消</a>
						</div>

					</form>
				</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司ID</span> <input type="text"
										class="form-control" placeholder="ID" id="companyId"
										name="companyId" value="${companyId }">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司名称</span> <input type="text"
										class="form-control" placeholder="公司名称" id="companyName"
										name="companyName" value="${companyName }">
								</div>
								<div class="input-group col-md-1 colLee">
									<a class="btn btn-primary" id="areaSearch">查询</a>
								</div>
								<!--   <button type="button" class="btn btn-primary" id="memberCreate" style="margin-top: -30px;">创建场地</button> -->
							</form>
							<input type="hidden" value="" id="areaSearchCondition">
							<div id="tid">
								<jsp:include page="areatable.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<script src="js/virtualMember/area.js"></script>
<script src="js/pagination.js"></script>