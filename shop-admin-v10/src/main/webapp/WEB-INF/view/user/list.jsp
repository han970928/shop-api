<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-18
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
<jsp:include page="/common/head.jsp"></jsp:include>
    <title>用户展示信息</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">查询用户信息</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="formId">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="userName" id="userName" placeholder="请输入用户名....">
                            </div>
                            <label  class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="roleName" name="roleName"  placeholder="请输入真实姓名....">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">年龄范围</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minAge" name="minAge" placeholder="最小年龄...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-resize-horizontal"></i></span>
                                    <input type="text" class="form-control" id="maxAge" name="maxAge" placeholder="最大年龄...." >
                                </div>
                            </div>
                            <label  class="col-sm-2 control-label">薪资范围</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="mincompensation" name="mincompensation" placeholder="最低薪资...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-jpy"></i></span>
                                    <input type="text" class="form-control" id="maxcompensation" name="maxcompensation" placeholder="最高薪资...." >
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">入职时间</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" name="minhiredate"  id="minhiredate" class="form-control" placeholder="入职时间...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" name="maxhiredate" id="maxhiredate" class="form-control" placeholder="离职时间...." >
                                </div>
                            </div>
                            <label  class="col-sm-2 control-label">匹配角色</label>
                            <div class="col-sm-4" id="search_role" name="roleIds"></div>
                        </div>
                        <div class="form-group" id="search_area">
                            <label  class="col-sm-2 control-label">地区</label>
                            <input type="hidden" name="areaId1" id="areaId1">
                            <input type="hidden" name="areaId2" id="areaId2">
                            <input type="hidden" name="areaId3" id="areaId3">
                        </div>
                        <div style="text-align: center">
                            <button type="button" class="btn btn-success" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                            <button type="reset"  class="btn btn-default"  onclick="resetRole()"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
             <div  style="background-color: #b2dba1 ">
                   <button type="button" class="btn btn-success" onclick="addUser()"><i class="glyphicon glyphicon-plus"></i>新增</button>
                   <button type="reset"  class="btn btn-danger" onclick="delAll()"><i class="glyphicon glyphicon-trash"></i>批量删除</button>
                   <button type="reset"  class="btn btn-info" onclick="downExcel()"><i class="glyphicon glyphicon-download-alt"></i>导出Excel</button>
                   <button type="reset"  class="btn btn-info" ><i class="glyphicon glyphicon-download-alt"></i>导出Word</button>
                   <button type="reset"  class="btn btn-info" ><i class="glyphicon glyphicon-download-alt"></i>导出PDF</button>
             </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">用户信息列表</div>
                <table class="table table-striped table-bordered" id="userTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>真实姓名</th>
                        <th>用户年龄</th>
                        <th>邮箱地址</th>
                        <th>用户性别</th>
                        <th>手机号码</th>
                        <th>入职时间</th>
                        <th>薪资范围</th>
                        <th>角色</th>
                        <th>图片</th>
                        <th>状态</th>
                        <th>地区名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>真实姓名</th>
                        <th>用户年龄</th>
                        <th>邮箱地址</th>
                        <th>用户性别</th>
                        <th>手机号码</th>
                        <th>入职时间</th>
                        <th>薪资范围</th>
                        <th>角色</th>
                        <th>图片</th>
                        <th>状态</th>
                        <th>地区名称</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="addUserDiv" style="display: none">
    <form class="form-horizontal"  id="resultFrom">
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_userName" name="add_userName" placeholder="请输入用户名....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >真实姓名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_roleName" name="add_roleName" placeholder="请输入真实姓名....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户密码</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="add_password"  placeholder="请输入用户密码....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户年龄</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_age" placeholder="请输入用户年龄....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >邮箱地址</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_email" name="add_email" placeholder="请输入邮箱地址....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户性别</label>
            <div class="col-sm-4">
                <input type="radio"   value="1"  name="add_sex">男
                <input type="radio"   value="0"  name="add_sex">女
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >手机号码</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_phone" placeholder="请输入手机号码....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >薪资</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_compensation" placeholder="请输入薪资....">
            </div>
        </div>
        <div class="form-group">
             <label  class="col-sm-2 control-label" >入职时间</label>
             <div class="col-sm-4">
                 <input type="text" class="form-control" id="add_hiredate" name="add_hiredate"  placeholder="请输入入职时间....">
             </div>
         </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户角色</label>
            <div class="col-sm-4" id="add_role">
            </div>
        </div>
        <div class="form-group" id="add_area">
            <label  class="col-sm-2 control-label" >地区</label>
        </div>
        <div class="form-group">
             <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-4">
                  <input type="file" name="imgss" id="file" >
                  <input type="hidden"  id="add_fileinput">
            </div>
        </div>
    </form>
</div>


<div id="updateUserDiv" style="display: none">
    <form class="form-horizontal" >
        <input type="hidden" id="update_id">
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_userName" placeholder="请输入用户名....">
            </div>
        </div>
         <div class="form-group">
            <label  class="col-sm-2 control-label" >真实姓名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_roleName" placeholder="请输入真实姓名....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户密码</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="update_password"  placeholder="请输入用户密码....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >手机号码</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_phone" placeholder="请输入手机号码....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户年龄</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_age" placeholder="请输入用户年龄....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >邮箱地址</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_email" placeholder="请输入邮箱地址....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户性别</label>
            <div class="col-sm-4">
                     <span class="input-group-addon">
                        <input type="radio"   value="1"  name="update_sex" >男
                        <input type="radio"   value="0"  name="update_sex" >女
                     </span>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >入职时间</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_hiredate"  placeholder="请输入入职时间....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >薪资</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_compensation"  placeholder="请输入薪资....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >用户角色</label>
            <div class="col-sm-4" id="update_role">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-4">
                <input type="file" name="imgss" id="update_imgFilePath" >
                <input type="hidden"  id="hidden_FileUrl">
            </div>
        </div>
        <div class="form-group" id="update_area">
            <label  class="col-sm-2 control-label" >地区</label>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var addUserCommmon;
    var updateUserCommmon;
    $(function(){
        initTable();
        initSearch();
        initcopy();
        initDate('add_hiredate');
        initDate('update_hiredate');
        initRoleList("add_role","addrole");
        initRoleList("update_role","updaterole");
        initRoleList("search_role","searchrole");
        initBindEvent();
        fileinput5();
        initSearchArea(0);
    })
    $(function() {
        $('#resultFrom').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                add_userName: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '请输入用户名称'
                        },
                        stringLength: {
                            min: 6,
                            max: 10,
                            message: '请输入6到10位汉字'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9]+$/,
                            message: 'The username can only consist of alphabetical and number'
                        },
                        different: {
                            field: 'password',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                add_roleName: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '请输入真实姓名'
                        },
                        stringLength: {
                            min: 6,
                            max: 10,
                            message: '请输入6到10位汉字'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9]+$/,
                            message: 'The username can only consist of alphabetical and number'
                        },
                        different: {
                            field: 'password',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                add_email: {
                    validators: {
                        notEmpty: {
                            message: 'The email address is required and cannot be empty'
                        },
                        emailAddress: {
                            message: '请输入正确的邮箱地址'
                        }
                    }
                },
            }
        });
    });
    function fileinput5(){
        $("#file").fileinput({
            language: 'zh', //设置语言,
            uploadUrl : "/user/uploadFile.jhtml", /*上传图片的url*/
            allowedFileExtensions : [ 'jpg', 'png', 'gif' ],//接收的文件后缀
            showUpload:true, //是否显示上传按钮
            overwriteInitial : false,
            maxFileCount:5, //表示允许同时上传的最大文件个数
            slugCallback : function(filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        });
        $('#file').on('fileuploaded', function(event, data, previewId, index) {
            $("#add_fileinput",v_userAddDlg).val(data.response.imgs);
        });
    }
    function updateFileInput(){
        var ss = $("#hidden_FileUrl").val();
        var markArr = [];
        if(ss != null && ss!=""){
            markArr.push(ss);
        }
        $("#update_imgFilePath").fileinput({
            uploadUrl:"/user/uploadFile.jhtml",//图片上传路径
            language:'zh',//插件语言
            initialPreviewAsData: true,//图片回显开启
            initialPreview:markArr,//图片 预览开启路径放进来
        })
        $('#update_imgFilePath').on("fileuploaded",function(event, data, previewId, index){
            $("#hidden_FileUrl",v_userUpdateDlg).val(data.response.imgs
            );
        })
    }
    function downExcel(){
        var v_a1=$($("select[name='areaName']",$("#formId"))[0]).val();
        var v_a2=$($("select[name='areaName']",$("#formId"))[1]).val();
        var v_a3=$($("select[name='areaName']",$("#formId"))[2]).val();
        $("#areaId1").val(v_a1);
        $("#areaId2").val(v_a2);
        $("#areaId3").val(v_a3);
        var v_form=document.getElementById("formId");
        v_form.action="/user/downExcel.jhtml";
        v_form.method="post";
        v_form.submit();
    }
    var ids=[];
    function initBindEvent(){
        $("#userTableId tbody").on("click","tr",function(){
            var checkbox=$(this).find("input[type=checkbox]");
            var checked=checkbox.prop("checked");
            if(checked){
                checkbox.prop("checked",false);
                $(this).css("background-color","");
                //移除 已经选中的值
                for(var i=ids.length;i>=0;i--){
                    if(ids[i]==checkbox.val()){
                        ids.splice(i,1);
                    }
                }
            }else{
                checkbox.prop("checked",true);
                $(this).css("background-color","#b2dba1");
                ids.push(checkbox.val());
            }
        });
    }
    function delAll(){
        if(ids.length>0){
            bootbox.confirm({
                message: "你确定要删除吗?",
                buttons: {
                    confirm: {
                        label: 'Yes',
                        className: 'btn-success',
                    },
                    cancel: {
                        label: 'No',
                        className: 'btn-danger'
                    }
                },
                callback: function (result ) {
                    if (result == true) {
                        $.post({
                            url:"/user/delAll.jhtml",
                            data:{"list":ids},
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("删除成功!", function(){
                                        location.reload();
                                    });
                                }
                            },
                        })
                    }
                }
            });
        }else{
            bootbox.alert("至少选择一个!", function(){  });
        }
    }
    //重置按钮事件
    function  resetRole(){
        $("#searchrole").selectpicker('deselectAll');
    }
    function initRoleList(rolecheckBox,roleDiv){
        $.post({
            url:"/role/queryRoleList.jhtml",
            async:false,
            success:function(result){
                if(result.code==200){
                    da=result.data;
                    var kong="<select id='"+roleDiv+"' class=\"selectpicker\"  multiple  title=\"请选择\">";
                    for(var i=0;i<da.length;i++){
                        kong+="<option  value='"+da[i].id+"'>"+da[i].roleName+"</option>";
                    }
                    kong+="</select>";
                    $("#"+rolecheckBox).html(kong);
                    $("#"+roleDiv).selectpicker("refresh");
                }
            },
        })
    }
    function initcopy(){
        addUserCommmon=$("#addUserDiv").html();
        updateUserCommmon=$("#updateUserDiv").html();
    }
    function initDate(elementUser){
        $("#"+elementUser).datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function initSearch(){
        $("#minhiredate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
        $("#maxhiredate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function search(){
        var  v_userName=$("#userName").val();
        var  v_roleName= $("#roleName").val();
        var  v_minAge= $("#minAge").val();
        var  v_maxAge= $("#maxAge").val();
        var  v_mincompensation= $("#mincompensation").val();
        var  v_maxcompensation= $("#maxcompensation").val();
        var  v_minhiredate= $("#minhiredate").val();
        var  v_maxhiredate= $("#maxhiredate").val();
        var  v_roleStrIds= $("#searchrole").val().join(",");
        var v_areaId1=$($("select[name='areaName']")[0]).val();
        var v_areaId2=$($("select[name='areaName']")[1]).val();
        var v_areaId3=$($("select[name='areaName']")[2]).val();
        var param={};
        param.userName=v_userName;
        param.roleName=v_roleName;
        param.minAge=v_minAge;
        param.maxAge=v_maxAge;
        param.mincompensation=v_mincompensation;
        param.maxcompensation=v_maxcompensation;
        param.minhiredate=v_minhiredate;
        param.maxhiredate=v_maxhiredate;
        param.roleIds=v_roleStrIds;
        param.areaId1=v_areaId1;
        param.areaId2=v_areaId2;
        param.areaId3=v_areaId3;
        userTable.settings()[0].ajax.data=param;
        userTable.ajax.reload();
    }
    function initAddArea(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/area/queryArea.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                   var v_areaList = result.data;
                   if(v_areaList.length==0){
                       return;
                   }
                   var kong="<div class='col-sm-3'>" +
                       "<select class='form-control' name='areaName' onchange='initAddArea(this.value,this)'>" +
                       "<option value='-1'>请选择</option>"
                   for(var i=0;i<v_areaList.length;i++){
                       kong+="<option value='"+v_areaList[i].id+"'>"+v_areaList[i].areaName+"</option>";
                   }
                   $("#add_area",v_userAddDlg).append(kong);
                }
            },
        })
    }
    function initUpdateArea(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/area/queryArea.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    var v_areaList = result.data;
                    if(v_areaList.length==0){
                        return;
                    }
                    var kong="<div class='col-sm-3'>" +
                        "<select class='form-control' name='areaName' onchange='initUpdateArea(this.value,this)'>" +
                        "<option value='-1'>请选择</option>"
                    for(var i=0;i<v_areaList.length;i++){
                        kong+="<option value='"+v_areaList[i].id+"'>"+v_areaList[i].areaName+"</option>";
                    }
                    $("#update_area",v_userUpdateDlg).append(kong);
                }
            },
        })
    }
    function initSearchArea(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/area/queryArea.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    var v_areaList = result.data;
                    if(v_areaList.length==0){
                        return;
                    }
                    var kong="<div class='col-sm-3'>" +
                        "<select class='form-control' name='areaName' onchange='initSearchArea(this.value,this)'>" +
                        "<option value='-1'>请选择</option>"
                    for(var i=0;i<v_areaList.length;i++){
                        kong+="<option value='"+v_areaList[i].id+"'>"+v_areaList[i].areaName+"</option>";
                    }
                    $("#search_area").append(kong);
                }
            },
        })
    }
    var v_userAddDlg;
    function addUser(){
        v_userAddDlg = bootbox.dialog({
            title: '新增用户信息',
            message: $("#addUserDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "<span class='glyphicon glyphicon-remove'>取消</span>" ,
                    className: 'btn-danger',
                    callback: function(){

                    }
                },
                ok: {
                    label: "<span class='glyphicon glyphicon-ok'>确定</span>",
                    className: 'btn-info',
                    callback: function(){
                        var v_userName = $("#add_userName",v_userAddDlg).val();
                        var v_roleName = $("#add_roleName",v_userAddDlg).val();
                        var v_password = $("#add_password",v_userAddDlg).val();
                        var v_age = $("#add_age",v_userAddDlg).val();
                        var v_email = $("#add_email",v_userAddDlg).val();
                        var v_sex = $("[name='add_sex']:checked",v_userAddDlg).val();
                        var v_phone = $("#add_phone",v_userAddDlg).val();
                        var v_compensation = $("#add_compensation",v_userAddDlg).val();
                        var v_hiredate = $("#add_hiredate",v_userAddDlg).val();
                        var temp=$("#addrole",v_userAddDlg).val();
                        var v_fileinput=$("#add_fileinput",v_userAddDlg).val();
                        var v_roleids=temp.join(",");
                        var v_areaId1=$($("select[name='areaName']",v_userAddDlg)[0]).val();
                        var v_areaId2=$($("select[name='areaName']",v_userAddDlg)[1]).val();
                        var v_areaId3=$($("select[name='areaName']",v_userAddDlg)[2]).val();
                        var v_param={};
                            v_param.userName=v_userName;
                            v_param.roleName=v_roleName;
                            v_param.password=v_password;
                            v_param.age=v_age;
                            v_param.email=v_email;
                            v_param.sex=v_sex;
                            v_param.phone=v_phone;
                            v_param.compensation=v_compensation;
                            v_param.hiredate=v_hiredate;
                            v_param.roleids=v_roleids;
                            v_param.imgFilePath=v_fileinput;
                            v_param.areaId1=v_areaId1;
                            v_param.areaId2=v_areaId2;
                            v_param.areaId3=v_areaId3;
                       $.post({
                            url:"/user/add.jhtml",
                            data:v_param,
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("新增成功!", function(){
                                        search();
                                    });
                                }
                            },
                        })
                    }
                }
            }
        });
        $("#addUserDiv").html(addUserCommmon);
        initDate('add_hiredate');
        initRoleList("add_role","addrole");
        fileinput5();
        initAddArea(0);
    }
    function editArea(obj){
        $(obj).parent().nextAll().remove();
        initUpdateArea(0);
        $("#update_area",v_userUpdateDlg).html("<label  class='col-sm-1 control-label' >地区</label>" +
            "<button type='button' onclick='cancelArea()'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>取消编辑</button>");
    }
    function cancelArea(){
        $("#update_area",v_userUpdateDlg).html("<label  class='col-sm-2 control-label' >地区</label>\n" +
        "</div>"+v_areaName+"<button type='button' onclick='editArea(this)'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>编辑</button>");
    }
    var v_userUpdateDlg;
    var v_areaName;
    function updateUser(id){
        //事件冒泡
        event.stopPropagation();
        $.post({
            url:"/user/toupdate.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    $("#update_id").val(result.data.id);
                    $("#update_userName").val(result.data.userName);
                    $("#update_roleName").val(result.data.roleName);
                    $("#update_password").val(result.data.password);
                    $("#update_phone").val(result.data.phone);
                    $("#update_age").val(result.data.age);
                    $("#update_email").val(result.data.email);
                    $("#update_compensation").val(result.data.compensation);
                    $("#update_hiredate").val(result.data.hiredate);
                    $("[name='update_sex']").each(function(){
                        if(result.data.sex==this.value){
                            this.checked=true;
                        }
                    });
                    temp=result.data.roleIds;
                    $("#updaterole").selectpicker("val",temp);
                    $("#hidden_FileUrl").val(result.data.imgFilePath);
                    updateFileInput();
                    v_areaName=result.data.areaName;
                    $("#update_area").append(result.data.areaName+"<button type='button' onclick='editArea(this)'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>编辑</button>");
                    v_userUpdateDlg = bootbox.dialog({
                        title: '修改用户信息',
                        message: $("#updateUserDiv form"),
                        size: 'large',
                        buttons: {
                            cancel: {
                                label: "<span class='glyphicon glyphicon-remove'>取消</span>" ,
                                className: 'btn-danger',
                                callback: function(){

                                }
                            },
                            ok: {
                                label: "<span class='glyphicon glyphicon-ok'>确定</span>",
                                className: 'btn-info',
                                callback: function(){
                                    var v_update_id=$("#update_id",v_userUpdateDlg).val();
                                    var v_update_userName=$("#update_userName",v_userUpdateDlg).val();
                                    var v_update_roleName=$("#update_roleName",v_userUpdateDlg).val();
                                    var v_update_password=$("#update_password",v_userUpdateDlg).val();
                                    var v_update_phone=$("#update_phone",v_userUpdateDlg).val();
                                    var v_update_age=$("#update_age",v_userUpdateDlg).val();
                                    var v_update_email=$("#update_email",v_userUpdateDlg).val();
                                    var v_update_compensation=$("#update_compensation",v_userUpdateDlg).val();
                                    var v_update_hiredate=$("#update_hiredate",v_userUpdateDlg).val();
                                    var v_update_sex=$("[name='update_sex']:checked",v_userUpdateDlg).val();
                                    var temp=$("#updaterole",v_userUpdateDlg).val();
                                    var temp1=temp.join(",");
                                    var v_update_imgFilePath=$("#hidden_FileUrl",v_userUpdateDlg).val();
                                    var v_areaList=$($("select[name='areaName']",v_userUpdateDlg));
                                    var v_area1;
                                    var v_area2;
                                    var v_area3;
                                    if(v_areaList.length==3){
                                        v_area1=$($("select[name='areaName']",v_userUpdateDlg)[0]).val();
                                        v_area2=$($("select[name='areaName']",v_userUpdateDlg)[1]).val();
                                        v_area3=$($("select[name='areaName']",v_userUpdateDlg)[2]).val();
                                    }
                                    var v_param={};
                                        v_param.id=v_update_id;
                                        v_param.userName=v_update_userName;
                                        v_param.roleName=v_update_roleName;
                                        v_param.password=v_update_password;
                                        v_param.phone=v_update_phone;
                                        v_param.age=v_update_age;
                                        v_param.email=v_update_email;
                                        v_param.sex=v_update_sex;
                                        v_param.compensation=v_update_compensation;
                                        v_param.hiredate=v_update_hiredate;
                                        v_param.roleids=temp1;
                                        v_param.imgFilePath=v_update_imgFilePath;
                                        v_param.areaId1=v_area1;
                                        v_param.areaId2=v_area2;
                                        v_param.areaId3=v_area3;
                                    $.post({
                                        url:"/user/update.jhtml",
                                        data:v_param,
                                        success:function(Pk){
                                            if(Pk.code==200){
                                                bootbox.alert("修改成功!", function(){
                                                    search();
                                                });
                                            }
                                        },
                                    })
                                }
                            }
                        }
                    });
                    $("#updateUserDiv").html(updateUserCommmon);
                    initDate('update_hiredate');
                    initRoleList("update_role","updaterole");
                }
            },
        })
    }
    function del(data){
        event.stopPropagation();
          bootbox.confirm({
              message: "你确定要删除吗?",
              buttons: {
                  confirm: {
                      label: 'Yes',
                      className: 'btn-success',
                  },
                  cancel: {
                      label: 'No',
                      className: 'btn-danger'
                  }
              },
              callback: function (result ) {
                  if (result == true) {
                      $.post({
                          url:"/user/del.jhtml",
                          data:{"id":data},
                          success:function(result){
                              if(result.code==200){
                                 bootbox.alert("删除成功!", function(){
                                     search();
                              });
                              }
                          },
                      })
                  }
              }
          });
      }
    function updateSuo(data){
        event.stopPropagation();
        bootbox.confirm({
            message: "你确定要解锁该用户吗?",
            buttons: {
                confirm: {
                    label: 'Yes',
                    className: 'btn-success',
                },
                cancel: {
                    label: 'No',
                    className: 'btn-danger'
                }
            },
            callback: function (result ) {
                if (result == true) {
                    $.post({
                        url:"/user/updateSuo.jhtml",
                        data:{"id":data},
                        success:function(result){
                            if(result.code==200){
                                bootbox.alert("解锁成功!", function(){
                                    search();
                                });
                            }
                        },
                    })
                }
            }
        });
    }
    function resetPassword(data){
        event.stopPropagation();
        bootbox.confirm({
            message: "你确定要重置该用户吗?",
            buttons: {
                confirm: {
                    label: 'Yes',
                    className: 'btn-success',
                },
                cancel: {
                    label: 'No',
                    className: 'btn-danger'
                }
            },
            callback: function (result ) {
                if (result == true) {
                    $.post({
                        url:"/user/resetPassword.jhtml",
                        data:{"id":data},
                        success:function(result){
                            if(result.code==200){
                                bootbox.alert("重置成功!", function(){
                                });
                            }
                        },
                    })
                }
            }
        });
    }
    var userTable;
    function initTable(){
        userTable=$('#userTableId').DataTable( {
                "processing": true,
                "serverSide": true,
                "searching":false,
                "ajax": {
                    "url": "/user/queryUserList.jhtml",
                    "type": "POST",
                    "dataSrc": function (result) {
                        result.recordsTotal=result.data.recordsTotal;
                        result.recordsFiltered=result.data.recordsFiltered;
                        result.draw=result.data.draw;
                        return result.data.data;
                    }
                },
                //点击上下页，触发到的一个事件，函数
                "drawCallback": function(settings) {
                    //获取到整页的tr 数据，多条数据
                   $("#userTableId tbody tr").each(function(){
                    var checkbox=$(this).find("input[type=checkbox]");
                    var all=checkbox.val();
                    for(var i=0;i<ids.length;i++){
                        if(ids[i]==all){
                            checkbox.prop("checked",true);
                            $(this).css("background-color","#b2dba1");
                        }
                    }
                   })
                },
                "columns": [
                    { "data": "id" ,render:function(data, type, row, meta){
                            return "<input type='checkbox' name='ids' value='"+data+"'>";
                        } },
                    { "data": "userName" },
                    { "data": "roleName" },
                    { "data": "age" },
                    { "data": "email" },
                    { "data": "sex",render:function(data, type, row, meta){
                            return data==0?"女":"男"
                        } },
                    { "data": "phone" },
                    { "data": "hiredate"},
                    { "data": "compensation" },
                    { "data": "roleNames" },
                    { "data": "imgFilePath",render:function(data, type, row, meta){
                            var as='<img  src="'+data+'"height="55px">';
                            return as;
                     }},
                    { "data": "suo",render:function(data, type, row, meta){
                            return data?"锁定":"正常";
                     }},
                    { "data": "areaName" },
                    { "data": "id",render:function(data, type, row, meta){
                        return "<div class=\"btn-group\" role=\"group\" >\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick='updateUser("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\"  onclick='del("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-info\"  onclick='updateSuo("+data+")'><i class='glyphicon glyphicon-compressed'></i>解锁</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-warning\"  onclick='resetPassword("+data+")'><i class='glyphicon glyphicon-wrench'></i>重置</button>\n" +
                            "</div>";
                    } }
                ],
                "lengthMenu": [ 5, 10, 15, 20],
                "language": {
                    "url": "/jsp/Chinese.json"
                }
            } );
    }
</script>
</body>
</html>
