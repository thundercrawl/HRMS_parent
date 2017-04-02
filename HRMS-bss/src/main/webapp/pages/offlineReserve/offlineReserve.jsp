<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<head lang="zh">
<title>线下预订</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/offlineReserve.css">
<link rel="stylesheet" href="css/contract/style.css">
<link rel="stylesheet" href="fonts/iconfont.css">
<link rel="stylesheet" href="css/contract/color.css">
<script src="js/jquery/jquery.min.js"></script>
<script src="plugin/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="js/offlineReserve/offlineReserve.js"></script>
<!-- <script src="js/offlineReserve/jquery-1.4.4.min.js"></script> -->
<script src="js/offlineReserve/jquery.jqprint-0.3.js"></script>
<script src="js/jquery/jquery.datetimepicker.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.0.js"></script>
<script src="js/main.js"></script>
</head>
<body>
	<input type="hidden" id="contractId" value=${contractId }>
	<div class="pay-header clearfix">
		<div class="mod current-step">
			<div class="pay-step claearfix">
				<div class="pay-content">
					<span class="step">1.</span><span class="step-con">查询座位</span>
				</div>
				<div class="angle"></div>
			</div>
			<div class="pay-line"></div>
		</div>
		<div class="mod">
			<div class="pay-step claearfix">
				<div class="pay-content">
					<span class="step">2.</span><span class="step-con">分配订单</span>
				</div>
				<div class="angle"></div>
			</div>
			<div class="pay-line"></div>
		</div>
		<div class="mod">
			<div class="pay-step claearfix">
				<div class="pay-content">
					<span class="step">3.</span><span class="step-con">赠品与折扣</span>
				</div>
				<div class="angle"></div>
			</div>
			<div class="pay-line"></div>
		</div>
		<div class="mod mod-4 claearfix">
			<div class="pay-step">
				<div class="pay-content">
					<span class="step">4.</span><span class="step-con">生成合同</span>
				</div>
			</div>
		</div>
	</div>

	<div class="pay-con clearfix">
		<div class="con-left">
			<div class="con-left-con clearfix">
				<div class="con-left-top">
					<div class="row">
						<form class="form-horizontal col-sm-12" onsubmit="return false">
							<div class="form-group col-sm-6">
								<label for="inputEmail3" class="col-sm-4 control-label">办公位置</label>
								<div class="col-sm-8">
									<select id="projectSelected" class="form-control"
										onchange="getCurrentProjectSpactType(this.value)">
										<c:if test="${!(empty projectList)}">
											<c:forEach items="${projectList}" var="project">
												<option value="${project.id}"
													projectNameData="${project.name}">${project.name}</option>
											</c:forEach>
										</c:if>
									</select>
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="inputEmail3" class="col-sm-4 control-label">空间选择</label>
								<div class="col-sm-8">
									<select id="spaceSelected" class="form-control"
										onchange="selectCurrentSpace(this.value)">
										<c:if test="${!(empty spaceList)}">
											<c:forEach items="${spaceList}" var="ofcSpaceType">
												<option value="${ofcSpaceType.spaceId}">${ofcSpaceType.spaceName}</option>
											</c:forEach>
										</c:if>
									</select>
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="inputEmail3" class="col-sm-4 control-label">房号选择</label>
								<div class="col-sm-8">
									<input type="text" id="inputAssetId" class="form-control">
								</div>
							</div>
						</form>
						<form class="form-horizontal col-sm-12">
							<div class="form-group col-sm-12" id="meetingRoomDate"
								style="display: none;">
								<label for="inputEmail3" class="col-sm-2 control-label">起始日期</label>
								<div class="col-sm-10">
									<div class="col-sm-4 no-pd-letf">
										<input type="text" id="datetimepicker4" class="w1p4" readonly />
									</div>
									<div class="col-sm-4">
										<input type="text" id="datetimepicker5" class="w1p4" readonly />
									</div>
									<div class="col-sm-4">
										<input type="text" id="datetimepicker6" class="w1p4" readonly />
									</div>
								</div>
							</div>
							<div class="form-group col-sm-12" id="elasticStationRoomDate"
								style="display: none;">
								<label for="inputEmail3" class="col-sm-2 control-label">起始日期</label>
								<div class="col-sm-10">
									<div class="col-sm-6 no-pd-letf">
										<input type="text" id="datetimepicker2" class="w1p4" readonly />
									</div>
									<div class="col-sm-6">
										<input type="text" id="datetimepicker3" class="w1p4" readonly />
									</div>
								</div>
							</div>
							<div class="form-group col-sm-12" id="officeRoomDate">
								<label for="inputEmail3" class="col-sm-2 control-label">起始日期</label>
								<div class="col-sm-10">
									<div class="col-sm-4 no-pd-letf">
										<input type="text" id="start-date" class="w1p4" readonly />
									</div>
									<div class="col-sm-4 po-relative">
										<input type="text" id="date-div" class="w1p4" readonly />
										<div class="data-month">
											<ul class="clearfix">
												<!-- <li class="li-show">1个月</li>
												<li class="li-show">2个月</li> -->
												<!-- 用来控制是否显示一二两个月 -->
												<li>1个月</li>
												<li>2个月</li>
												<li>3个月</li>
												<li>4个月</li>
												<li>5个月</li>
												<li>6个月</li>
												<li>7个月</li>
												<li>8个月</li>
												<li>9个月</li>
												<li>10个月</li>
												<li>11个月</li>
												<li>12个月</li>
												<li>13个月</li>
												<li>14个月</li>
												<li>15个月</li>
												<li>16个月</li>
												<li>17个月</li>
												<li>18个月</li>
											</ul>
											<div class="data-angle"></div>
										</div>
									</div>
									<div class="col-sm-4">
										<input type="text" id="endDate" class="w1p4" readonly />
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="col-sm-12 text-center">
						<div class="btn btn-info" id="projectSelect">查询</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="con-left-bottom">
					<p>查询结果</p>
					<table class="table" id="my-table">
						<thead>
							<tr>
								<th>项目名称</th>
								<th>产品名称</th>
								<th>空间类型</th>
								<th>容量</th>
								<th>价格</th>
								<th>剩余数量</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="productInfoBody">
						</tbody>
					</table>
				</div>
			</div>
			<div class="con-right" id="page1con-right">
				<div class="wrap con-right-first">
					您已选择的座位 :
					<div class="right-seat hidden" id="right-seat">
						<span class="title"></span>
						<p class="pp"></p>
						<ul class="item-list clearfix">
						</ul>
						<div class="server">
							请选择配套服务 <select id="serverSelect" class="form-control input-md"
								onchange="packageOptionClick(this)">
								<option value="">优惠2</option>
								<option value="">优惠3</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-sm-12  expense" id="priceExpense">
					<!-- 	<p id="priceExpense_p_0"></p>
				<p></p>
				<p></p>
				<span></span>
				<br>
				<span></span>
				<br>
				<span></span> -->
				</div>
				<button id="nextBtn1" class="next-btn btn btn-info"
					onclick="skipStep(this,1)" disabled>下一步</button>
			</div>
		</div>
	</div>

	<div class="pay-con clearfix hidden">
		<div class="border-content clearfix">
			<div class="order-left">
				<p class="choose-project">你已选择的项目：</p>
				<div id="projectsDiv"></div>
				<div id="fenpaiDiv"></div>
				<!-- <div class="projects">苏河项目一</div>
				<div>
						<div class="z-tr-d">
							<div class="z-round z-p-r"></div>
							<div class="z-line z-p-l"></div>
							<div class="tl"><b>开放式工位A类</b><p>201号，201号</p><span class="yhfw">XXXXXXXXXX服务</span></div>
						</div>
						<div class="z-tr-d">
							<div class="z-round z-p-r"></div>
							<div class="z-line z-p-l"></div>
							<div class="tl"><b>开放式工位B类</b><p>201号，201号，201号，201号，201号，201号，201号，201号,201号，201号，201号，201号，201号，201号，201号，201号</p><span class="yhfw">XXXXXXXXXX服务</span></div>
						</div>
				</div> -->
				<!-- <button id="allotButton" type="button" class="btn btn-info" disabled>分配</button> -->
			</div>
			<div class="pd3">
				<div class="order-right clearfix">
					<p class="choose-user">选择已注册用户</p>
					<p class="no-register">用户未注册 >></p>
					<form class="form-horizontal clearfix" onsubmit="return false">
						<div class="col-sm-10">
							<input type="text" class="form-control input-md" id="phoneSearch"
								placeholder="输入会员电话号码进行查找">
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-warning btn-search"
								id="searchUser">搜索</button>
						</div>
					</form>


					<div class="col-sm-12 padding-top search-table">
						<table class="table search-result">
							<colgroup>
								<col>
								<col>
								<col width="140">
								<col wdth="240">
								<col wdth="90">
							</colgroup>
						</table>
					</div>
					<div class="pbo">
						<div class="col-sm-10 padding-top">
							<button type="button" class="btn btn-default"
								onclick="skipStep(this,0)">上一步</button>
						</div>
						<div class="col-sm-2 padding-top">
							<button type="button" class="btn btn-default"
								onclick="skipStep(this,2)" disabled>下一步</button>
						</div>
					</div>
				</div>
			</div>
			<div class="order-rights">
				<p class="choose-user">用户注册</p>
				<button type="button" class="btn register current-register"
					id="userRegist">个人注册</button>
				<div class="circle-content">
					<form class="form-horizontal col-sm-6 col-sm-offset-3">
						<div class="form-group" style="margin-bottom: 25px;">
							<span id="phoneError" class="warning">${msg }</span> <label
								for="inputPassword" class="col-sm-4 control-label">手机号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="phone"
									placeholder="">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 25px;">
							<span id="userpassError" class="warning">${msg }</span> <label
								for="inputPassword" class="col-sm-4 control-label">登录密码</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="userpass"
									placeholder="">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 25px;">
							<span id="userpassErrorTwo" class="warning">${msg }</span> <label
								for="inputPassword" class="col-sm-4 control-label">确认密码</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="userpassTwo"
									placeholder="">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 25px;">
							<span id="usernameError" class="warning">${msg }</span> <label
								for="inputPassword" class="col-sm-4 control-label">用户姓名</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="username"
									placeholder="">
							</div>
						</div>
						<!-- <div class="form-group">
							<label for="inputPassword" class="col-sm-4 control-label">xxxx</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
							</div>
						</div> -->
					</form>
					<div class="col-sm-12">
						<button type="button" class="btn btn-warning marbtn"
							id="register-sure" style="margin-right: 25px;">确定</button>
						<button type="button" class="btn btn-warning" id="register-exit">取消</button>
					</div>
				</div>

				<div class="col-sm-10 padding-top">
					<button type="button" class="btn btn-default"
						onclick="skipStep(this,0)">上一步</button>
				</div>
				<div class="col-sm-2 padding-top">
					<button type="button" class="btn btn-default pageToButton"
						onclick="skipStep(this,2)">下一步</button>
				</div>
			</div>
		</div>
	</div>

	<div class="pay-con hidden">
		<div class="con-left">
			<div class="con-left-con">
				<div class="content-padding">
					<p class="choose-user">
						选择赠品<span class="no-select">可跳过</span>
					</p>
					<!-- <div class="server grey-server">
						智慧包B服务
						<select class="form-control input-md">
							<option value="">优惠1</option>
							<option value="">优惠2</option>
							<option value="">优惠3</option>
						</select>
					</div>
					<div class="server grey-server">
						智慧包C服务
						<select class="form-control input-md">
							<option value="">优惠1</option>
							<option value="">优惠2</option>
							<option value="">优惠3</option>
						</select>
					</div> -->
				</div>
			</div>
			<div class="con-right">
				<div class="wrap">
					<div class="col-sm-12">
						<form class="form-horizontal">
							<p>
								折扣码<span class="no-select">可跳过</span>
							</p>
							<div class="form-group padding-top">
								<div class="col-sm-9">
									<input type="text" class="form-control"
										id="inputDiscountNumber" placeholder="折扣码">
								</div>
								<div class="col-sm-3 text-right ">
									<button type="button" class="btn btn-info" id="saveFavourCode">确定</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="col-sm-12  expense" id="rebatePageExpense"></div>
				<div class="col-sm-12 padding-20">
					<div class="col-sm-8">
						<button type="button" class="btn btn-default"
							onclick="skipStep(this,1)">上一步</button>
					</div>
					<div class="col-sm-1">
						<button type="button" class="btn btn-default"
							onclick="skipStep(this,3)">下一步</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="pay-con hidden">
		<div class="con-left">
			<div class="con-left-con">
				<div class="con-left-bottom finaly-b">
					<p>订单生成</p>
					<table class="table" id="my-table">
						<thead>
							<tr>
								<th>项目名称</th>
								<th>产品名称</th>
								<th>空间类型</th>
								<th>房间号</th>
								<th>单价</th>
								<th class="mkwidth">租用时间</th>
								<th>租金</th>
							</tr>
						</thead>
						<tbody id="orderBodyId">

						</tbody>
					</table>
				</div>
			</div>
			<div class="con-right finaly-r" id="orderPageTotal">
				<p>
					订单编号：<span></span>
				</p>
				<p>
					生成时间：<span></span>
				</p>
				<p>
					优惠码：<span></span>
				</p>
				<p class="font-yell">总金额</p>
				<input type="hidden" id="orderTotal">
				<div id="oederPageInfo"></div>
				<div class="server">
					请选择分期次数 <select id="selectStages" class="form-control input-md"
						onchange="selectStages()">
						<option value="5">全款</option>
						<option value="1">月付</option>
						<option value="6">双月付</option>
						<option value="2">季付</option>
						<option value="3">半年付</option>
					</select>
				</div>
				<div id="stagesData">
					<p></p>
					<p></p>
					<p></p>
				</div>
				<div class="finaly-btn">
					<div class="btn create-b" id="createBook">生成意向书</div>
				</div>
				<div class="finaly-btn">
					<div class="btn create-c" id="createContract">生成合同</div>
				</div>
				<div class="col-sm-12 padding-20">
					<div class="col-sm-8">
						<button type="button" class="btn btn-default previousStep"
							onclick="skipStep(this,2)">上一步</button>
					</div>
				</div>
			</div>
		</div>
		<div class="send-alert send-alert2 hidden">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label class="col-md-4 control-label">截止时间</label>
					<div class="col-md-8">
						<!-- <input type="text" class="form-control" id="deadline"
							placeholder="2016年12月12日"> -->
						<input type="text" id="deadline" class="form-control" readonly />
					</div>
				</div>
			</form>
			<div class="well textleft">该日期为房源的保留截止日期，截止日期不可对房源再次下单，
				如截止日期前未支付，则释放房源（原则上为2天）</div>
			<div class="alert-close">X</div>
			<button type="submit" class="btn btn-default"
				onclick="skipStep(this,4)">确定</button>
		</div>
	</div>
	<div class="send-alert sure-agreement" style="display: none;">
		<p>是否生成合同</p>
		<button class="btn create-c" onclick="createContract()">确定</button>
		<button class="btn create-c" onclick="hideAgreement()">取消</button>
	</div>
	<div class="send-alertContract promptBox" style="display: none;">
		<p>是否生成合同</p>
		<div class="alert-close">X</div>
		<!-- <button class="btn create-c"  onclick="createContract()">确定</button>
		<button class="btn create-c" onclick="hideAgreement()">取消</button> -->
	</div>
	<!-- 合同预览 -->
	<div class="pay-con clearfix hidden">
		<div class="z-tr-d pd15">
			<div class="pact-left">
				<div class="row" id="bookPage">
					<div class="rent-box tab1" style="width: 100%; height: auto;">
						<div class="rent-wrap rent-Chinese">
							<div class="rent-contract" id="contractHead"
								style="box-sizing: border-box; width: 100%; max-width: 1100px; height: auto; padding-top: 40px; padding-left: 50px; padding-right: 50px; padding-bottom: 1px; background-color: #fff; box-shadow: 1px2px4pxrgba(0, 0, 0, .3);">
								<h1
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 40px; font-size: 25px; text-align: center; line-height: 50px; font-weight: bold;"
									id="contractTitle">租赁合同(线下)</h1>
								<div class="rent-con font-bold"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px; font-size: 0;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">供应方(甲方)</span>上海办伴科技发展有限公司
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">承租方(乙方)</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">合同编号</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">租赁周期</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">合同签订日期</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 120px; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">付款周期</span>
									</p>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">甲方</h4>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">联系人</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">电话</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">职位</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;"></span>
									</p>
									<p class="rent-w"
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 90%;">
										<span
											style="box-sizing: border-box; width: 70px; font-weight: bold; font-size: 15px; margin-right: 10px;">账单地址</span>
									</p>
								</div>


								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">乙方</h4>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">联系人</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">电话</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">职位</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 24px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 60px; font-weight: bold; font-size: 15px; margin-right: 10px;">邮箱</span>
									</p>
									<p class="rent-w"
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 90%;">
										<span
											style="box-sizing: border-box; width: 70px; font-weight: bold; font-size: 15px; margin-right: 10px;">账单地址</span>
									</p>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">租赁产品</h4>
									<table class="rentbox" id="contractProducts"
										style="box-sizing: border-box; width: 100%; height: auto; border-collapse: collapse; text-align: center;">
										<tbody>

											<tr>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">项目</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">产品名称</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">单价</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">数量</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">租赁周期</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">租金</th>
											</tr>
											<tr>
												<td rowspan="6" valign="top"
													style="box-sizing: border-box; line-height: 30px; vertical-align: middle;"></td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">首付款</h4>
									<div class="rent-f"
										style="box-sizing: border-box; padding: 10px; background-color: #E6E6E6;">
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											月租金<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											智慧包租金<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											安装费<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											押金<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											减免<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											合计<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00元</span>
										</p>
									</div>
								</div>

								<div class="rent-con rent-p"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">合同条款</h4>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">1、本合同</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.1</span>
										本合同本着公开、公平、公正的原则由双方协商签订，供应方为商业办公场地提供者和控制者，
										客户同意其不因此合同享有任何与办公场所相关的租赁利益、租赁持有地产权或其他房地产权利。供应方出于为客户提供服务的目的，根据本合同以及补充的入驻守则同意客户与供应方共同使用中心。此合同只对客户发生效力，客户在未经过供应方的事先同意，不得转让给任何第三方。供应方将不会无理拒绝客户将协议转让给母公司，附属公司或客户的关联公司来执行许可协议并将会要求受让人承担所有的客户义务，但并不会解除客户的协议（客户须提供文件证明其关联关系）。该合同是由第一页的入住描述、本条款及条件、入驻守则及服务价格指南（如适用）组成的。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.2</span>
										遵守入驻守则：客户应当遵守供应方为中心使用者制定的入驻守则。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.3</span>
										自动续约：
										此份合同在约定的期限内有效，之后将被自动按原合同等长的期限延长但不少于三个月，（除非法律续约限定应用）直到被客户或者服务提供商终止。请参照1.4条款。所有期限都于到期月份的最后一日到期。延长期的租金应当视当时市场通常价格确定。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.4</span>
										取消：供应方或客户可于合同到期日、延长期限到期日或续租期到期日终止本合同，但需提前3个月以书面方式通知对方。但是，如果合同期限、延长期或续租期等于或少于3个月，且供应方或者客户希望提前终止合同，则该项终止通知应提前2个月做出，或者如果合同期限、延长期或续租期不足2个月（或少于2个月），比该相应期限少一周的时间之前做出。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.5</span>
										即时终止：在法律允许的最大范围内，在下列任何一种情况下，供应方有权书面通知客户立即解除本合同，没收保证金，且无需遵守任何其它程序：
										(a) 如果客户失去偿债能力、破产、进入清算或者无力清偿到期债务；或者 (b)
										客户违反合同义务并无法改正，或者客户自收到供应方要求改正的通知14日内没有改正；或者(c)
										客户或经客户允许或邀请进入中心的人员的行为不符合对办公室的通常使用。如果供应方根据以上任何原因终止本协议，客户应履行的义务并不同时终止，包括支付已接受的附加服务费用以及合同剩余期间的每月租金。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.6</span>
										合同终止，客户应迅速将工作场所清空，并将场所恢复至入驻时的情形。当客户搬离或选择更换至中心内的另一间办公室时，供应方将收取办公室清理费用以支付恢复办公室原貌所需的日常检查和清洁费用。退租费用在各国有所不同并在入驻守则中列示。供应方保留向客户收取额外且合理的修理费用的权利，该费用用于修缮任何非正常的磨损。如果客户将任何物品或私人财产遗留在供应方中心，供应方可以任意处置这些物品，处置物品所需费用由客户负担，供应方不因此对客户负有任何责任，且客户无权主张处置该物品的收益。此条款同样适用于“即时终止”。在客户搬离工作场所后，如供应方被客户要求继续为客户提供接收信件、传真，接听电话和接待访客并妥善转移的服务。为此，供应方将一次性收取业务保留服务费。此服务由本合同截止日起保留3个月。若于客户使用办公室期间并无使用电话，无邮件，传真或访客，则此项服务不适用。此项费用已于入驻守册内说明。如果客户在合同终止后继续使用该工作场所，则客户应为因其未能按时清空办公场所而导致供应方负担的任何损失、主张或责任负责。供应方可选择同意客户延长租期，但客户应支付相应租金、赔偿损失。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.7</span>
										如果中心不再可供使用：如果供应方无法继续为客户提供本协议约定的服务及工作场所，则本协议终止，客户只需支付终止日之前的每月租金以及客户已使用的附加服务费用。供应方应尽力在另一供应方中心为客户找到合适的替换工作场所，供应方将会为妥善安排客户之办公场地进行相关的协商，由双方协商解决是否延续此合同，此条不适用于不可抗力情况。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.8</span>
										通知：所有客户方给供应方提供的正式通知均应以书面形式送达上述联系地址。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.9</span>
										员工：在本合同有效期内及期满后6个月内，供应方及客户均不得故意邀请或雇佣任何对方雇佣的在中心工作的员工。此义务适用于任何被雇佣在中心工作的员工直至劳动关系终止后3个月。双方约定，违约方应支付非违约方相当于相关员工1年工资的违约金。此条款并不限制任何一方雇佣通过公开发布广告而应聘的善意且独立的个人。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.10</span>
										禁止客户代表供应方员工：在本合同有效期内，客户同意，客户和其合伙人、成员、管理人员及员工不得代表供应方的现任或前任员工参与任何针对供应方或供应方的关联企业、成员、管理人员及员工的争端或法律程序或以其他方式提供法律顾问。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.11</span>
										适用的法律：此份合同在相关中心所在地法律的约束。对于所有争议的诉讼将在中心所在地的省、市或者国家内解决。供应方及其客户均接受具有专属管辖权的法院的专属管辖。如果这些条款和条件的任何规定依适用法律被认定为无效或不可执行，其他规定仍然有效。
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">1.12</span>
										保密：此合同的条款均需保密。除非法律或政府机关要求供应方或客户披露这些条款，否则供应方或客户均不能在未得到对方许可的情况下披露本合同。合同终止后双方仍需负担保密义务。合同的执行：客户必须支付任何合理和适当的费用包括服务提供商为强制执行合同所付出的的法律费用，不包括服务提供商和客户在需要仲裁调解时所需要各自承担的仲裁调解费。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">2.
										服务与义务</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">2.1</span>
										办公场所：供应方应当提供客户根据本合同同意付费的附带服务的办公场所数量。本合同列明了供应方最初为客户分配的办公场所。客户对分配的办公场所将不享有专一权利。在特定条件下，供应方可能需要重新分配办公场所，但重新分配的场所应与原场所面积基本相同，且供应方会事先将这种变动通知客户。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">2.2</span>
										办公室服务：供应方将根据客户的要求在正常运营时间，提供服务描述中所列的服务 (可根据要求提供服务价目表)
										。如果供应方认为客户的一项特殊要求产生过多的工作量，将有权利收取额外的费用。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">2.3</span>
										供应方网：供应方不对客户之网络（或互联网）的安全以及客户发布其上的任何信息作出陈述或承诺。客户应当采取任何其认为符合其需求的安全措施（例如加密）。供应方不对客户之可获得的供应方网络（或互联网）的程度与优劣作任何承诺。客户只能在供应方造成过失并在其收到书面通知后的一段合理时间内，要求唯一的赔偿。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">3.
										提供服务</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">3.1</span>
										进入办公场所：供应方可能需要进入客户的办公场所且可以在任意时间进入。但是，除非情况紧急或客户已向供应方发出终止合同的通知，供应方在因检测、修缮或其它非日常巡查、清洁和维护工作需要进入客户办公场所时，应尝试通过口头或电讯手段提前通知客户。供应方也将致力于遵守合理的安全程序以保护客户的商业秘密。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">3.2</span>
										本合同起始时场所的可用性：如果在本合同起始日时，供应方因合同约定外的原因无法提供本合同约定的办公场所，供应方对客户的任何损失或损害不承担责任，但客户可以解除本合同并无需支付违约金。供应方不会在办公场所可供使用之前向客户收取每月办公室租金。供应方可能延迟合同的起始日期，它将提供给客户另一个和在此份服务合同中注明办公场所至少面积相当的办公室。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">4.
										使用</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">4.1</span>
										客户只得将办公场所用于办公用途，保证任何成员不会违反办伴科技任门店之入驻守则，不会对供应方或者关联第三方人身/财产造成干扰、损坏和危险的行为，不会向供应方提供虚假信息、不会将办公区也用于接纳大量访客的用途（包括但不限于理财、教育、零售、保险、医疗等用途），
										不会复制办公区域的钥匙，门禁和任何可用于进入办公区域的物品，任何因客户成员或关联访客违反法律规定或者本合同条款而对供应方及任何第三方产生的损害进行赔偿。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">4.2</span>
										客户不得从事与供应方提供的出租服务式办公场地或其附属服务相竞争的业务活动
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">4.3</span>
										客户的名称及地址：客户应仅以自己的名称或其它供应方事先同意的名称经营。
									</p>


									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">4.4</span>
										中心地址的使用：客户可以将中心的地址用作其营业地址。任何其它使用均应获得供应方的事前同意。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">4.5</span>
										客户未经供应方书面许可，不得将本合同项下的任何权利或者义务转让，供应方有权在提前6个月通知客户的情况下，将本合同下的权利和义务终止或者转让给我司的任何关联方或者任何第三方。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">5.
										办公场所</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">5.1</span>
										客户不能改变其办公场所内任何部分财产，并且必须很好保护中心所有财产，包括您使用的设备，装置和家具。客户应为由客户或者其他经客户明示或暗示的邀请或允许而进入中心的人（包括但不限于全体员工、承包商、代理商或其他出现在该场所的人）所造成的任何损害负责。
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">5.2</span>
										办公设备：未经供应方同意，客户不得安装电缆电线，信息技术设备或电信设备，供应方有权拒绝该等安装。在供应方同意安装的情况下，客户应当允许供应方监督安装(例如，信息技术设备或电力系统)以确定此种安装不会影响其他客户或供应方或建筑物所有权人对场所的使用。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">5.3</span>
										保险：客户为其带入中心的财产以及其对其员工或其他第三方的责任购买保险是客户的职责。 供应方强烈建议客户购买相关保险。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">6.
										供应方的责任</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">6.1</span>
										供应方的责任范围：在适用法律允许的最大范围内，供应方不对客户与本合同、所接受服务或工作场所相关的任何损失或损害负责，除非此种损失或损害是由于供应方的故意或严重过失所导致的。供应方不因由于机械故障、罢工、供应方丧失对包含中心在内的建筑物权益等原因导致供应方无法提供服务而给客户造成的损害负责，除非供应方出于故意或过失。在任何情况下，客户应当以书面方式通知供应方并给供应方合理时间改正，否则供应方不为客户的任何损失或损害承担责任。如果因供应方的责任无法提供合同约定的服务，在遵守以下限制的前提下，供应方将支付客户用于寻找替代服务的实际且合理的支出。如果客户认为供应方未能提供与本合同约定一致的服务，则客户应以书面形式通知供应方并给予供应方合理期限改正。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">6.2</span>
										排除间接损失：除非供应方书面同意，否则供应方在任何情况下均不对经营损失、利润损失、预期节约的损失、数据损毁或损失、第三方主张或其它间接损失负责。供应方强烈建议客户为所有此种潜在损失、损害或责任购买保险。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">6.3</span>
										供应方所承担责任的金额数额限制：任何情况下供应方对客户承担的责任应受到下列限制： ?
										对人身伤害或死亡的赔偿按实际过错责任承担，但最高上限不超过人民币100万元。[风险提示：若根据法律强制性规定赔偿数额的计算超过该约定限额的，则导致该约定无效。]
										?
										因某一事件或系列相关事件造成的客户个人财产损失赔偿上限为客户方支付的所有费用的总和，我司不对任何间接损失或者预期的损失承担责任
										?
										其它损失或损害的赔偿原则上为客户的实际损失，但上限不超过自客户搬进办公场所之日起至其有争议的索赔要求发生之日期间客户支付的全部费用的125%。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span>6.4 </span> 客户方应就任何由客户方及访客违反本合同而对我司及任何第三方产生的损害进行赔偿。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">7.
										费用</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.1</span>税费：客户同意及时支付：（1）应当向政府机关缴纳的全部销售、使用、执行,
										消费或其它税款以及许可费用（并且，根据供应方的要求，向供应方提供相关款项的缴纳收据），以及（2）供应方向政府缴纳的关于办公场所的税款，包括但不限于，总收入税、租赁税费、个人有形资产税、印花税或其它文件印花税费。此规定适用于中华人民共和国税法。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.2
										</span>
										服务保证金／订金：除非已在本协议正面规定了其他金额，否则客户需要在签订本协议时支付相当于两个月办公室月费的服务订金／保证金,并于5个工作日内补齐合同之首付款和保证金（外加增值税／税费（若适用）。[该条的服务定金与7.5预留办公室如何更好衔接？请确认。]该服务保证金由供应方负责保管，但不支付任何利息。该服务保证金用于保证客户履行其在本合同项下的义务。该服务订金／押金或扣除应付费用、业务延续服务费和办公室恢复服务费以及其他供应方应收款项之后的余额将会在客户书面要求返还服务订金／押金且结算完毕后返还给客户。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.3</span>
										如果应支付费用超过供应方所持有的服务保证金，或客户经常不按时向供应方支付到期费用，则 供应方有权要求客户支付额外的保证金。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.4</span>
										客户应当在入驻时按入驻人数支付网络电话设置费。费用总额由入驻守则约定（该由入驻守则可在任何时候索要）。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.5</span>
										支付：供应方始终致力于减少环境负担并鼓励客户参与环保。因此，供应方将会开具并发送电子账单（当地法律允许的情况下）。除大客户可协商确定其他支付方式外，其他客户都将通过直接借记或信用支付等方式自动完成支付（当地银行系统许可的情况下）。客户在签订此合约时，供应方已经确认预留所需办公室。若未能提前30天书面通知供应方取消预订，则需支付三个月租金作为预订保留取消金[建议预定时即支付（相当于3个月租金）定金，否则该条款约定义务无法实际履行。]。本协议下所有客户应付的金额可分配至供应商集团的其它成员。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.6</span>
										滞纳金：如果客户未能按时支付到期费用，则将被收取一定数额的滞纳金。滞纳金的具体金额为每逾期一日所收取的滞纳金为所欠款项的的仟分之三，如果客户认为应付金额有争议，则客户应当按时支付没有争议的部分，否则应支付相应滞纳金。如果客户未能按时交纳应支付的费用和/或利息，或客户违约，则供应方有权决定暂停服务（为了避免疑问，包括拒绝客户进入办公场所）。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.7
										</span> 余额不足：如果因余额不足导致支票被拒付或者其它支付请求被拒绝，客户应当为此支付费用。这笔费用的具体金额请参见入驻守则。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.8
										</span>
										自本合同签订之日起每满一年，除非合同已约定，供应方将以一定比例提高月租金，增长率根据全部项目零售价值指数，或其它供应方提供的可替换的类似价值指数的增长率确定；假设上述增长为相关法律所禁止，则月租金涨幅由入驻守则确定。本条规定只适用于合同生效期和失效期间隔至少12个月的情况。续签合同将根据上述1.3条“期限”的规定进行续约，租金提升将适用于那些合同的生效期和失效期间隔至少12个月的情况。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.9
										</span>
										标准服务：每月办公室租金、以及客户要求提供的其它经常性服务，应当提前一个月全额付清。除非另行书面约定，否则供应方提供的该等固定的经常性服务按本合同（包括任何更新）期限内的特定费率收费。具体到期付款日在各中心有所不同并在入驻守则中列示。如果按日收费，则该月的收费应以日租金乘以30计算。时间不足1个月的租金应当按日计算。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.10</span>
										即付即用以及其它可选服务：对于即付即用的费用和相关税费（按照供应方公布费率，该费率可能不时变动），供应方将于费用发生后发出账单，客户应于相应附加服务提供所在日历月之后的一个月内支付。具体的
										付款日期请参见入驻守则。

									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.11</span>
										折扣，促销和优惠：对于享受折扣、促销和优惠的客户，
										若违反了合约条款或发生两次以上逾期付款的行为，供应方有权终止已给予的各项优惠而不作另行通知。结算时，乙方应将已享受的相应优惠，按正常价格支付。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">7.12</span>
										访客费用，“访客“系指经客户的许可进入供应方指定区域的人，访客经供应方登记后可在指定区域停留不超过2小时，如在指定区域逗留时间超过2小时，客户应为此支付费用（下称访客费用），收费标准参见办伴网站和入驻守则，而该等收费标准可有供应方不时调整。
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">8.
										合规</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">8.1</span>
										遵守法律：客户应当在商业运行当中遵守相关法律和法规。客户不得从事任何与使用商务中心相关的违法行为。客户不得从事任何可能影响供应方或其他人使用中心的行为，不得引起任何侵扰或妨碍，增加供应方所需负担的保险费用，或给客户使用的中心所在的建筑物的任何权利人或给供应方造成损失或损害
										(包括对名誉的损害)。客户承认（1）前述条款是供应方签署本合同的基础；以及（2）客户任何违反前述条款的行为都将造成实质违约，供应方有权据此终止本合同，无需进一步通知或遵守其他程序。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">8.2</span>
										客户已了解并接受其个人资料将被登记于供应方集团网络，以供供应方使用于以服务为目的的商业用途。
									</p>

									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">9.客户帐号使用安全</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">9.1
										</span>
										“客户“系指供应方同意的可以使用办公区域的人（为避免疑问，任何客户的任何行为都应被视为客户的行为）。客户应通过www.distrii.com.com（下称“办伴网站”）提交成员的名单和身份证件信息，而每一成员均应于在办伴门店办理入驻手续时向我司提供身份证原件及复印件。客户如果希望变更成员名单，应事先通过办伴网站提交变更申请，只有当客户成功提交上述变更申请并完成手续变更后，新成员方可办理办伴门店入驻手续。我司有权拒绝向未列入成员名单的人士或未向我司提供身份证原件的成员开放App使用权限。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span>9.2</span>
										客户之成员就帐号的使用应遵守中华人民共和国法律法规，客户就帐号的使用不在供应方和客户之间产生任何信托、代理、合伙、合资、担保和连带关系。
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">9.3</span>
										客户同意其不就对客户帐号有任何的所有权，客户承诺其成员和访客任何的线上行为遵守中华人民共和国法律法规，供应方有权对客户帐号之违规行为处理和限制关闭。
									</p>

									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">10.客户退驻约定
									</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 100px; text-align: left; width: auto;">10.1
										</span>
										合同终止和到期后工商注册地址的注销：合同无论是约定到期还是因违约而提前终止，客户均应在到期后的1个月内去工商管理部门办理“注册地址”变更登记手续。每逾期一日，则客户对供应方按此办公室的日租金的100%按天进行赔偿，造成其他损失的，供应方保留追诉的权利。
									</p>
									<h6 class="addContextTitle"
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold; display: none;">追加的内容：
									</h6>
									<p class="app-con"></p>
								</div>

								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 30px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										授权方(供应方)授权代表 <span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Authorizing
											Party's Authorized Representative</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										被授权方(承租方)授权代表 <span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Authorized
											Party's Authorized Representative</span>
									</p>
								</div>

								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 30px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										职位<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Position</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										职位<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Position</span>
									</p>
								</div>

								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 10px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										签署及盖章 <span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">signature
											and Seal</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 24px; text-align: left;">
										签署及盖章 <span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">signature
											and Seal</span>
									</p>
								</div>
							</div>
						</div>

						<!-- ============================== -->

						<div class="rent-wrap rent-English" style="display: none">
							<div class="rent-contract" id="contractHead"
								style="box-sizing: border-box; width: 100%; max-width: 1100px; height: auto; padding-top: 40px; padding-left: 50px; padding-right: 50px; padding-bottom: 1px; background-color: #fff; box-shadow: 1px2px4pxrgba(0, 0, 0, .3);">

								<h1 id="contractTitle"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 40px; font-size: 25px; text-align: center; line-height: 50px; font-weight: bold;">Office
									Service Agreement</h1>
								<div class="rent-con font-bold"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px; font-size: 0;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 100%; line-height: 30px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Provider</span>Shanghai
										Distrii Technology Development Co., Ltd
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Client
											Name</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Reference
											NO.</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Service
											Provision</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Agreement
											date:</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 100%; line-height: 30px; text-align: left; font-size: 14px; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 140px; letter-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px; float: left; display: block; text-align: left;">Payment
											Plan </span>
									</p>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">Provider</h4>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Contact
											Name</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Tel</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Position</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">E-mail</span>
									</p>
									<p class="rent-w"
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 90%;">
										<span
											style="box-sizing: border-box; width: 140px; lette-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px;">Mailing
											Address</span>
									</p>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">Client
										Name</h4>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Contact
											Name</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Tel</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 50%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">Position</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 40%; line-height: 30px; text-align: left; vertical-align: bottom;">
										<span
											style="box-sizing: border-box; width: 110px; letter-spacing: 0;; font-weight: bold; font-size: 15px; margin-right: 10px;">E-mail</span>
									</p>
									<p class="rent-w"
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 90%;">
										<span
											style="box-sizing: border-box; width: 140px; lette-spacing: 0; font-weight: bold; font-size: 15px; margin-right: 10px;">Mailing
											Address</span>
									</p>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">Occupancy
										Description</h4>
									<table class="rentbox" id="contractProducts"
										style="box-sizing: border-box; width: 100%; height: auto; border-collapse: collapse; text-align: center;">
										<tbody>
											<tr>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Center
													Name</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Office
													NO.</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Unit
													Price</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Units</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Service
													Provision</th>
												<th
													style="box-sizing: border-box; line-height: 25px; background-color: #E6E6E6;">Rental</th>
											</tr>
											<tr>
												<td rowspan="6" valign="top"
													style="box-sizing: border-box; line-height: 30px; vertical-align: middle;"></td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="rent-con"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">Initial
										Payment</h4>
									<div class="rent-f"
										style="box-sizing: border-box; padding: 10px; background-color: #E6E6E6;">
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											Office Monthly Fee<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											IT Package Monthly Fee<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											Setup Fee<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											Retainer/Deposit<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											Abatement<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
										<p
											style="box-sizing: border-box; width: 100%; font-weight: 600; border-bottom: 1px solid #ccc; line-height: 35px; height: 40px;">
											Total<span
												style="box-sizing: border-box; float: right; width: auto; font-weight: normal;">0.00</span>
										</p>
									</div>
								</div>

								<div class="rent-con rent-p"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 20px;">
									<h4
										style="line-height: 40px; border-bottom: #D6D6D6 1px solid; box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px;">TERMS
										AND CONDITIONS</h4>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">1、This
										Agreement</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.1</span>
										Both Parties hereby enter into this Contract based on the
										principles of equality and fairness. The Supplier is the
										provider and controller of the business office center
										(hereinafter referred to as “the Center”), and the Client
										agrees that it shall not be entitled to any ownership, estate
										or other real estate rights relating to the Office by virtue
										of this Contract. For the purpose of providing services to the
										Client, the Supplier agrees the Client to use the Center
										jointly with it according to this Contract and the
										supplemental code of occupancy. This Contract shall only be
										binding upon the Client, and, without prior written consent of
										the Supplier, the Client shall assign or transfer its rights
										and obligations hereunder to any third party. It is agreed by
										the Supplier that, the Client may assign or transfer it rights
										and obligations hereunder in whole or in part to its parent
										company, subordinate companies or affiliated companies
										(collectively referred to as “assignees”), and in such case,
										the Supplier may require such assignees to bear all
										obligations of the Client hereunder without termination of
										this Contract, provided that, the Client must provide
										documents in advance proving its affiliated relationship with
										such assignees. This Contract shall consist of the occupancy
										description, these terms and conditions, the code of occupancy
										(refer to the website for details) and the services
										description & price guidance (if appropriate). Each specific
										noun in this contract has the same definition.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.2</span>
										Compliance with the code of occupancy. The Client shall abide
										by the code of occupancy prepared by the Supplier for users of
										the Center.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.3</span>Execution
										& Automatic renewal. This Contract shall commence upon its
										execution and remain in full force and effect within the
										agreed lease term, and upon expiration, the original lease
										term shall be automatically extended by period equal to the
										original lease term, provided that the extended term shall not
										be less than 3 months (except as renewal is otherwise
										restricted by law), until this Contract is terminated by the
										Client or the Supplier. Please refer to Clause 1.4. Any term
										shall expire on the last date in the month of expiration. The
										rental due for the extended term shall be determined according
										to the prevailing market price.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.4</span>
										Expiration Termination. The Supplier or the Client may
										terminate this Contract on the expiration date of this
										Contract, the expiration date of the extended term or the
										expiration date of the renewed term, provided that a 3-month’s
										written notice shall be sent to the other party. If the
										contract term, the extended term or the renewed term is not
										more than 3 months, the Supplier or the Client shall give a
										2-month’s written notice to the other party if it intends to
										terminate this Contract on the expiration date; If the
										contract term, the extended term or the renewed term is not
										more than 2 months, the Supplier or the Client shall give at
										least 1-week’s written notice to the other party if it intends
										to terminate this Contract on the expiration date.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.5</span>
										Immediate termination. To the maximum extent permitted by law,
										the Supplier may immediately terminate this Contract by giving
										a written notice to the Client, and forfeit the deposit,
										without observing any other procedures, under any of the
										following circumstances: (a) the Client becomes insolvent or
										bankrupt, or is subject to liquidation, or becomes unable to
										discharge its debts due; or (b) the Client breaches this
										Contract, and is unable to rectify it, or fails to rectify it
										within 14 days after its receipt of a notice of rectification
										sent by the Supplier; or (c) the Client or any persons
										entering into the Center as permitted or invited by it carry
										out any activities contrary to the general purpose of the
										Office; or (d) the Client’s behaviors or business activities
										break the relevant law; or (e) there are more than five other
										clients complain of the Client; or (f) the Client pays any fee
										more than 30 days late. In case the Supplier terminates this
										Contract due to the above circumstances, the obligations of
										the Client shall not terminate simultaneously, including but
										not limited to payment of the fees for auxiliary services
										accepted by it and the monthly rentals for the remaining
										contract term.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.6</span>In
										case of termination of this Contract, the Client shall, on or
										prior to the date of termination, vacate the Office and
										restore the Office to its original conditions at the time of
										its occupancy. When the Client removes from the Office or
										relocates to another office in the Center, the Supplier will
										charge the expenses for routine inspection and cleaning
										required for restoring the Office to its original conditions
										(collectively referred to as ”restoration fee”), whether or
										not the Client has vacated the original office. The
										restoration fee shall be specified in the code of occupancy.
										The Supplier reserves the right to charge from the Client
										additional and reasonable repair expenses, which shall be used
										for repairing any abnormal wear and tear in the Office. If any
										items or personal properties of the Client are abandoned in
										the Center in case of termination of this Contract, the
										Supplier shall have the right to dispose of the same at its
										sole discretion, at the expenses for such disposal to be borne
										by the Client, and in such case, the Supplier shall not be
										held liable to the Client in any way, and the Client shall not
										be entitled to any proceeds obtained from such disposal. This
										Clause shall also be applicable to “immediate termination”.
										After the Client removes from the Office, if the Client still
										requires the Supplier to receive any letter, fax, telephone
										and guests for it and provide the services of proper transfer,
										the Supplier will charge the fees for reserved services in a
										lump sum, for 1-month’s period after the date of termination.
										Such fees have been specified in the code of occupancy. If the
										Client continues to use the Office after termination of this
										Contract, it shall be liable for any losses, claims or
										responsibilities suffered by the Supplier due to its failure
										to timely vacate the Office, and shall pay the fees during the
										period of occupation at 1.5 times the agreed rental rate. If
										supplier may elect to permit the Client to extend the lease
										term, but the Client shall still pay the relevant rentals and
										indemnify the Supplier all losses.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.7</span>
										If the Center is no longer available. If the Supplier becomes
										unable to continue to provide the services and office agreed
										herein and has given the Client a one-week’s written notice
										thereof, this Contract shall be deemed as terminated and the
										Supplier shall not be deemed to constitute a default, and in
										such case, the Client shall only pay the rentals occurred
										prior to the date of termination and the fees for auxiliary
										services already used by it. The Supplier shall exert its best
										efforts to provide the Client with alternative office in its
										other business office Centers, and both Parties shall, through
										consultation, determine whether to enter into a new lease
										contract for office, provided that, this Clause shall not be
										applicable to force majeure events.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.8</span>Notices.
										Any formal notices sent by the one party to the other party
										shall be delivered in writing to the communication address
										and/or email address specified in the occupancy description.
										If there is any change, this party shall give a written notice
										to the other one at least two working days before. Otherwise
										it shall take all the adverse consequences due to the late
										notice.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.9</span>Employees.
										within the valid term of this Contract and 6 months after its
										expiration or termination, neither the Supplier nor the Client
										may solicit or employ any employees of the other working in
										the Center. Such obligation shall be applicable to any
										employees working in the Center until 3 months after
										termination of their employment with either party. It is
										agreed, either party in breach of this Clause shall pay to the
										non-breaching party the liquidated damages equal to 1-year’s
										salary due and payable to the relevant employee involved in
										such breach. This Clause shall not prevent either party from
										employing any independent job applicant in good faith through
										issuing public recruitment advertisements.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.10</span>
										The Client is prohibited from representing employees of the
										Supplier: it is agreed by the Client, within the valid term of
										this Contract, the Client and its partners, members, officers
										and employees shall not represent any current or former
										employees of the Supplier in any dispute, actions or
										proceedings against the Supplier or its affiliated
										enterprises, members, officers and employees, nor otherwise
										provide any services of legal advice therefore.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.11</span>
										Applicable law. This Contract shall be governed by the law of
										the jurisdiction where the Center is situated. Any lawsuits
										arising out any disputes hereunder shall be resolved in the
										province, city, autonomous region or the state where the
										Center is situated. Both the Supplier and the Client submit to
										the exclusive jurisdiction of the competent courts having such
										jurisdiction. If any provisions contained herein are held
										invalid or unenforceable according to law, the remaining
										provisions hereof shall remain in full force and effect.
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.12</span>
										Confidentiality. All provisions contained herein shall be kept
										confidential. Except the Supplier or the Client is required by
										law or governmental authorities to disclose such provisions,
										neither party may disclose this Contract without the consent
										of the other party. Both Parties shall continue to bear the
										obligation of confidentiality after termination or expiration
										of this Contract.
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.13</span>Enforcement.
										The Client must pay any reasonable and appropriate expenses
										and fees, including any legal fees for enforcement of this
										Contract by the Supplier, but excluding the fees for
										arbitration or mediation to be respectively borne by the
										Supplier and the Client when arbitration or mediation is
										required.
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">1.14</span>Applicable
										Language. This Contract shall be executed in Chinese and
										English, and both the Chinese and English versions shall be
										legally binding. In case of any discrepancy between the
										Chinese and English versions, the Chinese version shall
										prevail.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">2.
										Services and Obligations</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">2.1</span>
										Office. The Supplier shall provide the Client with the agreed
										office together with auxiliary services for which the Client
										agrees to pay the fees pursuant to this Contract. This
										Contract specifies the Office originally allocated by the
										Supplier to the Client. The Client shall have no exclusive
										right to the Office allocated to it. The Supplier may
										reallocate the Office to the Client, provided that, such
										reallocated office shall be available to the persons the same
										as those in the original office, and the Supplier shall notify
										the Client of such reallocation in writing in advance.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">2.2</span>
										Office Services. The Supplier will, as demanded by the Client,
										provide the services specified in the services description &
										price guidance during normal operating hours (the services
										description & price guidance may be provided on demand). If
										any special demands of the Client cause extra working quantity
										in the opinions of the Supplier, additional fees may be
										charged.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">2.3</span>
										Supplier’s Network. The Supplier makes no representation or
										undertakings in respect of the security of the Client’s
										network (or internet) and any information issued by the Client
										thereon. The Supplier takes no responsibility for the behavior
										of the Client. The Client shall take any measures for security
										(such as encryption) suitable for its recruitments.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">3.
										Supply of Services</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">3.1</span>Access
										into the Office. The Supplier may have access into the
										Client’s office at any time. However, except for emergency or
										delivery of notice of termination of this Contract by the
										Client, the Supplier shall try to notify the Client in advance
										orally or by telecommunication when it needs to enter into the
										Client’s office for the purpose of testing, repair or other
										irregular inspection, cleaning and maintenance. The Supplier
										shall also abide by reasonable security procedures so as to
										protect the business secrets of the Client.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">3.2</span>Availability
										of the Office on the commencement date of lease. If the
										Supplier is unable to provide the Office agreed in this
										Contract on the commencement date of lease due to any reason
										beyond the scope of this Contract, it shall not be held liable
										for any losses or damages suffered by the Client, provided
										that the Client may terminate this Contract without payment of
										any liquidated damages. The Supplier will not charge any
										rentals from the Client before the Office becomes available
										for use. The Supplier may postpone the commencement date of
										lease hereunder.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">4.
										Use</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">4.1</span>The
										office shall only be used for the purpose of office, the
										Client shall not do any illegal activities and without the
										written consent of the Supplier any advertising in the office
										is forbidden. The Client undertakes and guarantees that, any
										members of the Client will not violate the code of occupancy
										of the Supplier’s any store, nor cause any disturbance, damage
										or danger to the health/properties of the Supplier or any
										third parties, nor provide false information to the Supplier,
										nor use the Office or any part of the Center for receiving
										lots of guests (including but not limited to money management,
										education, retail, insurance, medical treatment and training),
										nor duplicate any keys, entrance cards and any items accessing
										to the Office area in the Center. The Client shall fully
										indemnify any damages suffered by the Supplier and/or any
										third parties due to violation of laws or this Contract or
										code of occupancy by the members or affiliated visitors of the
										Client.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">4.2</span>
										The Client shall not engage in any business activities
										competing with the leased offices or the auxiliary services
										provided by the Supplier.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">4.3</span>
										Name and address of client. The Client shall carry on its
										business only under its own name or other names approved by
										the Supplier in advance.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">4.4</span>
										Use of the Center’s address. The Client may use the Center’s
										address as its registered address, and any use of such address
										shall be subject to prior written consent of the Supplier.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">4.5</span>
										Without written consent of the Supplier, the Client shall not
										assign or transfer its rights or obligations hereunder to any
										third parties. The Supplier may, by giving a 6-month’s written
										notice to the Client, terminate its rights and obligations
										hereunder or assign or transfer the same to its affiliates or
										any third parties.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">5.
										Office</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">5.1</span>
										The Client shall not alter any properties in the Office, and
										shall properly care for and use all properties in the Center,
										including but not limited to facilities, equipment, plants and
										furniture used by the Client. The Client shall be liable for
										any personal injury and/or property damages caused by any
										persons accessing to the Center as invited or permitted by it
										expressly or by implication (including but not limited to all
										employees, contractors and agents of the Client or other
										persons appearing in the Office).
									</p>
									<p>
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">5.2</span>Office
										equipment: without consent of the Supplier, the Client shall
										not install electric cables and wire, IT equipment or
										telecommunication device, and the Supplier may deny such
										installation. If such installation is approved by the
										Supplier, the Client shall permit the Supplier to supervise
										the installation (such as IT equipment or electric system), so
										that such installation will not affect use of the Offices by
										other customers or the Supplier or the owner of the building.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">5.3</span>
										Insurance. The Client shall effect the insurances for its
										properties in the Center and its liabilities towards its
										employees or other third parties, for which the Supplier shall
										not be held liable. It is strongly recommended by the Supplier
										that, the Client should purchase relevant insurances.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">6.
										Responsibilities of the Supplier</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">6.1</span>
										Scope of the Supplier’s responsibilities: to the maximum
										extent permitted by applicable laws, the Supplier will not be
										liable for any losses or damages suffered by the Client in
										connection with this Contract, the services accepted by the
										Client or the working places, except such losses or damages
										are caused by the Supplier due to its intention or gross
										negligence. The Supplier shall not be held liable for any
										damages suffered by the Client in case of its failure to
										provide services to the Client due to failure of machinery or
										equipment, strike, or loss by the Supplier of the rights and
										interests in the building containing the Center, except for
										intention or gross negligence of the Supplier. In any event,
										the Client shall notify in writing the Supplier of any losses
										or damages and grant the Supplier a reasonable time for
										rectification; otherwise, the Supplier shall not be liable for
										any losses or damages suffered by the Client. If the Supplier
										is unable to provide the agreed services for any reasons
										attributable to it, it shall, subject to the following
										limitation, pay actual and reasonable expenditures incurred by
										the Client for seeking alternative services. If the Client
										holds that the Supplier fails to provide the services
										consistent with the provisions in this Contract, it shall
										notify the Supplier in writing and grant the Supplier a
										reasonable time for rectification.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">6.2</span>
										Exclusion of indirect losses. Except as agreed by the Supplier
										in writing, in no event shall the Supplier be liable to the
										Client for any loss of operation, profits or expected saving,
										loss of or damage to data, claims of third party or other
										indirect or consequential losses. It is strongly recommended
										by the Supplier that, the Client shall effect insurances for
										such potential losses, damages or liabilities.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">6.3</span>The
										limitation on liability borne by the Supplier: in any event
										the liability borne by the Supplier to the Client shall be
										subject to the following limitations: <br> （1）、The
										liability for personal injury or death shall be borne based on
										actual fault, and shall not exceed RMB 1,000,000 at maximum. <br>
										（2）、The liability for indemnifying personal property damages
										suffered by the Client in respect of a certain event or series
										of related events shall be limited to the total amount paid by
										the Client, and the Supplier shall not be held liable for any
										indirect, consequential or expected losses. <br> （3）、The
										liability for indemnifying other losses or damages shall be
										limited to the actual losses suffered by the Client in
										principle, but shall not exceed 125% of all fees already paid
										by the Client during the period from the Client’s occupancy of
										the Office until occurrence of the dispute giving rising to
										its claim. <br>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">6.4
										</span> The Client be liable indemnifying any damages suffered by the
										Supplier and any third parties due to breach of this Contract
										on part of the Client and its visitors.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">7.
										Fees and expenses</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.1</span>
										Taxes and levies. The Client agrees to timely pay: (i) all
										taxes of sale, use, excise or consumption or other taxes and
										levies and licensing fees (and the Client shall provide the
										Supplier with the receipt of payment on demand); and (ii)
										taxes payable by the Supplier to the governmental authorities
										regarding the Office, including but not limited to total
										income taxes, leasing taxes and fees, individual tangible
										assets taxes, stamp duty and other documentary taxes and
										levies. This Sub-Clause shall be governed by the law of the
										P.R.C.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.2
										</span>Earnest money/deposit: except other amounts and payment method
										are specified in the occupancy description, the Client shall,
										at the time of execution of this Contract, pay the earnest
										money/deposit equal to 3-month’s office fees, and shall
										further pay the deficiency of the initial payment and earnest
										money (inclusive of VAT/taxes) (if applicable) within 5
										working days after execution of this Contract. The said
										earnest money/deposit shall be kept by the Supplier, free of
										interests, and made up by the Client according to the
										electronic bill. Such earnest money/deposit shall serve as the
										security for performance of the obligations by the Client
										hereunder. In case of termination/expiration of this Contract,
										the balance of such earnest money/deposit shall, after the
										fees due, the service fees for business extension, restoration
										fee and default (if any) are deducted therefrom, be refunded
										to the Client free of interests upon written request by the
										Client and completion of settlement.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.3</span>
										If the fees due exceed the earnest money/deposit held by the
										Supplier, or the Client delays to pay any fees due repeatedly
										to the Supplier, the Supplier may require the Client to pay
										additional earnest money/deposit.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.4</span>
										At the time of occupancy, the Client shall pay the fixed
										telephone setup expenses (if any) according to the quantity.
										The standards on such expenses shall be agreed in the code of
										occupancy (refer to the website for details).
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.5</span>
										Payment and reservation. The Supplier always aims to reduce
										the environmental burden and encourage the Client to
										participate in the environmental protection. Therefore, the
										Supplier will issue and send electronic bill (to the extent
										permitted by local laws). Except other methods of payment may
										be determined through consultation with major clients, all
										clients shall make payment by direct debit or credit payment
										(to the extent permitted by local banking system). When
										executing this Contract by the Client, the Supplier has
										confirmed reservation of the Office required. All amounts
										payable by the Client hereunder may be allocated to the
										associated companies of the Supplier.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.6</span>Late
										fees. if the Client fails to timely any fees due, it shall be
										charged a certain amount of late fees. The specific amount of
										late fees shall be 1% of the overdue amounts on a daily basis.
										If the Client has any objection to any part of the amounts due
										and payable, it shall timely pay the part other than those in
										dispute; otherwise, it shall pay the late fees. If the Client
										fails to timely pay any fees and/or interests due and payable
										by it, or it is in default, the Supplier may decide to suspend
										all the services immediately (for avoidance of doubt,
										including rejected access into the Office by the Client).
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.7
										</span> The rent and service fees in this Contract only include rate
										3% VAT (this part cannot be deducted). The Client shall bear
										the out part of the VAT (if any) by itself.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.8
										</span> Except as otherwise agreed in this Contract, on each
										anniversary of the execution date of this Contract, the
										Supplier will increase the monthly rental at a certain rate.
										The said increasing rate shall be determined according to the
										growth rate of retail value index of all projects or
										alternative similar value index provided by the Supplier; if
										the said increasing is prohibited by the applicable laws, the
										increase in the monthly rental shall be determined according
										to the code of occupancy. This Clause shall only be applicable
										to the period from effectiveness of this Contract until its
										expiration not less than 12 months, include the automatic
										renewal period. Any renewed contracts shall be executed
										according to the provisions on “term” in above Clause 1.3, and
										increase in rental shall be applicable to any period from the
										effectiveness of such contract until its expiration not less
										than 12 months.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.9
										</span>Standard services. The monthly rental for the Office and other
										regular services demanded by the Client must be paid fully one
										monthly in advance according to the occupancy description.
										Except as otherwise agreed in writing, such regular services
										provided by the Supplier shall be charged at the certain rate
										within the term of this Contract (including any renewal). The
										specific due date is set forth in the electronic bill. If such
										fees are charged on a daily basis, the monthly fees shall be
										calculated based on the daily rental multiplied by the actual
										days. The rental for any period less than one month shall be
										calculated based on the actual days lapsed.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.10</span>Use
										on payment and other optional services. In respect of the fees
										based on use on payment and relevant taxes and levies (subject
										to change from time to time according to the rate published by
										the Supplier), the Supplier will issue a bill after such fees
										are incurred, and the Client shall make payment within one
										month after the calendar month when the auxiliary services are
										provided. The specific date of payment is set forth in the
										electronic bill.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.11</span>
										Discount, rebates and preference. If the Client who has been
										entitled to discount, rebates or preference breaches any
										provisions of this Contract or delays in payment for twice,
										the Supplier may terminate various discounts, rebates and
										preferences granted to the Client without further notice. At
										the time of settlement, the Client shall return to the
										Supplier the relevant discounts, rebates and preferences
										already enjoyed by it (if any), and pay the relevant fees and
										expenses according to the original price before such
										discounts, rebates and preferences are granted.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">7.12</span>
										Visitor’s expenses. “Visitors” shall mean any persons entering
										into the area designated by the Supplier, as permitted by the
										Client. After registration with the Supplier, any visitor may
										stay in the designated area for not more than two hours. If he
										has stayed in such designated area for more than two hours,
										the Client shall pay the expenses (“visitor’s expenses”),
										according to the standards available on the Supplier’s website
										and the code of occupancy, which may be adjusted by the
										Supplier from time to time.
									</p>
									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">8.
										Compliance</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">8.1</span>
										Compliance with law. The Client shall abide by applicable laws
										and regulations during its business activities. The Client
										shall not commit any illegal acts concerning use of the
										Center. The Client shall not engage in any actions that would
										affect the use of the Center by the Supplier or others, nor
										cause any disturbance or hindrance, nor increase any insurance
										premium to be borne by the Supplier, nor cause any losses or
										damages (including loss of reputation) to the Supplier or any
										person entitled to use the building where the Center is
										located. The Client acknowledges that: (i) the above provision
										shall be the basis on which the Supplier enters into this
										Contract; and (ii) breach by the Client of the above provision
										shall constitute materials breach, and in such case, the
										Supplier may terminate this Contract, forfeit the deposit,
										without further notice or other procedures.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">8.2</span>
										The Client has known and agreed that, its corporate and/or
										personal data will be registered in the website, and will be
										used by the Supplier for the commercial purpose of performing
										the services.
									</p>

									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">9.Use
										of Client’s Account in Safety</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">9.1
										</span> “Client” shall mean any person permitted by the Supplier to
										use the Office (including natural person and corporate body;
										for avoidance of doubt, any acts of such person shall be
										deemed as the acts of the Client). The Client shall, through
										the website “www.distrii.com” (“the website”), submit its
										subject qualification certificate and the list of its members
										and ID information, and each member shall provide the Supplier
										with the original and copy of his ID card before handling the
										procedures for occupancy at the Supplier’s store. If the
										Client intends to change the list of its members, it shall
										submit an application for change through the website. Only
										after the Client successfully submits the said application for
										change and completes the procedures for change, may the new
										members handle the procedures for occupancy at the Supplier’s
										store. The Supplier may refuse to grant the powers to use the
										App to any persons who are not included into the list of
										members or who fail to provide the Supplier with the original
										of their ID cards.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">9.2</span>
										Use of the account by the Client’s members shall comply with
										the laws and regulations of the People’s Republic of China,
										and no use of account by the Client shall constitute any
										trust, agency, partnership, joint venture, guarantee and joint
										and several liability between the Supplier and the Client.
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">9.3</span>
										The Client confirms and agrees that, it has no ownership and
										IP rights to or in the Client’s account, it undertakes that,
										any online acts of its members and visitors will comply with
										the laws and regulations of the People’s Republic of China,
										and the Supplier may handle and/or restrict or close down the
										Client’ account in case of any violation.
									</p>

									<h6
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold;">10.Provisions
										on Removal by the Client from the Office</h6>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; width: 100%; height: auto; text-indent: 20px;">
										<span
											style="box-sizing: border-box; float: left; display: block; width: 40px; text-align: left;">10.1
										</span>Change in registered address: if the Client uses the Office
										provided by the Supplier as its registered address, it shall,
										within 1 month after expiration or early termination of this
										Contract, remove its registered address from the Office and
										complete the procedures for registration of change in its
										registered address. The date of completion of the said
										registration of change in registered address shall be that
										date recorded in the new business license containing the
										changed registered address, obtained by the Client from the
										competent administration for industry and commerce, and, after
										the registered address is changed, the Client shall provide
										the Supplier with a copy of the said new business license
										affixed with its official seal for the inspection and filing
										by the Supplier. If the Client delays to change the registered
										address pursuant to the above provisions, it shall indemnify
										the Supplier 100% daily rental for each overdue day, and the
										Supplier may further claim against the Client for any other
										losses (if any).
									</p>
									<h6 class="addContextTitle"
										style="box-sizing: border-box; text-align: left; font-size: 15px; line-height: 40px; font-weight: bold; display: none;">追加的内容：
									</h6>
									<p class="app-con"></p>
								</div>
								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 30px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Authorizing
											Party's Authorized Representative</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Authorized
											Party's Authorized Representative</span>
									</p>
								</div>

								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 30px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Position</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">Position</span>
									</p>
								</div>

								<div class="rent-con signature"
									style="box-sizing: border-box; width: 100%; height: auto; margin-bottom: 10px;">
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">signature
											and Seal</span>
									</p>
									<p
										style="box-sizing: border-box; padding-left: 10px; padding-right: 10px; letter-spacing: 1px; display: inline-block; width: 45%; line-height: 30px; text-align: left;">
										<span
											style="box-sizing: border-box; float: right; width: auto; font-weight: normal; display: block; width: 100%; height: 20px; margin-top: -5px; font-size: 12px; line-height: 20px;">signature
											and Seal</span>
									</p>
								</div>
							</div>
						</div>


					</div>
				</div>
			</div>
			<div class="pact-right">
				<div class="po-ab">
					<button type="button" class="btn btn-primary  btn-block printBtn"
						id='printBtn'>打印</button>
					<button type="button" class="btn btn-primary  btn-block send">发送</button>
					<button type="button" class="btn btn-primary  btn-block"
						onclick="update()">追加条款</button>

					<button type="button" class="btn btn-primary  btn-block btn-change">English</button>
					<!-- <button type="button" class="btn btn-primary  btn-block"
						onclick="cancelOrder()"></button> -->
					<div style="width: 100%;position: absolute;bottom: 0;">
						<button type="button"
							class="btn btn-primary  btn-block advanceCheckBtn">提前入住</button>
					</div>
					<div class="pact-sure">
						<!-- <button type="button"
							class="btn btn-primary  btn-block advanceCheckBtn">提前入住</button> -->
						<button type="button" class="btn btn-primary  btn-block"
							onclick="skipStep(this,5)">确定</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- 选择支付方式 -->
	<div class="pay-con clearfix hidden">
		<div class="closeZ" id="closePay-con" onclick="closePaymentMethod()">x</div>
		<div class="payment">
			<div class="insidepay">
				<div class="row">
					<div class="col-md-12">
						<div class="page-header">
							<h3>支付方式选择</h3>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="btn-group">
						<button type="button" class="btn btn-success btn-lg"
							onclick="skipStep(this,7)">在线支付</button>
					</div>
					<div class="btn-group marl40">
						<button type="button" class="btn btn-primary btn-lg"
							onclick="skipStep(this,6)">pos机支付</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- post支付 -->
	<div class="pay-con clearfix hidden">
		<div class="payment">
			<div class="insidepay">
				<div class="row">
					<div class="col-md-12">
						<div class="page-header">
							<h3>Pos机支付</h3>
							<h4 class="paynum">
								<input type="text" class="paynum-m" value="￥" redyonly /><input
									type="text" class="paynum-last" value="2000">
							</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 paysuccess">
						<button type="button" class="btn btn-primary"
							onclick="skipStep(this,5)">返回</button>
						<button type="button" class="btn btn-success"
							onclick="payComplete()">支付完成</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="well textleft">当用户完成付款后，请销售人员点击上面的支付完成按钮</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 二维码支付 -->
	<div class="pay-con clearfix hidden">
		<div class="payment">
			<div class="insidepay">
				<div class="row">
					<div class="col-md-12">
						<div class="page-header">
							<h3>支付二维码</h3>
							<h4 class="paynum">
								<input type="text" class="paynum-m" value="￥" redyonly /><input
									type="text" class="paynum-last" value="2000">
							</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="webchat-img">
							<img src="img/payment.jpg">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<button type="button" class="btn btn-primary"
							onclick="skipStep(this,5)">返回</button>
						<button type="button" class="btn btn-primary"
							onclick="downloadPDF()">下载</button>
						<button type="button" class="btn btn-primary printBtn">打印</button>
						<button type="button" class="btn btn-primary send">email</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="send-alert send-alert1 hidden">
		<form role="form" onsubmit="return false">
			<div class="form-group">
				<label for="exampleInputEmail1">输入Email</label> <input type="email"
					class="form-control" id="userEmailInputId"
					placeholder="Enter email">
			</div>
			<button type="submit" class="btn btn-default" id="emailSend">发送</button>
		</form>
		<div class="alert-close">X</div>
	</div>
	<div class="send-alert advanceCheck hidden">
		<form role="form" onsubmit="return false">
			<div class="form-group">
				<label for="exampleInputEmail1">提前入住时间</label> <input type="hidden"
					id="contractIdInp" value="${contractId }">
				<div style="width: 100%;">
					起始时间：<input type="text" id="advanceCheckStartDate" class="w1p4"
						style="width: 65%;" readonly />
				</div>
			</div>
			<button type="submit" class="btn btn-default" id="sureAdvanceCheck">确定</button>
		</form>
		<div class="alert-close">X</div>
	</div>
	<div class="b-wrap hidden"></div>
	<div class="send-alert updateContract hidden">
		<form role="form" action="javascript:;">
			<div class="form-group">
				<label for="exampleInputEmail1">追加内容</label>
				<textarea class="form-control" id="text-con"></textarea>
			</div>
			<button type="submit" class="btn btn-default" id="upd-save">保存</button>
		</form>
		<div class="alert-close">X</div>
	</div>
	</div>

	<!-- 点击新增公司弹框 -->
	<!------ 搜索内容 -->
	<div class="seat-alert seat-alert8">
		<div class="seat-header">
			选择公司 <span class="searchclose">X</span>
		</div>

		<div class="seat-con">
			<div class="row searchbox">
				<div class="col-md-7">
					<div class="col-sm-8">
						<input type="email" class="form-control input-md" id="inputEmail3"
							placeholder="输入用户公司进行查找">
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-default btn-search"
							id="searchCompany">搜索</button>
					</div>
				</div>
				<div class="col-md-5 newcomapny">
					没有新公司？<a href="javascript:void(0);" id="newcompany-register">注册新公司</a>
				</div>
			</div>
			<div class="searchnew">
				<table class="table table-striped clearfix">
					<tr>
						<th></th>
						<th>公司名称</th>
						<th>公司编号</th>
						<th></th>
					</tr>

					<tr class="person-list">
						<td><i class="glyphicon glyphicon-user"></i></td>
						<td class="td-name">亚信科技有限公司</td>
						<td class="td-number">AD1120134</td>
						<td>
							<button type="button" class="btn btn-default bts btn_button">选择</button>
						</td>
					</tr>
				</table>

			</div>
		</div>


	</div>

	<!------  搜索内容 -->
	<div class="seat-alert seat-alert9">
		<div class="seat-header">
			新公司注册<span class="searchclose">X</span>
		</div>
		<div class="input-group a11">
			<span class="input-group-addon">公司名称:</span> <input type="text"
				id="companyName" class="form-control" placeholder="公司名称"
				aria-describedby="basic-addon2">
		</div>
		<div class="input-group">
			<span class="input-group-addon">电话号码:</span> <input type="text"
				id="companyPhone" class="form-control" placeholder="电话号码"
				aria-describedby="basic-addon2"><span>注：此电话将用作该公司管理员账户！</span>
		</div>
		<!-- <div class="input-group">
			<span class="input-group-addon">联系人电话:</span>
  		<input type="text" id="companyPhone" class="form-control" placeholder="Recipient's username" aria-describedby="basic-addon2">
  		<div class="btn btn-info">发送验证码</div>
		</div> -->
		<!-- <div class="input-group">
			<span class="input-group-addon">验证码:</span>
  		<input type="text" class="form-control" placeholder="Recipient's username" aria-describedby="basic-addon2">
		</div> -->
		<div class="btn btn-warning bcc">提交并注册</div>
	</div>
	<div class="seat-alert seat-alert10">
		<div class="seat-header">
			新公司注册<span class="searchclose">X</span>
		</div>
		<div class="seat-con">
			<div class="window-main">
				<i class="glyphicon glyphicon-ok"></i>
				<div>
					<p>恭喜您！公司注册成功！</p>
					<span></span>
				</div>
			</div>
		</div>
	</div>
</body>
<script id="contractJsp" type="text/x-handlebars-template"></script>
<script>
	$(function() {
		$(".btn-change").click(function() {
			var text = $(this).text();
			if (text == "English") {
				$(".rent-English").show();
				$(".rent-Chinese").hide();
				$(this).text("中文");
			}
			;
			if (text == "中文") {
				$(".rent-English").hide();
				$(".rent-Chinese").show();
				$(this).text("English");
			}
		})
	})
</script>
</html>