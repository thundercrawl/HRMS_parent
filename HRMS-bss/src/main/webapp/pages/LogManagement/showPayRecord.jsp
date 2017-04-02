<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScipt:void(0);">日志管理/个人账单/支付记录</a></li>
		</ul>
</div>
<div class="record-search-cate">     <div class="ui-form-item">
		<label class="ui-form-label ui-label-text">分类：</label>
		<div class="ui-form-item-content gray-links" id="J-consume-category">
					<a  class="inline-item category-trigger"  onclick="showDeposit()" id="DEPOSIT">充值记录</a>
					<a  class="inline-item category-trigger"  onclick="showWithdraw()" id="WITHDRAW">提现记录</a>
					<a  class="inline-item category-trigger"  onclick="showRefund()" id="REFUND">退款记录</a>
					<a  class="inline-item category-trigger"  onclick="showPayRecord()" id="payRecord">支付记录</a>
				</div>
	</div>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
                 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员姓名</span>
                    <input type="text" class="form-control" placeholder="会员姓名" id="userName" name="userName">
                  </div> 
                 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员手机号</span>
                    <input type="text" class="form-control" placeholder="会员手机号" id="userPhone" name="userPhone">
                  </div> 
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">公司名称</span>
                    <input type="text" class="form-control" placeholder="公司名称" id="companyName" name="companyName">
                   </div> 
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">订单编号</span>
                   <input type="text" class="form-control reDatetimepicker" placeholder="订单编号" id="orderNo" name="orderNo" />
                   </div>  
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">支付起始时间</span>
                   <input type="text" class="form-control reDatetimepicker" placeholder="支付起始时间" id="fromTime" name="fromTime" />
                   </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">支付结束时间</span>
                   <input type="text" class="form-control reDatetimepicker" placeholder="支付结束时间"  id="toTime" name="toTime" />
                   </div>            
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                   <span class="input-group-addon">支付渠道</span>
						 <select name="unit" id="payWay" name="payWay" class="form-control" type="select" value="${payWay}">
							<c:if test="${payWay==null||payWay==''}">
						<option value="0">全部</option>
						<c:if test="${!(empty paginator2)}">
		  	 				<c:forEach items="${paginator2}" var="pag">
								$("#payWay").append("<option value="${pag.typeNum}" >${pag.typeValue}</option>");
          					</c:forEach>
						</c:if>
					</c:if>
				
					<c:if test="${payWay!=null&&payWay!=''}">
						<c:if test="${!(empty paginator2)}">
							<c:forEach items="${paginator2}" var="pag">
								<c:if test="${payWay==pag.typeNum}">
          							$("#payWay").append("<option value="${pag.typeNum}" id="${pag.typeNum}">${pag.typeValue}</option>");
          						</c:if>
          					</c:forEach>	
          					<c:forEach items="${paginator2}" var="pag">
          						<c:if test="${payWay!=pag.typeNum}">
          							$("#payWay").append("<option value="${pag.typeNum}" id="${pag.typeNum}">${pag.typeValue}</option>");
          						</c:if>
          					</c:forEach>
						</c:if>
							<option value="0">全部</option>
					</c:if>
							</select>
                 	</div>
                  <div class="input-group col-md-1 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="Deposit" onclick="findPayRecord()">查询</a>
               </div>
                 </form>
					<div id="PersonalBills4" style="margin-top: 8px;">
						<jsp:include page="payRecord.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script src="js/LogManagement/PersonalBills.js"></script>
<script src="js/pagination.js"></script>
