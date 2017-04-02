<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<link rel="stylesheet" href="css/scene/scene.css">
<link rel="stylesheet" href="css/scene/animate.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/wysiwyg-editor.css" />
<link href="fonts/iconfont.css" rel="stylesheet">
<script src="js/jquery/jquery.form.js"></script>
<script src="js/forum/forumJsp.js"></script>
<script type="text/javascript" src="js/wysiwyg.js"></script>
<script type="text/javascript" src="js/wysiwyg-editor.js"></script>
<script src="js/forum/forum.js"></script>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">辅助发帖</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
			  
    <a href="javaScript:void(0)" id="lookScene" class="btn btn-primary" style="margin-top: -15px;float: right;line-height:normal;">预览</a>
			</div>
			<div class="box-content">
				<div>
<div>
  <div class="input-group col-md-3" style="margin:2px 0;height: 30px;display: inline-table;">
    
    <input type="hidden" id="fonumId" value="${fonum.forumId }">
    <c:if test="${fonum.isforum=='3' }">
      <input type="hidden" id="forum_3" value="3">
    </c:if>
      <c:if test="${fonum.isforum=='4' }">
      <input type="hidden" id="forum_4" value="4">
    </c:if>
    <input type="hidden" id="forumType_f" value="${fonum.forumType }">
    <input type="hidden" id="forumTypeName_f" value="${fonum.forumTypeValue }">
     <input type="hidden" id="textarea_con" value="${fonum.content }">
     <span class="input-group-addon">帖子标题</span>
     <c:if test="${fonum.isforum=='3' }">
       <input type="text" class="form-control" value="${fonum.title }" placeholder="标题名长度在15个字以内" id="title">
     </c:if>
       <c:if test="${fonum.isforum=='2' }">
       <input type="text" class="form-control" placeholder="标题名长度在15个字以内" id="title">
     </c:if>
     <c:if test="${fonum.isforum=='4' }">
       <input type="text" disabled="disabled" class="form-control" value="${fonum.title }" placeholder="标题名长度在15个字以内" id="title">
     </c:if>
  </div>
  <div class="input-group col-md-3 po-relative" style="margin:2px 0;height: 30px;width: 275px;display: inline-table;">
     <span class="input-group-addon">帖子类型</span>
     <input type="text" class="form-control" placeholder="帖子类型" readonly="readonly" id="type">
     <input type="hidden" id="typeid" value="0">
  	  <c:if test="${fonum.isforum!='4' }">
  	   <ul class="project_ul" id="zt-drow"></ul>
     </c:if>
  </div>
  <!-- <div class="input-group col-md-3 po-relative" style="margin: -37px 587px;height: 30px;width: 275px;";display: inline-table;">
     <span class="input-group-addon">帖子标志</span>
     <input type="text" class="form-control" placeholder="帖子标志" readonly="readonly" id="cannotDel">
     <input type="hidden" id="cannotDelid"><input type="hidden" id="boardid" value="1">
  	 <ul class="project_ul" id="cannotDel_ul">
  	    <li dataid="1">不是水贴</li>
  	    <li dataid="0">是水贴</li>
  	 </ul>
  </div> -->
  <!-- <div class="input-group col-md-3 po-relative" style="margin: 50px 31px;height: 30px;width: 275px;";display: inline-table;"> -->
    <div class="input-group col-md-3 po-relative" style="margin:2px 0;height: 30px;width: 275px;display: inline-table;">
     <span class="input-group-addon">是否置顶</span>
         <c:if test="${fonum.isforum=='3' }">
         <c:if test="${fonum.isTop=='0' }">
     <input type="text" class="form-control" placeholder="是" readonly="readonly" id="Top">
     </c:if>
      <c:if test="${fonum.isTop=='1' }">
     <input type="text" class="form-control" placeholder="否" readonly="readonly" id="Top">
     </c:if>
     <input type="hidden" id="topid"><input type="hidden" id="istop" value="${fonum.isTop }">
     <ul class="istop_ul" id="idtop_ul">
  	    <li dataid="0">是</li>
  	    <li dataid="1">否</li>
  	 </ul>
     </c:if>
           <c:if test="${fonum.isforum=='2' }">
     <input type="text" class="form-control" placeholder="否" readonly="readonly" id="Top">
     <input type="hidden" id="topid"><input type="hidden" id="istop" value="1">
     <ul class="istop_ul" id="idtop_ul">
  	    <li dataid="0">是</li>
  	    <li dataid="1">否</li>
  	 </ul>
     </c:if>
      <c:if test="${fonum.isforum=='4' }">
      <c:if test="${fonum.isTop=='0' }">
     <input type="text" class="form-control" placeholder="是" readonly="readonly" id="Top">
     </c:if>
      <c:if test="${fonum.isTop=='1' }">
     <input type="text" class="form-control" placeholder="否" readonly="readonly" id="Top">
     </c:if>
      </c:if>
  </div>

</div>
<div style="margin: 8px 0;">
  <textarea id="editor1" style="height: 60xp;" disabled="disabled"  readonly="readonly" name="editor" placeholder="Type your text here..." ></textarea>
</div>
<div id="Scene_t" style="display: none;margin-left: 50px;" >
  <p>投票选项</p>
  <div class="col-md-6">
    <ul id="Scene_select">
       <c:if test="${fonum.isforum=='2' }">
         <li style="float: left;padding: 0 10px;"><label style="margin-right: 10px;font-weight: normal;">选项1</label><input type="text" class="select_l"></li>
      <li style="float: left;padding: 0 10px;"><label style="margin-right: 10px;font-weight: normal;">选项2</label><input type="text" class="select_l"></li>
       </c:if>
        <c:if test="${fonum.isforum=='3' }">
        <c:forEach items="${fonum.voteItemList }" var="toup" varStatus="toucount">
        <li style="float: left;padding: 0 10px;"><label style="margin-right: 10px;font-weight: normal;">选项${toucount.index+1 }</label><input type="text" value="${toup.voteItem }" class="select_l" data-touid="${toup.voteitemId }"></li>
        </c:forEach>
        </c:if>
          <c:if test="${fonum.isforum=='4' }">
          <c:forEach items="${fonum.voteItemList }" var="toup" varStatus="toucount">
        <li style="float: left;padding: 0 10px;"><label style="margin-right: 10px;font-weight: normal;">选项${toucount.index+1 }</label><input type="text" disabled="disabled" value="${toup.voteItem }" class="select_l" data-touid="${toup.voteitemId }"></li>
        </c:forEach>
          </c:if>
    </ul>
  </div>
  <c:if test="${fonum.isforum=='3' }">
  <input type="hidden" value="${fn:length(fonum.voteItemList)}" id="votesize">
  </c:if>
  <c:if test="${fonum.isforum!='4' }">
   <a href="javaScript:void(0)" class="btn btn-success btn-xs" id="addSelect">添加选项</a>
   </c:if>
</div>
<div id="activity" style="display: none;position:relative;height: 124px;text-align:center">
  <table>
  
     <tr>
       <td>活动时间</td>
       <td>
        <c:if test="${fonum.isforum=='3' }">
       <input type="hidden" value="${fonum.bbsActivityInfo.activityId }" id="activityId">
       		<input placeholder="活动起始时间" readonly="readonly" id="datetimepickerfrom" class="form_datetime" style="float:left;width:49%;margin-right: 1%;" value="${fonum.bbsActivityInfo.startTime }">
      		 <input placeholder="活动截止时间" readonly="readonly" id="date" class="form_datetime" style="width:50%;" value="${fonum.bbsActivityInfo.endTime }">
             </c:if> 
             <c:if test="${fonum.isforum=='2' }">
       		<input placeholder="活动起始时间" readonly="readonly" id="datetimepickerfrom" class="form_datetime" style="float:left;width:49%;margin-right: 1%;" >
      		 <input placeholder="活动截止时间" readonly="readonly" id="date" class="form_datetime" style="width:50%;" >
             </c:if>
             <c:if test="${fonum.isforum=='4' }">
       <input type="hidden" value="${fonum.bbsActivityInfo.activityId }" id="activityId">
       		<input placeholder="活动起始时间" readonly="readonly" disabled="disabled" class="form_datetime" style="float:left;width:49%;margin-right: 1%;" value="${fonum.bbsActivityInfo.startTime }">
      		 <input placeholder="活动截止时间" readonly="readonly" disabled="disabled"  class="form_datetime" style="width:50%;" value="${fonum.bbsActivityInfo.endTime }">
             </c:if>             	   
       </td>
       <td>备注</td>
       <td> 
        <c:if test="${fonum.isforum=='2' }">
       <input type="text" id="timeInfo" style="width:100%;">
       </c:if>
        <c:if test="${fonum.isforum=='3' }">
       <input type="text" id="timeInfo" style="width:100%;" value="${fonum.bbsActivityInfo.activeInfo }">
       </c:if>
         <c:if test="${fonum.isforum=='4' }">
       <input type="text" id="timeInfo" style="width:100%;" disabled="disabled" value="${fonum.bbsActivityInfo.activeInfo }">
       </c:if>
       </td>
       <td>地址</td>
       <td>
          <c:if test="${fonum.isforum=='2' }">
       <input type="text" id="address">
       </c:if>
        <c:if test="${fonum.isforum=='3' }"> 
        <input type="text" id="address" value="${fonum.bbsActivityInfo.address }">
        </c:if>
        <c:if test="${fonum.isforum=='4' }"> 
        <input type="text" id="address" disabled="disabled" value="${fonum.bbsActivityInfo.address }">
        </c:if>
       </td>
     </tr>  
     <tr>
       <td>发起方</td>
       <td>
        <c:if test="${fonum.isforum=='2' }">
       <input type="text" id="hold" style="width:100%;">
           </c:if> 
            <c:if test="${fonum.isforum=='3' }">
       <input type="text" id="hold" style="width:100%;" value="${fonum.bbsActivityInfo.sponsor }">
           </c:if> 
            <c:if test="${fonum.isforum=='4' }">
       <input type="text" id="hold" style="width:100%;" disabled="disabled" value="${fonum.bbsActivityInfo.sponsor }">
           </c:if> 
       </td>
       <td>活动图片</td>
       
       <td>
       <c:if test="${fonum.isforum=='3' }">
       <img alt="" style="height: 40px;width: 40px" src="${fonum.activePic }" id="testtest">
       <input type="hidden" value="${fonum.activePic }" id="picurl_id">
       <div id="testtest1" style="display: none">
        <form action="" id="actpic" style="position: relative;" enctype="multipart/form-data" method="post">
		    <input id='activitys' name="activitys" value="请选择新照片上传" style="width:100%;">
            <input type="file" id="file" name="file" style="width:191px;height:31px;opacity: 0;z-index:999;position: absolute;left: 0;top:2px;" ></td>
           </form>
       </div>
       
       </c:if>
       <c:if test="${fonum.isforum=='4' }">
       <img alt="" style="height: 40px;width: 40px" src="${fonum.activePic }" >
       
       </c:if>
       
          <c:if test="${fonum.isforum=='2' }">
           <form action="" id="actpic" style="position: relative;" enctype="multipart/form-data" method="post">
		    <input id='activitys' name="activitys" value="请选择图片上传" style="width:100%;">
            <input type="file" id="file" name="file" style="width:191px;height:31px;opacity: 0;z-index:999;position: absolute;left: 0;top:2px;" ></td>
           </form>
            </c:if>
           </td>
       <td>活动参与人数</td>
       <td>
         <c:if test="${fonum.isforum=='2' }">
       <input type="text" id="peoplecount">
       </c:if>
         <c:if test="${fonum.isforum=='3' }">
       <input type="text" id="peoplecount" value="${fonum.bbsActivityInfo.activeCount }">
       </c:if>
       <c:if test="${fonum.isforum=='4' }">
       <input type="text" id="peoplecount" disabled="disabled" value="${fonum.bbsActivityInfo.activeCount }">
       </c:if>
       <span id="countspan" style="display: none"><img src="img/delete.png" style="width: 20px;"></span></td>
     </tr>
  </table>
</div>
<div style="margin-top: -4px;text-align: right;">
 <c:if test="${fonum.isforum=='2' }">
  <a href="javaScript:void(0);" class="btn btn-primary sendScene" style="" status="1">发贴</a>
  <a href="javaScript:void(0);" class="btn btn-primary sendScene" status="3">保存到草稿</a>
  </c:if>
   <c:if test="${fonum.isforum=='3' }">
  <a href="javaScript:void(0);" class="btn btn-primary sendScene" style="" status="1" data-picId="${fonum.bbsActivityInfo.picId }" data-activeId="${fonum.bbsActivityInfo.activityId }">发贴</a>
  </c:if>
   <c:if test="${fonum.isforum=='4' }">
  <a href="javaScript:void(0);" class="btn btn-primary returnforum" style="" status="1" data-forumtitle="${forumtitle }"
  data-page="${page }" data-username="${username }" data-companyname="${companyname }" data-fromtime="${fromtime }"
  data-totime="${totime }" data-status="${status }" data-type="${type }">返回</a>
  </c:if>
</div>
</div></div></div></div></div>
<div id="myScene" style="display: none;background-color: white;"> 
<div class="personal-card">
			<div class="personal-header">
				<div class="circle-header">
						<img src="img/header.png" alt="头像">
				</div>
				<div>
				${username}
					<span>10分钟前</span>
					<span>网页设计师，伴办科网页设计师，伴办科技技</span>
				</div>	
			</div>
		<div class="personal-main">
				<h4 class="header-tag">
				<div id="stitle"></div>
				<div class="personal-tag tag-blue" id="stype"></div></h4>
				<p id="scontent">
				</p>
			<div class="personal-bottom">
				<p><span class="font-blue"></span></p>
				<div>
					<p><span class="iconfont icon-xihuan1"></span></p>
					<p><span class="iconfont icon-liulan"></span></p>
				</div>
				<div>
					<span class="iconfont icon-shoucang"></span>
					<span class="iconfont icon-xihuan"></span>
					<span class="iconfont icon-xiaoxi"></span>
				</div>
			</div>
		</div>
</div>
</div>
<div id="activityScene" style="display: none">
<div class="all-content clearfix">
    <div class="activity-date">
        <div class="circle-date">活动日期</div>
        <div class="date-number"></div>
        <div class="date-date"></div>
        <div class="big-circle">
        	<div class="small-circle">
            	未开始
            </div>
        </div>
    </div>
    <div class="activity-content">
        <div class="lecture"></div>
        <div class="placement">
            <p class="poster"></p>
        </div>
        <p class="three-words" id="Stime"></p>
        <p class="three-words" id="Saddress"></p>
        <p class="three-words" id="Shold"></p>
        <div class="people-number"></div>
    </div>
</div>

</div>
 <div id="add_Pdialog" style="display:none;">
    <form action="" id="actpic" style="position: relative;" enctype="multipart/form-data" method="post">
		    <input id='activitys' name="activitys" value="请选择图片上传" style="width:100%;">
            <input type="file" id="file" name="file" style="width:191px;height:31px;opacity: 0;z-index:999;position: absolute;left: 0;top:2px;" ></td>
           </form>
   <div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_sure">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="return_esc">取消</a>
		</div>
   
   
   
  </div>

