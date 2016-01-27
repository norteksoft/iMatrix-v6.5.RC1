<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
	
	
	<title>定时设置</title>
	<script type="text/javascript">
	$(document).ready(function(){
		validateDatasource();
	});
	
	function validateDatasource(){
		$("#jobInfoFrom").validate({
			submitHandler: function() {
				ajaxSubmit("jobInfoFrom",webRoot+"/options/datasource-setting-save.htm", "datasource-zones",saveCallback);
			},
			rules: {
				code: "required",
				driveName: "required",
				userName: "required",
				dataBaseUrl:"required"
			},
			messages: {
				code: "必填",
				driveName: "必填",
				userName: "必填",
				dataBaseUrl: "必填"
			}
		});
	}
	function saveCallback(){
		showMsg();
		validateDatasource();
	}

	//小窗体是否存在
	function isDatasourceExist(){
		$.ajax({
			   type: "POST",
			   url: webRoot+"/options/datasource-setting-validate-code.htm",
			   data: "datasourceCode="+$("#code").attr("value")+"&id="+$($("form[id='jobInfoFrom']").find("input[id='id']")[0]).attr("value"),
			   success: function(msg){
				   if(msg=="true"){
					  alert("该数据源编号已存在");
				   }else{
					   $("#jobInfoFrom").submit();
				   }
			   }
		});
	}
	
	function submitDatasource(){
		if($("#code").attr("value")==""){
			$("#jobInfoFrom").submit();
		}else{
			isDatasourceExist();
		}
	}
	function testDatasource(){
		var testSql = $("#testSql").attr("value");
		var driveName=$("#driveName").attr("value");
		if("other.jdbc.Driver"==$("#driveName").attr("value")){
			if($("#otherDriveName").attr("value")==""){
				alert("请填写数据源驱动");
				return;
			}
			driveName=$("#otherDriveName").attr("value");
		}
		$.ajax({
			   type: "POST",
			   url: webRoot+"/options/datasource-setting-test.htm",
			   data: "dataBaseUrlTest="+$("#dataBaseUrl").attr("value")+"&userNameTest="+$("#userName").attr("value")+"&dataBasePasswordTest="+$("#dataBasePassword").attr("value")+"&driveNameTest="+driveName+"&testSqlTest="+testSql,
			   success: function(msg){
				   if(msg=="true"){
					  alert("测试成功");
				   }else{
					  var errorMsg = msg.substring(msg.indexOf(";")+1);
					  alert("测试失败："+errorMsg);
				   }
			   }
		});
	}

	function selectDriverName(obj){
		if("com.microsoft.sqlserver.jdbc.SQLServerDriver"==$(obj).val()){
			$("#dataBaseUrl").attr("value","jdbc:sqlserver://ip地址:1433;database=数据库");
			$("#driveName").attr("name","driveName");
			$("#otherDriveName").hide();
			$("#otherDriveNameSpan").hide();
			$("#otherDriveName").attr("value","");
			$("#otherDriveName").attr("name","");
		}else if("com.mysql.jdbc.Driver"==$(obj).val()){
			$("#dataBaseUrl").attr("value","jdbc:mysql://ip地址:3306/数据库");
			$("#driveName").attr("name","driveName");
			$("#otherDriveName").hide();
			$("#otherDriveNameSpan").hide();
			$("#otherDriveName").attr("value","");
			$("#otherDriveName").attr("name","");
		}else if("other.jdbc.Driver"==$(obj).val()){
			$("#otherDriveName").show();
			$("#otherDriveNameSpan").show();
			$("#otherDriveName").attr("name","driveName");
			$("#otherDriveName").attr("value","");
			$("#driveName").attr("name","");
			$("#dataBaseUrl").attr("value","");
		}else{
			$("#dataBaseUrl").attr("value","jdbc:oracle:thin:@ip地址:1521:数据库");
			$("#driveName").attr("name","driveName");
			$("#otherDriveName").hide();
			$("#otherDriveNameSpan").hide();
			$("#otherDriveName").attr("value","");
			$("#otherDriveName").attr("name","");
		}
	}
	</script>
</head>
<body onload="">
<div class="ui-layout-center">
<div class="opt-body">
	<div class="opt-btn">
		<a class="btn" href="#" onclick="testDatasource();"><span><span>连接测试</span></span></a>
		<a class="btn" href="#" onclick="submitDatasource();"><span><span>保存</span></span></a>
		<a class="btn" href="#" onclick="window.parent.$.colorbox.close();"><span><span>关闭</span></span></a>
	</div>
	<div id="opt-content" >
		<aa:zone name="datasource-zones">
			<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
			<form action="" name="jobInfoFrom" id="jobInfoFrom" method="post">
				<input  type="hidden" name="id" id="id" value="${id}"/>
				<table class="form-table-without-border">
						<tr>
							<td class="content-title">数据源编号：</td>
							<td> <input name="code" id="code" maxlength="30" value="${code }"/> <span class="required">*</span></td>
						</tr>
						<tr>
							<td class="content-title" style="width: 90px;">数据源驱动：</td>
							<td> 
							<select id="driveName" name="driveName" onchange="selectDriverName(this);" style="width:302px;">
								<option value="oracle.jdbc.driver.OracleDriver" <s:if test="driveName=='oracle.jdbc.driver.OracleDriver'">selected="selected"</s:if>>oracle.jdbc.driver.OracleDriver</option>
								<option value="com.microsoft.sqlserver.jdbc.SQLServerDriver" <s:if test="driveName=='com.microsoft.sqlserver.jdbc.SQLServerDriver'">selected="selected"</s:if>>com.microsoft.sqlserver.jdbc.SQLServerDriver</option>
								<option value="com.mysql.jdbc.Driver" <s:if test="driveName=='com.mysql.jdbc.Driver'">selected="selected"</s:if>>com.mysql.jdbc.Driver</option>
								<option value="other.jdbc.Driver" <s:if test="driveName!='com.mysql.jdbc.Driver' && driveName!='oracle.jdbc.driver.OracleDriver' && driveName!='com.microsoft.sqlserver.jdbc.SQLServerDriver'">selected="selected"</s:if>>其他</option>
							</select>
							<span class="required">*</span>
							<br/>
							<input style="width:300px;display: none;margin-top: 2px;" id="otherDriveName" maxlength="100" value="${driveName }"/>
							<span style="display: none;" id="otherDriveNameSpan" class="required">*</span>
							</td>
						</tr>	
						<tr>
							<td class="content-title">数据源地址：</td>
							<td>
								<input style="width:300px;"  name="dataBaseUrl" id="dataBaseUrl" maxlength="100" value="${dataBaseUrl }"/><span class="required">*</span>
							</td>
						</tr>
						<tr>
							<td class="content-title">用户名：</td>
							<td>
								<input  name="userName" id="userName" maxlength="30" value="${userName }"/><span class="required">*</span>
							 </td>
							<td></td>
						</tr>
						<tr>
							<td class="content-title">密码：</td>
							<td>
								<input type="password" name="dataBasePassword" id="dataBasePassword" value="${dataBasePassword }"/>
							 </td>
						</tr>
						<tr>
							<td class="content-title">创建人：</td>
							<td>
								${creatorName }
							 </td>
							<td></td>
						</tr>
						<tr>
							<td class="content-title">创建时间：</td>
							<td>
							<s:date name="createdTime"  format="yyyy-MM-dd HH:mm" />
							 </td>
						</tr>
						<tr>
							<td class="content-title" style="width: 90px;">说明：</td>
							<td><textarea rows="5" cols="15" name="remark" onkeyup="javascript:if(this.value.length >=120){this.value=this.value.slice(0,120);alert('字符不能超过120');return false;}">${remark }</textarea></td>
						</tr>	
					</table>
			</form>
			<script type="text/javascript">
				$(document).ready(function(){
					if('${driveName}'!='com.mysql.jdbc.Driver' && '${driveName}'!='oracle.jdbc.driver.OracleDriver' && '${driveName}'!='com.microsoft.sqlserver.jdbc.SQLServerDriver'){
						$("#otherDriveName").show();
						$("#otherDriveNameSpan").show();
						$("#otherDriveName").attr("name","driveName");
						$("#driveName").attr("name","");
					}
				});
			</script>
	
		</aa:zone>
	</div>
</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
</html>