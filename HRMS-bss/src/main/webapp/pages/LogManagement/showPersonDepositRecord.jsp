<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScipt:void(0);">个人交易记录</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div style="min-width:1100px">
				<form action="" id="recordfrom">
				<input hidden="true" id="pageSize" name="pageSize" value="10">
				<input hidden="true" id="isCom" name="isCom" value="1">
				<input hidden="true" id="companyName" name="companyName">
				 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员姓名</span>
                    <input type="text" class="form-control" placeholder="会员姓名" id="userName" name="userName">
                  </div> 
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                   <span class="input-group-addon">交易类型</span> 
                  	 <select id="type" name="type" class="form-control" type="select" value="1">
						<option value="1">充值记录</option>
						<option value="2">提现记录</option>
						<option value="3">退款记录</option>
						<option value="4">支付记录</option>
					</select>
                   </div>
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员手机号</span>
                    <input type="text" class="form-control" placeholder="会员手机号" id="userPhone" name="userPhone">
                  </div> 
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">起始时间</span>
                   <input type="text" class="form-control reDatetimepicker" id="startTime" name="fromTime" readonly="readonly"/>
                   </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">结束时间</span>
                   <input type="text" class="form-control reDatetimepicker" id="endTime" name="toTime"  readonly="readonly"/>
                   </div>   
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">订单编号</span>
                   <input type="text" class="form-control" placeholder="订单编号" id="orderNo" name="orderNo" />
                   </div>          
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                   <span class="input-group-addon">渠道</span>
				<select id="channel" name="payWay" class="form-control" type="select" value="${payWay}">
				
				<c:if test="${channel==null||channel==''}">
					<option value="0">全部</option>
					<c:if test="${!(empty paginator2)}">
		  	 			<c:forEach items="${paginator2}" var="pag">
							$("#channel").append("<option value="${pag.typeNum}" >${pag.typeValue}</option>");
          				</c:forEach>
					</c:if>
				</c:if>
				
				<c:if test="${channel!=null&&channel!=''}">
					<c:if test="${!(empty paginator2)}">
					<c:forEach items="${paginator2}" var="pag">
						<c:if test="${channel==pag.typeNum}">
          						$("#channel").append("<option value="${pag.typeNum}" id="${pag.typeNum}">${pag.typeValue}</option>");
          				</c:if>
          			</c:forEach>	
          				<c:forEach items="${paginator2}" var="pag">
          					<c:if test="${channel!=pag.typeNum}">
          						$("#channel").append("<option value="${pag.typeNum}" id="${pag.typeNum}">${pag.typeValue}</option>");
          					</c:if>
          				</c:forEach>
					</c:if>
					<option value="0">全部</option>
				</c:if>
				
				</select>
                 	</div>
                 <a href="javaScript:void(0);" class="btn btn-primary" onclick="findComDeposit()" style="margin-top: -30px;">查询</a>
                </form>
                <input type="hidden" id="formParam" value>
					<div id="PersonalBills12" style="margin-top: 8px;">
						<jsp:include page="personRecord.jsp"></jsp:include>
					</div>
				</div>
				
			</div>
		</div>
	</div>

</div>
<script src="js/LogManagement/PersonalBills.js"></script>
<script src="js/pagination.js"></script>
