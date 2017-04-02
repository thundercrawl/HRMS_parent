<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>

		<tr>
			<th class="center">所属项目</th>
			<th class="center">产品名称</th>
			<th class="center">产品描述</th>
			<th class="center">产品等级</th>
			<th class="center">产品状态</th>
			<th class="center">产品价格</th>
			<th class="center">容量</th>
			<th class="center">产品生效时间</th>
			<th class="center">产品失效时间</th>
			<th class="center">产品类型</th>
			<th class="center">操作</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="project">
				<c:if test="${project.productType<5 }">
					<tr>
						<th class="center">${project.projectName}</th>
						<td class="center">${project.productName}</td>
						<td class="center">${project.productDesc }</td>
						<td class="center">${project.productLevelEnum }</td>
						<td class="center">${project.statusEnum }</td>
						<td class="center">${project.money  }元/${project.unitEnum  }</td>
						<td class="center">${project.capacity }</td>
						<td class="center">${project.validDate }</td>
						<td class="center">${project.expireDate }</td>
						<td class="center">${project.productTypeName }</td>
						<td><a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit revise_product"
							data-productid1="${project.productId }"
							data-expireDate="${project.expireDate }"
							data-productName="${project.productName}"
							data-productDesc="${project.productDesc}"
							data-productLeavl="${project.productLevel}"
							data-validDate="${project.validDate}"
							data-status="${project.status }" data-page1="${paginator.page}"
							data-rateid="${project.rateId }" data-itemid="${project.itemId }"
							data-space="${project.spaceId}"
							data-projectid="${project.projectId }"
							data-capacity="${project.capacity }"
							data-assetType="${project.productType }" 
							data-assetTypeName="${project.productTypeName }"
							data-assetMoney="${project.money }"
							data-productArea="${project.productArea }"><i
								class="fa fa-edit"></i>修改</a> <a href="javaScript:void(0);"
							class="btn btn-danger btn-xs delete_product"
							data-page="${paginator.page}"
							data-productid2="${project.productId }"><i
								class="fa fa-trash-o"></i>删除</a> <a href="javaScript:void(0);"
							class="btn btn-danger btn-xs gwconfsert"
							data-pagegw="${paginator.page}"
							data-productidgw="${project.productId }"><i
								class="fa fa-trash-o"></i>配置资产</a> <a href="javaScript:void(0);"
							class="btn btn-danger btn-xs pzwidsomas"
							data-pagegw="${paginator.page}"
							data-productidgw="${project.productId }"
							data-project="${project.projectId }"
							data-productname="${project.productName}"><i
								class="fa fa-trash-o"></i>配置智慧包产品</a></td>

					</tr>

				</c:if>
				<c:if test="${project.productType>4 }">
					<tr>
					    <th class="center">${project.projectName}</th>
						<td class="center">${project.productName}</td>
						<td class="center">${project.productDesc }</td>
						<td class="center">${project.productLevelEnum }</td>
						<td class="center">${project.statusEnum }</td>
						<td class="center">${project.money  }元/${project.unitEnum  }</td>
						<td class="center">${project.capacity }</td>
						<td class="center">${project.validDate }</td>
						<td class="center">${project.expireDate }</td>
						<td class="center">${project.productTypeName }</td>
						<td><a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit revise_product"
							data-productid1="${project.productId }"
							data-expireDate="${project.expireDate }"
							data-productName="${project.productName}"
							data-productDesc="${project.productDesc}"
							data-productLeavl="${project.productLevel}"
							data-validDate="${project.validDate}"
							data-status="${project.status }" data-page1="${paginator.page}"
							data-rateid="${project.rateId }" data-itemid="${project.itemId }"
							data-space="${project.spaceId}"
							data-projectid="${project.projectId }"
							data-capacity="${project.capacity }"
							data-assetType="${project.productType }"
							data-assetTypeName="${project.productTypeName }"
							data-assetMoney="${project.money }"
							data-productArea="${project.productArea }"><i
								class="fa fa-edit"></i>修改</a> <a href="javaScript:void(0);"
							class="btn btn-danger btn-xs delete_product"
							data-page="${paginator.page}"
							data-productid2="${project.productId }"><i
								class="fa fa-trash-o"></i>删除</a></td>

					</tr>

				</c:if>


			</c:forEach>

		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/product/productionconfall" name="url" />
	<jsp:param value="product_info_de" name="loadCmp" />
	<jsp:param value="query_info_producthi" name="formParam" />
</jsp:include>
<!--添加产品 开始  -->
<div id="add_Pdialog_pro" style="display: none;">

	<form action="" style="margin-right: 25px;">
		<table>
			<tr>
			</tr>
			<tr>
				<td>所属项目</td>
				<td><select type="select" id="project_Id">
						<option value=""></option>
						<c:forEach items="${projectList}" var="projec">
							<option value="${projec.projectId }">
								${projec.projectName }</option>
						</c:forEach>
				</select> <span id="spanproject_Id"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品名称</td>
				<td><input type="text" id="product_Name" maxlength="32" /> <span
					id="spanproduct_Name"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>

			<tr>
				<td>产品描述</td>
				<td><input type="text" id="product_Desc" maxlength="120" /> <span
					id="spanproduct_Desc"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
		<%-- 	<tr>
				<td>产品等级</td>
				<td><select type="select" id="product_productLevel">
						<option></option>
						<c:forEach items="${proleavel }" var="en">
							<option value="${en.typeNum }">${en.typeValue }</option>
						</c:forEach>
				</select> <span id="spanproduct_productLevel"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品状态</td>
				<td><select type="select" id="product_status">
						<option value="1" selected="selected">出售</option>
						<c:forEach items="${increstatus }" var="prostatus">
							<option value="${prostatus.typeNum }">${prostatus.typeValue }</option>
						</c:forEach>
				</select> <span id="spanproduct_status"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr> --%>
			<tr>
				<td>容量</td>
				<td><input type="number" value="" id="capacity" maxlength="10">
					<span id="spancapacity"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品生效时间</td>
				<td><input type="text" id="product_validDate"
					class="reDatetimepicker" ReadOnly="true" /> <span
					id="spanproduct_validDate"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品失效时间</td>
				<td><input type="text" id="product_expireDate"
					class="reDatetimepicker" ReadOnly="true" /> <span
					id="spanproduct_expireDate"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>费率</td>
				<td><select id="bssrate_id">
						<option value=""></option>
						<c:forEach items="${bssRate }" var="bssrate">
							<option value="${bssrate.rateId }">${bssrate.rateName }
								${bssrate.ratePriceFee }</option>
						</c:forEach>
				</select> <span id="spanbssrate_id"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>科目</td>
				<td><select id="iteminfo">
						<option value=""></option>
						<c:forEach items="${iteminfo }" var="itemin">
							<option value="${itemin.code }">${itemin.name }</option>
						</c:forEach>
				</select><span id="spaniteminfo"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>空间类型</td>
				<td><select id="space_id">
						<c:forEach items="${ofspace }" var="space">
						<c:if test="${space.spaceId<5}">
							<option value="${space.spaceId }">${space.spaceName }</option>
							</c:if>
						</c:forEach>
						<option value="-1">其他</option>
				</select><span id="spanspace_id"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品类型</td>
				<td id="apend_type"><select id="assert_id">
						<option value=""></option>
						<c:forEach items="${producttype }" var="en">
						<c:if test="${en.typeNum!=5 }">
							<option value="${en.typeNum }">${en.typeValue }</option>
						</c:if>
						</c:forEach>
				</select> <span id="spanassert_id"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr id="office_area"></tr>

		</table>
	</form>
	
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"	id="formcheck_product_sure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_product_esc">取消</a>
	</div>
	
	
</div>
<!--添加产品 结束  -->
<!--修改产品开始  -->
<div id="add_Pdialog_xg" style="display: none;">

	<form action="" style="margin-right: -26px;">
		<table>
			<tr>
				<td><input type="hidden" id="product_Idxg" value="" /></td>
				<td><input type="hidden" id="hiddenrate_Id" value="" /></td>
				<td><input type="hidden" id="productitem_Id" value="" /></td>
				<td><input type="hidden" id="productspace_Id" value="" /></td>
				<td><input type="hidden" id="productpro_Id" value="" /></td>
				<td><input type="hidden" id="produpage" value="" /></td>
				<td><input type="hidden" id="assert_idxg" value="" /></td>

			</tr>
			<tr>
				<td>产品名称</td>
				<td><input type="text" id="product_Namexg" maxlength="30" /> <span
					id="spanproduct_Namexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>

			<tr>
				<td>产品描述</td>
				<td><input type="text" id="product_Descxg" maxlength="120" /> <span
					id="spanproduct_Descxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<%-- <tr>
				<td>产品等级</td>
				<td><select type="select" id="product_productLevelxg">
						<option></option>
						<c:forEach items="${proleavel }" var="en">
							<option value="${en.typeNum }">${en.typeValue }</option>
						</c:forEach>
				</select> <span id="spanproduct_productLevelxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr> --%>
			<tr>
				<td>产品状态</td>
				<td><select type="select" id="product_statusxg">
						<option></option>
						<c:forEach items="${increstatus }" var="prostatus">
							<option value="${prostatus.typeNum }">${prostatus.typeValue }</option>
						</c:forEach>
				</select> <span id="spanproduct_statusxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>容量</td>
				<td><input type="number" value="" id="capacityxg"> <span
					id="spancapacityxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>产品生效时间</td>
				<td><input type="text" id="product_validDatexg" ReadOnly="true"
					class="reDatetimepicker" /> <span id="spanproduct_validDatexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
				</td>
			</tr>
			<tr>
				<td>产品失效时间</td>
				<td><input type="text" id="product_expireDatexg"
					ReadOnly="true" class="reDatetimepicker" /> <span
					id="spanproduct_expireDatexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr style="display:none;">
				<td>产品类型</td>
				<td><input type="text" id="showproducttype" value=""
					disabled="disabled">
			</tr>
			<tr>
				<td>产品类型</td>
				<td><input type="text" id="showproducttypeName" value=""
					disabled="disabled">
			</tr>
			<tr>
				<td>费率</td>
				<td><select id="bssrate_id2" class="changeRate">
						<option value=""></option>
						<c:forEach items="${bssRate }" var="bssrate">
						
							<option value="${bssrate.rateId }">${bssrate.rateName }
								${bssrate.ratePriceFee }</option>
						</c:forEach>
				</select> <span id="spanbssrate_id2"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr id="product_areaxg"></tr>

		</table>
	</form>
	
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_product_surexg">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_product_escxg">取消</a>
	</div>
	 
</div>
<!--修改产品开结束 -->

<!--给产品配置资产开始  -->
<div id="add_Pdialog_pro1gw" style="display: none;">

	<form action="" style="max-height:390px;overflow-y: auto;">
		<tr>
			<td><input type="hidden" value="" id="page_gw"></td>
		</tr>
		<tr>
			<td><input type="hidden" value="" id="assert_gw"></td>
		</tr>
		<table class="table1">
			<thead>
				<tr>
					<th>请选择</th>
					<th>名称</th>
					<th>区域信息</th>
					<th>楼层</th>
					<th>描述</th>
					<th>房间号</th>
				</tr>
			</thead>
			<tbody id="assertfg">


			</tbody>




		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_product_suregw">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_product_escgw">取消</a>
	</div>
	 
	
</div>
<!--给产品配置资产结束  -->

<div id="add_Pdialog_prowidsom" style="display: none;">
	<form action="">
		<tr>
			<td><input type="hidden" value="" id="page_widsom"></td>
		</tr>
		<tr>
			<td><input type="hidden" value="" id="assert_widsom"></td>
		</tr>
		<tr>
			<td><input type="hidden" value="" id="assert_project"></td>
		</tr>
		<tr>
			<td><input type="hidden" value="" id="pagefont"></td>
		</tr>
		<tr>
			<td>产品</td>
			<!-- <input type="text" id="product_id" disabled="disabled" value=""> -->
			<td><span id="product_id"></span></td>
		</tr>
		<tr>
			<td><div id="wdisomadd" style="margin-bottom: 10px;"></div></td>
		</tr>
		<tr>
		</tr>
		</form>
<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"	id="sure_pro_wdm_1">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="esc_pro_wdm_1">取消</a>
	</div>


		
		 
</div>

<script id="departmentList" type="text/x-handlebars-template">

   {{#each this}}
<tr> <td> 
{{#if isbinding}}
<input type="checkbox" class="choose confproduse" checked="true" id="{{seatId}}"
							name="confprodusenamegw" value="{{seatId}}|1|{{proRankId}}|{{status}}">
{{else}}
<input type="checkbox" class="choose confproduse" id="{{seatId}}"
							name="confprodusenamegw" value="{{seatId}}|1|{{proRankId}}|{{status}}">
{{/if}}
</td>
							<td>{{sname}}</td>
							<td>{{areaInfo}}</td>
							<td>{{floor}}</td>
							<td>{{description}}</td>
                            <td>{{houseNumber}}</td>
                          </tr>

   {{/each}}

</script>
<script id="departmentList2" type="text/x-handlebars-template">
   {{#each this}}

<tr> <td> 
{{#if isbinding}}
<input type="checkbox" class="choose confproduse" checked="true" id="{{meetingroomId}}"
							name="confprodusenamegw" value="{{meetingroomId}}|2|{{rankId}}|{{status}}">
{{else}}
<input type="checkbox" class="choose confproduse" id="{{meetingroomId}}"
							name="confprodusenamegw" value="{{meetingroomId}}|2|{{rankId}}|{{status}}">
{{/if}}
</td>
							<td>{{rname}}</td>
							<td>{{areaInfo}}</td>
							<td>{{floorInfo}}</td>
							<td>{{description}}</td>
	                        <td>{{houseNumber}}</td>
                             </tr>

   {{/each}}

</script>
<script id="departmentList3" type="text/x-handlebars-template">
   {{#each this}}

<tr> <td> 
{{#if isbinding}}
<input type="checkbox" class="choose confproduse" checked="true" id="{{officeId}}"
							name="confprodusenamegw" value="{{officeId}}|3|{{rankId}}|{{status}}">
{{else}}
<input type="checkbox" class="choose confproduse"  id="{{officeId}}"
							name="confprodusenamegw" value="{{officeId}}|3|{{rankId}}|{{status}}">
{{/if}}
</td>
							<td>{{oname}}</td>
							<td>{{areaInfo}}</td>
							<td>{{floor}}</td>
							<td>{{description}}</td>
	                        <td>{{houseNumber}}</td>	
</tr>

   {{/each}}

</script>
<script id="departmentList4" type="text/x-handlebars-template">
智慧包
{{#each this}}
{{#if iswhdsom}}
<tr class="xman">
 <td colspan="2">
<input type="checkbox" class="wdmclsss" id="{{productId}}" checked="true"
							name="product_wdmname" value="{{productId}}">
<span>{{productName}}</span>
</td>
							
                           
</tr>
 <tr class="xman"><td style="padding-left: 23px;">优惠产品</td>
<td><select id="{{productId}}se">
<option value=""></option>
   {{#each listparam}}
{{#if ispreferentialpro}}
<option value="{{productId}}"  selected="selected">{{productName}}{{money}}</option>
{{else}}
<option value="{{productId}}">{{productName}}{{money}}</option>
{{/if}}
   {{/each}}
</select></td></tr>
{{else}}
<tr class="xman">
 <td colspan="2">
<input type="checkbox" class="wdmclsss" id="{{productId}}"
							name="product_wdmname" value="{{productId}}">
<span>{{productName}}</span>
</td>
							
                            
</tr>
<tr class="xman"><td style="padding-left: 23px;">优惠产品</td>
<td><select id="{{productId}}se">
<option value=""></option>
   {{#each listparam}}
<option value="{{productId}}">{{productName}}{{money}}</option>
   {{/each}}
</select></td></tr>
{{/if}}
  {{/each}}
</script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/product/productionconf.js"></script>
