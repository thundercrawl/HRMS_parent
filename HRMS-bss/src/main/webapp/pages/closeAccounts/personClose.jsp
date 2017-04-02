<!DOCTYPE html>
<html lang="en">
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<style>
		.round-index,
		.all-index {
			background-color: aqua;
		}
	</style>
<div style="max-height: 570px;overflow-y: auto;">
	<div  id="printInfo" style="position:relative;width: 837px;height: auto;margin: 50px auto;padding: 50px;box-sizing:border-box;box-shadow: 0 0 15px #DAD2C8;">
	<c:if test="${!(empty listPersonBill)}">
		<table style="width: 100%;height: auto;margin-bottom: 0px;border-collapse: collapse;text-align: center;table-layout: fixed;border: #ccc 1px solid;">
			<c:forEach items="${listPersonBill}" var="personBill">
			<tr>
				<td rowspan="3" style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.userName}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;"></td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">人民币（元）</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">弹性工位券（张）</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">会议室券（张）</td>
			</tr>
			<tr>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">本月应付</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementFee}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementRPkg}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.unsettlementMPkg}</td>
			</tr>
			<tr>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">总消费</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.totalFee}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.rentianFee}</td>
				<td style="padding: 0 5px;border: #ccc 1px solid;line-height: 25px;font-size: 11px;">${personBill.huiyiFee}</td>
			</tr>
			</c:forEach>
		</table>
		</c:if>
		<c:if test="${!(empty listItemBill)}">
		<div style="padding: 10px 0;margin: 10px 0;border-bottom: 1px solid #F1F1F1;border-top: 1px solid #F1F1F1;background-color: #F9F9F9;padding: 20px;">
		<c:forEach items="${listItemBill}" var="itemBill">
			<h4 style="position: relative;width: 100%;height: auto;line-height: 30px;padding-left: 25px;font-weight: normal;font-size: 12px;margin: 0;box-sizing: border-box;">
			<c:if test="${flagsec==1 }">
			<span class="ch-round" style="position: absolute;left: 0;top: 50%;width: 13px;height: 13px;border: #ccc 1px solid;border-radius: 100%;margin-top: -7px;" data-orderNo="${itemBill.orderId }"></span>
			</c:if>
				订单编号：<span class="seclorder-ch" data-orderNo="${itemBill.orderId }">${itemBill.orderNo}</span>
				<p style="float: right;margin: 0;"><span>${itemBill.orderTime }</span></p>
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
							${asset.projectName} ${asset.assetName}  
						</c:forEach>
					</td>
				</tr>
			</table>
			</c:forEach>
		</div>
		</c:if>
		<c:if test="${!(empty listOtherBill)}">
		<div style="width: 100%;height: auto;background-color: #F9F9F9;padding: 5px 15px;box-sizing: border-box;">
		<c:forEach items="${listOtherBill}" var="otherBill">
			<p style="line-height: 30px;margin: 0;border-bottom: 1px solid #E2E2E2;font-size: 12px;">${otherBill.itemName }<span style="float: right;">${otherBill.unpayFee}元</span></p>
		</c:forEach>
		</div>
		</c:if>
			<c:if test="${flagsec==1 }">
		<div style="position: relative;width: 100%;margin-top: 20px;padding-left: 41px;font-size: 12px;background-color: #F9F9F9;height: 30px;line-height: 30px;box-sizing: border-box;">
			<span class="all-ch" style="position: absolute;left: 16px;top: 50%;width: 13px;height: 13px;border: #ccc 1px solid;border-radius: 100%;margin-top: -7px;"></span>全选
		</div>
		</c:if>
	</div>
	</div>
	<div style="width: 100%;height: auto;padding-top: 20px;text-align: right;">
			<button class="printButton" style="position: absolute;right: 55px;top: 80px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;">打印</button>
			<c:if test="${flagsec!=1 }">
			<c:if test="${zhifu==1 }">
			<c:forEach items="${listPersonBill}" var="personBill">
     		<button class="surecheckorder" style="position: absolute;right: 55px;top: 130px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;" 
     		data-companyId="${companyId }" data-userId="${userId }" data-unsettlementFee="${personBill.unsettlementFee}"
     		data-unsettlementRPkg="${personBill.unsettlementRPkg}" data-unsettlementMPkg="${personBill.unsettlementMPkg}">确认付款</button>
			</c:forEach>
			</c:if>
			</c:if>
			<c:if test="${flagsec==1 }">
			<c:forEach items="${listPersonBill}" var="personBill">
     		<button class="surecheckordersec" style="position: absolute;right: 55px;top: 130px;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 12px;font-weight:100;line-height: 1.42857143;text-align: center;border: 1px solid transparent;border-radius: 4px;color: #fff;background-color: #337ab7;border-color: #2e6da4;" 
     		data-companyId="${companyId }" data-userId="${userId }">结账</button>
			</c:forEach>
			</c:if>
		
		</div>
		
	<script src="js/closeAccount/personClose.js"></script>