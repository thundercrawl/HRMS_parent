<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>
		<tr>
			<th class="center">渠道编号</th>
			<th class="center">渠道名称</th>
			<th class="center">渠道电话</th>
			<th class="center">渠道地址</th>
			<th class="center">渠道邮箱</th>
			<!-- <th class="center">营业执照编号</th> -->
			<th class="center">渠道类型</th>
			<!-- <th class="center">渠道状态</th> -->
			<th class="center">创建人</th>
			<th class="center">创建时间</th>
			<th class="center">操作</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="channel">
					<tr>
						<td class="center">${channel.channelNumber}</td>
						<td class="center">${channel.channelName}</td>
						<td class="center">${channel.channelPhone }</td>
						<td class="center">${channel.channelAddress }</td>
						<td class="center">${channel.channelEmail }</td>
						<%-- <td class="center">${channel.channelLicenceNum }</td> --%>
						<td class="center">${channel.typeMessage  }</td>
						<%-- <td class="center">${channel.statusMessage }</td> --%>
						<td class="center">${channel.adminName }</td>
						<td class="center">${channel.createTime }</td>
						<td>
						<c:if test="${channel.channelType==1 }">
						<a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit add_agent"
							data-channelId3="${channel.channelId }"
							data-channelType3="${channel.channelType }"
							><i
								class="fa fa-edit"></i>新增经纪人</a>
						</c:if>
						<c:if test="${channel.channelType!=1&&channel.channelType!=3 }">
						<a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit add_agent"
							data-channelId3="${channel.channelId }"
							data-channelType3="${channel.channelType }"
							><i
								class="fa fa-edit"></i>新增联系人</a>
						</c:if>
						<%-- <a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit add_agent"
							data-channelId3="${channel.channelId }"><i
								class="fa fa-edit"></i>新增经纪人</a> --%>
						<a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit revise_channel"
							data-page1="${paginator.page}"
							data-channelId="${channel.channelId }"
							data-channelPhone="${channel.channelPhone }"
							data-channelName="${channel.channelName}"
							data-channelEmail="${channel.channelEmail}"
							data-channelLicenceNum="${channel.channelLicenceNum}"
							data-channelAddress="${channel.channelAddress}"
							data-channelType="${channel.channelType}"><i
								class="fa fa-edit"></i>修改</a> 
							<a href="javaScript:void(0);"
							class="btn btn-danger btn-xs delete_product"
							data-page="${paginator.page}"
							data-channelId2="${channel.channelId }"><i
								class="fa fa-trash-o"></i>删除</a>
							</td>
					</tr>
			</c:forEach>

		</c:if>
	</tbody>
</table>


<!-- 修改渠道开始 -->
<div id="add_Pdialog_xg" style="display: none;">
	<form action="" style="margin-right: -26px;">
		<table>
			<tr>
				<td><input type="hidden" id="produpage" value="" /></td>
				<td><input type="hidden" id="channel_Idxg" value="" /></td>
			</tr>
			<tr>
				<td>渠道名称</td>
				<td><input type="text" id="channel_Namexg" maxlength="32" /> <span
					id="spanchannel_Namexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>联系电话</td>
				<td><input type="text" id="channel_phonexg" maxlength="32" /> <span
					id="spanchannel_phonexg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>

			<tr>
				<td>渠道地址</td>
				<td><input type="text" id="channel_Addressxg" maxlength="120" /> <span
					id="spanchannel_Addressxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>渠道邮箱</td>
				<td><input type="text" id="channel_Emailxg" maxlength="120" /> <span
					id="spanchannel_Emailxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<!-- <tr>
				<td>营业执照编号</td>
				<td><input type="text" id="channel_LicenceNumxg" maxlength="120" /> <span
					id="spanchannel_LicenceNumxg"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr> -->
			<tr>
				<td>类型</td>
				<td><select type="select" id="channel_Typexg">
						<option value="1">中介</option>
						<option value="2">第三方团体</option>
						<option value="3">第三方个人</option>
						<option value="4">内部员工</option>
				</select>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_product_surexg">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_product_escxg">取消</a>
	</div>
	 
</div>
<!-- 修改渠道结束 -->
<!--添加渠经纪人开始  -->
<div id="add_agent_pro" style="display: none;">
	<form action="" style="margin-right: 30px;">
		<table>
			<tr>
			<input  type="hidden" id="agent_channel_id" />
			</tr>
			<tr>
				<td id="add_agent_name">经纪人姓名</td>
				<td><input type="text" id="agent_Name" maxlength="32" placeholder="必填"/> <span
					id="spanagent_Name"
					style="display: none; color: red; font-size: 8px">X</span></td>
			</tr>
			<tr>
				<td>联系电话</td>
				<td><input type="text" id="agent_phone" maxlength="32" placeholder="必填" /> <span
					id="spanagent_phone"
					style="display: none; color: red; font-size: 8px">X</span></td>
			</tr>
			<tr>
				<td id="add_agent_email">邮箱</td>
				<td><input type="text" id="agent_email" maxlength="64" placeholder="选填" /> <span
					id="spanagent_email"
					style="display: none; color: red; font-size: 8px">X</span></td>
			</tr>
			<tr>
				<td>备注</td>
				<td><input type="text" id="agent_remark" maxlength="128" placeholder="选填" /> <span
					id="spanagent_remark"
					style="display: none; color: red; font-size: 8px">X</span></td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"	id="formcheck_agent_sure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_agent_esc">取消</a>
	</div>
</div>
<!--添加经纪人结束-->
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/channel/findMyChannel" name="url" />
	<jsp:param value="channel_info_de" name="loadCmp" />
	<jsp:param value="query_info_channel" name="formParam" />
</jsp:include>

<script>
$(function (){
	var channelCurpage=0;
	/*------------------------新增经纪人前，清空原来的数据--------------------------------*/
	$(".add_agent").on('click',function(){
		$("#agent_channel_id").val($(this).attr('data-channelId3'));
		
		var type=$(this).attr('data-channelType3');
		if(type!=1){
			$("#add_agent_name").html("联系人姓名");
			$("#add_agent_email").html("联系人邮箱");
		}else{
			$("#add_agent_name").html("经纪人姓名");
			$("#add_agent_email").html("经纪人邮箱");
		}
		$("#spanagent_Name").hide();
		$("#spanagent_phone").hide();
		$("#agent_Name").val('');
		$("#agent_phone").val('');
		$("#agent_remark").val('');
		$("#add_agent_pro").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false
		});
	});
	$("#formcheck_agent_sure").on('click',function(){
		console.log("添加经纪人开始---")
		var agent_channel_id=$.trim($("#agent_channel_id").val());
		var agent_Name=$.trim($("#agent_Name").val());
		var re=/^[0-9]*[0-9][0-9]*$/;
		var agent_phone=$.trim($("#agent_phone").val());
		var boo0=re.test(agent_phone);
		var agent_remark=$.trim($("#agent_remark").val());
		var boo_1=agent_Name.length>0&&agent_Name.indexOf(" ") == -1;
		var agent_email=$.trim($("#agent_email").val());
		$("#spanagent_Name").hide();
		$("#spanagent_phone").hide();
		if(!boo_1){
			$("#spanagent_Name").show();
			$("#spanagent_Name").html("姓名不能为空");
			return ;
		}
		if(!boo0){
			$("#spanagent_phone").show();
			$("#spanagent_phone").html("手机号格式错误");
			return ;
		}
		if(boo_1&&boo0){
			$.ajax({
				url:"filter/channel/saveNewAgent",
				dataType:"json",
				type:"POST",
				data:{"agentName":agent_Name,
					"agentPhone":agent_phone,
					"remark":agent_remark,
					"agentEmail":agent_email,
					"channelId":agent_channel_id
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						alert("新增成功！");
						$('#add_agent_pro').dialog('destroy');
					}else{
						alert(data.message);
						//$('#add_agent_pro').dialog('destroy');
					}
					console.log("添加经纪人结束---")
				},error : function(data) {
					$('#add_agent_pro').dialog('destroy');
				}});
		}
	});
	
	/*--------------------------关闭增加经纪人弹框----------------------------------*/
	$("#return_agent_esc").on("click",function(){
		$('#add_agent_pro').dialog('destroy');
	});
	/*--------------------------修改渠道----------------------------------*/
	$(".revise_channel").on('click',function(){
		$("#channel_Idxg").val($(this).attr('data-channelId'));
		$("#channel_phonexg").val($(this).attr('data-channelPhone'));
		$("#channel_Namexg").val($(this).attr('data-channelName'));
		$("#channel_Emailxg").val($(this).attr('data-channelEmail'));
		//$("#channel_LicenceNumxg").val($(this).attr('data-channelLicenceNum'));
		$("#channel_Addressxg").val($(this).attr('data-channelAddress'));
		$("#channelTypexg option:selected").val($(this).attr('data-channelType'));
		channelCurpage=$(this).attr('data-page1')-1;
		$("#add_Pdialog_xg").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#add_Pdialog_xg').dialog('destroy');
			}});
	});
	
	/*--------------------------修改渠道提交表单----------------------------------*/
	$("#formcheck_product_surexg").on('click',function(){
		console.log("修改渠道开始---")
		var channel_Name=$.trim($("#channel_Namexg").val());
		var re=/^[0-9]*[0-9][0-9]*$/;
		var channel_phone=$.trim($("#channel_phonexg").val());
		var boo0=re.test(channel_phone);
		var channel_Type=$.trim($("#channel_Typexg option:selected").val());
		var channel_Email=$.trim($("#channel_Emailxg").val());
		var boo_1=channel_Name.length>0&&channel_Name.indexOf(" ") == -1;
		var channel_Address=$.trim($("#channel_Addressxg").val());
		var boo_2=channel_Email.length>0&&channel_Email.indexOf(" ") == -1;
		console.log($("#channel_Name").val())
		console.log(channel_phone)
		console.log(channel_Address)
		console.log(channel_Email)
		console.log(channel_Type)
		console.log(boo0)
		console.log(boo_1)
		console.log(boo_2)
		$("#spanchannel_Namexg").hide();
		$("#spanchannel_Emailxg").hide();
		$("#spanchannel_phonexg").hide();
		$("#spanchannel_Addressxg").hide();
		if(!boo_1){
			$("#spanchannel_Namexg").show();
			return ;
		}
		if(!boo_2){
			$("#spanchannel_Emailxg").show();
			return ;
		}
		if(!boo0){
			$("#spanchannel_phonexg").show();
			return ;
		}
		if(boo_1&&boo_2&&boo0){
			$.ajax({
				url:"filter/channel/saveNewchannel",
				dataType:"json",
				type:"POST",
				data:{
					"channelId":$("#channel_Idxg").val(),
					"channelName":channel_Name,
					"channelPhone":channel_phone,
					"channelAddress":channel_Address,
					"channelEmail":channel_Email,
					"channelType":channel_Type
				},cache:false,
				success:function(data){	
					console.log("修改渠道回调")
					console.log(data.message)
					if(data.message=="true"){
						$("#channelCurpage").val(channelCurpage);
						$('#add_Pdialog_xg').dialog('destroy');
						$('#channel_info_de').load("filter/channel/findMyChannel", $('#query_my_channel').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
						$('#add_Pdialog_xg').dialog('destroy');
					}
					console.log("修改渠道结束---")
				},error : function(data) {
					$('#add_Pdialog_xg').dialog('destroy');
				}});
		}
	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_product_escxg").on("click",function(){
		$('#add_Pdialog_xg').dialog('destroy');
	});
	/*--------------------------删除渠道----------------------------------*/
	$(".delete_product").on("click",function(){
		if(confirm("删除渠道将会导致该渠道所有经纪人被删除，请谨慎操作！确定删除此条记录吗？")){
			console.log("删除渠道")
			var dpage=$(this).attr('data-page')-1;
			$.ajax({
				url:"filter/channel/deleteMyChannel",
				dataType:"json",
				type:"POST",
				data:{
					"channelId":$(this).attr('data-channelId2')
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$("#channelCurpage").val(dpage);
						$('#channel_info_de').load("filter/channel/findMyChannel", $('#query_my_channel').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
					}
					console.log("删除渠道结束---")
				},error : function(data) {
				}
			});
			
		}
		
	});

})
</script>
