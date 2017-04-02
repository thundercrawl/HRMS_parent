<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-striped table-hover table-bordered dataTable no-footer"  aria-describedby="editabledatatable_info">
     <thead>
         <tr role="row">
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" >
       	 全选
       	 <input type="checkbox" onclick="checkAll(this)">
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
       	  类型 
         </th>
         <th>合同编号</th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
       	 用户名
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
       	公司名称
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
       	 订单编号
         </th>
        <!--  <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
       	 备注
         </th> -->
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
                合同时间
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
         状态
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1">
          操作
         </th>
         </tr>
         </thead>
       <c:if test="${!(empty paginator.list)}">
       <tbody>
         <c:forEach items="${paginator.list}" var="c">
         <tr class="even">
          	<td class=" "style="text-align: center;">
          	<input type="checkbox" name="promotions" value="${c.contractid}">
          	</td>
         	<td class=" ">${c.typevalue} </td>
         	<td class=" "><a href="javaScript:void(0)" id="${c.contractid}" class="showContract">${c.contractid}</a></td>
         	<td class=" ">${c.username}</td>
         	<td class=" ">${c.companyname}</td>
         	<td class=" "><a href="javaScript:void(0)" id="${c.orderid}" class="showOrder">${c.orderno }</a></td>
          	<%-- <td class=" ">${c.contractdesc}</td> --%>
          	<td class=" "style="white-space: nowrap;">${c.finishtime}</td>
          	<td class=" ">${c.statusvalue}</td>
          	<td>
          	   <c:if test="${c.statusname==1}">
          	   		<c:if test="${c.boolFirstPay eq 1 }">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs firstPay" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>生成首付款账单</a>
          	  		</c:if>
	          	  	<c:if test="${c.boolFirstPay eq 2 }">
	          	  		<a href="javaScript:void(0)" class="btn btn-danger  btn-xs checkFirstPay" style="background-color:#4381B9;border-color:#4381B9;" orderid="${c.contractid}" page="${paginator.page}" value="filter/sys/contract/contract?orderid=${orderid}&username=${username}&companyname=${companyname}&fromtime=${fromtime}&totime=${totime}&status=${status}&type=${type}&contractid=${contractid}&mark=${page}"  ><i class="fa fa-trash-o"></i>查看首付款账单</a>
	          	  	</c:if>
          	     <a href="javaScript:void(0)" class="btn btn-xs delete" id="sures${c.contractid}" style="color: gray;"><i class="fa fa-trash-o"></i>已确认</a>
          	   </c:if>
          	  <c:if test="${c.statusname==2}">
          	  	<c:if test="${c.typevalue=='意向书'}">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs create_contract" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>生成合同</a>
          	  	</c:if>
          	  	<c:if test="${c.typevalue=='合同'}">
          	    	<a href="javaScript:void(0)" class="btn btn-danger btn-xs sure" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>确认合同</a>
          	    </c:if>
          	    </c:if>
          	  <c:if test="${c.statusname==4}">
          	 	 	
          	  	<c:if test="${c.typevalue=='意向书'}">
          	  		<a href="javaScript:void(0)" class="btn btn-xs delete" id="sures${c.contractid}" style="color: gray;"><i class="fa fa-trash-o"></i>已生成合同</a>
          	  	</c:if>
          	  	<c:if test="${c.typevalue=='合同'}">
          	  		<c:if test="${c.boolFirstPay eq 1 }">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs firstPay" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>生成首付款账单</a>
          	  		</c:if>
	          	  	<c:if test="${c.boolFirstPay eq 2 }">
	          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs checkFirstPay" style="background-color:#4381B9;border-color:#4381B9;" orderid="${c.contractid}" page="${paginator.page}" value="filter/sys/contract/contract?orderid=${orderid}&username=${username}&companyname=${companyname}&fromtime=${fromtime}&totime=${totime}&status=${status}&type=${type}&contractid=${contractid}&mark=${page}"><i class="fa fa-trash-o"></i>查看首付款账单</a>
	          	  	</c:if>
          	    	<a href="javaScript:void(0)" class="btn btn-danger btn-xs surePay" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>确认付款</a>
          	    </c:if>
          	  </c:if>
          	</td>
         </tr></c:forEach>
           </tbody></c:if>
         </table>
         <input type="text" hidden="true" value="orderid=${orderid}&username=${username}&companyname=${companyname}&finishtime=${finishtime}&status=${status}&type=${type}&contractid=${contractid}" id="huan">
         <input type="text" hidden="true" value="${page}" id="page">
           <jsp:include page="../common/paginator.jsp">
				<jsp:param value="filter/sys/contract/contract?orderid=${orderid}&username=${username}&companyname=${companyname}&fromtime=${fromtime}&totime=${totime}&status=${status}&type=${type}&contractid=${contractid}" name="url" />
				<jsp:param value="contract_table" name="loadCmp"/> 
		   </jsp:include>
		   
<script src="js/tariff/contract.js"></script>