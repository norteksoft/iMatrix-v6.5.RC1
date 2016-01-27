<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
	
	
	<title>收发接口设置新建</title>
	<script type="text/javascript">
	$(document).ready(function(){
		validateSave();
	});
	
	function validateSave(){
		$("#smsSettingForm").validate({
			submitHandler: function() {
				ajaxSubmit("smsSettingForm",webRoot+"/sms/sms-authority-setting-save.htm", "smsSettingZone",saveCallback);
			},
			rules: {
				interCode: "required"
			},
			messages: {
				interCode: "必填"
			}
		});
	}
	
	function saveCallback(){
		showMsg();
		validateSave();
	}
	//保存	
	function submitSetting(){

		var requestType = $('#requestType').val();
		var backUrl = $('#backUrl').val();
		var flag1 = (requestType != null && requestType != '') && (backUrl != null && backUrl != '');
		var flag2 = (requestType == null || requestType == '') && (backUrl == null || backUrl == '');
		if(flag1 || flag2){
			$.ajax({
				   type: "POST",
				   url: webRoot+"/sms/sms-authority-setting-validateCode.htm",//验证唯一性
				   data: "interCode="+$('#interCode').val()+"&id="+$('#id').val(),
				   success: function(msg){
					   if(msg == "true"){
						   alert("该接口编号已存在");
					   }else if(msg == "false"){
						   $("#smsSettingForm").submit();
					   }
				   }
			});
		}else{
			alert("选择请求类型后,回调Url必须同时选择");return;
		}
		

	}
	//选择收发类型，接收时
	function changeType(){
		var type = $('#type').val();
		if(type == '接收'){
			$('#templateCode').attr("disabled","disabled");
			$('#templateCode').attr("style","background: #999999");
		}else{
			$('#templateCode').attr("disabled","");
			$('#templateCode').attr("style","background: #FFFFFF");
		}
	}
	//选择模版
	function selectTemplate(){
		var url = "${settingCtx}/sms/sms-authority-setting-selectTemplate.htm";
		init_colorbox(url,"选择模版",450,300,false,refreshListData);
	}
	//回调
	function refreshListData(){
		jQuery("#page").trigger("reloadGrid");
	}
	</script>
</head>
<body >
<div class="ui-layout-center">
<div class="opt-body">
	<div class="opt-btn">
		<a class="btn" href="#" onclick="submitSetting();"><span><span>保存</span></span></a>
		<a class="btn" href="#" onclick="window.parent.$.colorbox.close();"><span><span>关闭</span></span></a>
	</div>
	<div id="opt-content" >
		<aa:zone name="smsSettingZone">
			<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
			
			<form action="" name="smsSettingForm" id="smsSettingForm" method="post">
				
				<input  type="hidden" name="id" id="id" value="${id}"/>
				<input  type="hidden" name="systemId" id="systemId" value="${systemId}"/>
				
				<table class="form-table-without-border">
				
					<tr>
						<td class="content-title" style="width: 130px;">接口编号：</td>
						<td> 
							<input name="interCode" style="width: 130px;" id="interCode" maxlength="500" value="${interCode }"/> 
							<span class="required">*</span>
							
						</td>
					</tr>
					
					<tr>
						<td class="content-title">收发类型：</td>
						<td> 
							<select name="type" id="type"  style="width: 130px;" onchange="changeType();">
								<option value="发送" <s:if test="'发送' == smsAuthoritySetting.type">selected="selected"</s:if>  >发送</option>
								<option value="接收" <s:if test="'接收' == smsAuthoritySetting.type">selected="selected"</s:if>  >接收</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="content-title" style="width: 130px;">模板编号：</td>
						<td> 
							<input name="templateCode"  id="templateCode" maxlength="500" value="${templateCode }" readonly="readonly" <s:if test="'接收' == smsAuthoritySetting.type">disabled="disabled" style="background: #999999"</s:if>/> 
							<a class="btn" href="#" onclick="selectTemplate();"><span><span>选择模版</span></span></a>
						</td>
					</tr>	
					
					<tr>
						<td class="content-title" style="width: 130px;">请求类型：</td>
						<td> 
							<select name="requestType" id="requestType" >
									<option value="" <s:if test="id == null">selected="selected"</s:if>  >请选择</option>
								
								<s:iterator value="@com.norteksoft.bs.sms.base.enumeration.RequestType@values()" var="var">
									<option value="<s:property value= '#var'/>" <s:if test="#var == smsAuthoritySetting.requestType">selected="selected"</s:if>  >
										<s:if test="#var == @com.norteksoft.bs.sms.base.enumeration.RequestType@HTTP">http请求</s:if>
										<s:elseif test="#var == @com.norteksoft.bs.sms.base.enumeration.RequestType@WEBSERVICE">webservice请求</s:elseif>
										<s:elseif test="#var == @com.norteksoft.bs.sms.base.enumeration.RequestType@RESTFUL">restful请求</s:elseif>
									</option>
								</s:iterator>
							
							</select>
							
						</td>
					</tr>	
					
					
					<tr>
						<td class="content-title" style="width: 130px;">描述：</td>
						<td> 
							<input name="describe" style="width: 200px;" id="describe" maxlength="500" value="${describe }"/> 
						</td>
					</tr>	
					
					<tr>
						<td class="content-title" style="width: 130px;">回调Url：</td>
						<td> 
							<input name="backUrl" style="width: 200px;" id="backUrl" maxlength="250" value="${backUrl }"/> 
							
						</td>
					</tr>	
					
			
					
				</table>
			</form>
		</aa:zone>
	</div>
</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
</html>