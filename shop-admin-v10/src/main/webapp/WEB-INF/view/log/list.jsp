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
                <div class="panel-heading">查询日志信息</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="userName" placeholder="请输入用户名....">
                            </div>
                            <label  class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名....">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">开始日期</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text"  id="startCurrDate" class="form-control"  placeholder="开始日期...." >
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text"  id="overCurrDate" class="form-control" placeholder="结束日期...." >
                                </div>
                            </div>
                            <label  class="col-sm-2 control-label">状态</label>
                            <div class="col-sm-4">
                                <select id="status" class="form-control">
                                    <option value="-1">请选择</option>
                                    <option value="1">成功信息</option>
                                    <option value="0">失败信息</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">操作信息</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="info" placeholder="请输入操作信息....">
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
            <div class="panel panel-info">
                <div class="panel-heading">日志列表</div>
                <table class="table table-striped table-bordered" id="logTableId" style="width:100%">
                    <thead>
                    <tr>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>具体内容</th>
                        <th>访问时间</th>
                        <th>操作内容</th>
                        <th>操作状态</th>
                        <th>错误信息</th>
                        <th>详细信息</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>具体内容</th>
                        <th>访问时间</th>
                        <th>操作内容</th>
                        <th>操作状态</th>
                        <th>错误信息</th>
                        <th>详细信息</th>
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
    })
    function initSearch(){
        $("#startCurrDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
        $("#overCurrDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: moment.locale('zh-CN'),
            showClear:true,
        });
    }
    function search(){
        var  v_userName=$("#userName").val();
        var  v_realName= $("#realName").val();
        var  v_startCurrDate= $("#startCurrDate").val();
        var  v_overCurrDate= $("#overCurrDate").val();
        var  v_status=$("#status").val();
        var  v_info= $("#info").val();
        var param={};
        param.userName=v_userName;
        param.realName=v_realName;
        param.startCurrDate=v_startCurrDate;
        param.overCurrDate=v_overCurrDate;
        param.status=v_status;
        param.info=v_info;
        logTable.settings()[0].ajax.data=param;
        logTable.ajax.reload();
    }
    var logTable;
    var remarkShowLength=10;
    function initTable(){
        logTable=$('#logTableId').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching":false,
            "ajax": {
                "url": "/log/queryLogList.jhtml",
                "type": "POST"
            },
            "columns": [
                { "data": "userName" },
                { "data": "realName" },
                { "data": "content" },
                { "data": "currDate" },
                { "data": "info" },
                { "data": "status",render:function(data, type, row, meta){
                        return data==1?"成功信息":"失败信息"
                }},
                { "data": "errorMsg"},
                { "data": "detail"},
            ],
            "lengthMenu": [ 5, 10, 15, 20],
            "language": {
                "url": "/jsp/Chinese.json"
            },
            "columnDefs" : [{
                "targets": 4,
                "render": function (data, type, full, meta) {
                    if (full.info.length > remarkShowLength && full.info!=null) {
                        return getPartialRemarksHtml(full.info);//显示部分信息
                    } else {
                        return full.info;//显示原始全部信息 }
                    }
                }
            },{
                "targets": 7,
                "render": function (data, type, full, meta) {
                    if (full.detail.length > remarkShowLength && full.detail!=null) {
                        return getPartialRemarksHtml(full.detail);//显示部分信息
                    } else {
                        return full.detail;//显示原始全部信息 }
                    }
                }
            }
            ],
            "createdRow": function( row, data, dataIndex ) {
                if(data.info.length > remarkShowLength){//只有超长，才有td点击事件
                    $(row).children('td').eq(4).attr('onclick','javascript:changeShowRemarks(this);');
                }
                $(row).children('td').eq(4).attr('content',data.info);
                if(data.detail.length > remarkShowLength){//只有超长，才有td点击事件
                    $(row).children('td').eq(7).attr('onclick','javascript:changeShowRemarks(this);');
                }
                $(row).children('td').eq(7).attr('content',data.detail);
            },
        } );
    }
    function changeShowRemarks(obj){//obj是td
        var content = $(obj).attr("content");

        if($(obj).attr("isDetail") == 'true'){//当前显示的是详细备注，切换到显示部分
            //$(obj).removeAttr('isDetail');//remove也可以
            $(obj).attr('isDetail',false);
            $(obj).html(getPartialRemarksHtml(content));
        }else{//当前显示的是部分备注信息，切换到显示全部
            $(obj).attr('isDetail',true);
            $(obj).html(getTotalRemarksHtml(content));
        }

    }

    //部分备注信息
    function getPartialRemarksHtml(remarks){
        return remarks.substr(0,remarkShowLength) + '&nbsp;&nbsp;<a href="javascript:void(0);" ><b>...</b></a>';
    }

    //全部备注信息
    function getTotalRemarksHtml(remarks){
        return remarks + '&nbsp;&nbsp;<a href="javascript:void(0);" >收起</a>';
    }
</script>
</body>
</html>
