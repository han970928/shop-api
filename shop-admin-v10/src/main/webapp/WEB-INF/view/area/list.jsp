<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-25
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>地区展示页面</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading"  style="background-color: #b2dba1 ">
                    <button type="button" class="btn btn-success" onclick="addArea()"><i class="glyphicon glyphicon-plus"></i>新增</button>
                    <button type="button"  class="btn btn-info" onclick="updateArea()"><i class="glyphicon glyphicon-pencil"></i>修改</button>
                    <button type="button"  class="btn btn-danger" onclick="delAll()"><i class="glyphicon glyphicon-trash"></i>删除</button>
                </div>
                <div class="panel-body">
                    <ol id="treeDemo" class="ztree"></ol>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="addAreaDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >地区名</label>
            <div class="col-sm-4">
                <input type="text"  class="form-control"   id="add_areaName"  placeholder="请输入地区名...."/>
            </div>
        </div>
    </form>
</div>

<div id="updateAreaDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >地区名</label>
            <div class="col-sm-4">
                <input type="text"  class="form-control"   id="update_areaName"  placeholder="请输入地区名...."/>
            </div>
        </div>
    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script LANGUAGE="JavaScript">
    $(function(){
        initZtree();
        initCopy();
    });
    var add_AreaCommon;
    var update_AreaCommon;
    function initCopy(){
        add_AreaCommon=$("#addAreaDiv").html();
        update_AreaCommon=$("#updateAreaDiv").html();
    }
    var v_addArea
    function addArea(){
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length==1){
            var v_pId=nodes[0].id;
            v_addArea=bootbox.dialog({
                title: '新增地区信息',
                message: $("#addAreaDiv form"),
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
                            var v_areaName=$("#add_areaName",v_addArea).val();
                            $.post({
                                url:"/area/add.jhtml",
                                data:{"pid":v_pId,"areaName":v_areaName},
                                success:function(result){
                                    if(result.code==200){
                                        bootbox.alert("新增成功!", function(){
                                            var newNodes ={id:result.data,name:v_areaName,pId:v_pId};
                                            treeObj.addNodes(nodes[0], newNodes);
                                        });
                                    }
                                }
                            })
                        }
                    }
                }
            });
            $("#addAreaDiv").html(add_AreaCommon);
        }else{
            if(nodes.length>1){
                bootbox.alert("只能选择一个!", function(){  });
            }else{
                bootbox.alert("至少选择一个!", function(){  });
            }
        }
    }
    var v_updateArea
    function updateArea(){
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length==1){
            var v_id=nodes[0].id;
            var v_nodeName=nodes[0].name;
            $("#update_areaName").val(v_nodeName);
            v_updateArea=bootbox.dialog({
                title: '修改地区信息',
                message: $("#updateAreaDiv form"),
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
                            var v_name=$("#update_areaName",v_updateArea).val();
                            $.post({
                                url:"/area/update.jhtml",
                                data:{"id":v_id,"areaName":v_name},
                                success:function(result){
                                    if(result.code==200){
                                        bootbox.alert("修改成功!", function(){
                                            if (nodes.length>0) {
                                                nodes[0].name = v_name;
                                                treeObj.updateNode(nodes[0]);
                                            }
                                        });
                                    }
                                }
                            })
                        }
                    }
                }
            });
            $("#updateAreaDiv").html(update_AreaCommon);
        }else{
            if(nodes.length>1){
                bootbox.alert("只能选择一个!", function(){  });
            }else{
                bootbox.alert("至少选择一个!", function(){  });
            }
        }
    }
    function delAll(){
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        var newNodes = treeObj.transformToArray(nodes);
        if(newNodes.length>0){
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
                    var ids=[];
                    for(var i=0;i<newNodes.length;i++){
                        ids.push(newNodes[i].id);
                    }
                    if (result == true) {
                        $.post({
                            url:"/area/delAll.jhtml",
                            data:{"list":ids},
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("删除成功!", function(){
                                        for (var i=newNodes.length-1; i >= 0; i--) {
                                            treeObj.removeNode(newNodes[i]);
                                        }
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
    function initZtree(){
        $.post({
            url:"/area/queryAreaList.jhtml",
            success:function(result){
                if(result.code==200){
                    var setting = {
                        data: {
                            simpleData: {
                                enable: true,
                            },
                        }
                    };
                    zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result.data);
                    zTreeObj.expandAll(true);
                }
            },
        })
    }
</script>
</body>
</html>
