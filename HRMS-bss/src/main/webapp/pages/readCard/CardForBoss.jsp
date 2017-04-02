<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="js/My97DatePicker/WdatePicker.js"></script>

<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div class="pay-con clearfix">
					<div class="con-left">
						<div class="con-left-con">
							<div class="con-left-bottom card-reader">
								<form class="form-horizontal clearfix" id="forBossId"  style="margin-bottom: 10px;">
									<span class="form-hspan">项目地：</span>
									<div class="change-name1" id="changeName">苏和水岸空间</div>
									<ul class="change-list1">
										<c:if test="${!(empty proList)}">
											<c:forEach items="${proList}" var="ps">
												<li>${ps.projectName}<input type="hidden"
													id="projectId" name="projectId" value="${ps.projectId}"></li>
											</c:forEach>
										</c:if>
									</ul>
									<span class="form-hspan hspan1">门号：</span>
									<div class="col-sm-4 col-md-pull-1 col-md-offset-1">
										<input type="text" class="form-control input-md"
											id="doorNumber" name="doorNumber" placeholder="输入门号">
									</div>
									<div class="col-sm-2 col-md-pull-1">
										<button type="button" class="btn btn-info" id="bossSearch">查询</button>
									</div>
							</div>
							</form>
							<input type="hidden" value="" id="bossSearchCondition">
							<div id="bossId">
								<jsp:include page="bossCardTable.jsp"></jsp:include>
							</div>
							<%-- <div id="bossDoorId">
								<jsp:include page="bossDoorCardTable.jsp"></jsp:include>
							</div> --%>

							<div class="bottom-check">
								<form class="form-horizontal clearfix">
									<div class="checkbox col-md-12">
										<label> <input type="checkbox" id="blankCheckbox"
											class="alldiv" aria-label="..."> 全选
										</label>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="con-right">
						<!-- <div class="order-card" id="forRestCard"></div>
<form class="form-horizontal clearfix" id="forCardId">
						卡号：<input type="text" id="serial" name="cardCode" value=""
							class="form-control input-md" />
							</form> -->
						<div style="display: none;">
							<input type=radio name="radio" />SIM卡 <input type=radio
								name="radio" />CPU卡 <input type=radio name="radio" checked />IC卡
							<input type=radio name="radio" />SAM卡 <input type=radio
								name="radio" />UIM卡 <input type=radio name="radio" />SIM卡序列号 <input
								type=radio name="radio" />CPU卡序列号 <input type=radio
								name="radio" />身份证卡号
						</div>
						<!-- <div class="btn-groups col-md-12 text-center">
							<button class="btn btn-info" onclick="getCardSerial()">读卡</button>
							<button type="button" class="btn btn-info" id="bossDoorSearch">查询</button>
						</div> -->
						<div class="btn-groups col-md-12 text-center">
							<button class="btn btn-info choose-classifys">按手机号</button>
							<button class="btn btn-info choose-classifys">按公司名称</button>
						</div> 
						<div class="forms-groups">
							<div class="choose-one">
								<!-- <p>手机号：</p> -->
								<input type="text" class="form-control input-md" id="phoneNum" placeholder="请输入手机号" onblur="onblus()">
							</div>
							<div class="choose-one">
								<!-- <p>公司名称：</p> -->
								<div class="circle-company-name">
									<input type="text" class="form-control input-md" id="search-text" placeholder="请输入公司名称并选择已有公司" autocomplete="off">
									<input id="companyId" value="" type="hidden">
									<ul class="show-select"> </ul>
								</div>
							</div>
							<div  style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">开始时间：</span> <input
											type="text" class="form-control reDatetimepicker"
											id="startTime" name="startTime" ReadOnly="true">
									</div>
							<div  style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">结束时间：</span> <input
											type="text" class="form-control reDatetimepicker"
											id="endTime" name="endTime" ReadOnly="true">
									</div>
							
						</div>
						<div class="btn-groups col-md-12">
							<button type="button" class="btn btn-info" onclick="doorBossRest(bthType)">蓝牙授权</button>
							<!-- <button type="button" class="btn btn-info" onclick="doorBossRest(cardType)">卡授权</button>
							<button type="button" class="btn btn-info" onclick="doorBossRest(pswdType)">密码授权</button>
							<button type="button" class="btn btn-info" onclick="doorBossRest(cpype)">卡+密码授权</button>
							<button type="button" class="btn btn-info" onclick="doorBossRest(cbType)">卡+蓝牙授权</button>
							<button type="button" class="btn btn-info" onclick="doorBossRest(pbType)">密码+蓝牙授权</button>
							<button type="button" class="btn btn-info" onclick="doorBossRest(cpbType)">卡+密码+蓝牙授权</button>						
						 --></div>
						<object classid="CLSID:459B79A0-8785-4386-8EC6-C2B5D4F49C4A" id="MReader" codebase="ActiveReader.dll"></object>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="black-shadow"></div>
<script type="text/javascript">
	var cardType = 1;
	var pswdType = 2;
	var bthType = 3;
	var cpype = 4;
	var cbType = 5;
	var pbType = 6;
	var cpbType = 7;
	var tag=1;//1表示按照手机号码查，2按照公司查
</script>

<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/common_search.js"></script>
<script src="js/readCard/readCard.js"></script>
<script src="js/pagination.js"></script>
<script>
	
</script>
