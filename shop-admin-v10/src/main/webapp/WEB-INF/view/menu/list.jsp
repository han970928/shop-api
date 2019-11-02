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
                        <div class="panel panel-info">
                             <div class="panel-heading"  style="background-color: #b2dba1 ">
                                <button type="button" class="btn btn-success" onclick="addMenu()"><i class="glyphicon glyphicon-plus"></i>新增</button>
                                <button type="button"  class="btn btn-info" onclick="updateMenu()"><i class="glyphicon glyphicon-pencil"></i>修改</button>
                                <button type="button"  class="btn btn-danger" onclick="delAll()"><i class="glyphicon glyphicon-trash"></i>删除</button>
                             </div>
                             <div class="panel-body">
                                    <ol id="in" class="ztree"></ol>
                             </div>
                        </div>
                </div>
            </div>
    </div>

    <div id="addMenuDiv" style="display: none">
        <form class="form-horizontal" >
            <div class="form-group">
                 <label  class="col-sm-2 control-label" >菜单名</label>
                 <div class="col-sm-4">
                   <input type="text"  class="form-control"   id="add_menuName"  placeholder="请输入菜单名...."/>
                 </div>
             </div>
            <div class="form-group">
                 <label  class="col-sm-2 control-label" >菜单类型</label>
                 <div class="col-sm-4">
                   <input type="radio" name="add_menuType" value="1"/>菜单
                   <input type="radio" name="add_menuType" value="2"/>按钮
                 </div>
             </div>
            <div class="form-group">
                 <label  class="col-sm-2 control-label" >菜单路径</label>
                 <div class="col-sm-4">
                   <input type="text"  class="form-control"   id="add_menuUrl"  placeholder="请输入菜单路径...."/>
                 </div>
             </div>
        </form>
    </div>



    <div id="updateMenuDiv" style="display: none">
        <form class="form-horizontal" >
            <div class="form-group">
                <label  class="col-sm-2 control-label" >菜单名</label>
                     <div class="col-sm-4">
                     <input type="text"  class="form-control"   id="update_menuName"  placeholder="请输入菜单名...."/>
                     </div>
             </div>
            <div class="form-group">
                 <label  class="col-sm-2 control-label" >菜单类型</label>
                     <div class="col-sm-4">
                        <input type="radio" name="update_menuType" value="1"/>菜单
                        <input type="radio" name="update_menuType" value="2"/>按钮
                     </div>
                </div>
            <div class="form-group">
                 <label  class="col-sm-2 control-label" >菜单路径</label>
                     <div class="col-sm-4">
                         <input type="text"  class="form-control"   id="update_menuUrl"  placeholder="请输入菜单路径...."/>
                    </div>
            </div>
        </form>
    </div>
    <jsp:include page="/common/script.jsp"></jsp:include>
<script>
    $(function(){
         initZtree();
         initCopy();
    });
    var addMenuCommmon;
    var updateMenuCommmon;
    function initCopy(){
        addMenuCommmon=$("#addMenuDiv").html();
        updateMenuCommmon=$("#updateMenuDiv").html();
    }
    var v_addMenu
    function addMenu(){
            var treeObj = $.fn.zTree.getZTreeObj("in");
            var nodes = treeObj.getSelectedNodes();
            if(nodes.length == 1){
                    var v_pId=nodes[0].id;
                    v_addMenu=bootbox.dialog({
                    title: '新增菜单信息',
                    message: $("#addMenuDiv form"),
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
                    var v_menuName=$("#add_menuName",v_addMenu).val();
                    var v_menuType=$("[name='add_menuType']:checked",v_addMenu).val();
                    var v_menuUrl=$("#add_menuUrl",v_addMenu).val();
                    $.post({
                    url:"/menu/add.jhtml",
                    data:{"menuName":v_menuName,"fatherId":v_pId,"menuType":v_menuType,"menuUrl":v_menuUrl},
                    success:function(result){
                    if(result.code==200){
                        bootbox.alert("新增成功!", function(){
                            var newNodes = {id:result.data,name:v_menuName,pId:v_pId,menuType:v_menuType,menuUrl:v_menuUrl};
                            treeObj.addNodes(nodes[0],newNodes);
                     });
                    }
                    },
                    })
                    }
                    }
                    }
                    });
                    $("#addMenuDiv").html(addMenuCommmon);
            }else {
                if(nodes.length>1){
                     bootbox.alert("只能选择一个!", function(){  });
                }else{
                     bootbox.alert("至少选择一个!", function(){  });
                 }
            }
    }
    var v_updateMenu
    function updateMenu(){
         var treeObj = $.fn.zTree.getZTreeObj("in");
         var nodes = treeObj.getSelectedNodes();
         if(nodes.length == 1){
             var v_id=nodes[0].id;
             var v_nodeName=nodes[0].name;
             var v_menuType=nodes[0].menuType;
             console.log(v_menuType);
             var v_menuUrl=nodes[0].menuUrl;
             $("#update_menuName").val(v_nodeName);
             $("[name='update_menuType']").each(function(){
                if(this.value==v_menuType){
                    this.checked=true;
                }
             })
             $("#update_menuUrl").val(v_menuUrl);
             v_updateMenu=bootbox.dialog({
            title: '修改菜单信息',
             message: $("#updateMenuDiv form"),
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
                     var v_menuName=$("#update_menuName",v_updateMenu).val();
                     var v_menuType=$("[name='update_menuType']:checked",v_updateMenu).val();
                     var v_menuUrl=$("#update_menuUrl",v_updateMenu).val();
                    $.post({
                         url:"/menu/update.jhtml",
                        data:{"menuName":v_menuName,"id":v_id,"menuType":v_menuType,"menuUrl":v_menuUrl},
                     success:function(result){
                        if(result.code==200){
                             bootbox.alert("修改成功!", function(){
                            if (nodes.length>0) {
                                  nodes[0].name = v_menuName;
                                  nodes[0].menuType = v_menuType;
                                  nodes[0].menuUrl = v_menuUrl;
                                  treeObj.updateNode(nodes[0]);
                            }
                            });
                            }
                         },
                     })
                   }
               }
              }
            });
                 $("#updateMenuDiv").html(updateMenuCommmon);
          }else {
                if(nodes.length>1){
                    bootbox.alert("只能选择一个!", function(){  });
                }else{
                     bootbox.alert("至少选择一个!", function(){  });
                 }
             }
         }
    function delAll(){
        var treeObj = $.fn.zTree.getZTreeObj("in");
        var nodes = treeObj.getSelectedNodes();
        var newNodes = treeObj.transformToArray(nodes);
        if(newNodes.length > 0){
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
                 var nodeArr=[];
                 for(var i=0;i<newNodes.length;i++){
                    nodeArr.push(newNodes[i].id);
                 }
                 if (result == true) {
                     $.post({
                        url:"/menu/delAll.jhtml",
                       data:{"list":nodeArr},
                    success:function(result){
                        if(result.code==200){
                  bootbox.alert("删除成功!", function(){
                        for (var i=newNodes.length-1; i>=0 ;i--) {
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
            bootbox.alert("只能选择一个!", function(){  });
     }
    }
    //初始化Ztree
    function initZtree(){
        $.post({
        url:"/menu/queryMenuList.jhtml",
        async:false,
        success:function(result){
            if(result.code==200){
                var setting = {
                    data: {
                         simpleData: {
                         enable: true
                    }
                 }
                };
                $.fn.zTree.init($("#in"), setting, result.data);
                //父节点展开
                var treeObj=$.fn.zTree.init($("#in"), setting, result.data);
                treeObj.expandAll(true);
            }
            },
        })
    }
</script>
</body>
</html>
