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
	<div class="box col-md-12 first_item">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""
				style="padding-top: 0; padding-bottom: 0; line-height: 35px;">新建商机--公司信息</div>
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
									<select class="form-control" id="industryone" name="industryone" onChange="InitIndustrytwo(this.options[this.options.selectedIndex].text)"></select>
									<i class="glyphicon glyphicon-remove alert-cha" id="cocha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">公司二级行业</label>
								<div class="col-md-6">
									<select class="form-control" id="industrytwo" name="industrytwo"></select>
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
									<option value="1">创业公司</option>
									<option value="2">A轮</option>
									<option value="3">B轮-上市前</option>
									<option value="4">上市公司</option>
									<option value="5">非上市公司</option>
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
									<input type="text" class="form-control input-md"
										id="search-text" class="companyName" autocomplete="off"
										placeholder="请输入并选择已有公司">
										<input type="hidden" id="companyId">
									<ul class="show-select" style="width: 194px; left: 13px">
									</ul>
								</div>
							</div>
							<div class="col-md-5">
								<label for="inputEmail3" class="col-md-4 control-label">联系人名称</label>
								<div class="col-md-8">
									<select class="form-control " name="show-contract" id="show-contract">
								</select>
								</div>
							</div>
							<!-- <div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label">联系人手机</label>
								<div class="col-md-8">
									<input type="text" class="form-control input-md"
										id="" class="" autocomplete="off"
										placeholder="">
								</div>
							</div> -->
						</div>
		<!-- 				<div class="form-group">
							<div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label">合同编号</label>
								<div class="col-md-8">
									<input type="text" class="form-control input-md" id=""
										class="" autocomplete="off" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label">订单编号</label>
								<div class="col-md-8">
									<input type="text" class="form-control input-md" id=""
										class="" autocomplete="off" placeholder="">
								</div>
							</div>
						</div> -->
					</form>

					<div class="input-group col-md-12 text-center">
						<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="secondStep">下一步</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="box col-md-12 second_item">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""
				style="padding-top: 0; padding-bottom: 0; line-height: 35px;">新建商机--意向信息</div>
			<div class="box-content" style="min-height: 350px;">
				<div id="addPdialog" style="">
					<form class="form-horizontal" id="bookinfo"
						style="margin-left: -15px;">
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">意向项目</label>
								<div class="col-md-8">
								<select class="form-control " name="project_ul" id="project_ul">
								</select>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">意向产品</label>
								<div class="col-md-6">
									<select class="form-control " name="product_ul" id="product_ul">
								</select>
								</div>
							</div>
							<div class="col-md-4">
								<label class="col-md-5 control-label">意向房间</label>
								<div class="col-md-6">
									<input id="intentionRoom"></input>
									<div class="box" id="select_box">
									 <input id="select2"/>
									<ul id="select_items" ></ul>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">预计起租日</label>
								<div class="col-md-8">
									<input type="text"
								class="form-control form_datetime" style="width: 100%;"
								readOnly="true" placeholder="选择起租日" id="startTime"
								value="${startTime}" />
										</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">预计截止日</label>
								<div class="col-md-6">
									<input type="text"
								class="form-control form_datetime" style="width: 100%;"
								readOnly="true" placeholder="选择截止日" id="endTime"
								value="${endTime}" />
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-5 control-label">意向工位数</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="intentionWork"	name="intentionWork" placeholder="" >
									<i class="glyphicon glyphicon-remove alert-cha" id="bocha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">客户预算</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="budget"	name="budget" placeholder="" maxlength=15>
									<i class="glyphicon glyphicon-remove alert-cha" id="bocha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">商机状态</label>
								<div class="col-md-6">
									<select class="form-control" name="oppStatus" id="oppStatus">
									<option value="1">来电</option>
									<option value="2">初次来访</option>
									<option value="3">发送报价单</option>
									<option value="4">复看</option>
									<option value="5">支付定金</option>
									<option value="6">签约</option>
									<option value="7">支付首付款（成功）</option>
									<option value="8">流失（商机失败）</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-5 control-label">成功率</label>
								<div class="col-md-6">
									<select class="form-control" name="successRate" id="successRate">
									<option value="1" data-id="5%">来电(5%)</option>
									<option value="2" data-id="10%">到访(10%)</option>
									<option value="3" data-id="5%">发送报价单(20%)</option>
									<option value="4" data-id="5%">复看(40%)</option>
									<option value="5" data-id="5%">支付定金(70%)</option>
									<option value="6" data-id="5%">签约(90%)</option>
									<option value="7" data-id="5%">成功(100%)</option>
									<option value="8" data-id="5%">失败(0%)</option>
									</select>
									<i class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
						</div>
						<div class="form-group">
						<div class="col-md-4">
								<label  class="col-md-4 control-label">渠道来源</label>
								<div class="col-md-8">
									<select class="form-control" name="source" id="source">
									<option value="1">中介</option>
									<option value="2">第三方团体</option>
									<option value="3">第三方个人</option>
									<option value="4">内部员工</option>
									<option value="5">老客户</option>
									<option value="6">400</option>
									<option value="7">广告</option>
									<option value="8">直客</option>
									</select>
										<i class="glyphicon glyphicon-remove alert-cha" id="fecha"></i>
								</div>
							</div>
						<div class="col-md-4">
								<label  class="col-md-4 control-label agentname">经纪人</label>
								<div class="col-md-8">
								<input type="text" class="form-control input-md"
										id="search-agent" class="agentName" autocomplete="off"
										placeholder="请输入手机号码">
										<input type="hidden" id="agentId">
									<ul class="agent" style="width: 194px; left: 13px">
									</ul>
								</div>
							</div>
							
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label class="col-md-6 control-label" style="color: #d81717;">
									<input type="checkbox"> 是否需要注册
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-2">
								<label class="col-md-6 control-label">备注</label>
								<div class="col-md-4">
								<textarea name="" style="width:200px;height:40px;"></textarea>
								</div>
							</div>
							<div class="col-md-6 fail" style="display: none">
								<label class="col-md-6 control-label">失败原因</label>
								<div class="col-md-4">
								<select class="form-control" name="failReason" id="failReason">
									<option>预算不足</option>
									<option>地理位置不佳</option>
									<option>商务配套服务不能满足</option>
									<option>周边配套欠缺</option>
									<option>产品不满意</option>
									<option>其他原因</option>
								</select>
								</div>
							</div>
							<div class="col-md-2 fail" style="display: none">
								<label class="col-md-8 control-label">失败备注</label>
								<div class="col-md-4">
								<textarea name="" style="width:200px;height:40px;"></textarea>
								</div>
							</div>
						</div>
					</form>
					<br>
					<div class="input-group col-md-12 text-center">
					<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="firstStep">上一步</a>
						</div>
						<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="thirdStep">下一步</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="box col-md-12 third_item">
		<div class="box-inner">
			<div class="box-header well" data-original-title=""
				style="padding-top: 0; padding-bottom: 0; line-height: 35px;">新建商机--生成商机</div>
			<div class="box-content" style="min-height: 350px;">
				<div id="addPdialog" style="">
					<form class="form-horizontal" id="bookinfo"
						style="margin-left: -15px;">
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">意向房源1</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="intentionRoom1" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">房间价格</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="roomPrice" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">客户预算</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="budget1" placeholder="">
								</div>
							</div>
						</div>
						<br>
						<div class="form-group">
						<div class="col-md-4">
								<label for="inputEmail3" class="col-md-4 control-label" style="color:#ff9800;">历史意向</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4">
								<label  class="col-md-4 control-label">意向日期</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="companyName" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">意向房源1</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="companyName" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<label  class="col-md-4 control-label">房间价格</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="companyName" placeholder="">
								</div>
							</div>
						</div>
						<div class="form-group">
						<div class="col-md-4">
								<label  class="col-md-4 control-label">客户预算</label>
								<div class="col-md-6">
									<input type="text" class="form-control" id="companyName" placeholder="">
								</div>
							</div>
						</div>
					</form>
					<br>	
					<div class="input-group col-md-12 text-center">
						<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="secondStep2">上一步</a>
						</div>
						<div class="input-group col-md-3 colLee"
							style="display: inline-block;">
							<a class="btn btn-primary" id="accomplish">生成商机</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script id="useroption" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{userId}}" data-name="{{userPhone}}"> {{userName}}        {{userPhone}} </option>
{{/each}}
</script>
<link href="css/walletItem.css" rel="stylesheet">
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/common_search.js"></script>
<script src="js/opportunity/add.js"></script>
<script src="js/opportunity/industry.js"></script>
<script src="js/opportunity/search_agent.js"></script>
<script src="js/jquery/jquery.js"></script>
<!--  <div><input id="select" class="form-control input-md"></input>
  <ul id="select_items" class="show-select">
  <input id="select1" class="form-control input-md">
    <li>
        <label><input type="checkbox" value="北京">北京</label>
    </li>
    <li>
        <label><input type="checkbox" value="北京">北京</label>
    </li>
    <li>
        <label><input type="checkbox" value="北京">北京</label>
    </li>
    <li>
        <label><input type="checkbox" value="北京">北京</label>
    </li>
    <li>
        <label><input type="checkbox" value="北京">北京</label>
    </li>
</ul></div>
-->
  <style>
     
        #select_items,li{list-style: none;padding:0px;margin:0 0 0 5px;}
        #select_items{min-height:100px;overflow-y:auto;max-height:100px;}
        #intentionRoom{
            width:150px;height:30px;border:1px solid #AABDE6;
        }
        #select2{
            width: 139px;
            height: 19px;
            border: 1px solid #AABDE6;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            margin-top: 5px;
        }
        #select_box{
            display:none;
            z-index:999;
            position: absolute;
            background: #f5f5f5;
        }
    </style>  