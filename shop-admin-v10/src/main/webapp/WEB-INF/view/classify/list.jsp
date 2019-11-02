<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-09-21
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>分类管理</title>
    <jsp:include page="/common/top.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="panel-heading" style="background-color: #b2dba1 ">
            <button type="button" class="btn btn-success" onclick="addClassify()"><i class="glyphicon glyphicon-plus"></i>新增</button>
            <button type="button"  class="btn btn-info" onclick="updateClassify()"><i class="glyphicon glyphicon-pencil"></i>修改</button>
            <button type="button"  class="btn btn-danger" onclick="delAll()"><i class="glyphicon glyphicon-trash"></i>删除</button>
        </div>
    </div>
    <div class="row">
        <ol id="classifyDiv" class="ztree"></ol>
    </div>
</div>


<div id="addclassifyDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >分类名称</label>
            <div class="col-sm-4">
                <input type="text"  class="form-control"   id="add_classifyName"  placeholder="请输入分类名称...."/>
            </div>
        </div>
    </form>
</div>

<div id="updateclassifyDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >分类名称</label>
            <div class="col-sm-4">
                <input type="text"  class="form-control"   id="update_classifyName"  placeholder="请输入分类名称...."/>
            </div>
        </div>
    </form>
</div>


<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var  add_common;
    var  update_common;
    $(function(){
        initZtree();
        initCopy();
    })
    function initCopy(){
        add_common=$("#addclassifyDiv").html();
        update_common=$("#updateclassifyDiv").html();
    }
    var add_Classify;
    function addClassify(){
        //获取页面被选中节点，返回一个数组
        var treeObj = $.fn.zTree.getZTreeObj("classifyDiv");
        var nodes = treeObj.getSelectedNodes();
        //判断是否选择了
        if(nodes.length==1){
            //从数组中拿到 父节点
            var v_pId=nodes[0].id;
            add_Classify=bootbox.dialog({
                title: '新增分类信息',
                message: $("#addclassifyDiv form"),
                size: 'large',
                buttons: {
                    cancel: {
                        label: "<span class='glyphicon glyphicon-remove'>取消</span>" ,
                        className: 'btn-danger',
                        callback: function(){  }
                    },
                    ok: {
                        label: "<span class='glyphicon glyphicon-ok'>确定</span>",
                        className: 'btn-info',
                        callback: function(){
                            var v_classifyName=$("#add_classifyName",add_Classify).val();
                            $.post({
                                url:"/classify/add.jhtml",
                                data:{"pid":v_pId,"classifyName":v_classifyName},
                                success:function(result){
                                    if(result.code==200){
                                        bootbox.alert("新增成功!", function(){
                                            var newNodes ={id:result.data,name:v_classifyName,pId:v_pId};
                                            treeObj.addNodes(nodes[0], newNodes);
                                        });
                                    }
                                }
                            })
                        }
                    }
                }
            });
            $("#addclassifyDiv").html(add_common);
        }else {
            if(nodes.length>1){
                bootbox.alert("只能选择一个!", function(){  });
            }else{
                bootbox.alert("至少选择一个!", function(){  });
            }
        }
    }
    var update_Classify;
    function updateClassify() {
        //获取页面被选中节点，返回一个数组
        var treeObj = $.fn.zTree.getZTreeObj("classifyDiv");
        var nodes = treeObj.getSelectedNodes();
        //判断是否选择了
        if(nodes.length==1){
            //从数组中拿到 父节点
            var v_id=nodes[0].id;
            var v_name=nodes[0].name;
            $("#update_classifyName").val(v_name);
            update_Classify=bootbox.dialog({
                title: '修改分类信息',
                message: $("#updateclassifyDiv form"),
                size: 'large',
                buttons: {
                    cancel: {
                        label: "<span class='glyphicon glyphicon-remove'>取消</span>" ,
                        className: 'btn-danger',
                        callback: function(){  }
                    },
                    ok: {
                        label: "<span class='glyphicon glyphicon-ok'>确定</span>",
                        className: 'btn-info',
                        callback: function(){
                            var v_classifyName=$("#update_classifyName",update_Classify).val();
                            $.post({
                                url:"/classify/update.jhtml",
                                data:{"id":v_id,"classifyName":v_classifyName},
                                success:function(result){
                                    if(result.code==200){
                                        bootbox.alert("修改成功!", function(){
                                            if (nodes.length>0) {
                                                nodes[0].name = v_classifyName;
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
            $("#updateclassifyDiv").html(update_common);
        }else {
            if(nodes.length>1){
                bootbox.alert("只能选择一个!", function(){  });
            }else{
                bootbox.alert("至少选择一个!", function(){  });
            }
        }
    }
    function delAll(){
        //获取页面被选中节点，返回一个数组
        var treeObj = $.fn.zTree.getZTreeObj("classifyDiv");
        var nodes = treeObj.getSelectedNodes();
        //官网提供的，获取到这个节点的所有节点
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
                            url:"/classify/delAll.jhtml",
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
            url:"/classify/queryClassifyList.jhtml",
            success:function(result){
                if(result.code==200){
                    var setting = {
                        data: {
                            simpleData: {
                                enable: true,
                            },
                        }
                    };
                    zTreeObj = $.fn.zTree.init($("#classifyDiv"), setting, result.data);
                    zTreeObj.expandAll(true);
                }
            },
        })
    }
</script>
</body>
</html>
