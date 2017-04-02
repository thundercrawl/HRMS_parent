<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">蓝牙授权记录</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
					<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">会员名称</span> <input type="text"
								class="form-control" placeholder="请输入会员名全称" id="userName"
								value="${userName }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">会员手机号</span> <input type="text"
								class="form-control" placeholder="请输入会员手机号" id="userPhone"
								value="${userPhone }">
						</div>
						
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">公司名称</span> <input type="text"
								class="form-control" placeholder="请输入公司名全称" id="companyName"
								value="${ companyName}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">订单编号</span> <input type="text"
								class="form-control" placeholder="请输入完整订单编号" id="orderNo"
								value="${orderNo}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">门编号</span> <input type="text"
								class="form-control" placeholder="请输入完整门编号" id="doorNumber"
								value="${doorNumber }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">状态</span> <select name="unit"
								id="type" class="form-control" type="select">
								<c:if test="${type==null||type==''}">
									<option value="0">全部</option>
									<option value="1">有效</option>
									<option value="2">失效</option>
								</c:if>
								<c:if test="${type!=null&&type!=''}">
									<c:if test="${type==1}">
										<option value="1">有效</option>
										<option value="2">失效</option>
										<option value="0">全部</option>
									</c:if>
									<c:if test="${type==2}">
										<option value="2">失效</option>
										<option value="1">有效</option>
										<option value="0">全部</option>
									</c:if>
									<c:if test="${type==0}">
										<option value="0">全部</option>
										<option value="1">正常</option>
										<option value="2">禁用</option>
									</c:if>
								</c:if>
							</select>
						</div> 
						
						
						<div class="input-group col-md-5"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">授权起止时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择起始时间" id="startTime"
								value="${startTime}" /> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择终止时间" id="endTime"
								value="${endTime}" />
						</div>  		
						
						
						<div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"
						onclick="findbluetooth()" style="margin-left: 14px;">查询</a>
	</div>
						
					</form>
					
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="bluetooth.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<script src="js/pagination.js"></script>
