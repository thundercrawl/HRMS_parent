<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="class_item_fg">
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" >
	<thead>
		<tr>
            <th class="center">科目名称</th>
            <th class="center">科目类别</th>
            <!-- <th class="center">父类科目</th> -->
            <th class="center">描述</th>
            <th class="center">创建时间</th>
            <th class="center">状态</th>
            <th class="center">创建人</th>
            <th class="center">操作</th>
		</tr>
	</thead>

	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="project">
		<tr>
	
			<td class="center">${project.name }</td>
			<td class="center">${project.typeName }</td>
		<%-- <c:if test="${project.parentCodeId==0 }"><td class="center">顶级科目</td></c:if>
		<c:if test="${project.parentCodeId!=0 }"><td class="center">${project.parentItemName }</td></c:if> --%>
			<td class="center">${project.content }</td>
			<td class="center">${project.createTime }</td>
			<td class="center">${project.statusName }</td>
			<td class="center">${project.operName }</td>
			  <td><a href="javaScript:void(0);" class="btn btn-info btn-xs edit updateitem" 
			  data-itemcode="${project.code}" data-itemname="${project.name}" data-itemclass="${project.type}" 
			  data-itemdesc="${project.content}" data-page="${paginator.page}" data-parent="${project.parentCodeId }"  data-operId="${operId }" data-status="${project.status }">
			  <i class="fa fa-edit"></i>修改</a>
			 <a href="javaScript:void(0);" class="btn btn-info btn-xs edit deleteitem" 
			  data-itemcode="${project.code}" data-itemname="${project.name}" data-itemclass="${project.type}" 
			  data-itemdesc="${project.content}" data-page="${paginator.page}" data-parent="${project.parentCodeId }"  data-operId="${operId }" data-status="${project.status }">
			  <i class="fa fa-edit"></i>删除</a>
</td>
		</tr>
		</c:forEach>
	</c:if>
	
</table>
<input type="hidden" id="curPage" value="${paginator.page}"> 
<jsp:include page="../common/paginator.jsp">

	<jsp:param value="filter/tariff/all" name="url"/>
	<jsp:param value="projectable_item" name="loadCmp"/>
		<jsp:param value="query_item_ip" name="formParam"/>
</jsp:include>
  <div id="add_Pdialog" style="display:none;">
  <form action="" style="margin-right: 10px;">
    <table>
      <tr>
         <td><input type="hidden" id="item_code_add" /></td>
      </tr>
      <tr>
         <td>科目名称</td>
         <td><div><input type="text" id="item_name_add" maxlength="20"/><span id="span_name"  style="display: none;color: red;font-size: 18px">X</span></div></td>
      </tr>
      <tr>
         <td>科目类别</td>
         <td><select type="select" name="Item_type_add" id="Item_type_add">
             <option value="">
             <c:forEach items="${itemtype }" var="ittype">
             <option value="${ittype.typeNum }">${ittype.typeValue }</option>
             </c:forEach>
   </select><span id="span_type"  style="display: none;color: red;font-size: 18px">X</span></td>
   </tr>
   <tr>
<!--    <td>父类科目</td> -->
<!--     <td><select type="select"  id="parent_sec"> -->
<!--        <option value="1"> -->
<!--     </option> -->
<%--     <c:forEach items="${ItemList }" var="parList"> --%>
<%--       <option value="${parList.code }">${parList.name } --%>
<!--     </option> -->
<%--     </c:forEach> --%>
<!--    </select><span id="parent_span"  style="display: none;color: red;font-size: 18px">X</span></td> -->
      </tr>
      <tr><td>描述</td>
      <td>
      <input type="text" id="contentdesc" maxlength="512"><span id="contentspan"  style="display: none;color: red;font-size: 18px">X</span></td>
      </td></tr>
        <tr>
         <td>状态</td>
         <td><select type="select" name="Item_status" id="Item_status" class="Item_status">
             <option value="">
             <c:forEach items="${Itemstatus }" var="itst">
             <option value="${itst.typeNum }">${itst.typeValue }</option>
             </c:forEach>
   </select><span id="span_status"  style="display: none;color: red;font-size: 18px">X</span></td>
   </tr>
   
    </table>
   </form>
   <div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_sure">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="return_esc">取消</a>
		</div>
   
   
   
  </div>
</div>
<script src="js/tariff/tariff.js"></script>