package com.norteksoft.bs.sms.web;


import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.norteksoft.acs.entity.authorization.BusinessSystem;
import com.norteksoft.acs.service.authorization.BusinessSystemManager;
import com.norteksoft.bs.sms.entity.SmsGatewaySetting;
import com.norteksoft.bs.sms.service.SmsWaitTosendManager;
import com.norteksoft.product.util.JsonParser;
import com.norteksoft.product.util.tree.ZTreeNode;
import com.norteksoft.product.web.struts2.CrudActionSupport;
/**
 * 短信平台
 * @author lenove1
 *
 */
@Namespace("/sms")
@ParentPackage("default")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "sms-list", type = "redirectAction") })
public class SmsAction extends CrudActionSupport<SmsGatewaySetting> {

	private static final long serialVersionUID = 1L;
	private String receiver;//收信人
	private String ids;//ids
	private String content;//内容
	
	@Autowired
	private BusinessSystemManager businessSystemManager;
	@Autowired
	private SmsWaitTosendManager smsWaitTosendManager;
	private static final String SUCCESS_MESSAGE_LEFT = "<font class=\"onSuccess\"><nobr>";
	private static final String MESSAGE_RIGHT = "</nobr></font>";
	private static final String ERROR_MESSAGE_LEFT = "<font class=\"onError\"><nobr>";
	protected void addErrorMessage(String message) {
		this.addActionMessage(ERROR_MESSAGE_LEFT + message + MESSAGE_RIGHT);
	}
	protected void addSuccessMessage(String message){
		this.addActionMessage(SUCCESS_MESSAGE_LEFT+message+MESSAGE_RIGHT);
	}
	/**
	 * 短信平台/左侧菜单树
	 * @return
	 */
	@Override
	@Action("sms-tree")
	public String list() throws Exception {
		List<BusinessSystem> businessSystems= businessSystemManager.getAllBusiness();
		List<ZTreeNode> treeNodes = new ArrayList<ZTreeNode>();
		ZTreeNode root = new ZTreeNode("_smsGatewaySetting","0", "短信网关设置", "false", "false", "", "", "folder", "");
		treeNodes.add(root);
		root = new ZTreeNode("_templateSetting","0", "短信模版设置", "false", "false", "", "", "folder", "");
		treeNodes.add(root);
		root = new ZTreeNode("_SmsAuthoritySetting","0", "收发接口设置", "true", "false", "", "", "folder", "");
		treeNodes.add(root);
		for(BusinessSystem system :businessSystems){//子系统
			root = new ZTreeNode(system.getId().toString(),"_SmsAuthoritySetting", system.getName(), "true", "false", "", "", "folder", "");
			treeNodes.add(root);
		}
		root = new ZTreeNode("_SmsSendMessage","0", "通用短信发送", "true", "false", "", "", "folder", "");
		treeNodes.add(root);
		root = new ZTreeNode("_SmsLog_Send","0", "短信发送日志", "true", "false", "", "", "folder", "");
		treeNodes.add(root);
		root = new ZTreeNode("_SmsLog_Receive","0", "短信接收日志", "true", "false", "", "", "folder", "");
		treeNodes.add(root);
		root = new ZTreeNode("_SmsWaitTosend","0", "待发送列表", "true", "false", "", "", "folder", "");
		treeNodes.add(root);
		renderText(JsonParser.object2Json(treeNodes));
		return null;
	}
	
	/**
	 * 短信平台/菜单
	 */
	@Action("sms-list")
	public String smsList() throws Exception {
		return "sms-list";
	}
	/**
	 * 短信平台/通用短信发送/列表
	 */
	@Override
	@Action("sms-send-message")
	public String input() throws Exception {
		return "sms-send-message";
	}
	/**
	 * 短信平台/通用短信发送/发送
	 */
	@Override
	@Action("sms-send-message-save")
	public String save() throws Exception {
		smsWaitTosendManager.createWaitToSend(ids,receiver,content);
		this.addSuccessMessage("已保存至待发送列表");
		return "sms-send-message";
	}
	
	@Override
	public String delete() throws Exception {
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
	}

	public SmsGatewaySetting getModel() {
		return null;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}

}
