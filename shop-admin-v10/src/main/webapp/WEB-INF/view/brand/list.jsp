<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-24
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">查询品牌信息</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="shopForm">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">品牌名称</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text"  id="search_brandName" class="form-control" placeholder="请输入品牌名称...." >
                                </div>
                            </div>
                        </div>
                        <div style="text-align: center">
                            <button type="button" class="btn btn-success" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                            <button type="reset"  class="btn btn-default" ><i class="glyphicon glyphicon-refresh"></i>重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <button type="button" class="btn btn-success" onclick="addBrand()"><i class="glyphicon glyphicon-plus"></i>新增</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">品牌信息列表</div>
                <table class="table table-striped table-bordered" id="userTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户Id</th>
                        <th>品牌名称</th>
                        <th>热销</th>
                        <th>排序</th>
                        <th>图片</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户Id</th>
                        <th>品牌名称</th>
                        <th>热销</th>
                        <th>排序</th>
                        <th>图片</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="addBrandDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >品牌名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_brandName" placeholder="请输入品牌名称....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >热销</label>
            <div class="col-sm-4">
                <input type="radio"  name="add_popular"  value="0">热销
                <input type="radio"  name="add_popular"  value="1">普通
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >图片</label>
            <div class="col-sm-4">
                <input type="file" name="phonePath" id="add_imgPathId">
                <input type="hidden" id="add_fileId">
            </div>
        </div>
    </form>
</div>

<div id="updateBrandDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >角色名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_brandName" placeholder="请输入角色名....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >热销</label>
            <div class="col-sm-4">
                <input type="radio"  name="update_popular"   value="0">热销
                <input type="radio"  name="update_popular"   value="1">普通
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >图片</label>
            <div class="col-sm-4">
                <input type="file" name="phonePath" id="update_imgPathId">
                <input type="hidden" id="update_fileId">
                <input type="hidden" id="update_formerPhoto">
            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var add_common;
    var update_common;
    $(function(){
        add_common=$("#addBrandDiv").html(),
        update_common=$("#updateBrandDiv").html(),
        initTable();
    })
    function fileinput5(type){
        var ss = $("#update_fileId").val();
        var pic = "";
        if(ss != null && ss!=""){
            pic = '<img src="'+ss+'" width="100px">';
        }
        var prefix = type==1?"add":"update";
        $("#"+prefix+"_imgPathId").fileinput({
            language: 'zh', //设置语言,
            uploadUrl : "/file/downloadFileALiOSS.jhtml", /*上传图片的url*/
            allowedFileExtensions : [ 'jpg', 'png', 'gif' ],//接收的文件后缀
            showUpload:true, //是否显示上传按钮
            overwriteInitial : false,
            maxFileCount:5, //表示允许同时上传的最大文件个数
            initialPreview:[pic],
            slugCallback : function(filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        });
        $("#"+prefix+"_imgPathId").on('fileuploaded', function(event, data, previewId, index) {
            var result=data.response;
            if(result.code==200){
                if(type == 1){
                    $("#"+prefix+"_fileId",add_brand).val(data.response.data);
                }else{
                    $("#"+prefix+"_fileId",update_brand).val(data.response.data);
                }
            }
        });
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
                        url:"/brand/del.jhtml",
                        data:{"id":data},
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
    }
    var add_brand;
    function addBrand(){
        fileinput5(1);
        add_brand=bootbox.dialog({
            title: '新增品牌信息',
            message: $("#addBrandDiv form"),
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
                        var v_brandName=$("#add_brandName",add_brand).val();
                        var v_imgPath=$("#add_fileId",add_brand).val();
                        var v_popular=$("input[name='add_popular']:checked",add_brand).val();
                        var v_param={};
                        v_param.brandName=v_brandName;
                        v_param.popular=v_popular;
                        v_param.imgPath=v_imgPath;
                        $.post({
                            url:"/brand/add.jhtml",
                            data:v_param,
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("新增成功!", function(){
                                        location.reload();
                                    });
                                }
                            },
                        })
                    }
                }
            }
        });
        $("#addBrandDiv").html(add_common);
    }
    var update_brand;
    function updateBrand(data){
        $.post({
            url:"/brand/toupdate.jhtml",
            data:{"id":data},
            success:function(result){
                if(result.code==200){

                    $("#update_brandName").val(result.data.brandName);
                    $("[name='update_popular']").each(function () {
                        if(result.data.popular==this.value){
                            this.checked=true;
                        }
                    })
                    $("#update_fileId").val(result.data.imgPath);

                    fileinput5(2);
                    update_brand=bootbox.dialog({
                        title: '修改品牌信息',
                        message: $("#updateBrandDiv form"),
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
                                    var v_brandName=$("#update_brandName",update_brand).val();
                                    var v_popular=$("input[name='update_popular']:checked",update_brand).val();
                                    var v_imgPath=$("#update_fileId",update_brand).val();
                                    var v_formerPhoto=$("#update_formerPhoto",update_brand).val();
                                    $.post({
                                        url:"/brand/update.jhtml",
                                        data:{
                                                "brandName":v_brandName,
                                                "popular":v_popular,
                                                "imgPath":v_imgPath,
                                                "id":data,
                                                "formerPhoto":v_formerPhoto
                                             },
                                        success:function(result){
                                            if(result.code==200){
                                                bootbox.alert("修改成功!", function(){
                                                    location.reload();
                                                });
                                            }
                                        },
                                    })
                                }
                            }
                        }
                    });
                    $("#updateBrandDiv").html(update_common);
                }
            },
        })
    }
    function search(){
        var  v_search_brandName=$("#search_brandName").val();
        var param={};
        param.brandName=v_search_brandName;
        brandTable.settings()[0].ajax.data=param;
        brandTable.ajax.reload();
    }
    function updatePopular(id,popular){
        bootbox.confirm({
            message: "你确定要修改吗?",
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
                        url:"/brand/updatePopular.jhtml",
                        data:{"id":id,"popular":popular},
                        success:function(result){
                            if(result.code==200){
                                bootbox.alert("修改成功!", function(){
                                    location.reload();
                                });
                            }
                        },
                    })
                }
            }
        });
    }
    function updateSort(id){
        bootbox.confirm({
            message: "你确定要修改吗?",
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
                    var v_sortId=$("#sort_"+id).val();
                    $.post({
                        url:"/brand/updateSort.jhtml",
                        data:{"id":id,"sort":v_sortId},
                        success:function(result){
                            if(result.code==200){
                                bootbox.alert("修改成功!", function(){
                                    location.reload();
                                });
                            }
                        },
                    })
                }
            }
        });
    }
    var brandTable;
    function initTable(){
        brandTable= $('#userTableId').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching":false,
            "ajax": {
                "url": "/brand/queryBrandList.jhtml",
                "type": "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "brandName" },
                { "data": "popular",render:function(data, type, row, meta){
                        return data==0?"热销<font color='red'><i class='glyphicon glyphicon-fire'></i></font>":"普通"
                    } },
                { "data": "sort" ,render:function(data, type, row, meta){
                        return '<input type="text" class="form-control" id="sort_'+row.id+'" value="'+row.sort+'">' +
                            '<button  class="btn btn-info" onclick="updateSort(\''+row.id+'\')"><i class="glyphicon glyphicon-refresh"></i>刷新</button>';
                    }},
                { "data": "imgPath" ,render:function(data, type, row, meta){
                        return "<img src='"+data+"' height='50px' width='50px'>";
                    }},
                { "data": "id",render:function(data, type, row, meta){
                     var v_btn="";
                     var v_class="";
                     var v_content="";
                     var v_popular=row.popular;
                     var v_hot="";
                     if(v_popular==0){
                         v_btn="btn btn-info";
                         v_class="glyphicon glyphicon-leaf";
                         v_content="普通";
                         v_hot=1;
                     }else{
                         v_btn="btn btn-warning";
                         v_class="glyphicon glyphicon-fire";
                         v_content="热销";
                         v_hot=0;
                     }
                        return "<div class=\"btn-group\" role=\"group\" >\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick='updateBrand("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\"  onclick='del("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class='"+v_btn+"'  onclick='updatePopular("+data+","+v_hot+")'><i class='"+v_class+"'></i>"+v_content+"</button>\n" +
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
