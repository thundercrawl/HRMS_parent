<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div class="pay-con clearfix">
					<div class="con-left">
						<div class="con-left-con">
							<div class="con-left-bottom card-reader">

								<form class="form-horizontal clearfix" id="forid" style="margin-bottom: 10px;">
									<div class="col-md-2" style="line-height:34px;">订单号</div>
									<div class="col-sm-4 col-md-pull-1">
										<input type="text" class="form-control input-md" id="orderNum"
											name="orderNo" placeholder="输入订单号">
									</div>
									<div class="col-sm-2 col-md-pull-1">
										<button type="button" class="btn btn-info" id="orderSearch">查询</button>
									</div>
								</form>
								<input type="hidden" value="" id="orderSearchCondition">
								<div id="tid">
									<jsp:include page="cardTable.jsp"></jsp:include>
								</div>

								<div class="bottom-check">
									<form class="form-horizontal clearfix"  style="margin-bottom: 10px;">
										<div class="checkbox col-md-6">
											<label> <input type="checkbox" id="blankCheckbox"
												class="alldiv" aria-label="..."> 全选
											</label>
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-md"
												id="phoneNum" placeholder="手机号">
										</div>
										<div class="input-group col-md-1 colLee" style="display: inline-block">
											<a class="btn btn-info"
												onclick="doorRest()">分配</a>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="con-right">
							<p>已分配订单号：</p>
							<div class="order-card" id="forRestCard"></div>
							<form>
			                 <div class="input-group" style="display: inline-table;">
			                  <span class="input-group-addon">卡号：</span>
			                   <input type="text" id="serial" value="" class="form-control input-md" /></div> 
							</form>
							<div style="display: none;">
								<input type=radio name="radio" />SIM卡 <input type=radio
									name="radio" />CPU卡 <input type=radio name="radio" checked />IC卡
								<input type=radio name="radio" />SAM卡 <input type=radio
									name="radio" />UIM卡 <input type=radio name="radio" />SIM卡序列号
								<input type=radio name="radio" />CPU卡序列号 <input type=radio
									name="radio" />身份证卡号
							</div>
							<div class="col-md-12 text-center" style="margin-top: 10px;">
								<button class="btn btn-info" onclick="getCardSerial()">读卡</button>
							</div>
							<object classid="CLSID:459B79A0-8785-4386-8EC6-C2B5D4F49C4A"
								id="MReader" codebase="ActiveReader.dll"></object>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script id="cardRest" type="text/x-handlebars-template">
{{#each this}}
<p class="yellow-header">手机号码：{{userPhone}}</p>
								<div class="order-number">
									<p class="left-header">订单编号：</p>
									<p>{{orderId}}</p>
								</div>
{{/each}}
</script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/readCard.js"></script>
<script src="js/pagination.js"></script>
<script>
	
</script>
