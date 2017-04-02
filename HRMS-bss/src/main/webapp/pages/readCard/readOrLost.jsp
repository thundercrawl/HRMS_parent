<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;" id="forIn">
				<div class="reader-btn card-scanning">
					<button class="btn btn-warning card-open" onclick="getCardSerial()">开启发卡器</button>
					<button class="btn btn-warning diu" id="forLost">挂失</button>
					<div class="scanning-con">
						<p class="scanning-p">请在此页面进行读卡操作。</p>
						<form class="form-horizontal scanning-form" style="display: none">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">卡号：</label>
								<div class="col-sm-6">
									<input type="text" id="serial" value="" class="form-control">
								</div>
							</div>
						</form>
					</div>
					<button class="btn btn-info" onclick="toReadCard()">确定</button>
				</div>
				<div style="display: none;">
					<input type=radio name="radio" />SIM卡 <input type=radio
						name="radio" />CPU卡 <input type=radio name="radio" checked />IC卡
					<input type=radio name="radio" />SAM卡 <input type=radio
						name="radio" />UIM卡 <input type=radio name="radio" />SIM卡序列号 <input
						type=radio name="radio" />CPU卡序列号 <input type=radio name="radio" />身份证卡号
				</div>
				<object classid="CLSID:459B79A0-8785-4386-8EC6-C2B5D4F49C4A"
					id="MReader" codebase="ActiveReader.dll"></object>
			</div>
		</div>
	</div>
</div>
<script>
	$(function() {
		$(".card-open").click(function() {
			var text = $(this).text();
			if (text == "开启发卡器") {
				$(".scanning-p").hide();
				$(".scanning-form").show();
				$(this).text("关闭发卡器");
			} else {
				$(".scanning-p").show();
				$(".scanning-form").hide();
				$(this).text("开启发卡器");
			}
		});
	})
</script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/readCard.js"></script>
<script src="js/pagination.js"></script>