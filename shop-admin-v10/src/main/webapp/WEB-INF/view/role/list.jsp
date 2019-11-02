<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-25
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>菜单展示</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <button type="button" class="btn btn-success" onclick="addRole()"><i class="glyphicon glyphicon-plus"></i>新增</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">角色信息列表</div>
                <table class="table table-striped table-bordered" id="userTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="addRoleDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >角色名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_roleName" placeholder="请输入角色名称....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >菜单名称</label>
            <div class="col-sm-4">
                <ul id="add_ztreeDiv" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>

<div id="updateRoleDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >角色名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_roleName" placeholder="请输入角色名....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >菜单名称</label>
            <div class="col-sm-4">
                <ul id="update_ztreeDiv" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    var add_common;
    var update_common;
    $(function(){
        add_common=$("#addRoleDiv").html();
        update_common=$("#updateRoleDiv").html();
        initTable();
    })
    function initZtree(Element){
        $.post({
            url:"/menu/queryMenuList.jhtml",
            async:false,
            success:function(result){
                if(result.code==200){
                    var setting = {
                        check: {
                            enable: true,
                            chkboxType:{ "Y" : "ps", "N" : "s" }
                        },
                        data: {
                            simpleData: {
                                enable: true
                            }
                        }
                    };
                        $.fn.zTree.init($("#"+Element), setting, result.data);
                        //父节点展开
                        var treeObj=$.fn.zTree.init($("#"+Element), setting, result.data);
                        treeObj.expandAll(true);
                }
            },
        })
    }
    function search(){
        userTable.ajax.reload();
    }
    var addrole;
    function addRole(){
        initZtree("add_ztreeDiv");
        addrole=bootbox.dialog({
            title: '新增角色信息',
            message: $("#addRoleDiv form"),
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
                        var roleIds=[];
                        var treeObj = $.fn.zTree.getZTreeObj("add_ztreeDiv");
                        var nodes = treeObj.getCheckedNodes(true);
                        $(nodes).each(function(){
                            roleIds.push(this.id);
                        });
                        var v_roleName=$("#add_roleName",addrole).val();
                        $.post({
                            url:"/role/add.jhtml",
                            data:{"roleName":v_roleName,"list":roleIds},
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
        $("#addRoleDiv").html(add_common);
    }
    var updaterole;
    function updateRole(data){
        $.post({
            url:"/role/toupdate.jhtml",
            data:{"id":data},
            success:function(result){
                initZtree("update_ztreeDiv");
                if(result.code==200){
                    var v_idList=result.data.roleStrIds;
                    for(var i=0;i<v_idList.length;i++){
                        var treeObj = $.fn.zTree.getZTreeObj("update_ztreeDiv");
                        var nodes = treeObj.getNodeByParam("id",v_idList[i],null);
                        treeObj.checkNode(nodes,true);
                    }
                    $("#update_roleName").val(result.data.roleName);
                    updaterole=bootbox.dialog({
                        title: '修改角色信息',
                        message: $("#updateRoleDiv form"),
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
                                    var ids=[];
                                    var nodes = treeObj.getCheckedNodes(true);
                                    for(var i=0;i<nodes.length;i++){
                                        ids.push(nodes[i].id);
                                    }
                                    var v_update_userName=$("#update_roleName",updaterole).val();
                                    $.post({
                                        url:"/role/update.jhtml",
                                        data:{"id":data,"roleName":v_update_userName,"list":ids},
                                        success:function(result){
                                            if(result.code==200){
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
                    $("#updateRoleDiv").html(update_common);
                }
            },
        })
    }
    function del(data){
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
                        url:"/role/del.jhtml",
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
    var userTable;
    function initTable(){
        userTable= $('#userTableId').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching":false,
            "ajax": {
                "url": "/role/queryRole.jhtml",
                "type": "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "roleName" },
                { "data": "id",render:function(data, type, row, meta){
                        return "<div class=\"btn-group\" role=\"group\" >\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick='updateRole("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\"  onclick='del("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
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
