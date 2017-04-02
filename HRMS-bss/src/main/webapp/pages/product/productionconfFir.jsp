<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">产品配置</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
							<form id="query_info_product">
								<div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">所属项目</span> <select
											class="form-control" name="projectId" id="projectId">
											<option value=""></option>
											<c:forEach items="${projectList }" var="projec">
												<option value="${projec.projectId }">
													${projec.projectName }</option>
											</c:forEach>
										</select>
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">产品名称</span> <input type="text"
											class="form-control" placeholder="产品名称" id="info_productName"
											name="productName" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="display: inline-table;">
										<span class="input-group-addon">产品类型</span> <select
											class="form-control" name="productType">
											<option value=""></option>
											<c:forEach items="${producttype }" var="protype">
												<c:if test="${protype.typeNum!=10}">
												<option value="${protype.typeNum }">${protype.typeValue }</option>
													</c:if>
											</c:forEach>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary " href="javaScript:void(0);"
											id="exportProductInfo" style="border-radius: 4px;">导出查询结果
										</a>
									</div>
									<div id="exportProductInfo"></div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">起始时间</span> <input
											type="text" class="form-control reDatetimepicker"
											id="info_validDate" name="validDate" ReadOnly="true">
									</div>
									<div class="input-group col-md-3"	style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">结束时间</span> 
										<input	type="text" class="form-control reDatetimepicker"
											id="info_expireDate" name="expireDate" ReadOnly="true">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">产品状态 </span> <select
											class="form-control" name="status" id="info_status">
											<option value=""></option>
											<c:forEach items="${increstatus }" var="prostatus">
												<option value="${prostatus.typeNum }">${prostatus.typeValue }</option>
											</c:forEach>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary "
											id="query_info_productFir" style="border-radius: 4px;">查询
										</a>
									</div>
									<div class="input-group col-md-1 colLee">
						<a href="javaScript:void(0);" class="btn btn-primary shiny"
							id="add_pro_info">添加</a>
					</div>
								</div>
							</form>			

					<input type="hidden" value="" id="query_info_producthi">
					<div id="product_info_de" style="margin-top: 8px;">
						<jsp:include page="productionconf.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->


</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/product/productionconffir.js"></script>
