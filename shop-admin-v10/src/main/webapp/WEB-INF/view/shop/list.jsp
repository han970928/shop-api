<!DOCTYPE html>
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
                <div class="panel-heading">查询商品信息</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="shopForm">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">商品名称</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="shopName" name="shopName" placeholder="请输入商品名成....">
                            </div>
                            <label  class="col-sm-2 control-label">价格范围</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minPrice" name="minPrice" placeholder="最低价格...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-jpy"></i></span>
                                    <input type="text" class="form-control" id="maxPrice" name="maxPrice" placeholder="最高价格...." >
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">生产日期</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text"  id="minDate" class="form-control" name="minDate" placeholder="出厂日期...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text"  id="maxDate" class="form-control" name="maxDate" placeholder="过期日期...." >
                                </div>
                            </div>
                            <label  class="col-sm-2 control-label" >品牌</label>
                            <div class="col-sm-4" >
                                <div id="search_brandDiv"  name="shopId"></div>
                            </div>
                        </div>
                        <div class="form-group" id="search_classify">
                            <label  class="col-sm-2 control-label" >分类</label>
                            <input type="hidden"  name="classifyId1"  id="classifyId1">
                            <input type="hidden"  name="classifyId2"  id="classifyId2">
                            <input type="hidden"  name="classifyId3"  id="classifyId3">
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
            <button  class="btn btn-success" onclick="addShop()"><i class="glyphicon glyphicon-plus"></i>新增</button>
            <button  class="btn btn-info" onclick="downExcel()"><i class="glyphicon glyphicon-download-alt"></i>导出Excel</button>
            <button  class="btn btn-info"><i class="glyphicon glyphicon-download-alt"></i>导出Word</button>
            <button  class="btn btn-info"><i class="glyphicon glyphicon-download-alt"></i>导出Pdf</button>
            <button  class="btn btn-info" onclick="clean()"><i class="glyphicon glyphicon-refresh"></i>刷新缓存</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">商品信息列表</div>
                <table class="table table-striped table-bordered" id="userTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户Id</th>
                        <th>商品名称</th>
                        <th>商品价格</th>
                        <th>生产时间</th>
                        <th>图片</th>
                        <th>库存</th>
                        <th>热销状态</th>
                        <th>上架状态</th>
                        <th>分类</th>
                        <th>品牌</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户Id</th>
                        <th>商品名称</th>
                        <th>商品价格</th>
                        <th>生产时间</th>
                        <th>图片</th>
                        <th>库存</th>
                        <th>热销状态</th>
                        <th>上架状态</th>
                        <th>分类</th>
                        <th>品牌</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="addShopDiv" style="display:none;" >
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >商品名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_shopName" placeholder="请输入商品名称....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_price" placeholder="请输入价格....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >生产时间</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_productiveTime"  placeholder="请输入生产时间....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-4">
                <input type="file" name="imgss" id="file" >
                <input type="hidden"  id="add_fileinput">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >库存</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_stock"  placeholder="请输入库存....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >热销</label>
            <div class="col-sm-4">
                <input type="radio"  name="add_isHot"  value="0">热销
                <input type="radio"  name="add_isHot"  value="1">普通
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >上架</label>
            <div class="col-sm-4">
                <input type="radio"  name="add_isShelf"  value="0">上架
                <input type="radio"  name="add_isShelf"  value="1">下架
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >品牌</label>
            <div class="col-sm-4">
                <div id="add_brandDiv"></div>
            </div>
        </div>
        <div class="form-group" id="add_classify">
            <label  class="col-sm-2 control-label" >分类</label>
        </div>
    </form>
</div>

<div id="updateShopDiv" style="display: none">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label" >商品名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_shopName" placeholder="请输入商品名称....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_price" placeholder="请输入价格....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >生产时间</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_productiveTime"  placeholder="请输入生产时间....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-4">
                <input type="file" name="imgss" id="update_imgFilePath" >
                <input type="hidden"  id="hidden_FileUrl">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >库存</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_stock"  placeholder="请输入库存....">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >热销</label>
            <div class="col-sm-4">
                <input type="radio"  name="update_isHot"   value="0">热销
                <input type="radio"  name="update_isHot"   value="1">普通
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >上架</label>
            <div class="col-sm-4">
                <input type="radio"  name="update_isShelf"  value="0" >上架
                <input type="radio"  name="update_isShelf"  value="1">下架
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label" >品牌</label>
            <div class="col-sm-4">
                <div id="update_brandDiv"></div>
            </div>
        </div>
        <div class="form-group" id="update_classify">
            <label  class="col-sm-2 control-label" >分类</label>
        </div>
    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var add_common;
    var update_common;
    $(function(){
        queryBrandList("add_brandDiv","add_brandDivId");
        queryBrandList("update_brandDiv","update_brandDivId");
        queryBrandList("search_brandDiv","search_brandDivId");
        initCopy();
        initTable();
        initDate("add_productiveTime");
        initDate("update_productiveTime");
        initSearch();
        fileinput5();
        searchClassifyId(0);
    })
    //分类
    function initClassifyId(id,obj){
        if(obj){
            //因为最外面有一个Div，所以要获取到他的父亲，
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/classify/queryClassify.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    var classifyList=result.data;
                    if(classifyList.length==0){
                        return;
                    }
                    var  kong="<div class='col-sm-3'>" +
                        "<select  class='form-control' name='classifyName' onchange='initClassifyId(this.value,this)'>" +
                        "<option value='-1' >===请选择===</option>";
                        for(var i=0;i<classifyList.length;i++){
                            kong+="<option value='"+classifyList[i].id+"'>"+classifyList[i].name+"</option>";
                        }
                    kong+="</select></div>";
                    $("#add_classify",add_shop).append(kong);
                }
            }
        })
    }
    function updateClassifyId(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/classify/queryClassify.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    var classifyList=result.data;
                    if(classifyList.length==0){
                        return;
                    }
                    var  kong="<div class='col-sm-2'>" +
                        "<select  class='form-control' name='classifyName' onchange='updateClassifyId(this.value,this)'>" +
                        "<option value='-1' >===请选择===</option>";
                    for(var i=0;i<classifyList.length;i++){
                        kong+="<option value='"+classifyList[i].id+"'>"+classifyList[i].name+"</option>";
                    }
                    kong+="</select></div>";
                    $("#update_classify",update_shop).append(kong);
                }
            }
        })
    }
    function searchClassifyId(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/classify/queryClassify.jhtml",
            data:{"id":id},
            success:function(result){
                if(result.code==200){
                    var classifyList=result.data;
                    if(classifyList.length==0){
                        return;
                    }
                    var  kong="<div class='col-sm-3'>" +
                        "<select  class='form-control' name='classifyName' onchange='searchClassifyId(this.value,this)'>" +
                        "<option value='-1' >===请选择===</option>";
                    for(var i=0;i<classifyList.length;i++){
                        kong+="<option value='"+classifyList[i].id+"'>"+classifyList[i].name+"</option>";
                    }
                    kong+="</select></div>";
                    $("#search_classify").append(kong);
                }
            }
        })
    }
    //清楚缓存
    function clean(){
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
                        url:"/clean/cleanCache.jhtml",
                        success:function(result){
                            if(result.code==200){
                                bootbox.alert("刷新成功!", function(){
                                    search();
                                });
                            }
                        },
                    })
                }
            }
        });
    }
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
            $("#add_fileinput",add_shop).val(data.response.imgs);
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
            $("#hidden_FileUrl",update_shop).val(data.response.imgs);
        })
    }
    function queryBrandList(element,brandDivId){
        $.post({
            url:"/brand/queryBrand.jhtml",
            success:function(result){
                if(result.code==200){
                     brandList=result.data;
                    var brandStr="<select class='form-control' id='"+brandDivId+"'><option value='-1'  >===请选择===</option>";
                    for(var i=0;i<brandList.length;i++){
                        brandStr+="<option value='"+brandList[i].id+"'>"+brandList[i].brandName+"</option>";
                    }
                    brandStr+="</select>";
                    $("#"+element).append(brandStr);
                }
            }

        })
    }
    function downExcel(){
        var v_c1=$($("select[name='classifyName']",$("#shopForm"))[0]).val();
        var v_c2=$($("select[name='classifyName']",$("#shopForm"))[1]).val();
        var v_c3=$($("select[name='classifyName']",$("#shopForm"))[2]).val();
        $("#classifyId1").val(v_c1);
        $("#classifyId2").val(v_c2);
        $("#classifyId3").val(v_c3);
        var v_shopForm=document.getElementById("shopForm");
        v_shopForm.action="/shop/downExcel.jhtml";
        v_shopForm.method="post";
        v_shopForm.submit();
    }
    function initCopy(){
        add_common=$("#addShopDiv").html();
        update_common=$("#updateShopDiv").html();
    }
    function initDate(elementShop){
        $("#"+elementShop).datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function initSearch(){
        $("#minDate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
        $("#maxDate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function editClassify(obj){
        //先把回显到的数据清空
        $(obj).parent().nextAll().remove();
        //替换成下拉框
        updateClassifyId(0);
        //在这个范围中，将取消编辑拼接进去
        $("#update_classify",update_shop).html("<label  class='col-sm-2 control-label' >分类</label><button type='button' onclick='cancelClassify()'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>取消编辑</button>");
    }
    function cancelClassify(){
        //取消编辑的同时，将值恢复到原来的样子
        $("#update_classify",update_shop).html("<label  class='col-sm-2 control-label' >分类</label>\n" +
            "        </div>"+v_classifyName+"<button type='button' onclick='editClassify(this)'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>编辑</button>");
    }
    var add_shop;
    function addShop(){
        add_shop=bootbox.dialog({
            title: '新增商品信息',
            message: $("#addShopDiv form"),
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
                        var v_shopName=$("#add_shopName",add_shop).val();
                        var v_price=$("#add_price",add_shop).val();
                        var v_productiveTime=$("#add_productiveTime",add_shop).val();
                        var v_stock=$("#add_stock",add_shop).val();
                        var v_isHot=$("input[name='add_isHot']:checked",add_shop).val();
                        var v_isShelf=$("input[name='add_isShelf']:checked",add_shop).val();
                        var v_brandId=$("#add_brandDivId",add_shop).val();
                        var v_fileinput=$("#add_fileinput",add_shop).val();
                        var v_classify1=$($("select[name='classifyName']",add_shop)[0]).val();
                        var v_classify2=$($("select[name='classifyName']",add_shop)[1]).val();
                        var v_classify3=$($("select[name='classifyName']",add_shop)[2]).val();
                        var v_param={};
                        v_param.shopName=v_shopName;
                        v_param.price=v_price;
                        v_param.productiveTime=v_productiveTime;
                        v_param.stock=v_stock;
                        v_param.isHot=v_isHot;
                        v_param.isShelf=v_isShelf;
                        v_param.brandId=v_brandId;
                        v_param.imgPath=v_fileinput;
                        v_param.classifyId1=v_classify1;
                        v_param.classifyId2=v_classify2;
                        v_param.classifyId3=v_classify3;
                        $.post({
                            url:"/shop/add.jhtml",
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
        $("#addShopDiv").html(add_common);
        initDate("add_productiveTime");
        queryBrandList("add_brandDiv","add_add_brandDivId");
        fileinput5();
        initClassifyId(0);
    }
    var update_shop;
    var v_classifyName;
    function updateShop(data){
        $.post({
            url:"/shop/toupdate.jhtml",
            data:{"id":data},
            success:function(result){
                if(result.code==200){
                    $("#update_shopName").val(result.data.shopName);
                    $("#update_price").val(result.data.price);
                    $("#update_productiveTime").val(result.data.productiveTime);
                    $("#update_stock").val(result.data.stock);
                    $("#update_brandDivId").val(result.data.brandId);
                    $("[name='update_isHot']").each(function () {
                        if(result.data.isHot==this.value){
                            this.checked=true;
                        }
                    })
                    $("[name='update_isShelf']").each(function () {
                        if(result.data.isShelf==this.value){
                            this.checked=true;
                        }
                    })
                    $("#hidden_FileUrl").val(result.data.imgPath);
                    updateFileInput();
                    v_classifyName=result.data.classifyName;
                    $("#update_classify").append(result.data.classifyName+"<button type='button' onclick='editClassify(this)'  class='btn btn-default' ><i class='glyphicon glyphicon-pencil'></i>编辑</button>");
                    update_shop=bootbox.dialog({
                        title: '修改商品信息',
                        message: $("#updateShopDiv form"),
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
                                    var v_shopName=$("#update_shopName",update_shop).val();
                                    var v_price=$("#update_price",update_shop).val();
                                    var v_productiveTime=$("#update_productiveTime",update_shop).val();
                                    var v_stock=$("#update_stock",update_shop).val();
                                    var v_isHot=$("input[name='update_isHot']:checked",update_shop).val();
                                    var v_isShelf=$("input[name='update_isShelf']:checked",update_shop).val();
                                    var v_brandId=$("#update_brandDivId",update_shop).val();
                                    var v_update_imgFilePath=$("#hidden_FileUrl",update_shop).val();
                                    var v_classList=$($("select[name='classifyName']",update_shop));
                                    var v_c1;
                                    var v_c2;
                                    var v_c3;
                                    if(v_classList.length==3){
                                        v_c1=$($("select[name='classifyName']",update_shop)[0]).val();
                                        v_c2=$($("select[name='classifyName']",update_shop)[1]).val();
                                        v_c3=$($("select[name='classifyName']",update_shop)[2]).val();
                                    }
                                    var v_param={};
                                    v_param.shopName=v_shopName;
                                    v_param.price=v_price;
                                    v_param.productiveTime=v_productiveTime;
                                    v_param.id=data;
                                    v_param.stock=v_stock;
                                    v_param.isHot=v_isHot;
                                    v_param.isShelf=v_isShelf;
                                    v_param.brandId=v_brandId;
                                    v_param.imgPath=v_update_imgFilePath;
                                    v_param.classifyId1=v_c1;
                                    v_param.classifyId2=v_c2;
                                    v_param.classifyId3=v_c3;
                                   $.post({
                                        url:"/shop/update.jhtml",
                                        data:v_param,
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
                    $("#updateShopDiv").html(update_common);
                    initDate("update_productiveTime");
                    queryBrandList("update_brandDiv","update_brandDivId");
                }
            },
        })
    }
    function search(){
        var  v_shopName=$("#shopName").val();
        var  v_minPrice= $("#minPrice").val();
        var  v_maxPrice= $("#maxPrice").val();
        var  v_minDate= $("#minDate").val();
        var  v_maxDate= $("#maxDate").val();
        var  v_search_brandDiv= $("#search_brandDivId").val();
        //因为获取到是一个数组，通过下标拿值，获取到被选中的，因为是要用到jquery 中的val()取值，所以转换一下
        var v_classify1=$($("select[name='classifyName']")[0]).val();
        var v_classify2=$($("select[name='classifyName']")[1]).val();
        var v_classify3=$($("select[name='classifyName']")[2]).val();
        var param={};
        param.shopName=v_shopName;
        param.minPrice=v_minPrice;
        param.maxPrice=v_maxPrice;
        param.minDate=v_minDate;
        param.maxDate=v_maxDate;
        param.shopId=v_search_brandDiv;
        param.classifyId1=v_classify1;
        param.classifyId2=v_classify2;
        param.classifyId3=v_classify3;
        shopTable.settings()[0].ajax.data=param;
        shopTable.ajax.reload();
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
                        url:"/shop/del.jhtml",
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
    //修改上下架
    function updateShelf(data){
        bootbox.confirm({
            message: "你确定要更改吗?",
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
                        url:"/shop/updateShelf.jhtml",
                        data:{"id":data},
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
        });
    }
    var shopTable;
    function initTable(){
        shopTable= $('#userTableId').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching":false,
            "ajax": {
                "url": "/shop/queryShopList.jhtml",
                "type": "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "shopName" },
                { "data": "price" },
                { "data": "productiveTime" },
                { "data": "imgPath",render:function(data, type, row, meta){
                        var as='<img  src="'+data+'"height="55px">';
                        return as;
                    }},
                { "data": "stock" },
                { "data": "isHot",render:function(data, type, row, meta){
                        return data==0?"热销":"普通"
                    } },
                { "data": "isShelf",render:function(data, type, row, meta){
                        return data==0?"上架":"下架"
                    } },
                { "data": "classifyName" },
                { "data": "brandName" },
                { "data": "id",render:function(data, type, row, meta){
                    var isShelf;
                    if(row.isShelf==1){
                        isShelf='<button class="btn btn-info"  onclick="updateShelf('+data+')"><i class="glyphicon glyphicon-chevron-up"></i>上架</button>'
                    }else{
                        isShelf='<button class="btn btn-warning"  onclick="updateShelf('+data+')"><i class="glyphicon glyphicon-chevron-down"></i>下架</button>'
                    }
                    return "<div  class=\"btn-group\" role=\"group\" >\n" +
                        "  <button class=\"btn btn-success\" onclick='updateShop("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                        "  <button class=\"btn btn-danger\"  onclick='del("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</button>\n"+isShelf;
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
