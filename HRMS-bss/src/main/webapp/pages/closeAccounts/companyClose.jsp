<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="max-height: 570px;overflow-y: auto;">
	<div id="printInfo" style="position:relative;width: 937px;height: auto;margin: 50px auto;padding: 30px;box-sizing:border-box;box-shadow: 0 0 15px #DAD2C8;">
	<div style="width:877px;height:70px;position:relative;">
		<img src="${pageContext.request.contextPath}/img/logo.png" style="width:200px;">
		<div style="position:absolute;width:50%;height:auto;top:0;right:0;">
			<p style="margin:0;width:100%;height:30px;line-height:30px;text-align:right;font-size:14px">www.distrii.com</p>
			<p style="margin:0;width:100%;height:30px;line-height:20px;text-align:right;font-size:14px;padding-right:5px;">400-920-9888</p>
		</div>
	</div>
	<c:if test="${!(empty listCompanyBill)}">
	 <c:forEach items="${listCompanyBill}" var="companyBill">
	 	 <h4 style="box-sizing: border-box;width: 100%;height: auto;padding-left: 20px;padding-right: 20px;font-size: 16px;font-weight: normal;line-height: 40px;border-bottom: #ccc 1px solid;">
		公司名称：${companyBill.companyName }
			<p style="box-sizing: border-box;float: right;">账期：<span>${companyBill.billStartTime}</span>至<span>${companyBill.billEndTime}&nbsp;&nbsp;&nbsp;付款截止日${nextmonth }-10</span></p></h4>
		<table style="width: 100%;height: auto;margin-bottom: 0px;border-collapse: collapse;text-align: center;table-layout: fixed;border: #ccc 1px solid;">
			<tr>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;"></td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">人民币（元）</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">弹性工位券（张）</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">会议室券（张）</td>
			</tr>
			<tr>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">本月应付</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.unsettlementFee}<input type="hidden" value="${companyBill.unsettlementFee}" id="unsettlementFee">	</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.unsettlementRPkg}<input type="hidden" value="${companyBill.unsettlementRPkg}" id="unsettlementRPkg">	</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.unsettlementMPkg}<input type="hidden" value="${companyBill.unsettlementMPkg}" id="unsettlementMPkg">	</td>
			</tr>
			<tr>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">总消费</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.totalFee}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.rentianFee}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${companyBill.huiyiFee}</td>
			</tr>
		</table>
		</c:forEach>
<!-- 		<p style="box-sizing: border-box;float: right;">付款截止日：-10</p> -->
	</c:if>
		<c:if test="${!(empty listPersonBill)}">
		<c:forEach items="${listPersonBill}" var="personBill">
		<div style="padding: 10px 0;margin: 10px 0;background-color: #F9F9F9;padding: 20px;">
<!-- 		<table style="width: 100%;height: auto;margin-bottom: 0px;border-collapse: collapse;text-align: center;table-layout: fixed;border: #ccc 1px solid;"> -->
<!-- 			<tr> -->
<%-- 				<td rowspan="3" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.userName}</td> --%>
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;"></td> -->
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">人民币（元）</td> -->
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">弹性工位券（张）</td> -->
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">会议室券（张）</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">本月应付</td> -->
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementFee}</td> --%>
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementRPkg}</td> --%>
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementMPkg}</td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">总消费</td> -->
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.totalFee}</td> --%>
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.rentianFee}</td> --%>
<%-- 				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.huiyiFee}</td> --%>
<!-- 			</tr> -->
<!-- 			</table> -->
			
			<c:if test="${!(empty listItemBill)}">
		<c:forEach items="${listItemBill}" var="itemBill">
			<c:if test="${itemBill.userId==personBill.userId}">
			<h4 style="position: relative;width: 100%;height: auto;line-height: 30px;font-weight: normal;font-size: 12px;margin: 0;box-sizing: border-box;">
				<%--订单编号：<span>${itemBill.orderNo}</span>
				 <p style="float: right;margin: 0;"><span>${itemBill.orderTime }</span></p> --%>
				每月固定费项：<span></span>
				<p style="float: right;margin: 0;">订单编号：<span>${itemBill.orderNo}</span></p>
			</h4>
			<table style="width: 100%;height: auto;margin-bottom: 0px;border-collapse: collapse;text-align: center;table-layout: fixed;border: #ccc 1px solid;">
				<tr>
					<td rowspan="2" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">类型</td>
					<!-- <td rowspan="2" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">工位</td> -->
					<td rowspan="2" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">费用</td>
					<td colspan="3" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">本月应付</td>
					<td rowspan="2" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">保证金</td>
				</tr>
				<tr>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">人民币（元）</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">弹性工位券（张）</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">会议室券（张）</td>
					<%-- <td rowspan="2" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.unaccountFee}</td> --%>
				</tr>
				
				<c:forEach items="${itemBill.itemList}" var="item" varStatus="status">
				<tr>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.itemName}</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.totalFee}</td>
					<c:if test="${item.feeType==1}">
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.unaccountFee}</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0</td>
					</c:if>
					<c:if test="${item.feeType==2}">
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0.0</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.unaccountFee}</td>
					</c:if>
					<c:if test="${item.feeType==3}">
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0.0</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${item.unaccountFee}</td>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">0</td>
					</c:if>
					<c:if test="${status.first}">
					<c:forEach items="${itemBill.itemList}" varStatus="counts">
						<c:if test="${counts.last}">
							<td rowspan="${counts.count}" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${itemBill.ensureFee}</td>
						</c:if>
					</c:forEach>
					</c:if>
				</tr>
				
				</c:forEach>
				
				<tr>
					<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">工位</td>
					<td colspan="5" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">
						<c:forEach items="${itemBill.assetList}" var="asset">
							${asset.projectName}${asset.assetName}  
						</c:forEach>
					</td>
				</tr>
				
			</table>
			</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${!(empty listOtherBill)}">
		<div style="width: 100%;height: auto;background-color: #F9F9F9;padding: 5px 15px;box-sizing: border-box;">
			<p style="line-height: 30px;margin: 0;font-size: 12px;">一次性费项：</p>
			<c:forEach items="${listOtherBill}" var="otherBill">
			<c:if test="${otherBill.userId==personBill.userId}">
				<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">${otherBill.itemName }<span style="float: right;">${otherBill.unpayFee}元</span></p>
			</c:if>
			</c:forEach>
			</div>
		</c:if>
		<!-- </table> -->
		</div>
		</c:forEach>
		</c:if>
		 <c:forEach items="${listCompanyBill}" var="companyBill">
		<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">账单金额：<span style="float: right;">${companyBill.totalFee}元</span></p>
		<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">税费：<span style="float: right;">0.00元</span></p>
		<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">公司余额：<span style="float: right;">
		${comanymoneymess }
				</span></p>
		
		<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">待付款合计：<span style="float: right;">${companyBill.unsettlementFee}元</span></p>
		</c:forEach>
		
		<p style="width:100%;height:30px;line-height:30px;text-align:center;font-size:14px;margin-top:40px;">办伴公司账号信息</p>
		<p style="width:100%;height:30px;line-height:30px;text-align:center;font-size:14px">办伴公司地址（及财务章（如需要））</p>
		<p style="width:100%;height:30px;line-height:30px;text-align:center;font-size:14px">签收回执</p>
	</div>
		<div style="width: 100%;height: auto;padding-top: 20px;text-align: right;">
		<button class="printButton" style="position: absolute;right: 55px;top: 80px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">打印</button>
		<c:if test="${surecomanycount==1 }">
		    <c:if test="${isAccount==1 }">
		   		<button class="closaccountButton" style="position: absolute;right: 55px;top: 130px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">确认支付</button>
			</c:if>
		</c:if>
		<input type="hidden" value="${companyId }" id="companyId">
		<input type="hidden" value="${billMonth }" id="billMonth">
		</div>
		</div>
<script src="js/closeAccount/jquery.jqprint-0.3.js"></script>
<script src="js/closeAccount/companyClose.js"></script>