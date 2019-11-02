<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-09-10
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>修改密码</title>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">修改用户密码</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">初始密码</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="oldPassword"  placeholder="请输入初始密码...." autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">新密码</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="newPassword"  placeholder="请输入新密码...." autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">确认密码</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="confirmPassword"  placeholder="请确认密码...." autocomplete="off">
                            </div>
                        </div>
                        <div style="text-align: center">
                            <button type="button" class="btn btn-success" onclick="updatePassword()"><i class="glyphicon glyphicon-pencil"></i>修改</button>
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
    function updatePassword(){
        var v_oldPassword=$("#oldPassword").val();
        var v_newPassword=$("#newPassword").val();
        var v_confirmPassword=$("#confirmPassword").val();
        var v_userId='${user.id}';
        if(v_newPassword == v_confirmPassword){
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
                            url:"/user/updatePassword.jhtml",
                            data:{
                                "oldPassword":v_oldPassword,
                                "newPassword":v_newPassword,
                                "confirmPassword":v_confirmPassword,
                                "userId":v_userId
                            },
                            success:function(result){
                                if(result.code==200){
                                    bootbox.alert("修改成功,请重新登录", function(){
                                        location.reload();
                                    });
                                }
                            },
                        })
                    }
                }
            });
        }else{
            bootbox.alert("两次密码输入不一致!", function(){ });
        }
    }
</script>

</body>
</html>
