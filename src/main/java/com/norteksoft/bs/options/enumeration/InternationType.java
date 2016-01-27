package com.norteksoft.bs.options.enumeration;

public enum InternationType {
	MENU_RESOURCE("internation.type.menu.resource"),//菜单资源
	WORKFLOW_RESOURCE("internation.type.workflow.resource"),//工作流资源
	PUBLIC_RESOURCE("internation.type.public.resource");//公共资源
	
	public String code;
	InternationType(String code){
		this.code=code;
	}
	public String getCode() {
		return code;
	}
	
}
