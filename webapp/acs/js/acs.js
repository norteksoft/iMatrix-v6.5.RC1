function demonstrateOperate(){
		alert("为确保系统的正常演示，屏蔽了该功能");
	}

//是否开启单点登录设置时，四种方式中只能有一种是启用的状态
function loginInvocationCheck(type){
	var loginType = "";
	if(type=="ldap"){
		if($("#ldapInvocation1").attr("checked")){
			loginType = "ldap";
		}
	}else if(type=="rtx"){
		if($("#rtxInvocation1").attr("checked")){
			loginType = "rtx";
		}
	}else if(type=="other"){
		if($("#externalInvocation1").attr("checked")){
			loginType = "other";
		}
	}
	if(loginType!=""){
		$.ajax({
			   type: "POST",
			   url: webRoot+"/syssetting/validate-loginInvocation.htm",
			   data:{type:loginType},
			   success: function(data, textStatus) {
				   if(data=="success"){
					   var url = $("#inputForm").attr("action");
		    			ajaxSubmit("inputForm",url,"acs_content",saveCallback);
				   }else if(data=="ldap"){
					   if(confirm("ldap集成方式中已经启用了单点登录，确认开启当前集成方式的单点登录吗？")){
						   saveWithLoginInvocation(data);
					   }else{
						   saveWithoutLoginInvocation(loginType);
					   }
				   }else if(data=="rtx"){
					   if(confirm("rtx集成方式中已经启用了单点登录，确认开启当前集成方式的单点登录吗？")){
						   saveWithLoginInvocation(data);
					   }else{
						   saveWithoutLoginInvocation(loginType);
					   }
				   }else if(data=="other"){
					   if(confirm("其他集成方式中已经启用了单点登录，确认开启当前集成方式的单点登录吗？")){
						   saveWithLoginInvocation(data);
					   }else{
						   saveWithoutLoginInvocation(loginType);
					   }
				   }
		      },
		      error : function(XMLHttpRequest, textStatus) {
					alert(textStatus);
				}
		  }); 
	}
}

function saveWithoutLoginInvocation(type){
	if(type=="ldap"){
		 $("#ldapInvocation").attr("value","false");
	}else if(type=="rtx"){
		$("#rtxInvocation").attr("value","false");
	}else if(type=="other"){
		$("#externalInvocation").attr("value","false");
	}
	$("#oldInvocationType").attr("value","");
   var url = $("#inputForm").attr("action");
	ajaxSubmit("inputForm",url,"acs_content",saveCallback);
}
function saveWithLoginInvocation(oldInvocationType){
	$("#oldInvocationType").attr("value",oldInvocationType);
	var url = $("#inputForm").attr("action");
	ajaxSubmit("inputForm",url,"acs_content",saveCallback);
}