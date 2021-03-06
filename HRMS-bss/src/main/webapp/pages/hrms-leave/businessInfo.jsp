<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">出差管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">

				<div id="transfer-upBusiness" style="display: none;">
				<form class="business-form business-form1 business-info" id="upBusiness"
					  method="post" action="" style="margin-left: 25px;margin-bottom: 20px"  enctype="multipart/form-data">
					<div>
						<label>出差开始时间:</label> <input type="text"
																		 id="startTime1" />
					</div>
					<div>
						<label>出差结束时间:</label> <input type="text"
													  id="endTime1" />
					</div>
					<div>
						<label>出差事由:</label> <input type="text"
													  id="leaveContent" />
					</div>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary" id="upBusinessSure">确定</a>
				</div>
				<div class="input-group col-md-3 colLee"
					 style="margin: 2px 0; display: inline-block;">
					<a type="button" class="btn btn-primary shiny" id="upBusinessQuit">取消</a>
				</div>
				</form>
			</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">出差审批流水号</span> <input type="text"
										class="form-control" placeholder="出差流水号" id="leaveCode" value="${searchParam.leaveCode}"/>
								</div>
								<div class="input-group col-md-3"
									 style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">审批状态</span>
									<select id="leaveStatus" class="form-control" placeholder="审批状态">
										<option value="0" selected="selected">全选</option>
										<option value="1">待审核</option>
										<option value="2">审核通过</option>
										<option value="3">审核驳回</option>
									</select>
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forBusinessSearch">查询</a>
								</div>
								<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
									<a class="btn btn-primary" class="btn btn-primary" id="addBusiness">提交申请</a>
								</div>
							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="businessTable.jsp"></jsp:include>
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
<script src="js/hrms-leave/businessInfo.js"></script>