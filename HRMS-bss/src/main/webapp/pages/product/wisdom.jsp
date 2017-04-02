<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="class_item_fg">
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" >
	<thead>
			<tr>
			<th class="center">所属项目</th>
            <th class="center">产品名称</th>
           <!--  <th class="center">产品描述</th>
            <th class="center">产品等级</th> 
            <th class="center">产品状态</th>-->
            <th class="center" >产品价格</th>
           <!--  <th class="center">容量</th> -->
            <th class="center">产品状态</th>
            <th class="center">产品生效时间</th>
            <th class="center">产品失效时间</th>
             <th class="center">操作</th>
		</tr>
	</thead>
	<tbody id="queryitem_fy">
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="project">
		<tr>
		   	<td class="center"> ${project.projectName}</td>
			<td class="center">${project.productName}</td>
		<%-- 	<td class="center">${project.productDesc }</td>
			<td class="center">${project.productLevelEnum }</td> 
			<td class="center">${project.statusEnum }</td>--%>
			<td class="center">${project.money  } 元/${project.unitEnum  }</td>
			<%-- <td class="center">${project.capacity }</td> --%>
			<td class="center">${project.statusEnum }</td>
			<td class="center">${project.validDate }</td>
			<td class="center">${project.expireDate }</td>
			  <td><a href="javaScript:void(0);" class="btn btn-info btn-xs revise_prowdom_id "   data-wdomproduct-id="${project.productId}" data-rateid="${project.rateId}" ><i class="fa fa-edit"
			  ></i>修改</a>
                <a href="javaScript:void(0);" class="btn btn-danger btn-xs delete_prodom_id"  data-productwd-Id="${project.productId}"><i class="fa fa-trash-o"></i>删除</a>
		    <a href="javaScript:void(0);" class="btn btn-info btn-xs detail_prowdm_id "   data-detail-id="${project.productId}"  data-page-detail="${paginator.page }"><i class="fa fa-edit"
			  ></i>详情</a>
		    </td>

		</tr>
		</c:forEach>
	</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/product/productwidsomall" name="url"/>
	<jsp:param value="widsom_fy" name="loadCmp"/>
	<jsp:param value="query_widsom_ip" name="formParam"/>
</jsp:include>
   <div id="add_Pdialogdetail" style="display:none;">
   <form style="max-height:390px;overflow-y:auto ">
<table>

 <tr>
 <td>产品名称</td>
         <td><input type="text" disabled="disabled"  id="detail_product" />
         </td>
         </tr>
         <tr>
         <tr>
 <td>等级</td>
         <td><input type="text" disabled="disabled"  id="detail_01" />
         </td>
         </tr>
 <td>隔间座机</td>
         <td><input type="text" disabled="disabled"  id="detail_1" />个/月
         </td>
         </tr>
         <tr>
        <td>黑白A4打印(张/月)</td>
         <td><input type="text" disabled="disabled" id="detail_2" />张/月
       </tr>
       <tr>
     <td>会议室(小时/月)</td>
         <td><input type="text"  disabled="disabled" }"  id="detail_3"/>小时/月
         </td>
         </tr>
         <tr>
       <td>弹性工位(人*天/月)</td>
         <td><input type="text"  disabled="disabled" id="detail_4" />天/月
         </td>
       </tr>
       <tr>
        <td>隔间接入带宽</td>
         <td>
         <input  type="text" disabled="disabled" id="detail_5"></td></tr>
         <tr>
       <td>隔间接入等级</td>
         <td>
       <input type="text" disabled="disabled"  id="detail_6">
     
         </td>
       </tr>
       <tr>
       <td>人均最大同时接入终端数量</td>
         <td><input type="text"  disabled="disabled"  id="detail_7" />
         </td>
         </tr>
       <tr>
        <td>网络双备份 </td><td>
          <input type="text" disabled="disabled" id="detail_8">
         </td>
      </tr>
       <tr>
        <td>个人接入带宽</td>
         <td><input type="text"  disabled="disabled" id="detail_9" />
         </td></tr>
       <tr>
       <td>个人接入等级</td>
         <td>
        <input type="text" disabled="disabled" id="detail_10">
         </td>
      </tr>
       <tr>
        <td>个人最大同时接入终端数量</td>
         <td><input type="text" id="detail_11"  disabled="disabled"  />
         </td>
         </tr>
       <tr>
        <td>无线WIFI网络使用范围 </td>
         <td>
         <input type="text" disabled="disabled"  id="detail_12">
      
         </td>
       </tr>
       <tr>
       <td>办伴APP协同办公</td>
         <td>
         <input type="text" disabled="disabled" id="detail_13">
         </td>
         </tr>
       <tr>
      <td>语音远程会议分钟数</td>
         <td><input type="text" id="detail_14" disabled="disabled14"  />
         </td>
       </tr>
       <tr>
        <td>手机开门</td>
         <td>
              <input type="text" disabled="disabled" id="detail_15">
         </td>
         </tr>
       <tr>
        <td>智能储物柜</td>
         <td>
           <input type="text" disabled="disabled" id="detail_16">
         </td>
      </tr>
    
    </table>
   </form>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formdetail">确定</a>
   </div>

</div>
<script src="js/product/productWidsom.js"></script>
