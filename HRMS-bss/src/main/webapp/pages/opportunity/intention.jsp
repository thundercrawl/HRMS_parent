<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">商机管理/新建商机</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""
				style="padding-top: 0; padding-bottom: 0; line-height: 35px;">新建商机</div>
			<div class="box-content" style="min-height: 350px;">
				<div id="addPdialog" style="">
					<form class="form-horizontal" id="bookinfo"
						style="margin-left: -15px;">
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label" style="color:#e51c23;">新建公司</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司名称</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="companyName" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司一级行业</label>
								<div class="col-md-6">
									<select class="form-control " name="industry_one" id="industry_one">
									<option>房产</option>
									<option>建筑</option>
									<option>汽车</option>
									<option>住宿餐饮</option>
									<option>时尚类</option>
									<option>教育培训</option>
									<option>医疗卫生</option>
									<option>文化体育娱乐</option>
									<option>金融</option>
									<option>IT互联网</option>
									<option>互联网</option>
									<option>制造业</option>
									<option>贸易</option>
									<option>交通物流</option>
									<option>商务服务</option>
									<option>公共管理和社会组织</option>
									<option>环境与公共设施</option>
									<option>国际组织</option>
									<option>科学研究和技术服务</option>
									<option>能源</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="cocha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司二级行业</label>
								<div class="col-md-6">
									<select class="form-control " name="industry_two" id="industry_two">
									<option>房地产开发</option>
									<option>房屋建筑</option>
									<option>汽车制造</option>
									<option>酒店宾馆</option>
									<option>婚庆</option>
									<option>院校类</option>
									<option>医疗机构</option>
									<option>影视媒体</option>
									<option>银行</option>
									<option>通讯</option>
									<option>电子商务</option>
									<option>冶金冶炼</option>
									<option>互联网交易平台</option>
									<option>仓储</option>
									<option>企业管理咨询</option>
									<option>党政机关</option>
									<option>环境保护</option>
									<option>领事馆</option>
									<option>高新技术</option>
									<option>石油化工</option>
									<option>农业</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="cocha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">

							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司规模</label>
								<div class="col-md-6">
									<select class="form-control" name="scale" id="scale">
									<option>4人以下</option>
									<option>4-8人</option>
									<option>8-20人</option>
									<option>20-100人</option>
									<option>100-500人</option>
									<option>500以上</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="uscha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司类型</label>
								<div class="col-md-6">
									<select class="form-control" name="companyType" id="companyType">
									<option>创业公司</option>
									<option>A轮</option>
									<option>B轮-上市前</option>
									<option>上市公司</option>
									<option>非上市公司</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="ascha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司资质</label>
								<div class="col-md-6">
									<select class="form-control" name="qualification" id="qualification">
									<option>国企</option>
									<option>民企</option>
									<option>外企（欧美）</option>
									<option>外企（日韩）</option>
									<option>外企（其他）</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="prcha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">联系人姓名</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactsName"	name="contactsName" placeholder="" maxlength=15>
									<i class="glyphicon glyphicon-remove alert-cha" id="bocha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">联系人电话</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactsPhone" name="contactsPhone" placeholder=""> 
									<i class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">联系人邮箱</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactsEmail" name="contactsEmail" placeholder=""> 
										<i class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
						<div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label" style="color:#ff9800;">已有公司</label>
							</div>
						</div>
						<div class="form-group">
						<div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label">已有公司</label>
								<div class="col-md-8">
									<input type="text" class="form-control input-md" id="search-text" class="companyName"
								autocomplete="off" placeholder="请输入公司名称">
							<ul class="show-select" style="width:184px;left:73px">
							</ul>
								</div>
							</div>
						</div>
					</form>

					<div class="input-group col-md-12 text-center">
						<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="formcheck_sure">下一步</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<link href="css/walletItem.css" rel="stylesheet">
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/common_search.js"></script>
