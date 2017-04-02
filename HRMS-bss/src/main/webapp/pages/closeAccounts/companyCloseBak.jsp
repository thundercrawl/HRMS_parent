<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="css/index.css" rel="stylesheet" type="text/css">
<div style="max-height: 570px;overflow-y: auto;">
<div style="position:relative;width: 937px;height: auto;margin: 50px auto;padding: 30px;box-sizing:border-box;box-shadow: 0 0 15px #DAD2C8;">
<input id="isFirstBill" type="hidden" value="${ifFirstBill }">
 <div style="width: 100%;height: auto;padding-top: 20px;text-align: right;">
 		<c:if test="${isReturn}">
		<button class="returnButton" url=${returnUrl } style="position: absolute;left: 55px;top: 150px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: left;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">返回</button>
 		</c:if>
		<button class="printButton" style="position: absolute;right: 55px;top: 150px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">打印</button>
		<c:if test="${surecomanycount==1 }">
		    <c:if test="${isAccount==1 }">
		   		<button class="closaccountButton" style="position: absolute;right: 55px;top: 200px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">确认支付</button>
			</c:if>
		</c:if>
		<input type="hidden" value="${companyId }" id="companyId">
		<input type="hidden" value="${billMonth }" id="billMonth"> 
</div>
<div id="printInfo" style="padding:30px;width:100%;height:auto;">
	<div class="check-top">
    	<img src="${pageContext.request.contextPath}/img/logozd.png">
        <div class="check-top-message">
        	<p>www.distrii.com</p>
            <p>400-920-9888</p>
        </div>
    </div>
    <p class="contract-pay-notice">账单/付款通知书</p>
    <c:if test="${!(empty listCompanyBill)}">
	 <c:forEach items="${listCompanyBill}" var="companyBill">
    <table class="pay-table border-gray mt40"  cellpadding="0" cellspacing="0">
    	<colgroup>
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
        </colgroup>
    	<tr>
        	<td></td>
            <td class="fwd">承租房源</td>
            <td class="fwd">人数/数量</td>
            <td></td>
            <td class="fwd">客户名称</td>
            <td colspan="3">
            	${companyBill.companyName }
            </td>
        </tr>
        <tr>
        	<td class="fwd">独立办公室</td>
            <td>
            	<div class="test_box1"> 
            	${officeNumStr } 
                    <br />  
                </div>
            </td>
            <input type="hidden" value="${companyBill.unsettlementFee}" id="unsettlementFee">
			<input type="hidden" value="${companyBill.unsettlementRPkg}" id="unsettlementRPkg">	
			<input type="hidden" value="${companyBill.unsettlementMPkg}" id="unsettlementMPkg">	
            <c:if test="${officePeopleNum ne 0 }">
            <td>
            	${officePeopleNum }
            </td>
            </c:if>
            <c:if test="${officePeopleNum eq 0 }">
            <td>
            	N/A
            </td>
            </c:if>
            <td></td>
            <td class="fwd">客户编号</td>
            <td colspan="3">
            	${companyBill.companyCode }
            </td>
        </tr>
        <tr>
        	<td class="fwd">移动商务舱</td>
            <td>
            	<div class="test_box1"> 
            	${moveBusinessStr } 
                    <br />  
                </div>
            </td>
            <c:if test="${moveBusinessNum ne 0 }">
            <td>
            	${moveBusinessNum }
            </td>
            </c:if>
            <c:if test="${moveBusinessNum eq 0 }">
            <td>
            	N/A
            </td>
            </c:if>
            <td></td>
            <td class="fwd">出账日期</td>
            <td colspan="3">
            	${billStartDate}
            </td>
        </tr>
        <tr>
        	<td class="fwd">弹性工位包</td>
            <td>
            	-
            </td>
            <td>
            	N/A
            </td>
            <td></td>
            <td class="fwd">付款截止日</td>
            <td colspan="3">
            	${payEndDate }
            </td>
        </tr>
        <tr>
        	<td class="fwd">会议室包</td>
            <td>
            	-
            </td>
            <td>
            	N/A
            </td>
            <td></td>
            <td class="fwd">账单编号</td>
            <td colspan="3">
            	${companyBill.billNo }
            </td>
        </tr>
    </table>
    </c:forEach>
    </c:if>
    <table class="pay-table border-gray mt40" cellpadding="0" cellspacing="0">
    	<colgroup>
            <col width="12.5%">
            <col width="12.5%">
            <col width="19%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="12.5%">
            <col width="6%">
            <col width="12.5%">
        </colgroup>
    	<tr>
        	<td></td>
			<td class="fwd">费项内容</td>
            <td colspan="3" class="fwd">账单周期</td>
            <td class="fwd">单价</td>
            <td class="fwd">数量</td>
            <td class="fwd">小计</td>
        </tr>
          <c:if test="${!(empty comBillOrderList)}">
          <c:forEach items="${comBillOrderList}" var="comBillOrderLists" varStatus="item_index" >
          <c:forEach items="${comBillOrderLists.orderDetailInfo}" var="orderDetailInfo" varStatus="forindex">
          <c:if test="${orderDetailInfo.nomalFee ne 0 }">
        <tr>
        	<c:choose>  
			   <c:when test="${item_index.index eq 0 && forindex.index eq 0}">
			   <td rowspan="${rowNum}" class="fwd">每月固定费项</td>
			   </c:when>
			</c:choose>
			<c:if test="${orderDetailInfo.productType eq 3}">
			<td>
            	${orderDetailInfo.itemName}${orderDetailInfo.assetList}
            </td>
            </c:if>
            <c:if test="${orderDetailInfo.productType ne 3}">
			<td>
            	${orderDetailInfo.itemName}
            </td>
            </c:if>
            <c:forEach items="${orderDetailInfo.splitList}" var="splitList" varStatus="infoIndex">
            	<c:choose>  
				   <c:when test="${infoIndex.index eq 0}">
		            <td colspan="3" >
		            	${splitList.startDate }-----${splitList.endDate }
				   </td>
				   </c:when>
			</c:choose>
            </c:forEach>
            <td>
            	${orderDetailInfo.ratePriceFee} &nbsp;${orderDetailInfo.ratePrecision}/${orderDetailInfo.unit}
            </td>
            <td>
            	${orderDetailInfo.amount}
            </td>
            	  <c:forEach items="${orderDetailInfo.splitList}" var="splitList" varStatus="infoIndex">
            	<c:choose>  
				   <c:when test="${infoIndex.index eq 0}">
		            <td>
		            	${splitList.priceFee }&nbsp;${orderDetailInfo.ratePrecision}
				   </td>
				   </c:when>
			</c:choose>
            </c:forEach>
        </tr>
        </c:if>
        </c:forEach>
        </c:forEach>
        </c:if>
        <c:if test="${!(empty otherBillInfoList)}">
          <c:forEach items="${otherBillInfoList}" var="otherBillInfoList" varStatus="item_index" >
        <tr>
        	<c:if test="${item_index.index eq 0}">
        	<td rowspan="${oneOffRowNum }" class="fwd">一次性服务费项</td>
        	</c:if>
			<td>
            	${otherBillInfoList.itemName }
            </td>
            <td colspan="3">
            	${otherBillInfoList.effectTime }----${otherBillInfoList.lapsedTime }
            </td>
            <td>
            	${otherBillInfoList.fee }元
            </td>
            <td>
            	1
            </td>
            <td>
            	${otherBillInfoList.fee }元
            </td>
            
        </tr>
        </c:forEach>
        </c:if>
    </table>
    <c:forEach items="${listCompanyBill}" var="companyBill">
    <table class="pay-table mt40 w50 fr " cellpadding="0" cellspacing="0">
    	<colgroup>
            <col width="25%">
            <col width="25%">
            <col width="25%">
            <col width="25%">
        </colgroup>
    	<tr>
        	<td></td>
            <td></td>
            <td class="fwd">账单金额</td>
            <td>
            	${companyBill.totalFee}元
            </td>
        </tr>
        <tr>
        	<td></td>
            <td></td>
            <td class="fwd">税额</td>
            <td>
            	0.00元
            </td>
        </tr>
        <tr>
        	<c:if test="${ifFirstBill }">
        	<td class="fwd border-black">押金/保证金</td>
            <td class="border-black">
            	${ensureFee }元
            </td>
        	</c:if>
        	<c:if test="${!ifFirstBill }">
        	<td class="fwd border-black"></td>
            <td class="border-black">
            </td>
        	</c:if>
            <td class="fwd border-black">本月已付</td>
            <td class="border-black">
            	${companyBill.totalFee-companyBill.unsettlementFee}元
            </td>
        </tr>
        <tr>
        	<td></td>
            <td></td>
            <td class="fwd">待付款合计</td>
            <c:if test="${ifFirstBill }">
        	<td>
            	${companyBill.unsettlementFee+ensureFee}元
            </td>
        	</c:if>
        	<c:if test="${!ifFirstBill }">
        	<td>
            	${companyBill.unsettlementFee}元
            </td>
        	</c:if>
        </tr>
    </table>
    </c:forEach>
</div>
 	<div class="clear"></div>
    <hr class="cutoff-rule"/>
<div id="printBankPage">
    <div class="bank-information">
    	<p>BANK INFORMATION</p>
        银行资料
    </div>
    <ul class="bank-information-message">
    	<li class="clearfix">
            <p>Bank Name:</p>
            <div class="circle-input">
                <div class="test_box1">  
               		Shanghai Pudong Development Bank Co Ltd Zhabei Sub-branch
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>银行名称:</p>
            <div class="circle-input">
                <div class="test_box1">  
                   上海浦东发展银行股份有限公司闸北支行
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>Account Name:</p>
            <div class="circle-input">
                <div class="test_box1">  
                    Shanghai Distrii Technology Development Co., Ltd
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>收款人姓名:</p>
            <div class="circle-input">
                <div class="test_box1">  
                    上海办伴科技发展有限公司
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>SWIFT CODE:</p>
            <div class="circle-input">
                <div class="test_box1">  
                    SPDBCNSHXXX
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>Account Number:</p>
            <div class="circle-input">
                <div class="test_box1">  
                    98401454740000909   (USD Settlement Account)<br/>98400154740016485   (RMB Basic Account)
                </div>
            </div>
        </li>
        <li class="clearfix">
            <p>收款人账号: </p>
            <div class="circle-input">
                <div class="test_box1">  
                    98401454740000909   (美金账号)<br/>98400154740016485   (人民币账号)
                </div>
            </div>
        </li>
    </ul>
    </div>
    
    
    
</div>
    
</div>
<script src="js/closeAccount/jquery.jqprint-0.3.js"></script>
<script src="js/closeAccount/companyClose.js"></script>