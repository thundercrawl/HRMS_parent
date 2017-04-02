<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScipt:void(0);">日志管理/业务记录/月业务记录</a></li>
		</ul>
</div>
<div class="record-search-cate">     <div class="ui-form-item">
		<label class="ui-form-label ui-label-text">分类：</label>
		<div class="ui-form-item-content gray-links" id="J-consume-category">
					<a  class="inline-item category-trigger"  onclick="showDayBusinessRecord()" id="DayBusiRecord">日业务记录</a>
					<a  class="inline-item category-trigger"  onclick="showMonBusinessRecord()" id="MonBusiRecord">月业务记录</a>
				</div>
	</div>
</div>

<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
                 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员姓名</span>
                    <input type="text" class="form-control" placeholder="会员姓名" id="userName" name="userName">
                  </div> 
                 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员手机号</span>
                    <input type="text" class="form-control" placeholder="会员手机号" id="userPhone" name="userPhone">
                  </div> 
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">公司名称</span>
                    <input type="text" class="form-control" placeholder="公司名称" id="companyName" name="companyName">
                   </div>  
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">选择查询时间</span>
                   <input type="text" class="form-control reDatetimepicker" placeholder="选择查询时间" id="submitMonTime" name="submitTime" />
                   </div>
                   <div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="" onclick="findMonBusinessRecord()">查询</a>
               </div>
                  </form>
					<div id="MonBusinessRecord" style="margin-top: 8px;">
						<jsp:include page="MonBusinessRecord.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script src="js/LogManagement/PersonalBills.js"></script>
<script src="js/pagination.js"></script>
