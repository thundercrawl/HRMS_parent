<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">智慧包配置</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<div class="box-content" >
				<div>
					<form id="query_info_product">
					<div>
					<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">所属项目</span>
						  <select class="form-control" name="projectId" id="projectId">
						  <option value="">  </option>
		    <c:forEach items="${projectList }" var="projec">
         <option value="${projec.projectId }">
${projec.projectName }
    </option>
    </c:forEach>
   </select>
						</div>
	<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">产品名称</span>
							<input type="text" class="form-control" placeholder="产品名称" id="info_productName" name="productName" maxlength="30">
						</div>
						<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">产品等级</span>
						<select class="form-control" id="info_productLevel" name="productLevel">
						<option></option>
						<c:forEach items="${wdmtype }"  var="wdty">
						<option value="${wdty.typeNum }">${wdty.typeValue }</option>
						</c:forEach>
						</select>
						</div>
						<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">产品失效时间</span>
							<input type="text" class="form-control reDatetimepicker" ReadOnly="true" id="info_validDate" name="validDate" >
						</div>
						<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">产品生效时间</span>
							<input type="text" class="form-control reDatetimepicker" ReadOnly="true" id="info_expireDate" name="expireDate"  >
						</div>
						<div class="input-group col-md-3" style=" margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">产品状态 </span>
							       <select class="form-control" name="status" id="info_status">
							       <option value=""></option>
							      <c:forEach items="${wdstatus }" var="st">
							        <option value="${st.typeNum }">${st.typeValue }</option>
							      </c:forEach>
                              </select>
						</div>
						<div class="input-group col-md-1 colLee" style=" display: inline-block;">
							<a class="btn btn-primary" id="query_info_productFir"">
				                查询
				            </a>
						</div>
						 <div class="input-group col-md-1 colLee">
        <a href="javaScript:void(0);" class="btn btn-primary shiny" id="add_pro_wdm">添加</a>
      </div>
					</div>
					</form>
				</div>
			</div>
				
      <input type="hidden" value="" id="query_widsom_ip">
					<div id="widsom_fy">
						<jsp:include page="wisdom.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script src="js/pagination.js"></script>
<script src="js/product/productWidsomFir.js"></script>
