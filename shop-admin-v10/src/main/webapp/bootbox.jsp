<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: lishihui
  Date: 2019-08-19
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Title</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="page-header">
                <h2>新增账户信息</h2>
            </div>
            <form id="resultFrom" method="post" class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-3 control-label">账户名称</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="username" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">邮箱地址</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="email" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">密码</label>
                    <div class="col-sm-5">
                        <input type="password" class="form-control" name="password" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">性别</label>
                    <div class="col-sm-5">
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" value="male" /> 男
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" value="female" />女
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">时间</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="birthday" placeholder="YYYY-MM-DD" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button type="submit" class="btn btn-default">Sign up</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    $(function() {
        $('#resultFrom').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The username is required and cannot be empty'
                        },
                        stringLength: {
                            min: 6,
                            max: 10,
                            message: '请输入6到10位汉字'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9]+$/,
                            message: 'The username can only consist of alphabetical and number'
                        },
                        different: {
                            field: 'password',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: 'The email address is required and cannot be empty'
                        },
                        emailAddress: {
                            message: '请输入正确的邮箱地址'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: 'The password is required and cannot be empty'
                        },
                        different: {
                            field: 'username',
                            message: 'The password cannot be the same as username'
                        },
                        stringLength: {
                            min: 8,
                            message: 'The password must have at least 8 characters'
                        }
                    }
                },
                birthday: {
                    validators: {
                        notEmpty: {
                            message: 'The date of birth is required'
                        },
                        date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date of birth is not valid'
                        }
                    }
                },
                gender: {
                    validators: {
                        notEmpty: {
                            message: 'The gender is required'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
