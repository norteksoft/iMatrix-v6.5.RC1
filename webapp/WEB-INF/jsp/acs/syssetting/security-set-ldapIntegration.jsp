<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/acs-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/acs-iframe-meta.jsp"%>
	<title>参数设置</title>
	<script type="text/javascript">
	$().ready(function(){
		if("${serverConfig.synLdapInvocation}"=="true"){
			$(".opt-btn").append("<button class='btn' onclick='synClick();' id='sysBtn'><span><span>同步组织结构</span></span></button>");
		}
		validateLdap();
	});

	function validateLdap(){
		$("#inputForm").validate({
			submitHandler: function() {
				if($("#synInvocation1").attr("checked")){
					$("#synInvocation").attr("value","true");
				}else{
					$("#synInvocation").attr("value","false");
				}
				if($("#ldapInvocation1").attr("checked")){
					$("#ldapInvocation").attr("value","true");
				}else{
					$("#ldapInvocation").attr("value","false");
				}
				if($("#ldapInvocation1").attr("checked")){
					loginInvocationCheck("ldap");
				}else{
					 var url = $("#inputForm").attr("action");
					ajaxSubmit("inputForm",url,"acs_content",saveCallback);
				}
			},
			rules: {
				ldapUsername: "required",
				ldapPassword: "required",
				ldapUrl: "required",
				ldapBaseDomain: "required"
		     },
			 messages: {
		    	ldapUsername: "必填",
		    	ldapPassword: "必填",
		    	ldapUrl: "必填",
		    	ldapBaseDomain: "必填"
			}
		});
	}

	function saveCallback(){
		showMsg();
		validateLdap();
	}

	function save(){
		$('#inputForm').attr("action","${acsCtx}/syssetting/integration-save.htm");
		$('#inputForm').submit();
	}

	function synInvocationClick(){
		$("#sysBtn").remove();
		if($("#synInvocation1").attr("checked")){
			$(".opt-btn").append("<button class='btn' onclick='synClick();' id='sysBtn'><span><span>同步组织结构</span></span></button>");
		}
	}

	function synClick(){
		init_colorbox(webRoot+"/syssetting/integration-showSynUserInfo.htm?id="+$("#serverConfigId").val(),"同步用户信息","300","400");
	}

	function ldapExample(){
		var ldapType=$("#ldapType").val();
		if("DOMINO"==ldapType){
			$("#ldapUsernameSpan").html("例如：cn=admin");
			$("#ldapBaseDomainSpan").html("例如：o=norteksoft");
		}else if("WINDOWS_AD"==ldapType){
			$("#ldapUsernameSpan").html("例如：cn=andmin,cn=users,dc=norteksoft,dc=com");
			$("#ldapBaseDomainSpan").html("例如：cn=users,dc=norteksoft,dc=com");
		}else{
			$("#ldapUsernameSpan").html("例如：uid=admin,ou=system");
			$("#ldapBaseDomainSpan").html("例如：dc=norteksoft,dc=com");
		}
	}
</script>
</head>
<body>
<div class="ui-layout-center" style="height: 1000px;">
	<div class="opt-body">
		<div class="opt-btn">
			<button class='btn' onclick="save();"><span><span>保存</span></span></button>
		</div>
		<aa:zone name="acs_content">
		<div id="message"><s:actionmessage theme="mytheme"/></div>
			<div id="opt-content">
			<form id="inputForm" name="inputForm" action="" method="post">
			<input  type="hidden" name="id" size="40" id="serverConfigId" value="${serverConfig.id}" />
			<input  type="hidden" name="type" size="40" value="ldap" />
			<input  type="hidden" name="oldInvocationType" id="oldInvocationType"/>
			<input  type="hidden" name="synLdapInvocation" id="synInvocation" size="40" value="${serverConfig.synLdapInvocation}" />
			<input  type="hidden" name="ldapInvocation" id="ldapInvocation" size="40" value="${serverConfig.ldapInvocation}" />
				<table class="form_table1">
					<tr>
						<td style="width: 130px;">操作：</td>
						<td>
							<input type="checkbox" id="synInvocation1"  <s:if test="serverConfig.synLdapInvocation">checked="checked"</s:if> onclick="synInvocationClick();"/>是否同步组织结构
							<input type="checkbox" id="ldapInvocation1"   <s:if test="serverConfig.ldapInvocation">checked="checked"</s:if>/>是否开启单点登陆
						</td>
					</tr>
					<tr>
						   <td >LDAP服务器类别：</td>
						   <td>
						   <select id="ldapType" name="ldapType" onchange="ldapExample();">
						    <option value="APACHE" <s:if test="serverConfig.ldapType==@com.norteksoft.acs.entity.sysSetting.LdapType@APACHE"> selected="selected" </s:if> >apache</option>
						    <option value="DOMINO" <s:if test="serverConfig.ldapType==@com.norteksoft.acs.entity.sysSetting.LdapType@DOMINO"> selected="selected" </s:if> >domino</option>
						    <option value="WINDOWS_AD" <s:if test="serverConfig.ldapType==@com.norteksoft.acs.entity.sysSetting.LdapType@WINDOWS_AD"> selected="selected" </s:if> >windowsAD</option>
						   </select>
						   </td>
					</tr>
					 <tr>
						   <td>登录名：</td>
						   <td>
						     <input  type="text" id="ldapUsername" name="ldapUsername"  value="${serverConfig.ldapUsername}" style="width: 200px;"/>
						     <span id="ldapUsernameSpan" style="color: red;"></span>
						   </td>
					 </tr>
					<tr>
							<td >登录密码：</td>
							<td >
							<input type="password" id="ldapPassword" name="ldapPassword"  value="${serverConfig.ldapPassword}" style="width: 200px;"/>
							</td>
					</tr>
					<tr>
							<td >LDAP服务器地址：</td>
							<td>
								<input type="text" id="ldapUrl" name="ldapUrl"  value="${serverConfig.ldapUrl}" style="width: 200px;" maxlength="150"/>
							</td>
					</tr>
					<tr>
							<td >基础域配置：</td>
							<td>
								<input type="text" id="ldapBaseDomain" name="ldapBaseDomain"  value="${serverConfig.ldapBaseDomain}" style="width: 200px;" maxlength="150"/>
								<span id="ldapBaseDomainSpan" style="color: red;"></span>
							</td>
					</tr>
					<tr>
							<td >前缀：</td>
							<td>
								<input type="text" id="ldapPrefix" name="ldapPrefix"  value="${serverConfig.ldapPrefix}" style="width: 200px;" maxlength="150"/>
							</td>
					</tr>
					<tr>
							<td >后缀：</td>
							<td>
								<input type="text" id="ldapSuffix" name="ldapSuffix"  value="${serverConfig.ldapSuffix}" style="width: 200px;" maxlength="150"/>
							</td>
					</tr>
					 <tr>
						 <td></td>
						 <td  style="display: none" colspan="3" id="warn">
						 <font color="red"><s:text name="syssetting.prompt"/></font>
						 </td>
					 </tr>
					 <tr>
						 <td></td>
					     <td  style="display: none" colspan="3" id="warn2">
					     <font color="red"><s:text name="syssetting.passwordSecondDanger"/></font>
				    	 </td>
					 </tr>
					 <tr>
						 <td></td>
						 <td  style="display: none" colspan="3" id="warn3">
						 <font color="red"><s:text name="syssetting.passwordLightDanger"/></font>
					 	</td>
					 </tr>
				</table>
			</form>
			</div>
			<script type="text/javascript">
				$(function(){
					ldapExample();
				});
			</script>
		</aa:zone>
	</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
</html>
