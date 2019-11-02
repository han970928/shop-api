<!DOCTYPE html>
    <html lang="en">
    <head>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <meta charset="utf-8">
        <title>登录</title>
        <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
        <meta name="author" content="Vincent Garreau" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" media="screen" href="/jsp/Demo/style.css">
        <link rel="stylesheet" type="text/css" href="/jsp/Demo/reset.css"/>
        <script type="text/javascript" charset="utf-8" id="tr-app" src="/jsp/Demo/jquery.min.js"></script></head>
    <body>

    <div id="particles-js" style="background: #67b168">
        <div class="login">
            <div class="login-top">登录 </div>
            <div class="login-center clearfix">
                <div class="login-center-img"><img src="/jsp/Demo/name.png"/></div>
                <div class="login-center-input">
                    <input type="text" id="userName" placeholder="请输入您的用户名" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的用户名'" autocomplete="off"/>
                    <div class="login-center-input-text">用户名</div>
                </div>
            </div>
            <div class="login-center clearfix">
                <div class="login-center-img"><img src="/jsp/Demo/password.png"/></div>
                <div class="login-center-input">
                    <input type="password" id="password" placeholder="请输入您的密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的密码'" autocomplete="off"/>
                    <div class="login-center-input-text">密码</div>
                </div>
            </div>
            <div class="login-center clearfix">
                <div class="login-center-img"><img src="/jsp/Demo/name.png"/></div>
                <div class="login-center-input">
                    <img src="/img/code" id="imgCodes"><a href="#" onclick="conversion()">看不清换一张?</a>
                    <input type="text" id="imgCodeId" placeholder="请输入您的验证码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的验证码'" autocomplete="off"/>
                </div>
            </div>
            <div class="login-center clearfix">
                <div class="login-center-input" style="text-align: center">
                    <a href="/index/forgetPassword.jhtml">忘记密码?</a>
                </div>
            </div>
            <div class="login-button" onclick="login()">登录</div>
        </div>
        <div class="sk-rotating-plane"></div>
    </div>


    <script src="/jsp/jquery-3.3.1.js"></script>
    <script src="/jsp/Demo/particles.min.js"></script>
    <script src="/jsp/Demo/app.js"></script>
    <script type="text/javascript">
        function conversion(){
            var times=new Date().getTime();
            $("#imgCodes").prop("src","/img/code?"+times);
        }

        function hasClass(elem, cls) {
            cls = cls || '';
            if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
            return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
        }
        function addClass(ele, cls) {
            if (!hasClass(ele, cls)) {
                ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
            }
        }
        function removeClass(ele, cls) {
            if (hasClass(ele, cls)) {
                var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
                while (newClass.indexOf(' ' + cls + ' ') >= 0) {
                    newClass = newClass.replace(' ' + cls + ' ', ' ');
                }
                ele.className = newClass.replace(/^\s+|\s+$/g, '');
            }
        }
        document.querySelector(".login-button").onclick = function(){
            addClass(document.querySelector(".login"), "active")
            setTimeout(function(){
                removeClass(document.querySelector(".login"), "active")
                removeClass(document.querySelector(".sk-rotating-plane"), "active")
                document.querySelector(".login").style.display = "block"

                var v_userName=$("#userName").val();
                var v_password=$("#password").val();
                var v_imgCode=$("#imgCodeId").val();
                $.post({
                    url:"/user/login.jhtml",
                    data:{"userName":v_userName,"password":v_password,"imgCode":v_imgCode},
                    success:function(result){
                        if(result.code==200){
                            location.href="/index/index.jhtml";
                        }else{
                            alert(result.msg);
                        }
                    }
                })
            },200)
        }
    </script>
    </body>
    </html>