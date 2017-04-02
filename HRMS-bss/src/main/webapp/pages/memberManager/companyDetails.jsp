<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScipt:void(0);">客户关系管理/公司管理/公司员工</a></li>
		</ul>
	</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div >
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
						<form id="forid">
						 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">会员ID</span>
                    <input type="text" class="form-control" placeholder="ID" id="userId" name="userId">
                  </div>
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">公司ID</span>
                    <input type="text" class="form-control" placeholder="ID" id="companyId" name="companyId">
                  </div>
                  <a class="btn btn-primary" id="forComMemSearch" style="margin-top: -30px;">查询</a>
                  <button type="button" class="btn btn-primary" id="backToCompany" style="margin-top: -30px;">返回</button>
						<!-- <button type="button" class="btn btn-primary shiny" id="workerAdd">添加员工</button> -->
                  </form>
                  <input type="hidden" value="" id="companyMemberSearchCondition">
<div id="tid">
<jsp:include page="detailsTable.jsp"></jsp:include>
</div>
</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script src="js/virtualMember/company.js"></script>
<script src="js/pagination.js"></script>