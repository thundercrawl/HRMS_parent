<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-striped table-hover table-bordered dataTable no-footer"  aria-describedby="editabledatatable_info">
     <thead>
         <tr role="row">
         <!-- <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	 全选
       	 <input type="checkbox" onclick="checkAll(this)">
         </th> -->
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
       	公司名 
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 150px;">	
                 账单月份</th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 150px;">	
                 账单总金额</th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 151px;">
      应支付弹性工位券
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 151px;">
       	 应支付会议室券
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 150px;">
       	未支付金额
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 150px;">
       	 未支付弹性工位券
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 150px;">
       	 未支付会议室券
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 80px;">
       	 是否出账
         </th>
         <!-- <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
                          帖子状态
         </th> 
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
          操作
         </th> -->
         </tr>
         </thead>
       <c:if test="${!(empty paginator.list)}">
       <tbody id="billListInfo">
         <c:forEach items="${paginator.list}" var="c">
         <tr class="even">
          	<%-- <td class=" "style="text-align: center;">
          	<input type="checkbox" name="promotions" value="${c.forumId}">
          	</td> --%>
         	<td class=" ">${c.companyName} </td>
         	<td class=" "><a href="javaScript:void(0)" id="${c.billMonth}" class="showBill">${c.billMonth}</a></td>
         	<td class=" ">${c.totalFee}</td>
         	<td class=" ">${c.rentianFee}</td>
         	 <td class=" ">${c.huiyiFee}</td>
         	<td class=" ">${c.unsettlementFee}</td>
          	<td class=" ">${c.unsettlementRPkg}</td>
          	<td class=" ">${c.unsettlementMPkg}</td>
          	
          	<td class=" "><c:if test="${c.isAccount==1}">已出账</c:if>
          	<c:if test="${c.isAccount==0}">未出账</c:if>
          	</td>
          	
          	
          	<%--<td class=" ">${c.delSignName}</td>
          	 <td>
          	   <c:if test="${c.status==1}">
          	     <a href="javaScript:void(0)" class="btn btn-xs delete" id="sures${c.contractid}" style="color: gray;"><i class="fa fa-trash-o"></i>已确认</a>
          	   </c:if>
          	  <c:if test="${c.status==1}">
          	  	<c:if test="${c.cannotDel==1}">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs change_forum" orderid="${c.forumId}" page="${paginator.page}" cannotdel="${c.cannotDel}"><i class="fa fa-trash-o"></i>置为水贴</a>
          	  	</c:if>
          	  	<c:if test="${c.cannotDel==0}">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs cancel_change_forum" orderid="${c.forumId}" page="${paginator.page}" cannotdel="${c.cannotDel}"><i class="fa fa-trash-o"></i>取消水贴</a>
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
          	    	<a href="javaScript:void(0)" class="btn btn-danger btn-xs surePay" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>确认付款</a>
          	    </c:if>
          	  </c:if>
          	</td> --%>
         </tr></c:forEach>
           </tbody></c:if>
         </table>
         
         <input type="text" hidden="true" value="${page}" id="page">
           <jsp:include page="../common/paginator.jsp">
				<jsp:param value="filter/account/queryCompanyAccount?companyId=${companyId }&flag=${flag }" name="url" />
				<jsp:param value="fourm_table" name="loadCmp"/> 
		   </jsp:include>
		   <div id="selectcomp" style="display: none;">
						<div >
								<label>选择公司</label>
								<div >
									<select class="form-control " name="companyId" id="companyId"></select>
								</div>
							</div>
                        <div>
						</div>

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="queryonecomap">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="escquerycomp">取消</a>
						</div>
				</div>	
				
				   <div id="selectclosecom" style="display: none;">
						<div >
								<label>选择公司</label>
								<div >
									<select class="form-control " name="companyIdclose" id="companyIdclose"></select>
								</div>
							</div>
                        <div>
						</div>

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="queryclose">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="escqueryclose">取消</a>
						</div>
				</div>	
				 <div id="surecompanycheck" style="display: none;">
						<div >
								<label>公司要支付的账单</label>
								<div>
						<table>
						<thead>
						<tr><td>人民币（元）</td><td>会议室券（张）</td><td>弹性工位券（张 ）</td></tr>
						</thead>
						<tbody id="showcompanycheck"> </tbody>
						</table>
								</div>
							</div>
                        <div>
						</div>

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="querycheck">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="escquerycheck">取消</a>
						</div>
				</div>	
	 <script id="companyselect" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{companyId}}">{{companyName}}</option>
{{/each}}
</script>
 <script id="companycloseselect" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{companyId}}">{{companyName}}</option>
{{/each}}
</script>
 <script id="companycheckselect" type="text/x-handlebars-template">
{{#each this}}

	<tr> 
<td><input type="hidden" value="{{unsettlementFee}}" id="check_1"></td>
<td><input type="hidden" value="{{unsettlementMPkg}}" id="check_2"></td>
<td><input type="hidden" value="{{unsettlementRPkg}}" id="check_3"></td>
</tr>
	<tr> 
<td>{{unsettlementFee}}</td>
<td>{{unsettlementMPkg}}</td>
<td>{{unsettlementRPkg}}</td>
</tr>

{{/each}}
</script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/closeAccount/quercompanyAccount.js"></script>