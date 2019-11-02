<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-29
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
</head>
<body>
<form>
账号<input id="userName"  placeholder="请输入用户名" autocomplete="off"><br>
密码<input type="password" id="password" placeholder="请输入密码"><br>
    <a href="/index/forgetPassword.jhtml">忘记密码?</a><br>
<input onclick="login()" type="button" value="登录"/>
<input type="reset" >
</form>
<script src="/jsp/jquery-3.3.1.js"></script>
<script>
    function  login(){
        var v_userName=$("#userName").val();
        var v_password=$("#password").val();
        $.post({
            url:"/user/login.jhtml",
            data:{"userName":v_userName,"password":v_password},
            success:function(result){
                if(result.code==200){
                    location.href="/index/index.jhtml";
                }else{
                    alert(result.msg);
                }
            }
        })
    }
</script>
</body>
</html>
