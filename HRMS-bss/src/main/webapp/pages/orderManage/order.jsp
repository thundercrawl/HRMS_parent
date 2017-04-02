<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>订单编号</th>
			<th>公司名称</th>
			<th>会员名称</th>
			<th>订单总金额</th>
			<th>下单时间</th>
			<th>下单人</th>
			<th>保证金</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="order">
		<tr>
			<td style="display:none">${order.orderId}</td>
			<td class="center">${order.orderNo}</td>
			<td class="center">${order.companyName}</td>
			<td class="center">${order.userName}</td>
			<td class="center">${order.totalPrice}</td>
			<td class="center">${order.orderTime}</td>
			<td class="center">${order.salerName}</td>
			<td class="center">${order.ensurePriceFee}</td>
			  <td class="center">${order.status}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs detail "  data-orderId="${order.orderId}" data-page="${paginator.page}">明细</a>
			<c:if test="${order.status eq '交易等待' || order.status eq '交易签订' || order.status eq '交易履行中' }" >
			  	<a href="javaScript:void(0);" class="btn btn-danger btn-xs toContract "  data-orderId="${order.orderId}">查看合同</a>
			  </c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/orderManage/showOfcOrder?&companyName=${companyName}&status=${status}&userName=${userName}&orderStartTime=${orderStartTime}&orderEndTime=${orderEndTime}&orderId=${orderId}&salerName=${salerName }" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>状态</td>
         <td>
         <div class="dataTables_length" id="simpledatatable_length">
         <label><select name="simpledatatable_length" aria-controls="simpledatatable" class="form-control input-sm" id="status">
             <option value="1">交易成功</option>
             <option value="2">记录删除</option>
             <option value="3">交易关闭</option>
             <option value="4">交易保留</option>
             <option value="5">交易等待</option>
             <option value="6">交易签订</option>
             <option value="7">交易履行中</option>
             <option value="8">未付款</option>
         </select></label>
         </div>
         </td>
      </tr>
    </table>
     <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
   </form>
  
  </div>
  <script src="js/orderManage/order.js"></script>
<script src="js/pagination.js"></script>
