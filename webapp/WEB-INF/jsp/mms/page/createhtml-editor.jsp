<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/mms-taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
	<%@ include file="/common/mms-iframe-meta.jsp"%>
	
	<link href="${imatrixCtx}/widgets/formeditor/themes/default/default.css" rel="stylesheet" type="text/css" />
	<script src="${imatrixCtx}/widgets/formeditor/kindeditor.js" type="text/javascript"></script>
	<script src="${imatrixCtx}/widgets/formeditor/lang/zh_CN.js" type="text/javascript"></script>
	<script src="${imatrixCtx}/widgets/formeditor/formeditor.js" type="text/javascript"></script>
	<link href="${imatrixCtx}/widgets/formeditor/formeditor.css" rel="stylesheet" type="text/css" />
	<script src="${mmsCtx}/js/formControl.js" type="text/javascript"></script>
	
	<title></title>
	<script>
	
		function submitForm(){
			if($("#fileName").val()==null || $("#fileName").val()==''){
				alert("文件名必填");return ;
			}
			//ajaxSubmit("example","${mmsCtx }/page/createhtml-editor-save.htm", "createHtmlForm",saveCallback);
			var fileName = $("#fileName").val();
			var pageType = $("#pageType").val();
			var inputShowType = $("#inputShowType").val();
			var content = editor1.html();
			$.ajax({
				   type: "POST",
				   url: "${mmsCtx }/page/createhtml-editor-save.htm",
				   data: {content:content,inputShowType:inputShowType,pageType:pageType,fileName:fileName},
				   success: function(msg){
						//下载		
						window.location = "${mmsCtx }/page/download-htmlpage.htm";
				   },
					complete:function(XMLHttpRequest, textStatus){
					  // ajaxSubmit("example","${mmsCtx }/page/createhtml-editor.htm", "createHtmlForm");
					},
			        error:function(){}
			});
			
		}
		function saveCallback(){
			alert(1);
			}
		$(function(){
			callback();
		});
		
		var editor1;
		function callback (){
			var hh = $(window).height();
			var ww = $(window).width()-20;
			editor1 = KindEditor.create('#content', {
               	width:ww,
   				height:hh+50,
   				themeType : 'default',
   				filterMode:false,
   				resizeType: 0 ,
   				items : ['source','undo','redo', 'print', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|',
   							'justifyleft','justifycenter','justifyright','justifyfull','insertorderedlist', 'insertunorderedlist',
   							'indent', 'outdent', 'subscript','superscript', '|','selectall', '-',
   							'fontname', 'fontsize', '|','forecolor', 'hilitecolor','bold', 'italic', 'underline', 'strikethrough', 'removeformat','|',
   							 'table','hr']
   			
               });
		}
	</script>
</head>
<body>
<div class="ui-layout-center">
<div class="opt-body">
	<div class="opt-btn">
		<a class="btn" href="#" onclick="submitForm();"><span><span>生成文件</span></span></a>
	</div>
	<div id="opt-content" >
		<aa:zone name="createHtmlForm">
			<form id="example" name="example" method="post" action="${mmsCtx }/page/createhtml-editor-save.htm">
				<table class="form-table-without-border">
				<tr>
					<td class="content-title" >
						文件名：
					</td>
					<td class="content-title" >
						<input type="text" name="fileName" id="fileName" value="fielName"/>
						<span class="required">*</span>
					</td>
				</tr>
				<tr>
					<td class="content-title" >
						页面类型：
					</td>
					<td class="content-title" >
						<select name="pageType" id="pageType">
							<option value="list">列表页面</option>
							<option value="input" selected="selected">新建/修改页面</option>
							<option value="view" >查看页面</option>
						</select>
					</td>
				</tr>
				<!-- 
				<tr>
					<td class="content-title" >
						生成的文件路径：
					</td>
					<td class="content-title" >
						<input type="text" name="filePath" id="filePath" value="D:\MyToolbox\eclipse3.5\ws\短信平台静态页面\WebContent\cbm_page\WEB-INF\测试表单1"/><span class="required">*</span>
					</td>
				</tr>
				 -->
			
				<tr>
					<td class="content-title" >
						表单页面显示类型：
					</td>
					<td class="content-title" >
						<input type="radio" name="inputShowType" id="inputShowType" value="refresh" checked="checked"/>刷新区域
						<input type="radio" name="inputShowType" id="inputShowType" value="popup"/>弹框
					</td>
				</tr>
				
				
				<tr>
					<td colspan="2" class="content-title" >
						<textarea id="content" name="content" cols="100" rows="8" style="width:1000px;height:400px;visibility:hidden;">
						</textarea>
					</td>
				</tr>
				</table>
				<br />
			</form>
		</aa:zone>
	</div>
</div>
</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
</html>