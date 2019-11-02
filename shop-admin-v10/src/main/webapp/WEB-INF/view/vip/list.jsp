<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
<jsp:include page="/common/head.jsp"></jsp:include>
    <title>用户会员信息</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">查询会员信息</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="formId">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">账户名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="userName" placeholder="请输入用户名....">
                            </div>
                            <label  class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control"  id="realName"  placeholder="请输入真实姓名....">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">生日时间</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text"  id="minBirthday" class="form-control" placeholder="开始时间...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text"  id="maxBirthday" class="form-control" placeholder="结束时间...." >
                                </div>
                            </div>
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
            <div class="panel panel-info">
                <div class="panel-heading">会员信息列表</div>
                <table class="table table-striped table-bordered" id="vipTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>真实姓名</th>
                        <th>手机号</th>
                        <th>地区</th>
                        <th>邮箱</th>
                        <th>地址</th>
                        <th>生日</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户Id</th>
                        <th>账户名称</th>
                        <th>真实姓名</th>
                        <th>手机号</th>
                        <th>地区</th>
                        <th>邮箱</th>
                        <th>地址</th>
                        <th>生日</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>




<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    $(function(){
        initTable();
        initSearch();
        initSearchArea(0);
    })
    function initSearch(){
        $("#minBirthday").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
        $("#maxBirthday").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function search(){
        var  v_userName=$("#userName").val();
        var  v_realName= $("#realName").val();
        var  v_minBirthday= $("#minBirthday").val();
        var  v_maxBirthday= $("#maxBirthday").val();
        var v_areaId1=$($("select[name='areaName']")[0]).val();
        var v_areaId2=$($("select[name='areaName']")[1]).val();
        var v_areaId3=$($("select[name='areaName']")[2]).val();
        var param={};
        param.userName=v_userName;
        param.realName=v_realName;
        param.minBirthday=v_minBirthday;
        param.maxBirthday=v_maxBirthday;
        param.areaId1=v_areaId1;
        param.areaId2=v_areaId2;
        param.areaId3=v_areaId3;
        vipTable.settings()[0].ajax.data=param;
        vipTable.ajax.reload();
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
    var vipTable;
    function initTable(){
        vipTable=$('#vipTableId').DataTable( {
                "processing": true,
                "serverSide": true,
                "searching":false,
                "ajax": {
                    "url": "/vip/querySearch.jhtml",
                    "type": "POST",
                    "dataSrc": function (result) {
                        result.recordsTotal=result.data.recordsTotal;
                        result.recordsFiltered=result.data.recordsFiltered;
                        result.draw=result.data.draw;
                        return result.data.data;
                    }
                },
                "columns": [
                    { "data": "id"},
                    { "data": "userName" },
                    { "data": "realName" },
                    { "data": "phone" },
                    { "data": "areaName" },
                    { "data": "email"},
                    { "data": "address" },
                    { "data": "birthday"},
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
