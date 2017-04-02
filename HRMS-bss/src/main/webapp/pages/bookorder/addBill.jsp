<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">账单配置/挂账</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""
				style="padding-top: 0; padding-bottom: 0; line-height: 35px;">挂账</div>
			<div class="box-content" style="min-height: 320px;">
				<div id="addPdialog" style="">
					<form class="form-horizontal" id="bookinfo"
						style="margin-left: -75px;">
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">公司名称</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="mohucompany"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">选择公司</label>
								<div class="col-md-8">
									<select class="form-control " name="companyId" id="companyId"></select>
									<i class="glyphicon glyphicon-remove alert-cha" id="cocha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">会员帐号</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="mohuuser"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">选择会员</label>
								<div class="col-md-8">
									<select class="form-control" name="userId" id="userPhone"></select>
									<i class="glyphicon glyphicon-remove alert-cha" id="uscha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">选择产品类型</label>
								<div class="col-md-8">
									<select class="form-control" name="productType" id="assetType"></select>
									<i class="glyphicon glyphicon-remove alert-cha" id="ascha"></i>
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">选择项目</label>
								<div class="col-md-8">
									<select class="form-control" name="projectId" id="projectId" onchange="screenProduct(this.value)">
									<c:forEach items="${projectList }" var="project" varStatus="index_val">
									<option class="proclass" value="${project.id }" projectId="${project.id }" data-name="${project.name }">${project.name }</option>
									</c:forEach>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="prcha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">结清状态</label>
								<div class="col-md-8">
									<select class="form-control" name="status" id="status">
										<i class="glyphicon glyphicon-remove alert-cha" id=""></i>
										<option value="0" data-name="未结清">未结清</option>
										<option value="1" data-name="已结清">已结清</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputPassword3" class="col-md-4 control-label">选择产品</label>
								<div class="col-md-8">
									<select class="form-control" name="productId" id="productId">
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="prcha"></i>
									
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">数量</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="bookCount"
										name="bookCount" placeholder="" maxlength=15<%-- onKeyPress="if (event.keyCode!=45  && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false"  --%>  >
									<i class="glyphicon glyphicon-remove alert-cha" id="bocha"></i>
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">金额</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="fee" name="fee"
										readonly="readonly" placeholder=""> <i
										class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">生效时间</label>
								<div class="col-md-8">
									<input type="text" class="form-control reDatetimepicker"
										id="effectTime" name="effectTime"> <i
										class="glyphicon glyphicon-remove alert-cha" id="efcha"></i>
								</div>
							</div>
							<div class="col-md-6">
								<label for="inputEmail3" class="col-md-4 control-label">失效时间</label>
								<div class="col-md-8">
									<input type="text" class="form-control reDatetimepicker"
										id="lapsedTime" name="lapsedTime"> <i
										class="glyphicon glyphicon-remove alert-cha" id="lacha"></i>
								</div>
							</div>
						</div>
						
					</form>

					<div class="input-group col-md-12 text-center">
						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="formcheck_sure">确定</a>
						</div>
						<div class="input-group col-md-1 colLee"
							style="display: inline-block;">
							<a class="btn btn-default" id="return_esc">取消</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script id="companyoption" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{companyId}}" data-name="{{companyName}}">{{companyName}}</option>
{{/each}}
</script>
<script id="useroption" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{userId}}" data-name="{{userPhone}}"> {{userName}}  {{userPhone}} </option>
{{/each}}
</script>
<script id="spaceId" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{value}}" data-name="{{name}}">{{name}}</option>
{{/each}}
</script>
<script id="product" type="text/x-handlebars-template">
{{#each this}}
	<option class="proclass" value="{{productId}}" projectId={{projectId}} data-value="{{unitPrice}}" data-name="{{productName}}">{{productName}}</option>
{{/each}}
</script>

<link href="css/walletItem.css" rel="stylesheet">
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/bookorder/bookorderfirst.js"></script>
