<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
	
	
	<title>短信模板设置新建</title>
	<script type="text/javascript">
	$(document).ready(function(){
		validateSave();
	});
	
	function validateSave(){
		$("#smsTemplateSettingForm").validate({
			submitHandler: function() {
				ajaxSubmit("smsTemplateSettingForm",webRoot+"/sms/sms-template-setting-save.htm", "smsTemplateSettingZone",saveCallback);
			},
			rules: {
				templateCode: "required",
				templateName: "required"
			},
			messages: {
				templateCode: "必填",
				templateName: "必填"
			}
		});
	}
	
	function saveCallback(){
		showMsg();
		validateSave();
	}
	//保存	
	function submitSmsTemplateSetting(){
		$.ajax({
			   type: "POST",
			   url: webRoot+"/sms/sms-template-setting-validateCode.htm",//验证唯一性
			   data: "templateCode="+$('#templateCode').val()+"&id="+$('#id').val(),
			   success: function(msg){
				   if(msg == "true"){
					  alert("该模版编号已存在");
				   }else if(msg == "false"){
					   $("#smsTemplateSettingForm").submit();
				   }
			   }
		});

	}
	function andParamForTemplate(){
		var  templateName = $('#templateName').val();
		$('#templateName').attr("value",templateName + "##");
	}
	</script>
</head>
<body onload="">
<div class="ui-layout-center">
<div class="opt-body">
	<div class="opt-btn">
		<a class="btn" href="#" onclick="submitSmsTemplateSetting();"><span><span>保存</span></span></a>
		<a class="btn" href="#" onclick="window.parent.$.colorbox.close();"><span><span>关闭</span></span></a>
	</div>
	<div id="opt-content" >
		<aa:zone name="smsTemplateSettingZone">
			<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
			
			<form action="" name="smsTemplateSettingForm" id="smsTemplateSettingForm" method="post">
				
				<input  type="hidden" name="id" id="id" value="${id}"/>
				
				<table class="form-table-without-border">
					<tr>
						<td class="content-title">模板编号：</td>
						<td> <input name="templateCode" id="templateCode" maxlength="50" value="${templateCode }" style="width:300px;"/> <span class="required">*</span></td>
					</tr>
					<tr>
						<td class="content-title" style="width: 130px;">模板内容：</td>
						<td> 
							
							<textarea name="templateName" cols="10" rows="7" id="templateName"   style="border: 1 solid #888888;LINE-HEIGHT:18px;padding: 3px;width:300px;">${templateName }</textarea>
					 		<span class="required">*</span>
						</td>
					</tr>	

					<tr>
						<td colspan="2">
							<span style= "color:red">注：模版中参数请用字符#param#代替</span>
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