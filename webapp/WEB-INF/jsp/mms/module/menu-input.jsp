<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/mms-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<title>菜单管理</title>
	<%@ include file="/common/mms-iframe-meta.jsp"%>
	
	<script src="${mmsCtx}/js/menu.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			validate_menu();
			$.extend($.validator, {
				messages: {
					accept: "图片(png,jpg,gif)"
				}
			});
		});
	</script>
	<style type="text/css">
	.form-table-without-border td input{
		width:250px;
	}
	label.error{margin-left: 6px;}
	.form-table-without-border td select{
		width:250px;
	}
	</style>
</head>
<body>
<div class="ui-layout-center">
<div class="opt-body">
	<div class="opt-btn">
		<button class="btn" onclick="save('save');"><span><span>保存</span></span></button>
		<button class="btn" onclick="saveAndEnable();"><span><span >保存并启用</span></span></button>
		<button class="btn" onclick="parent.$.colorbox.close();"><span><span >返回</span></span></button>
	</div>
	<div class="opt-content">
		<div id="message" style="display:none;"></div>
		<div id="msgDiv"></div>
			<form id="menuForm" action="${mmsCtx }/module/menu-save.htm" method="post" name="menuForm" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="parentMenuId" id="parentMenuId" value="${parent.id }">
			<input type="hidden" name="menuId" id="menuId" value="${menuId }">
			<input type="hidden" name="enableState" id="enableState" value="${enableState }"/>
			<input type="hidden" name="choseSystemId" id="choseSystemId" value="${choseSystemId }"/>
			<input type="hidden" name="isCreateSystem" id="isCreateSystem" value="${isCreateSystem }"/>
			<input type="hidden" name="iconName" id="iconName" value="${iconName }"/>
			<input type="hidden" name="imageUrl" id="imageUrl" value="${imageUrl }"/>
				<table class="form-table-without-border" >
					<s:if test="parent!=null">
					<tr id="parentMenuNameTr">
						<td class="content-title" style="width:135px;">父菜单：</td>
						<td class="no-edit">${parentMenuName}</td>
					</tr>
					</s:if>
					<tr>
						<td class="content-title">名称：</td>
						<td><s:textfield  theme="simple" id="name" name="name"  maxlength="64" size="50"></s:textfield><span class="required">*</span></td>
					</tr>
					<tr>
						<td class="content-title">编号：</td>
						<td><input readonly="readonly" id="code" type="text" name="code" value="${code }"/><span class="required">*</span></td>
					</tr>
					<tr>
						<td class="content-title">序号：</td>
						<td><s:textfield  theme="simple" id="serialNumber" name="displayOrder" size="50"  maxlength="9" onkeyup="value=value.replace(/[^\d]/g,'')"></s:textfield><span class="required">*</span></td>
					</tr>
					<tr id="urlTr">
						<td class="content-title">链接地址：</td>
						<td><s:textfield  theme="simple" id="url" name="url"   maxlength="255" size="50"></s:textfield></td>
					</tr>
					<s:if test="parent!=null">
					<tr id="urlParamTr">
						<td class="content-title">地址参数动态获取：</td>
						<td><s:textfield  theme="simple" id="urlParamDynamic" name="urlParamDynamic"   maxlength="150" size="50"></s:textfield><span class="required">RESTful地址</span></td>
					</tr>
					<tr>
						<td class="content-title">是否iframe显示内容：</td>
						<td><select id="iframable" name="iframable">
						<option value="false" <s:if test='!iframable'>selected="selected"</s:if>>否</option>
						<option value="true" <s:if test='iframable'>selected="selected"</s:if>>是</option>
						</select>&nbsp;<span class="required" onclick="alert('内容区是否以iframe方式显示内容，如果是，则页面中iframe的名称默认为contentIframe，如果需要修改请在业务系统的application.properties文件中修改menu.iframe.name的值');">说明</span></td>
					</tr>
					</s:if>
					<tr id="eventTr">
						<td class="content-title">事件：</td>
						<td><s:textfield  theme="simple" id="event" name="event" maxlength="255" size="50"></s:textfield></td>
					</tr>
					<tr id="externalableTr">
						<td class="content-title" style="width:105px;">是否外部系统：</td>
						<td><select name="externalable" id="externalable" onchange="changeExternalable(this);">
						<option value="false" <s:if test='!externalable'>selected="selected"</s:if>>否</option>
						<option value="true" <s:if test='externalable'>selected="selected"</s:if>>是</option>
						</select></td>
					</tr>
					<tr id="autoLoginableTr" <s:if test="!externalable">style="display:none;"</s:if>>
						<td class="content-title">是否单点登录：</td>
						<td><select name="autoLoginable">
						<option value="false" <s:if test='!autoLoginable'>selected="selected"</s:if>>否</option>
						<option value="true" <s:if test='autoLoginable'>selected="selected"</s:if>>是</option>
						</select>&nbsp;<span class="required" onclick="alert('是否单点登录，如果是，则平台会在该菜单的链接地址后添加ticket参数，该菜单对应的系统需要调用iMatrix平台提供的验证ticket是否有效的接口的方法来实现单点登录');">说明</span></td>
					</tr>
					<s:if test="parent!=null">
					<s:if test="selectPlaceholderSign">
					<tr>
						<td class="content-title">是否占位符：</td>
						<td><select id="placeholderSign" name="placeholderSign" onchange="selectPlaceholder();">
						<option value="false" <s:if test='!placeholderSign'>selected="selected"</s:if>>否</option>
						<option value="true" <s:if test='placeholderSign'>selected="selected"</s:if>>是</option>
						</select></td>
					</tr>
					</s:if><s:else>
					<input type="hidden" id="placeholderSign" name="placeholderSign" value="${placeholderSign }"/>
					</s:else>
					</s:if>
					<s:if test="parent==null">
					<tr>
						<td class="content-title">打开方式：</td>
						<td>
							<select name="openWay">
								<s:iterator value="@com.norteksoft.mms.base.OpenWay@values()" var="openWayVar">
									<option <s:if test="#openWayVar==openWay">selected="selected"</s:if> value="${openWayVar}"><s:text name="%{code}"></s:text></option>
								</s:iterator>
							</select>
					</tr>
					<tr>
						<td>当前图标：</td>
						<td><input size="50" id="currentIconName" value="${iconName}" readonly="readonly"/><a class="btn" href="#" onclick="$('#iconName').attr('value','');$('#imageUrl').attr('value','');$('#currentIconName').attr('value','');"><span><span>清空</span></span></a></td>
						<td></td>
					</tr>
					<s:if test="type.code == @com.norteksoft.mms.form.enumeration.MenuType@CUSTOM.code">
						<s:file label="更新图标" accept=".png,.jpg,.gif" size="26" name="file"></s:file>
					</s:if>
					</s:if>
				</table>
		  </form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		selectPlaceholder();
	});
</script>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
</html>
