<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<title>定时设置</title>
</head>
<body onload="getContentHeight();">
<div class="ui-layout-center">
<div class="opt-body">
	<div id="opt-content" >
		<aa:zone name="datasource-zones">
			<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
			<form action="" name="jobInfoFrom" id="jobInfoFrom" method="post">
				<input  type="hidden" name="id" id="id" value="${id}"/>
				<table class="form-table-without-border">
						<tr>
							<td class="content-title" style="width: 140px;">编码：</td>
							<td > ${code }</td>
						</tr>
						<tr>
							<td class="content-title" >名称：</td>
							<td> ${name }</td>
						</tr>	
						<tr>
							<td class="content-title">数据源引用：</td>
							<td>
								${datasourceCode }
							</td>
						</tr>
						<tr>
							<td class="content-title" >邮件提醒人:</td>
							<td > <textarea rows="5" cols="5"  readonly="readonly" style="width: 280px;">${emails }</textarea></td>
						</tr>
						<tr>
							<td class="content-title" >RTX提醒人:</td>
							<td> <textarea rows="5" cols="5"  readonly="readonly" style="width: 280px;"> ${rtxAccounts}</textarea></td>
						</tr>
						<tr>
							<td class="content-title" >短信提醒人:</td>
							<td>  <textarea rows="5" cols="5"  readonly="readonly" style="width: 280px;">${phoneReminderNums}</textarea></td>
						</tr>
						<tr>
							<td class="content-title" >办公助手提醒人:</td>
							<td > <textarea rows="5" cols="5"  readonly="readonly" style="width: 280px;">${officeHelperReminderNames}</textarea></td>
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
							<td class="content-title" >说明：</td>
							<td> <textarea rows="5" cols="5"  readonly="readonly" style="width: 280px;">${remark }</textarea></td>
						</tr>	
					</table>
			</form>
		</aa:zone>
	</div>
</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
</html>