<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">系统管理/查询挂账</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forBillId">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">会员名称</span> <input type="text"
										class="form-control" placeholder="会员名称" id="userName"
										name="userName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司</span> <input type="text"
										class="form-control" placeholder="公司" id="companyName"
										name="companyName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">操作人</span> <input type="text"
										class="form-control" placeholder="操作人" id="adminRName"
										name="adminRName">
								</div>
								<div class="input-group col-md-1 colLee"
									style="display: inline-block;">
									<a class="btn btn-primary" id="forBillSearch">查询</a>
								</div>
								<!-- <div class="input-group col-md-1 colLee"
									style="display: inline-block;">
									<a class="btn btn-primary" id="versionAdd">添加版本</a>
								</div>
 -->
							</form>
							<!-- <input type="hidden" value="" id="versionSearchCondition">
							<input type="hidden" value="" id="versionAddCondition"> -->
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="billTable.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<script src="js/searchBill/searchBill.js"></script>
<script src="js/pagination.js"></script>

