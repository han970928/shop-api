    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"  %>
    <%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<style>
        .dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
        }
        .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }
        .dropdown-submenu > a:after {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
        }
        .dropdown-submenu:hover > a:after {
            border-left-color: #fff;
        }
        .dropdown-submenu.pull-left {
            float: none;
        }
        .dropdown-submenu.pull-left > .dropdown-menu {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
        }
    </style>
<nav class="navbar navbar-default" style="background-color: #b2dba1">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/index/index.jhtml">飞狐电商后台管理</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="menuListId">
                <%--<li><a href="/shop/toList.jhtml">商品管理</a></li>
                <li><a href="/area/toList.jhtml">地区管理</a></li>
                <li><a href="/brand/toList.jhtml">品牌管理</a></li>
                <li>
                    <a href="#"  data-toggle="dropdown">系统管理 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/user/toList.jhtml">用户管理</a></li>
                        <li><a href="/role/toList.jhtml">角色管理</a></li>
                        <li><a href="/menu/toList.jhtml">菜单管理</a></li>
                    </ul>
                </li>--%>
            </ul>
            <ul class="nav navbar-nav navbar-right" id="userDiv">
                <li><a href="#" >欢迎##roleNameId##登陆</a></li>
                <li style="display:none;" id="loginDateDiv"><a href="#">上次登录的时间为##loginDateId##</a></li>
                <li><a href="#">今天是第##tocountId##次登录</a></li>
                <li><a href="/user/toUpdatePassword.jhtml">个人中心</a></li>
                <li><a href="/user/loginOut.jhtml">退出</a></li>
            </ul>
        </div>
    </div>
</nav>
<script src="/jsp/jquery-3.3.1.js"></script>
<script>
     $(function(){
         initTop();
         queryMenuListByUserId();
         $.ajaxSetup({
             complete: function (result) {
                 var v_data=result.responseJSON;
                 if(v_data.code && v_data.code!=200 ){
                     bootbox.alert(v_data.msg, function(){})
                 }
             }
         })
     })
     function initTop(){
         $.post({
             url:"/user/initTop.jhtml",
             success:function(result){
                 if(result.code==200){
                     var user=result.data;
                     var userDiv=$("#userDiv").html();
                     var temp =userDiv.replace(/##roleNameId##/g,user.roleName).replace(/##tocountId##/g,user.tocount);
                     $("#userDiv").html(temp);
                     if(user.loginDate){
                        var login=$("#loginDateDiv").html().replace(/##loginDateId##/g,user.loginDateString);
                         $("#loginDateDiv").html(login);
                         $("#loginDateDiv").show();
                     }
                 }
             }
         })
     }
     var menuListArr;
     function queryMenuListByUserId(){
         $.post({
             url:"/menu/queryMenuListByUserId.jhtml",
             success:function(result){
                 if(result.code==200){
                     //取出菜单集合
                     menuListArr=result.data;
                     initMenu(1,1);
                     $("#menuListId").append(menuListStr);
                 }
             }
         })
     }
     var menuListStr="";
    function initMenu(id,level){
        var childArr=getChild(id);
        if(childArr.length>0){
            if(level==1){
                menuListStr+='<ul class="nav navbar-nav">';
            }else{
                menuListStr+='<ul class="dropdown-menu">';
            }
            for(var i=0;i<childArr.length;i++){
               var v_child=getFather(childArr[i].id);
                if(level==1){
                    if(v_child){
                        menuListStr+='<li><a href="'+childArr[i].menuUrl+'" data-toggle="dropdown">'+childArr[i].menuName+'<span class="caret"></span></a>';
                    }else{
                        menuListStr+='<li><a href="'+childArr[i].menuUrl+'">'+childArr[i].menuName+'</a></li>';
                    }
                }else{
                    if(v_child){
                        menuListStr+='<li class="dropdown-submenu"><a href="'+childArr[i].menuUrl+'" >'+childArr[i].menuName+'</a>';
                    }else{
                        menuListStr+='<li><a href="'+childArr[i].menuUrl+'">'+childArr[i].menuName+'</a></li>';
                    }
                }
                initMenu(childArr[i].id,level+1);
                menuListStr+="</li>";
            }
            menuListStr+="</ul>";
        }
    }
    function getChild(menuId){
        var v_childArr=[];
        for(var i=0;i<menuListArr.length;i++){
            if(menuListArr[i].fatherId==menuId){
                v_childArr.push(menuListArr[i]);
            }
        }
        return v_childArr;
    }
    function getFather(childId){
        for(var i=0;i<menuListArr.length;i++){
            if(menuListArr[i].fatherId==childId){
               return true;
            }
        }
        return false;
    }








   /* $(function(){
        queryMenuListByUserId();
    })
   function queryMenuListByUserId(){
        $.post({
            url:"/menu/queryMenuListByUserId.jhtml",
            success:function(result){
                if(result.code==200){
                    menuList=result.data;
                    initMenu();
                }
            }
        })
   }
    var menuList;
    function initMenu(){
        //获取顶层菜单
        var menuStr=getTopHtml();
        //把顶层菜单转换成 jquery 对象
        var v_menu=$(menuStr);
        //获取顶层菜单的Id
        var fatherId=getFatherId();
        for(var i=0;i<fatherId.length;i++){
            //根据菜单Id判断下面是否有子节点
           var child=findChild(fatherId[i]);
           //如果子节点的长度大于0 ,则代表有
            if(child.length>0){
                //根据自定义的属性，来增加属性，
                var v_href=v_menu.find("a[data-id='"+fatherId[i]+"']");
                v_href.attr("data-toggle","dropdown");
                v_href.append('<span class="caret"></span>');
                //给子节点添加对应的值
                var getChild=buidChild(child);
                v_href.parent().append(getChild);
            }
        }
        //已经转换成js 对象，所以放的是转换过的js 对象
        $("#menuListId").html(v_menu);
    }
    //获取到顶级菜单
   function getTopHtml(){
        var menuListStr="";
        for(var i=0;i<menuList.length;i++){
            if(menuList[i].fatherId==1){
                menuListStr+='<li><a href="'+menuList[i].menuUrl+'" data-id="'+menuList[i].id+'">'+menuList[i].menuName+'</a></li>';
            }
        }
        return menuListStr;
   }
    //获取到顶级菜单的Id
   function getFatherId(){
       var menuArr=[];
       for(i=0;i<menuList.length;i++){
           if(menuList[i].fatherId==1){
               menuArr.push(menuList[i].id);
           }
       }
       return menuArr;
   }
   //判断菜单的Id 来找到其对应的子Id
   function findChild(id){
       var childArr=[];
       for(var i=0;i<menuList.length;i++){
           if(menuList[i].fatherId==id){
               childArr.push(menuList[i]);
           }
       }
       return childArr;
   }
   //获取父节点下面的子节点
   function buidChild(child){
       var v_child='<ul class="dropdown-menu">';
       for(var i=0;i<child.length;i++){
           v_child+='<li><a href="'+child[i].menuUrl+'">'+child[i].menuName+'</a></li>';
       }
       v_child+='</ul>';
       return v_child;
   }*/
</script>
