<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/setting-iframe-meta.jsp"%>
	<title>接口管理</title>
	<script type="text/javascript">
	function showInterface(cellvalue, options, rowObject){
		var v="<a  href=\"#\" hidefocus=\"true\" onclick=\"viewInterface("+rowObject.id+");\">" + cellvalue + "</a>";
		return v;
	}
	function viewInterface(id){
		init_colorbox("${settingCtx}/options/interface-setting-view.htm?id="+id,"普通接口",500,500);
	}

	function createInterface(id){
		var url = "${settingCtx}/options/interface-setting-input.htm";
		if(typeof(id)!="undefined"&&id!=""){
			url=url+"?id="+id;
		}
		init_colorbox(url,"普通接口","","",true,refreshListData);
	}

	function refreshListData(){
		jQuery("#page").trigger("reloadGrid");
	}
	function deleteInterface(){
		var boxes = jQuery("#page").jqGrid("getGridParam",'selarrrow');
		if(boxes==null||boxes==""){
			alert("请选择记录！");
		}else{
			if(confirm("确认删除吗？")){
				$("#ids").attr("value",boxes.join(","));
				ajaxSubmit("defaultForm",webRoot+"/options/interface-setting-delete.htm", "interface-zones",deleteCallback);
			}
		}
	}

	function deleteCallback(){
		showMsg();
		refreshListData();
	}

	function updateInterface(){
		var boxes = jQuery("#page").jqGrid("getGridParam",'selarrrow');
		if(boxes==null||boxes==""){
			alert("请选择记录！");
		}else if(boxes.length>1){
			alert("只能选择一条记录！");
		}else{
			createInterface(boxes[0]);
		}
	}
	function changeInterfaceState(){
		var ids = jQuery("#page").getGridParam('selarrrow');
		if(ids==''||ids==null){
			alert("请选择记录！");
			return;
		}
		if(confirm("确定启用/禁用吗?")){
			$.post(webRoot+"/options/interface-setting-deploy.htm?ids="+ids.join(","), "", function(data) {
            	$("#message").html("<font class=\"onSuccess\"><nobr>"+data+"</nobr></font>");
				showMsg("message");
    			jQuery("#page").jqGrid().trigger("reloadGrid");
    		});
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
			<aa:zone name="interface-zones">
				<div class="opt-btn">
					<button class="btn" onclick="iMatrix.showSearchDIV(this);"><span><span>查询</span></span></button>
						<button class="btn" onclick='createInterface();' ><span><span >新建</span></span></button>
						<button class="btn" onclick="updateInterface();"><span><span >修改</span></span></button>
						<button class='btn' onclick="changeInterfaceState();" ><span><span>启用/禁用</span></span></button>
						<button class="btn" onclick="deleteInterface();"><span><span >删除</span></span></button>
				</div>
				<div id="opt-content" >
						<div id="message" style="display: none;"><s:actionmessage theme="mytheme" /></div>
						<form action="${settingCtx}/options/interface-setting-list-data.htm" name="pageForm" id="pageForm" method="post">
								<view:jqGrid url="${settingCtx}/options/interface-setting-list-data.htm" code="BS_INTERFACE_SETTING" gridId="page" pageName="page"></view:jqGrid>
						</form>
				</div>
			</aa:zone>
		</div>	
	</div>
</body>

</html>