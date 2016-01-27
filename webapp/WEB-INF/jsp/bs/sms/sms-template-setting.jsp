<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<title>短信模版设置</title>
	<script type="text/javascript">
	//新建
	function createSmsTemplateSet(){
		var url = "${settingCtx}/sms/sms-template-setting-input.htm";
		init_colorbox(url,"短信模板设置新建",600,350,true,refreshListData);
	}
	//回调
	function refreshListData(){
		jQuery("#page").trigger("reloadGrid");
	}

	//删除
	function deleteSmsTemplateSet(){
		var boxes = jQuery("#page").jqGrid("getGridParam",'selarrrow');
		if(boxes==null || boxes==""){
			alert("请选择记录！");
		}else{
			if(confirm("确认删除吗？")){
				$("#ids").attr("value",boxes.join(","));
				ajaxSubmit("defaultForm",webRoot+"/sms/sms-template-setting-delete.htm", "defaultZone",deleteCallback);
			}
		}
	}
	//删除回调
	function deleteCallback(){
		showMsg();
		refreshListData();
	}
	//修改
	function updateSmsTemplateSet(){
		var boxes = jQuery("#page").jqGrid("getGridParam",'selarrrow');
		if(boxes==null || boxes==""){
			alert("请选择记录！");
		}else if(boxes.length > 1){
			alert("只能选择一条记录！");
		}else{
			var url = "${settingCtx}/sms/sms-template-setting-input.htm?id="+boxes[0];
			init_colorbox(url,"短信模版设置修改",600,350,true,refreshListData);
		}
	}
	</script>
</head>

<body>
	<div class="ui-layout-center">
		<div class="opt-body">
			<form action="" name="defaultForm" id="defaultForm" method="post">
				<input name="ids" id="ids" type="hidden"></input>
			</form>
			<aa:zone name="defaultZone">
				<div class="opt-btn">
					<button class="btn" onclick="iMatrix.showSearchDIV(this);"><span><span>查询</span></span></button>
						<button class="btn" onclick='createSmsTemplateSet();' ><span><span >新建</span></span></button>
						<button class="btn" onclick="updateSmsTemplateSet();"><span><span >修改</span></span></button>
						<button class="btn" onclick="deleteSmsTemplateSet();"><span><span >删除</span></span></button>
				</div>
				<div id="opt-content" >
						<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
						<form action="${settingCtx}/sms/sms-template-setting.htm" name="pageForm" id="pageForm" method="post">
								<view:jqGrid url="${settingCtx}/sms/sms-template-setting.htm" code="BS_SMS_TEMPLATE_SETTING" gridId="page" pageName="page"></view:jqGrid>
						</form>
				</div>
			</aa:zone>
		</div>	
	</div>
</body>

</html>