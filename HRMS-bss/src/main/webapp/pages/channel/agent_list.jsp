<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>
		<tr>
			<th class="center">经纪人/联系人编号</th>
			<th class="center">经纪人/联系人</th>
			<th class="center">经纪人/联系人手机</th>
			<th class="center">经纪人/联系人邮箱</th>
			<th class="center">渠道</th>
			<th class="center">创建人</th>
			<th class="center">创建时间</th>
		<!-- 	<th class="center">状态</th> -->
			<th class="center">操作</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="agent">
					<tr>
						<td class="center">${agent.agentNumber}</td>
						<td class="center">${agent.agentName}</td>
						<td class="center">${agent.agentPhone }</td>
						<td class="center">${agent.agentEmail }</td>
						<td class="center">${agent.channelName  }</td>
						<td class="center">${agent.adminName }</td>
						<td class="center">${agent.createTime }</td>
						<%-- <td class="center">${agent.statusMessage }</td> --%>
						<td><a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit revise_agent"
							data-page="${paginator.page}"
							data-channelId="${agent.channelId }"
							data-agentId="${agent.agentId }"
							data-agentPhone="${agent.agentPhone }"
							data-agentName="${agent.agentName}"
							data-agentEmail="${agent.agentEmail}"
							data-remark="${agent.remark}"><i
								class="fa fa-edit"></i>修改</a> 
							<a href="javaScript:void(0);"
							class="btn btn-danger btn-xs delete_agent"
							data-page1="${paginator.page}"
							data-agentId="${agent.agentId }"><i
								class="fa fa-trash-o"></i>删除</a></td>
					</tr>
			</c:forEach>

		</c:if>
	</tbody>
</table>


<!-- 修改经纪人开始 -->
<div id="change_agent_window" style="display: none;">
	<form action="" style="margin-right: -26px;">
		<table>
			<tr>
				<td><input type="hidden" id="agent_Idxg"  /></td>
				<td><input type="hidden" id="channel_Idxg"  /></td>
			</tr>
			<tr>
				<td>经纪人名称</td>
				<td><input type="text" id="agent_Namexg" maxlength="32" /> <span
					id="spanagent_Namexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>经纪人联系电话</td>
				<td><input type="text" id="agent_phonexg" maxlength="32" /> <span
					id="spanagent_phonexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>

			<tr>
				<td>经纪人邮箱</td>
				<td><input type="text" id="agent_Emailxg" maxlength="120" /> <span
					id="spanagent_Emailxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>备注</td>
				<td><input type="text" id="agent_remark" maxlength="240" /> <span
					id="spanagent_remarkxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_chagent_surexg">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_chagent_escxg">取消</a>
	</div>
	 
</div>
<!-- 修改渠道结束 -->
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/channel/findMyAgent" name="url" />
	<jsp:param value="agent_info_de" name="loadCmp" />
	<jsp:param value="query_info_agent" name="formParam" />
</jsp:include>

<script>
$(function (){
	var agentCurpage=0;
	/*--------------------------修改经纪人信息----------------------------------*/
	$(".revise_agent").on('click',function(){
		agentCurpage=$(this).attr('data-page');
		$("#channel_Idxg").val($(this).attr('data-channelId'));
		$("#agent_Idxg").val($(this).attr('data-agentId'));
		$("#agent_phonexg").val($(this).attr('data-agentPhone'));
		$("#agent_Namexg").val($(this).attr('data-agentName'));
		$("#agent_Emailxg").val($(this).attr('data-agentEmail'));
		$("#agent_remark").val($(this).attr('data-remark'));
		$("#change_agent_window").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#change_agent_window').dialog('destroy');
			}});
	});
	/*--------------------------修改经纪人提交表单----------------------------------*/
	$("#formcheck_chagent_surexg").on('click',function(){
		console.log("修改经纪人开始---")
		var agent_Name=$.trim($("#agent_Namexg").val());
		var re=/^[0-9]*[0-9][0-9]*$/;
		var agent_phone=$.trim($("#agent_phonexg").val());
		var boo0=re.test(agent_phone);
		var agent_Email=$.trim($("#agent_Emailxg").val());
		var boo_1=agent_Name.length>0&&agent_Name.indexOf(" ") == -1;
		$("#spanagent_Namexg").hide();
		$("#spanagent_Emailxg").hide();
		$("#spanagent_phonexg").hide();
		$("#spanagent_remarkxg").hide();
		if(!boo_1){
			$("#spanagent_Namexg").show();
			return ;
		}
		if(!boo0){
			$("#spanagent_phonexg").show();
			return ;
		}
		if(boo_1&&boo0){
			$.ajax({
				url:"filter/channel/saveNewAgent",
				dataType:"json",
				type:"POST",
				data:{
					"agentId":$("#agent_Idxg").val(),
					"agentName":agent_Name,
					"agentPhone":agent_phone,
					"remark":$("#agent_remark").val(),
					"agentEmail":agent_Email,
					"channelId":$("#channel_Idxg").val()
				},cache:false,
				success:function(data){	
					console.log("修改渠道回调")
					if(data.message=="true"){
						$("#agentCurpage").val(agentCurpage-1);
						$('#change_agent_window').dialog('destroy');
						$('#agent_info_de').load("filter/channel/findMyAgent", $('#query_my_agent').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
						$('#change_agent_window').dialog('destroy');
					}
					console.log("修改渠道结束---")
				},error : function(data) {
					$('#change_agent_window').dialog('destroy');
				}});
		}
	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_chagent_escxg").on("click",function(){
		$('#change_agent_window').dialog('destroy');
	});
	/*--------------------------删除经纪人----------------------------------*/
	$(".delete_agent").on("click",function(){
		if(confirm("确定删除此条记录吗？")){
			//console.log("删除渠道")
			var dpage=$(this).attr('data-page1');
			$.ajax({
				url:"filter/channel/deleteMyAgent",
				dataType:"json",
				type:"POST",
				data:{
					"agentId":$(this).attr('data-agentId')
				},cache:false,
				success:function(data){
					console.log(data.message);
					if(data.message=="true"){
						console.log(dpage-1);
						console.log("------------");
						$("#agentCurpage").val(dpage-1);
						$('#agent_info_de').load("filter/channel/findMyAgent", $('#query_my_agent').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
					}
				},error : function(data) {
				}
			});
			
		}
		
	});

})
</script>
