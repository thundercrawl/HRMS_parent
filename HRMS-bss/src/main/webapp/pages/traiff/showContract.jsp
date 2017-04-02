<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">合同管理</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
				<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">合同编号</span>
                    <input type="text" class="form-control" placeholder="请输入合同编号" id="contractid" value="${contractid}">
                  </div>
				<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">公司名称</span>
                    <input type="text" class="form-control" placeholder="请输入公司名" id="companyname" value="${companyname}">
                  </div>
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">用户名</span>
                    <input type="text" class="form-control" placeholder="请输入用户名" id="username" value="${username}">
                  </div>
<div class="input-group col-md-5" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">合同时间</span>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readOnly="true"  placeholder="选择起始时间" id="datetimepickerfrom" value="${fromtime}"/>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readOnly="true"  placeholder="选择终止时间" id="datetimepickerto" value="${totime}"/>
						</div>
<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">订单编号</span>
                    <input type="text" class="form-control" value="${orderid}" placeholder="请输入订单编号" id="ordernumber" >
                  </div>

<div style="margin: 2px 0;display: inline-table;" class="input-group col-md-3">
							<span class="input-group-addon">合同状态</span>
							       <select name="unit" id="contractstatus" class="form-control" type="select" >
							       <c:if test="${status==3||status==null}">
							       		<option value="3">全部</option>
                                        <option value="1">生效</option>
                                     	<option value="2">未生效</option> 
                                     	<option value="4">待付款</option>      
							       </c:if>
							       <c:if test="${status==1}">
                                         <option value="1">生效</option>
                                     	<option value="2">未生效</option> 
                                     	<option value="3">全部</option>
                                    	<option value="4">待付款</option>
							       </c:if>
							       <c:if test="${status==2}">
                                     	<option value="2">未生效</option> 
                                       	<option value="1">生效</option>
							      		<option value="3">全部</option>
							        	<option value="4">待付款</option>
							       </c:if>
							       <c:if test="${status==4}">
							       		<option value="4">待付款</option>
							        	<option value="1">生效</option>
                                     	<option value="2">未生效</option> 
							       		<option value="3">全部</option>
							       </c:if>
                                                 </select>
						                      </div>
<div style="margin: 2px 0;display: inline-table;" class="input-group col-md-3">
							<span class="input-group-addon">合同类型</span>
							       <select name="unit" id="contracttype" class="form-control" type="select" >
								<c:if test="${type==1}">
								<option value="1">合同</option>
								<option value="2">意向书</option>
								<option value="3">全部</option>
								</c:if>
								<c:if test="${type==2}">
								<option value="2">意向书</option>
								<option value="1">合同</option>
								<option value="3">全部</option>
								</c:if>
								<c:if test="${type==3||type==null}">
								<option value="3">全部</option>
								<option value="1">合同</option>
								<option value="2">意向书</option>
								</c:if>
							</select>
						                      </div>
					<div class="input-group col-md-1 colLee">
						 <a href="javaScript:void(0);" class="btn btn-primary" onclick="findcontracts()">查询</a>
					</div>
					<div class="input-group col-md-1 colLee">
						 <a href="javaScript:void(0);" class="btn btn-primary" id="deletecontracts">删除</a>
					</div>
                 
                  
                 
				</form>
					<div id="contract_table" style="margin-top: 4px;">
						<jsp:include page="contract.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/tariff/showContract.js"></script>
