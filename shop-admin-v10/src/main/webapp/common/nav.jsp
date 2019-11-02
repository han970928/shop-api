
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
        <div class="collapse navbar-collapse" id="menuListId">


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
   /* var menuListArr=[
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
                    $("#menuListId").append(menuListStr);
                }
            }
        })
    }

    var menuListStr="";
    function initMenu(id,level){
        //判断是否有孩子，返回一个孩子对象
        var v_child=getChild(id);
        if(v_child.length>0){
            //判断是否是顶层菜单
            if(level==1){
                //是
                menuListStr+='<ul class="nav navbar-nav">';
            }else{
                //不是
                menuListStr+='<ul class="dropdown-menu">';
            }
            for(var i=0;i<v_child.length;i++){
                //循环孩子对象
                var father=isFather(v_child[i].id);
                if(level==1){
                    if(father){
                        //是子节点，并且有孩子
                        menuListStr+='<li><a href="'+v_child[i].menuUrl+'"  data-toggle="dropdown">'+v_child[i].menuName+'<span class="caret"></span></a>';
                    }else{
                        //没有孩子
                        menuListStr+='<li><a href="'+v_child[i].menuUrl+'">'+v_child[i].menuName+'</a>';
                    }
                }else{
                    if(father){
                        menuListStr+='<li class="dropdown-submenu"><a  href="'+v_child[i].menuUrl+'">'+v_child[i].menuName+'</a>';
                    }else{
                        menuListStr+='<li><a href="'+v_child[i].menuUrl+'">'+v_child[i].menuName+'</a>';
                    }
                }
                initMenu(v_child[i].id,level+1);
                menuListStr+="</li>";
            }
            menuListStr+="</ul>";
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
    function isFather(child){
        for(var i=0;i<menuListArr.length;i++){
            if(menuListArr[i].fatherId==child){
                return true;
            }
        }
        return false;
    }

    /*
    $(function(){
        queryMenuListByUserId();
    })
    function queryMenuListByUserId(){
        $.post({
            url:"/menu/queryMenuListByUserId.jhtml",
            success:function(result){
                if(result.code==200){
                    //取出菜单集合
                    menuList=result.data;
                    initMenu();
                }
         }
        })
    }
    var menuList;
    function initMenu(){
        //找到顶层菜单
        var menuHtml=getMenuHtml();
        //把顶层菜单转换成jquery对象，这样就可以用jquery里面的方法了
        var v_menu=$(menuHtml);
        //找到顶层菜单Id
        var menuId=getMenuId();
        //根据拿到的菜单Id，来判断此下面是否有子节点
        for(var i=0;i<menuId.length;i++){
            var chiId=findchild(menuId[i]);
            if(chiId.length>0){
                //根据自定义属性，也就是菜单的Id，给他增加下拉属性
                var m=v_menu.find("a[data-id='"+menuId[i]+"']");
                //标签里面是添加属性
                m.attr("data-toggle","dropdown");
                //标签外面是追加属性
                m.append('<span class="caret"></span>');
                //根据 子节点的Id 去拼接子节点的下拉
                var childStr=childHtml(chiId);
                //根据自定义的属性，去找父节点，把父节点下面的子节点追加进去
                m.parent().append(childStr);
            }
        }
        // 上面已经把顶层菜单转换成jquery对象，这里就应该放的是jquery对象
        $("#menuListId").html(v_menu);
    }
    function getMenuHtml(){
        var menuHtmlStr="";
        for(var i=0;i<menuList.length;i++){
            // 因为都属于整个后台管理下面，所以这个Pid 为1
            if(menuList[i].fatherId==1){
                //拼接顶层菜单
                menuHtmlStr+='<li><a href="'+menuList[i].menuUrl+'" data-id="'+menuList[i].id+'">'+menuList[i].menuName+'</a></li>';
            }
        }
        /!*console.log(menuHtmlStr);*!/
        return menuHtmlStr;
    }
    function getMenuId(){
        var  menuArr=[];
        for(var i=0;i<menuList.length;i++){
            //判断是否是父节点,然后拿到菜单Id
            if(menuList[i].fatherId==1){
                menuArr.push(menuList[i].id);
            }
        }
       /!* console.log(menuArr);*!/
        return menuArr;
    }
    function findchild(menuId){
        var childArr=[];
        for(var i=0;i<menuList.length;i++){
            //根据pid 和 id 比较，相同的话，就代表是pid 的子节点
            if(menuList[i].fatherId==menuId){
                childArr.push(menuList[i]);
            }
        }
        /!*console.log(childArr);*!/
        return childArr;
    };
    function childHtml(chiId){
        var childHtmlStr='<ul class="dropdown-menu">';
        for(var i=0;i<chiId.length;i++){
            //根据子节点Id 拼接子节点的下拉
            childHtmlStr+='<li><a href="'+chiId[i].menuUrl+'">'+chiId[i].menuName+'</a></li>';
        }
        childHtmlStr+="</ul>";
        /!*console.log(childHtmlStr);*!/
        return childHtmlStr;
    }
    */
</script>
