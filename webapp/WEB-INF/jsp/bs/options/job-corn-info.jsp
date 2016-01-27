<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/setting-taglibs.jsp"%>
<table>
		<tbody>
			<tr>
				<td>
					定时任务方式：<select name="typeEnum" id="typeEnum" onchange="typeChange(this.value);">
									<option value="">请选择</option>
								<s:iterator value="@com.norteksoft.bs.options.enumeration.TimingType@values()" var="FK">
									<option value="${FK}"><s:text name="%{code}"></s:text></option>
								</s:iterator>
							</select>
				</td>
			</tr>
			<tr id="tr_everyMonth" style="display: none;">
				<td>
					定时任务每月：<select id="everyMonth" name="everyMonth"  class="customRequired">
								<option value="">请选择</option>
								<s:iterator value="@com.norteksoft.bs.options.enumeration.DateEnum@values()" var="FK">
									<option value="${FK}"><s:text name="%{code}"></s:text></option>
								</s:iterator>
							</select>
				</td>
			</tr>
			<tr id="tr_everyWeek" style="display: none;">
				<td>
					定时任务每周：<select id="everyWeek" name="everyWeek" multiple="multiple">
								<s:iterator value="@com.norteksoft.bs.options.enumeration.WeekEnum@values()" var="FK">
									<option value="${FK}"><s:text name="%{code}"></s:text></option>
								</s:iterator>
							</select>
				</td>
			</tr>
			<tr id="tr_everyDate" style="display: block;">
				<td>
					定时任务每天：<input id="everyDate" name="everyDate" value="" readonly="readonly" class="customRequired"/>
				</td>
			</tr>
			<tr id="tr_appointTime" style="display: none;">
				<td>
					定时指定日期：<input id="appointTime" name="appointTime" value="" readonly="readonly" class="customRequired"/>
				</td>
			</tr>
			<tr id="tr_appointSet" style="display: none;">
				<td>
					定时高级设置：<input id="appointSet" name="appointSet" value="" maxlength="30" class="customRequired"/><span style="color: red;margin: 40px;">(必须按照高级设置说明设置)</span>
				</td>
			</tr>
			<tr id="tr_appointSet_discription" style="display: none;">
				<td>
					高级设置说明：<a href="#" onclick="showDiscription();">查看</a>
				</td>
			</tr>
			<tr id="tr_intervalTime_type" style="display: none;">
				<td>
					时间间隔单位：<select id="intervalType" onchange="intervalTypeChange(this.value);" class="customRequired">
					                <option value="">请选择</option>
									<option value="secondType">分钟</option>
									<option value="hourType">小时</option>
							  </select>
				</td>
			</tr>
			<tr id="tr_intervalTime_second" style="display: none;">
				<td>
					时间间隔分钟：<input id="everySecond" name="everySecond" value=""  onclick="secondOrHour(this);" class="customRequired intervalTimeValidate"/></br>
				</td>
			</tr>
			<tr id="tr_intervalTime_hour" style="display: none;">
				<td>
					时间间隔小时：<input id="everyHour" name="everyHour" value="" onclick="secondOrHour(this);" class="customRequired intervalTimeValidate"/>
				</td>
			</tr>
		</tbody>
	</table>
