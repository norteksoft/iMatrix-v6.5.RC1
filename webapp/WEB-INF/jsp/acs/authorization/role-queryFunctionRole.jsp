<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/acs-taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
   <head>
	<title><s:text name="role.roleManager"/></title>
    <%@ include file="/common/acs-iframe-meta.jsp"%>
	
	<script src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="${resourcesCtx}/widgets/jstree/jquery.jstree.js"></script>
    <script src="${resourcesCtx}/js/staff-tree.js" type="text/javascript"></script>
	<script src="${resourcesCtx}/js/custom.tree.js" type="text/javascript"></script>
	<link   type="text/css" rel="stylesheet" href="${acsCtx}/css/custom.css" />
	
	<script type="text/javascript">
		function resetInput(){
			$("#function_code").attr("value","");
			$("#function_name").attr("value","");
			$("#function_path").attr("value","");
		}
		function queryFunctionRole(){
			var code=$("#function_code").val().replace(/(^\s*)|(\s*$)/g, "");
			var name=$("#function_name").val().replace(/(^\s*)|(\s*$)/g, "");
			var path=$("#function_path").val().replace(/(^\s*)|(\s*$)/g, "");
			$("#functionCode").attr("value",code);
			$("#functionName").attr("value",name);
			$("#functionPath").attr("value",path);
			$("#ajax_from").attr("action",webRoot+"/authorization/role-queryFunctionRole.action");
			ajaxAnywhere.formName = "ajax_from";
			ajaxAnywhere.getZonesToReload = function() {
				return "acs_content";
			};
			ajaxAnywhere.onAfterResponseProcessing = function () {
				getRoleQueryContentHeight();
			};
			ajaxAnywhere.submitAJAX();
		}
		function getRoleQueryContentHeight(){
			var h = $('.ui-layout-center').height();
			$("#opt-content").css("height",h-80); 
		}
	</script>
	<style type="text/css">
		table.full{ 
			border:1px solid #C5DBEC;
			border-collapse:collapse;
			width:100%;
		}
		table.full thead tr {
			background:url("../../images/ui-bg_glass_85_dfeffc_1x400.png") repeat-x scroll 50% 50% #DFEFFC;
			color:#2E6E9E;
			font-weight:bold;
		}
		td ul{ padding-left: 8px; margin: 2px 0; }
		td ul li{ list-style: none; }
	</style>
</head>

<body>
<div class="ui-layout-center">
			<div class="opt-body">
				<div class="opt-btn">
					资源名称：<input id="function_name" type="text"/>
					资源编码：<input id="function_code" type="text"/>
					资源路径：<input id="function_path" type="text"/>
					<button  class='btn' onclick="queryFunctionRole();"><span><span>查询</span></span></button>
					<button  class='btn' onclick="resetInput();"><span><span>重置</span></span></button>
				</div>
				<form id="ajax_from" name="ajax_from" action="" method="post">
					<input  id="functionCode" name="functionCode" type="hidden" value=""/>
					<input  id="functionName" name="functionName" type="hidden" value=""/>
					<input  id="functionPath" name="functionPath" type="hidden" value=""/>
				</form>
				<div id="opt-content" >
					<aa:zone name="acs_content">
						<div id="result" >
							<s:if test="fvs.size()>0">
									<table border="1" cellpadding="0" cellspacing="0" class="leadTable">
										<thead>
											<tr>
												<th style="text-align:left; padding-left:4px;">资源名称</th>
												<th style="text-align:left; padding-left:4px;">资源编号</th>
												<th style="text-align:left; padding-left:4px;">资源路径</th>
												<th style="text-align:left; padding-left:4px;">资源所属角色</th>
											</tr>
										</thead>
										<tbody>
											<s:iterator value="fvs" var="fv" >
												<tr> 
													<td valign="top">
														<ul style="list-style-type:none;margin:0;padding-left: 0px;">
															<li style="margin: 3px;">${fv.name }</li>
														</ul>
													</td>
													<td valign="top">
														<ul style="list-style-type:none;margin:0;padding-left: 0px;">
															<li style="margin: 3px;">${fv.code }</li>
														</ul>
													</td>
													<td valign="top">
														<ul style="list-style-type:none;margin:0;padding-left: 0px;">
															<li style="margin: 3px;">${fv.path }</li>
														</ul>
													</td>
													<td valign="top">
														<ul style="list-style-type:none;margin:0;padding-left: 0px;">
															<li style="margin: 3px;">${fv.roles }</li>
														</ul>
													</td>
												</tr>
											</s:iterator>
										</tbody>
									</table>
									</s:if>
								</div>
					</aa:zone>
				</div>
			</div>
</div>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/validation/validate-all-1.0.js"></script>
</body>
</html>
	