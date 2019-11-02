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
        <div class="collapse navbar-collapse" id="menuDiv">
           <%-- <ul class="nav navbar-nav">
                    <li><a href="#">商品管理</a></li>
                    <li><a href="#" data-toggle="dropdown">系统管理<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                        <li><a href="/user/index.jhtml">用户管理</a></li>
                        <li role="separator"></li>
                        <li class="dropdown-submenu">
                            <a  href="#">角色管理</a>
                            <ul class="dropdown-menu">
                                <li class="dropdown-submenu"><a  href="#">Second</a>
                                    <ul class="dropdown-menu">
                                        <li><a  href="#">Second  </a></li>
                                    </ul>
                                </li>
                         <li><a  href="#">Second  </a></li>
                             </ul>
                        </li>
                    </ul>
                </li>
            </ul>--%>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎${user.roleName}登陆</a></li>
                <c:if test="${!empty  user.loginDate}">
                    <li><a href="#">上次登录的时间为<fmt:formatDate value="${user.loginDate}" pattern="yyyy-MM-dd HH:mm:ss" /></a></li>
                </c:if>
                <li><a href="#">今天是第${user.tocount}次登录</a></li>
                <li><a href="/user/loginOut.jhtml">退出</a></li>
            </ul>
        </div>
    </div>
</nav>
<script src="/jsp/jquery-3.3.1.js"></script>
<script>
    /*var menuListArr=[
        {id:1,menuName:"河南",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:0},
        {id:2,menuName:"河北",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:0},
        {id:3,menuName:"郑州",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:1},
        {id:4,menuName:"洛阳",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:3},
        {id:5,menuName:"偃师",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:4},
        {id:6,menuName:"偃化口",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:5},
        {id:7,menuName:"金水区",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:3},
        {id:8,menuName:"邯郸",menuType:1,menuUrl:"/user/toList.jhtml",fatherId:2},
    ]*/
    $(function(){
        queryMenuListByUserId();
    })
    var menuListArr;
    function queryMenuListByUserId(){
        $.post({
            url:"/menu/queryMenuListByUserId.jhtml",
            success:function(result){
                if(result.code==200){
                    //取出菜单集合
                    menuListArr=result.data;
                    initMenu(1,1);
                    $("#menuDiv").append(menuList);
                }
            }
        })
    }
    var menuList="";
    function initMenu(id,level){
        //根据菜单Id判断下面是否有子节点
        var childArr=getChild(id);
        if(childArr.length>0){
            // 判断是否是顶级菜单
            if(level==1){
                //是  代表没有根节点
                menuList+='<ul class="nav navbar-nav">';
            }else{
                //不是  代表有根节点
                menuList+='<ul class="dropdown-menu">';
            }
                //循环子节点对象
                for(var i=0;i<childArr.length;i++){
                    //判断 下面是否有父节点的子节点
                    var v_isFather=isFather(childArr[i].id);
                    //判断是否还有顶级菜单
                    if(level==1){
                        //是否是父节点
                        if(v_isFather){
                            //有的话 拼接属性
                            menuList+='<li><a href="'+childArr[i].menuUrl+'" data-toggle="dropdown">'+childArr[i].menuName+'<span class="caret"></span></a>';
                        }else{
                            //没有 ，则拼成最终样子
                            menuList+='<li><a href="#">'+childArr[i].menuName+'</a></li>';
                        }
                    }else{
                        //是否是父节点
                        if(v_isFather){
                            //有的话 拼接属性
                            menuList+='<li class="dropdown-submenu"><a  href="'+childArr[i].menuUrl+'">'+childArr[i].menuName+'</a>';
                        }else{
                            //没有 ，则拼成最终样子
                            menuList+='<li><a href="'+childArr[i].menuUrl+'">'+childArr[i].menuName+'</a></li>';
                        }
                    }
                    //进行 递归 循环，每次传入的参数都不一样
                    initMenu(childArr[i].id,level+1);
                    menuList+="</li>";
                }
                menuList+="</ul>";
        }
    }
    function getChild(menuId){
        var childArr=[];
        for(var i=0;i<menuListArr.length;i++){
            if(menuListArr[i].fatherId==menuId){
                childArr.push(menuListArr[i]);
            }
        }
        return childArr;
    }
    function isFather(childId){
        for(var i=0;i<menuListArr.length;i++){
            if(menuListArr[i].fatherId==childId){
                return true;
            }
        }
        return false;
    }


</script>

