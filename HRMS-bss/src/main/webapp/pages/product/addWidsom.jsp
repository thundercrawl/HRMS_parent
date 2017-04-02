<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<input type="hidden" id="hidden_spaceId" value="${wispro.spaceId }">
<input type="hidden" id="hidden_itemId" value="${wispro.itemId }">
<input type="hidden" id="hidden_rateId" value="${wispro.rateId }">
<input type="hidden" id="hidden_projectid" value="${wispro.projectId }">
<input type="hidden" id="productId" value="${wispro.productId }">
 <form action="" >
    <table class="table big-ch">
       <tr>
         <c:if test="${wispro.projectId=='-1'}">
       <td>所属项目</td>
         <td><select   id="project_Id">
           <option value=""></option>
         <c:forEach items="${projectList }" var="projec">
         <option value="${projec.projectId }">
${projec.projectName }
    </option>
    </c:forEach>
   </select><span id="spanproject_Id" style="display: none;color: red;margin-left: 5px;">X</span></td></c:if>
      
       <td>产品名称</td>
         <td><input type="text" id="product_Name"  value="${wispro.productName}" maxlength="30"/><span id="spanproduct_Name"  style="display: none;color: red;margin-left: 5px;">X</span></td>
      </tr>
      
      <tr>
       <td>产品描述</td>
         <td><input type="text" id="product_Desc" value="${wispro.productDesc}" maxlength="120"/><span id="spanproduct_Desc"  style="display: none;color: red;margin-left: 5px;">X</span></td>
       
       <td>产品等级</td>
       <td>
         <select   id="product_productLevel">
         <c:if test="${wispro.productLevel!='-1' }">
           <option value="${wispro.productLevel }">${wispro.productLevelEnum }</option>
         </c:if>
         <c:if test="${wispro.productLevel=='-1' }">
           <option value=""></option>
         </c:if>
         <c:forEach items="${proleavel }" var="prolev">
           <option value="${prolev.typeNum }">${prolev.typeValue }</option>
         </c:forEach>
         

   </select><span id="spanproduct_productLevel"  style="display: none;color: red;margin-left: 5px;">X</span>
 </td>
      </tr>
      <tr>
         <td>产品状态</td>
         <td>
          <select id="product_status">
           <c:if test="${wispro.status!='-1'}">
          <option value="${wispro.status}">${wispro.statusEnum}</option></c:if>
          <c:if test="${wispro.status=='-1'}">
          <option value=""></option></c:if>
        <c:forEach items="${increstatus }" var="status">
        <option value="${status.typeNum}">${status.typeValue}</option>
        </c:forEach>
    </select><span id="spanproduct_status" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       
       <td>产品生效时间</td>
         <td><input type="text" id="product_validDate"  value="${wispro.validDate}"  class="reDatetimepicker" ReadOnly="true"/><span id="spanproduct_validDate"  style="display: none;color: red;margin-left: 5px;">X</span></td>
      </tr>
        <tr>  <td>产品失效时间</td>
         <td><input type="text" id="product_expireDate" value="${wispro.expireDate}"  class="reDatetimepicker" ReadOnly="true"/><span id="span" style="display: none;color: red;margin-left: 5px;">X</span></td>
     <td>等级</td>
     <td><select id="wd_incrementLevel">
     <c:if test="${wispro.incrementLevel!='-1'}">
       <option value="${wispro.incrementLevel }">${wispro.incrementLevelName }</option></c:if>
        <c:if test="${wispro.incrementLevel=='-1'}">
           <option value=""></option></c:if>
       <c:forEach items="${increlevel }" var="prlevl" >
       <option value="${prlevl.typeNum }">${prlevl.typeValue}</option>
       </c:forEach>
     </select><span id="spanwd_incrementLevel" style="display: none;color: red;margin-left: 5px;">X</span></td>
     </tr>

 <c:if test="${wispro.projectId=='-1'}"><tr><td>费率</td><td>
   <select id="bssrate_id">
   <option value=""></option>
   <c:forEach items="${bssRate }" var="bssrate">
     <option value="${bssrate.rateId }">${bssrate.rateName } ${bssrate.ratePriceFee }</option>
     </c:forEach>
   </select>
  <span id="spanbssrate_id" style="display: none;color: red;margin-left: 5px;">X</span>
  </td>
     <td>科目</td>
     <td>
     <select id="iteminfo">
     <option value=""></option>
   <c:forEach items="${iteminfo }" var="itemin">
     <option value="${itemin.code }">${itemin.name }</option>
     </c:forEach>
   </select><span id="spaniteminfo" style="display: none;color: red;margin-left: 5px;">X</span>
   </td>
   </tr>
   </c:if>
     <tr style="display:none;">
           <td>容量</td>
            <td><input type="number"  id="capacity_add" value="${wispro.capacity }" maxlength="10"> 
            <span id="spancapacity"  style="display: none;color: red;margin-left: 5px;">X</span></td>
           </tr>
        <tr>
       <td>隔间座机</td>
         <td><input type="text" id="wd_phoneCount" value="${wispro.phoneCount}" maxlength="10"/>个/月
         <span id="spanwd_phoneCount" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
        <td>黑白A4打印</td>
         <td><input type="text" id="wd_paperCount"  value="${wispro.paperCount}" maxlength="10"/>张/月
         <span id="spanwd_paperCount" style="display: none;color: red;margin-left: 5px;">X</span></td>
       </tr>
       <tr>
     <td>会议室</td>
         <td><input type="text" id="wd_meetingroomHours" value="${wispro.meetingroomHours}" maxlength="10"/>小时/月
         <span id="spanwd_meetingroomHours" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       <td>弹性工位券</td>
         <td><input type="text" id="wd_seatCount" value="${wispro.seatCount}" maxlength="10"/>个/月
         <span id="spanwd_seatCount" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       </tr>
       <tr>
        <td>隔间接入带宽</td>
         <%-- <td>
         <input id="wd_seatBroadbandWidth" type="text" value="${wispro.seatBroadbandWidth}" maxlength="10">
          <span id="spanwd_seatBroadbandWidth" style="display: none;color: red;margin-left: 5px;">X</span>
          </td> --%>
           <td>
           <select id="wd_seatBroadbandWidth">
           <c:if test="${wispro.seatBroadbandWidth!='-1'}"> <option value="${wispro.seatBroadbandWidth}">${wispro.seatBroadbandWidthName }</option></c:if>
            <c:if test="${wispro.seatBroadbandWidth=='-1'}"> <option value=""></option></c:if>
           <c:forEach items="${swith }" var="perwth">
           <option value="${perwth.typeNum }">${perwth.typeValue }</option>
           </c:forEach>
           </select> <span id="spanwd_seatBroadbandWidth" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       <td>隔间接入等级</td>
         <td>
         <select id="wd_seatBroadbandLevel">
         <c:if test="${wispro.seatBroadbandLevel=='0'}">  <option value="0">独享</c:if>
         <c:if test="${wispro.seatBroadbandLevel=='1'}"><option value="1">共享</c:if>
         <c:if test="${wispro.seatBroadbandLevel=='-1'}"><option value=""></c:if>
       <c:forEach items="${brolevel }" var="brovl">
        <option value="${brovl.typeNum }">${brovl.typeValue }</option>
       </c:forEach> 
         </select>
          <span id="spanwd_seatBroadbandLevel" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       </tr>
       <tr>
       <td>人均最大同时接入终端数量</td>
         <td><input type="text" id="wd_seatAvgConNum" value="${wispro.seatAvgConNum}" maxlength=""/>
           <span id="spanwd_seatAvgConNum" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
        <td>网络双备份 </td>
         <td><select id="wd_isBackup">
          <c:if test="${wispro.isBackup=='0'}"><option value="0">否</option></c:if>
         <c:if test="${wispro.isBackup=='1'}"><option value="1">是</option></c:if>
          <c:if test="${wispro.isBackup=='-1'}"><option value=""></option></c:if>
        <c:forEach items="${backup }" var="baup">
        <option value="${baup.typeNum }">${baup.typeValue }</option>
       </c:forEach>
         </select>
          <span id="spanwd_isBackup" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
      </tr>
       <tr>
        <td>个人接入带宽</td>
         <td>
           <select id="wd_personBroadbandWidth">
           <c:if test="${wispro.personBroadbandWidth!='-1'}"> <option value="${wispro.personBroadbandWidth}">${wispro.personBroadbandWidthName }</option></c:if>
            <c:if test="${wispro.personBroadbandWidth=='-1'}"> <option value=""></option></c:if>
           <c:forEach items="${pwith }" var="perwth">
           <option value="${perwth.typeNum }">${perwth.typeValue }</option>
           </c:forEach>
           </select> <span id="spanwd_personBroadbandWidth" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       <td>个人接入等级</td>
         <td>
         <select id="wd_personBroadbandLevel">
         <c:if test="${wispro.personBroadbandLevel=='0'}"> <option value="0">独享</option></c:if>
         <c:if test="${wispro.personBroadbandLevel=='1'}"> <option value="0">共享</option></c:if>
         <c:if test="${wispro.personBroadbandLevel=='-1'}">  <option value=""></option></c:if>
          <c:forEach items="${broadban }" var="broban">
        <option value="${broban.typeNum }">${broban.typeValue }</option>
       </c:forEach>
         </select>
         <span id="spanwd_personBroadbandLevel" style="display: none;color: red;margin-left: 5px;">X</span>
         
         </td>
      </tr>
       <tr>
        <td>个人最大同时接入终端数量</td>
         <td><input type="text" id="wd_PERSON_AVG_CON_NUM" value="${wispro.personAvgConNum}" maxlength="10"/>
         <span id="spanwd_PERSON_AVG_CON_NUM" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
        <td>无线WIFI网络使用范围 </td>
         <td><select id="wd_wifiRangeUse">
         <c:if test="${wispro.wifiRangeUse=='1'}"><option value="1">上海项目</option></c:if>
         <c:if test="${wispro.wifiRangeUse=='2'}"><option value="2">全国项目</option></c:if>
         <c:if test="${wispro.wifiRangeUse=='3'}"><option value="3">租约项目</option></c:if>
          <c:if test="${wispro.wifiRangeUse=='-1'}"><option value=""></option></c:if>
         <c:forEach items="${wifi }" var="wi">
        <option value="${wi.typeNum }">${wi.typeValue }</option>
       </c:forEach>
         </select>
          <span id="spanwd_wifiRangeUse" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       </tr>
       <tr>
       <td>办伴APP协同办公</td>
         <td>
         <select id="wd_collaboration" >
          <c:if test="${wispro.collaboration=='0'}"><option value="0">否</option></c:if>
          <c:if test="${wispro.collaboration=='1'}"><option value="1">是</option></c:if>
          <c:if test="${wispro.collaboration=='-1'}"><option value=""></option></c:if>
         <c:forEach items="${collaboraion }" var="coll">
        <option value="${coll.typeNum }">${coll.typeValue }</option>
       </c:forEach>
         </select>
          <span id="spanwd_collaboration" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
      <td>语音远程会议分钟数</td>
         <td><input type="text" id="wd_meetingMinute"  value="${wispro.meetingMinute}" maxlength="10"/>
           <span id="spanwd_meetingMinute" style="display: none;color: red;margin-left: 5px;">X</span>
         </td>
       </tr>
       <tr>
        <td>手机开门</td>
         <td>
         <select id="wd_isPhoneOendoor">
            <c:if test="${wispro.isPhoneOendoor=='0'}"><option value="0">否</option></c:if>
            <c:if test="${wispro.isPhoneOendoor=='1'}"><option value="1">是</option></c:if>
            <c:if test="${wispro.isPhoneOendoor=='-1'}"><option value=""></option></c:if>
         <c:forEach items="${phone }" var="ph">
        <option value="${ph.typeNum }">${ph.typeValue }</option>
       </c:forEach>
         </select>
        <span id="spanwd_isPhoneOendoor" style="display: none;color: red;margin-left: 5px;">X</span>
         
         </td>
        <td>智能储物柜</td>
         <td>
         <select id="wd_isCabinetUse">
           <c:if test="${wispro.isCabinetUse=='0'}"><option value="0">否</option></c:if>
           <c:if test="${wispro.isCabinetUse=='1'}"><option value="1">是</option></c:if>
           <c:if test="${wispro.isCabinetUse=='-1'}"><option value=""></option></c:if>
         <c:forEach items="${cabint }" var="cab">
        <option value="${cab.typeNum }">${cab.typeValue }</option>
       </c:forEach>
         </select>
        <span id="spanwd_isCabinetUse" style="display: none;color: red;margin-left: 5px;">X</span>
         
         </td>
         <td>费率</td>
				<td><select id="bssrate_id2" class="changeRate2">
				
						<option value=""></option>
						<c:forEach items="${bssRate }" var="bssrate">
						<c:if test="${wispro.rateId==bssrate.rateId}">
						<option selected="selected" value="${bssrate.rateId }">${bssrate.rateName }${bssrate.ratePriceFee }</option>
						</c:if>
							<option value="${bssrate.rateId }">${bssrate.rateName }
								${bssrate.ratePriceFee }</option>
						</c:forEach>
				</select> <span id="spanbssrate_id2"
					style="display: none; color: red; font-size: 18px">X</span></td>
      </tr>
    </table>
   </form>
   <div class="input-group col-md-12 text-center">
   	<div class="input-group col-md-1 colLee" style="display:inline-block">
      <a href="javaScript:void(0);" class="btn btn-primary" id="wd_pro_sure">确定</a>
      </div>
      <div class="input-group col-md-1 colLee" style="display:inline-block">
   <a href="javaScript:void(0);" class="btn btn-primary" id="wd_pro_esc">取消</a>
   </div>
   </div>
 
   <script src="js/pagination.js"></script>
<script src="js/product/addproductWidsom.js"></script>
<script src="js/product/productWidsom.js"></script>
