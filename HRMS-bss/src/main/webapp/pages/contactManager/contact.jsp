<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">客户联系人管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="" id="usergroup">
	
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">联系人姓名</span> <input type="text"
								class="form-control" placeholder="联系人姓名" id="contactUserName"
								name="contactUserName" value="${ contactUserName}">
						</div>
						
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">联系人手机号</span> <input type="text"
								class="form-control" placeholder="联系人手机号" id="contactUserPhone"
								name="contactUserPhone" value="${ contactUserPhone}">
						</div>
						
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">联系人邮箱</span> <input type="text"
								class="form-control" placeholder="联系人邮箱" id="contactUserEmail"
								name="contactUserEmail" value="${ contactUserEmail}">
						</div>
						
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">联系人公司名</span> <input type="text"
								class="form-control" placeholder="联系人公司名" id="contactCompanyName"
								name="contactCompanyName" value="${ contactCompanyName}">
						</div>
						
						<div class="input-group col-md-3"
							style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon peopel-classify-span">联系人类型</span> 
							<select name="type"
							aria-controls="simpledatatable" class="input-sm peopel-classify-select" id="type">
							<option value="0">全部</option>
							<option value="1">账单联系人</option>
							<option value="2">合同联系人</option>
							<option value="3">活动联系人</option>
						</select>
						</div>


						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary" id="findproject">查询</a></div>
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary" id="addUser">添加</a>
						</div>
						<!-- <div  class="input-group col-md-1 colLee" style="display: inline-block;">
                       <a href="javaScript:void(0);" class="btn btn-primary shiny" id="exportProject">导出查询结果</a>
                           </div> -->
						<!-- <div class="input-group col-md-5 colLee" style="display: inline-block;">
							 <span id="textspan" style="display: none; color: red">请输入合法的用户姓名</span>
						</div> -->
					</form>
					<input type="hidden" id="formParam" value="" />
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="showContact.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
