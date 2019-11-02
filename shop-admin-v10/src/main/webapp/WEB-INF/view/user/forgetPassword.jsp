<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-09-11
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>忘记密码</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">修改</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">邮箱地址</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="email"  placeholder="请输入邮箱地址...." autocomplete="off">
                            </div>
                        </div>
                        <div style="text-align: center">
                            <button type="button" class="btn btn-success" onclick="forGetPassword()"><i class="glyphicon glyphicon-pencil"></i>发送</button>
                            <button type="reset"  class="btn btn-default" ><i class="glyphicon glyphicon-refresh"></i>重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    function forGetPassword(){
        var v_email=$("#email").val();
            bootbox.confirm({
                message: "你确定要发送吗?",
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
                            url:"/user/forGetPassword.jhtml",
                            data:{"email":v_email},
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("新密码已发送，注意查收！", function(){ });
                                }else{
                                    bootbox.alert(result.msg, function(){ });
                                }
                            },
                        })
                    }
                }
            });
    }
</script>
</body>
</html>
