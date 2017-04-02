<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>项目名称</th>
			<th>产品名称</th>
			<th>产品数量</th>
			<th>原价</th>
			<th>保证金</th>
			<th>租用起始时间</th>
			<th>租用截止时间</th>
			<th>产品类型</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="list" varStatus="item_index" >
			
			<c:forEach items="${list.list}" var="orderDetail" varStatus="item_index">
			<tr>
			<c:choose>  
			   <c:when test="${orderDetail.parentId eq 0}">
			   <td rowspan="${fn:length(list.list)}" class="center">${orderDetail.projectName }</td>
			   </c:when>  
			</c:choose>
			<td class="center">${orderDetail.productName}(${orderDetail.capacity })</td>
			<td class="center">${orderDetail.amount}</td>
			<td class="center">${orderDetail.nomalFee}</td>
			<td class="center">${orderDetail.ensureFee}</td>
			<td class="center">${orderDetail.rentStartTime}</td>
			<td class="center">${orderDetail.rentEndTime}</td>
			<td class="center">${orderDetail.productType}</td>
			<c:choose>  
			   <c:when test="${orderDetail.parentId eq 0}">
			   </c:when>  
			</c:choose>
		</tr>
		</c:forEach>
		</c:forEach>
		
			<c:choose>  
			   <c:when test="${productDiscount eq null}">
			   </c:when>  
			    <c:otherwise>
			    <tr>
			   <td colspan="7" class="center">跨产品折扣</td>
			   <td class="center">98%</td>
			   </tr>
			   </c:otherwise> 
			</c:choose>
			<c:choose>  
			   <c:when test="${projectDiscount eq null}">
			   </c:when>  
			    <c:otherwise>
			    <tr>
			   <td colspan="7" class="center">跨点折扣</td>
			   <td class="center">98%</td>
			   </tr>
			   </c:otherwise> 
			</c:choose>
			
	</tbody>
	</c:if>
</table>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="assetTable" style="display:none;">
	<thead>
		<tr>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	   全选<input type="checkbox" onclick="checkAll(this)">
      </th>
      <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	所属项目
         </th>
      <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	资产编号
         </th>
      <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
     	  资产类型
         </th>
         <th>资产状态</th>
         <th></th>
		</tr>
	</thead>
	 <c:if test="${!(empty assetAllList)}">
	<tbody id="assetData">
      	<c:forEach items="${assetAllList}" var="asset">
			<tr>
				<td class="center"><input type="checkbox" name="checkAsset" ></td>
				<td class="center">${asset.projectName}</td>
				<td class="center">${asset.assetCode}</td>
				<td class="center">${asset.assetType}</td>
				<td class="center">${asset.statusName}</td>
				<td>
			   		<a href="javaScript:void(0);" class="btn btn-danger btn-xs  deleteAsset" data-assetTypeStr="${asset.assetType}" data-assetId="${asset.assetId}" data-page="${paginator.page}">删除</a>
			   	</td>
			</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="stageTable" style="display:none;">
	<thead>
		<tr>
			<th>分期段</th>
			<th>主产品</th>
			<th>智慧包产品</th>
			<th>智慧包房租减免产品</th>
			<th>合计(不含保证金)</th>
		</tr>
	</thead>
	<c:if test="${!(empty stageList)}">
	<tbody id="stageData">
		<c:forEach items="${stageList}" var="list" varStatus="item_index" >
			  <c:set var="sum" value="0"></c:set>
			<c:forEach items="${list.list}" var="timePay" varStatus="item_index" >
			<tr>
			 <c:choose>  
			   <c:when test="${item_index.index eq 0}">
			   <td rowspan="${fn:length(list.list)}" class="center">${list.name }</td>
			   </c:when>
			</c:choose>
			
			<td class="center">${timePay.mainProductName}(${timePay.assetNameStr}) ￥${timePay.mainProductMoney} 
			</td>
			<td class="center">${timePay.incrementName} ￥${timePay.incrementMoney}
				<c:if test="${!(empty timePay.disposableIncrement)}">
					</br>${timePay.disposableIncrement } ￥${timePay.disposableIncrementFee }
				</c:if>
			</td>
			<td class="center">${timePay.discountProductName} ￥${timePay.discountProdectMoney}</td>
			<c:set var="sum" value="${sum+timePay.totalMoney}"></c:set>
			 <c:choose>  
			   <c:when test="${item_index.index eq 0}">
			   <td rowspan="${fn:length(list.list)}"  class="center totalMoney"></td>
			   </c:when>  
			</c:choose>
			<c:choose>  
			   <c:when test="${item_index.index eq fn:length(list.list)-1}">
			   	<input type="hidden" class="sumInputHide" value="${sum }" >
			   </c:when>  
			</c:choose>
		</tr>
		</c:forEach>
		</c:forEach>
		
			
	</tbody>
	</c:if>
</table>

<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/order/showOfcOrderDetail" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="assetTable" style="display:none;">
  <form action="">
    <table>
      
      
      <c:if test="${!(empty assetAllList)}">
      	<c:forEach items="${assetAllList}" var="asset">
			<tr>
				<td class="center"><input type="checkbox" ></td>
				<td class="center">${asset.projectName}</td>
				<td class="center">${asset.assetCode}</td>
				<td class="center">${asset.assetType}</td>
			</tr>
		</c:forEach>
      </c:if>
    </table>
   </form>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
  </div>
  <script src="js/orderManage/orderDetail.js"></script>
<script src="js/pagination.js"></script>
