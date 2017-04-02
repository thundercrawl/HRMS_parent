<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">活动参与人员</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div style="min-width:1100px;margin-bottom:10px;">
				<div class="container-fluid" stle="width:100%;height:auto;">
				<div class="row">
                  <div class="input-group col-md-3" style="float:left;padding:0 4px;">
                     <span class="input-group-addon">人员姓名</span>
                     <input type="text" class="form-control" placeholder="人员姓名" id="personName">
                  </div>
                  
                  <div class="input-group col-md-3" style="float:left;padding:0 4px;">
							<span class="input-group-addon">是否中奖</span>
							       <select class="form-control" onChange="showValue(this.value);" name="status" id="prizeStatus">
							       <option value="0"></option>
							       <option value="2"> 否 </option>
							       <option value="1"> 是 </option>
   								   </select>
				  </div>
                  <div class="input-group col-md-3" id="statusDiv" style="float:left;padding:0 4px; display : none">
							<span class="input-group-addon">是否配送</span>
							       <select class="form-control" id="sendStatus">
							       <option value="0"></option>
							       <option value="1"> 是 </option>
							       <option value="2"> 否 </option>
   								   </select>
				  </div>
				 
				  <div class="input-group col-md-3" id="nameDiv" style="float:left;padding:0 4px; display : none">
                     <span class="input-group-addon">配送人员</span>
                     <input type="text" class="form-control" placeholder="配送人员" id="sendName">
                  </div>
                </div>
				</div>
                  </div>
                  
                 <div class="container-fluid" style="width:100%;height:auto;">
                 	<div class="row">
                  		<div class="input-group col-md-3" style="float:left;padding:0 4px;">
							<span class="input-group-addon">抽奖开始时间</span>
							<input type="text" class="form-control reDatetimepicker"  id="startTime" name="validDate"  >
						</div>
				
						<div class="input-group col-md-3" style="float:left;padding:0 4px;">
							<span class="input-group-addon">抽奖结束时间</span>
							<input type="text" class="form-control reDatetimepicker" id="endTime" name="expireDate" >
						</div>
						
                  		<div class="input-group col-md-3" id="timeStart" style="float:left;padding:0 4px; display : none">
							<span class="input-group-addon">配送开始时间</span>
							<input type="text" class="form-control reDatetimepicker"  id="sendStartTime" name="validDate"  >
						</div>
				
						<div class="input-group col-md-3" id="timeEnd" style="float:left;padding:0 4px; display : none">
							<span class="input-group-addon">配送结束时间</span>
							<input type="text" class="form-control reDatetimepicker" id="sendEndTime" name="expireDate" >
						</div>
					</div>
	                <div class="container-fluid" stle="width:100%;height:auto;">
	                	<div class="row">
	                		<div class="input-group col-md-1" style="float:right;margin-top:10px;">
								<a class="btn btn-success form-control" id="findActivity" style="border-radius: 4px;">
					                <i class="glyphicon glyphicon-zoom-in icon-white"></i>查询
					            </a>
						    </div>
	                	</div>
	                </div>  	
                   		
					</div>
                    <input type="hidden" id="formParam" value=""/>
					<div id="persontable" style="margin-top: 8px;">
						<jsp:include page="joinPersonList.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="js/pagination.js"></script>
<script src="js/prize/checkAndAdd.js"></script>
