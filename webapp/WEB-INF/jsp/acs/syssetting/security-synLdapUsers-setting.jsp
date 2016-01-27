<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/acs-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/acs-iframe-meta.jsp"%>
	<title>参数设置</title>
	<script type="text/javascript">

	function synOrg(){
		$("#synType").val(getSynType());
		$("#synLdapUserInfo").val(getSynUserInfo());
		ajaxSubmit("inputForm","${acsCtx}/syssetting/integration-sysOrg.htm","acs_content",showMsg);
	}
	
	function getSynType(){
		var synUserRadio = $("input[name='synUser']:checked");
		return $(synUserRadio).val();
	}

	function selectUserInfo(obj){
		var synType = getSynType();
		var isChecked = $(obj).attr("checked");
		if(isChecked&&synType=="synSelectUserInfo"){
			$("#userInfoTable").css("display","block");
		}else{
			$("#userInfoTable").css("display","none");
		}
	}
	
	function getSynUserInfo(){
		var userInfos = "";
		var checkedUserInfo = $("input[name='userInfo']:checked");
		for(var i=0;i<checkedUserInfo.length;i++){
			userInfos = userInfos+$(checkedUserInfo[i]).val()+",";
		}
		return userInfos;
	}
</script>
</head>
<body>
<div class="ui-layout-center" style="height: 1000px;">
	<div class="opt-body">
		<div class="opt-btn">
			<button class='btn' onclick="synOrg();"><span><span>同步</span></span></button>
		</div>
		<aa:zone name="acs_content">
		<div id="message"><s:actionmessage theme="mytheme"/></div>
		</aa:zone>
			<div id="opt-content">
			<form id="inputForm" name="inputForm" action="" method="post">
			<input  type="hidden" name="id" size="40" value="${id }" />
			<input  type="hidden" name="type" size="40" value="ldap" />
			<input  type="hidden" name="synType" id="synType"  />
			<input  type="hidden" name="synLdapUserInfo" id="synLdapUserInfo"  />
				<table class="form_table1">
					<tr>
					   <td ><input type="radio" id="synAllUser"  name="synUser"   value="synAllUser"  onclick="selectUserInfo(this);"  checked="checked" title="更新所有用户信息，系统中已存在的用户再次同步时做更新操作"/>更新所有用户信息</td>
					</tr>
					<tr>
						<td><input type="radio" id="onlySynAdd"  name="synUser" value="onlySynAdd"  onclick="selectUserInfo(this);"  title="只更新增加的用户信息，系统中已存在的用户不再更新"/>只更新增加的用户信息</td>
					</tr>
					 <tr>
					   <td ><input type="radio" id="synSelectUserInfo" name="synUser"  value="synSelectUserInfo"  onclick="selectUserInfo(this);"  title="更新选中的用户的信息，系统中已存在的用户再次同步时做更新操作"/>更新用户信息</td>
					 </tr>
				</table>
				<table class="form_table1" id="userInfoTable" style="display: none;">
					<tr>
						<td ><input type="checkbox" value="userName"  name="userInfo"/>姓名</td>
					</tr>
					<tr>
						<td ><input type="checkbox" value="mainDept"  name="userInfo" />正职部门</td>
					</tr>
					<tr>
						<td ><input type="checkbox" value="email"   name="userInfo"/>邮箱</td>
					</tr>
					<tr>
						<td ><input type="checkbox" value="telephone"   name="userInfo"/>电话</td>
					</tr>
				</table>
			</form>
			</div>
		
	</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
</html>
