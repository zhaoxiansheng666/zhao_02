<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<div style="padding:10px 10px 10px 10px">
	<form id="dayAddForm" class="dayForm" method="post">
	    <table cellpadding="5">
	        <tr>
	            <td>路线名称:</td>
	            <td><input id ='lineId' class="easyui-combobox" name="lineId" style="width:280px" required="required">
		</td>
	        </tr>

			<tr>
				<td>日程名称:</td>
				<td><input class="easyui-textbox" type="text" name="title" style="width: 280px;"></input></td>
			</tr>

			<tr>
				<td>行程第几天:</td>
				<td><input class="easyui-textbox" type="text" name="dayNum" style="width: 280px;"></input></td>
			</tr>

			<tr>
				<td>餐:</td>
				<td><input class="easyui-textbox" type="text" name="meal" style="width: 280px;"></input></td>
			</tr>

			<tr>
				<td>宿:</td>
				<td><input class="easyui-textbox" type="text" name="hotel" style="width: 280px;"></input></td>
			</tr>
	        <tr>
	            <td>行程:</td>
	            <td>
	                <textarea style="width:800px;height:300px;visibility:hidden;" name="travel"></textarea>
	            </td>
	        </tr>

			<tr>
				<td>亮点:</td>
				<td>
					<textarea style="width:800px;height:300px;visibility:hidden;" name="linghtPoint"></textarea>
				</td>
			</tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
	var travelEditor ;
	var lightPointEditor;

    $.ajax({
        type: "GET",
        url: "/line/lineIdAndTitles",
        dataType: "json",
        success: function(json) {
            $('#lineId').combobox({
                data: json.rows,
                valueField: 'id',
                textField: 'text'
            });
        }
    });


	$(function(){
		//为行程创建富文本编辑器
        travelEditor = KindEditor.create("#dayAddForm [name=travel]", TT.kingEditorParams)
		//为亮点创建富文本编辑器
        lightPointEditor = KindEditor.create("#dayAddForm [name=linghtPoint]", TT.kingEditorParams)

	});

	//提交表单
	function submitForm(){
		//有效性验证
		if(!$('#dayAddForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
        travelEditor.sync();
        lightPointEditor.sync();
		//ajax的post方式提交表单
		$.post("/lineDay/add",$("#dayAddForm").serialize(), function(data){
			if(data.status == "success"){
				$.messager.alert('提示','新增日程成功!');
                $('#dayAddForm').form('reset');
                dayAddEditor.html('');
			}
		});
	}
	
	function clearForm(){
		$('#dayAddForm').form('reset');
		dayAddEditor.html('');
	}
</script>
