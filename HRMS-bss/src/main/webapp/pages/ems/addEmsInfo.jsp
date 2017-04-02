<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">消息推送</a></li>
	</ul>
</div>
<input type="hidden" id="sendType"/>
<input type="hidden" id="emsType"/>
<div class="wrapper">
	<div class="push-message">
    	<span>推送消息设置</span>
    </div>
    <div class="message-content clearfix">
    	<div class="push-search-circle">
        	<div class="push-search">
            	<div class="push-search-top">
                	推送查找
                </div>
                <div class="push-search-content">
                	<div class="find-methods clearfix">
                    	<div class="find-methods-left w18">消息内容：</div>
                        <div class="find-methods-right w82">
                        	<textarea class="textarea" id="msgContent" cols="44" rows="3" placeholder="请输入推送消息内容"></textarea>
                        </div>
                    </div>
                    <div class="find-methods clearfix">
                    	<div class="find-methods-left w18">消息类型：</div>
                        <div class="find-methods-right w82">
                        	<div class="please-choose">
                            	<span id="emsType">请选择</span>
                                <img src="img/iconfont-xia.png" class="angle-down">
                            </div>
                            <ul class="person-choose">
                                <li>社区消息</li>
                                <li>系统消息</li>
                                <li>其他消息</li>
                            </ul>
                        </div>
                    </div>
                    <div class="find-methods clearfix">
                    	<div class="find-methods-left w18">推送范围：</div>
                        <div class="find-methods-right w82">
                        	<div class="please-choose">
                            	<span id="sendType">请选择</span>
                                <img src="img/iconfont-xia.png" class="angle-down">
                            </div>
                            <ul class="person-choose">
                                <li>按个人</li>
                                <li>按公司</li>
                                <li>所有会员</li>
                            </ul>
                        </div>
                    </div>
                    <button class="btn-sures" id="fBut">确定</button>
                </div>
            </div>
        </div>
        <div class="push-range">
        	<div class="push-search-top">
                推送范围
            </div>
         	<div class="push-search-content">
                <div class="find-methods clearfix toggle-find-methods">
                    <div class="find-methods-left w25" id="find-methods-left">联系电话：</div>
                    <div class="find-methods-right w75">
                        <input  type="text" id="companyName" class="please-choose click-choose">
                        <a class="ajax-link btn-searchs" id="btn-searchs">搜索</a>
                    </div>
                </div>
                <div class="circle-table" id="tableInfo">
                <table cellpadding="0" cellspacing="0" border="1" class="show-table" id="show-table">
                    <colgroup>
                    	<col width="10%">
                        <col width="30%">
                        <col width="30%">
                        <col width="30%">
                    </colgroup>
                	<thead>
                    	<tr>
                        	<th></th>
                            <th>姓名11111</th>
                            <th>公司1111111</th>
                            <th>联系方式11111</th>
                        </tr>
                    </thead>
                    <tbody id="">
                    	<tr>
                        	<td><input type="checkbox"></td>
                            <td>张三</td>
                            <td>上海博彦科技</td>
                            <td>188888888881</td>
                        </tr>
                    </tbody>
               		 </table>
                </div>
          		<button class="btn-sures" id="seBut">提交</button>
            </div>
        </div>
    </div>
    
<!--温馨提示  -->    
<div class="cover-layer">
    <div class="kindly-reminder">
        <div class="kindly-reminder-top">
        	温馨提示
            <img src="img/wrongs.png">
        </div>
        <p class="kindly-reminder-content">
        	请选择推送范围！
        </p>
    </div>
</div>

</div>
<script id="info2" type="text/x-handlebars-template">
<table cellpadding="0" cellspacing="0" border="1" class="show-table">
 	<colgroup>
	<col width="10%">
    <col width="30%">
    <col width="30%">
    <col width="30%">
	</colgroup>
    <thead>
      <tr>
         <th></th>
         <th>公司名称</th>
         <th>联系地址</th>
         <th>联系电话</th>
      </tr>
     </thead>
<tbody id="ttt">
{{#each this}}
        <tr>
           <td><input type="checkbox" name="infoid" value="{{companyId}}"></td>
           <td>{{companyName}}</td>
           <td>{{companyAddress}}</td>
           <td>{{companyPhone}}</td>
       </tr>                    
{{/each}}
</tbody>
</table>
</script>
<!--个人  -->
<script id="info3" type="text/x-handlebars-template">
<table cellpadding="0" cellspacing="0" border="1" class="show-table">
	<colgroup>
	<col width="10%">
    <col width="30%">
    <col width="30%">
    <col width="30%">
	</colgroup>
    <thead>
      <tr>
         <th></th>
         <th>联系电话</th>
         <th>个人性名</th>
         <th>邮箱地址</th>
      </tr>
     </thead>
<tbody id="ttt">
{{#each this}}
        <tr id="{{userPhone}}">
           <td><input type="checkbox" name="infoid" value="{{userId}}"></td>
           <td>{{userPhone}}</td>
           <td>{{userName}}</td>
           <td>{{userMail}}</td>
       </tr>                    
{{/each}}
</tbody>
</table>
</script>
<link href="css/ems/style.css" rel="stylesheet" type="text/css">
<script src="js/ems/jquery-1.11.1.min.js"></script>
<script src="js/ems/main.js"></script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/ems/addEmsInfo.js"></script>