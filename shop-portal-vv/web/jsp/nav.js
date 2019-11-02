var loginFlag=false;
$(function(){
        var v_html="<nav class=\"navbar  navbar-inverse\">\n" +
            "    <div class=\"container-fluid\">\n" +
            "        <div class=\"navbar-header\">\n" +
            "            <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\" aria-expanded=\"false\">\n" +
            "                <span class=\"sr-only\">Toggle navigation</span>\n" +
            "                <span class=\"icon-bar\"></span>\n" +
            "                <span class=\"icon-bar\"></span>\n" +
            "                <span class=\"icon-bar\"></span>\n" +
            "            </button>\n" +
            "            <a class=\"navbar-brand\" href=\"/index.html\">商城首页</a>\n" +
            "        </div>\n" +
            "        <div style='width: 1250px;float: right' class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n" +
            "            <ul class=\"nav navbar-nav navbar-right\">\n" +
            "                <li id=\"dengluId\"><a href=\"/denglu.html\">登陆</a></li>\n" +
            "                <li><a href=\"/login.html\">注册</a></li>\n" +
            "                <li><a href=\"/cart-student.html\">购物车</a></li>\n" +
            "            </ul>\n" +
            "        </div>\n" +
            "    </div>\n" +
            "</nav>";

          $("#navId").html(v_html);

          //传递头信息
          $.ajaxSetup({
            beforeSend:function(xhr){
                var v_cookie=$.cookie("x");
                xhr.setRequestHeader("x-auth",v_cookie);
            },
          })

           //名字展示
          $.post({
                url:"http://localhost:8082/vips/initUser.jhtml",
                async:false,
                success:function(result){
                    if(result.code==200){
                        //获取到上面id 的值，将其进行追加进去
                        $("#dengluId").html("<li><a href='#'>欢迎"+result.data+"登陆</a></li>" +
                            "<li><a href='#' onclick='outUser()'>退出</a></li>");
                        loginFlag=true;
                    }
                }
            })

    //没有登录状态
    if(!loginFlag) {
        $("#nullnav").html("<div style='text-align: center;font-size: 15px'><li>您还没有登录，<a href='/denglu.html'>登录          </a>或<a href='login.html'>        注册</a></li></div>");
    }


    })
//买商品
function byShop(shopId,flag,action){
            var count;
            //加
            if(action=="add"){
                count=1;
            }else{
                count=-1;
            }
            if(loginFlag){
                $.post({
                    url:"http://localhost:8082/carts.jhtml",
                    data:{"shopId":shopId,"count":count},
                    success:function(result){
                        if(result.code==200){
                            if(flag==1){
                                //买好更新
                                initQueryList();
                            }else{
                                location.href="/cart-student.html";
                            }
                        }
                    },
                })
            }
}
//退出
function  outUser() {
        $.post({
            url:"http://localhost:8082/vips/outUser.jhtml",
            success:function(result){
                if(result.code==200){
                    location.href="/";
                }
            }
        })
    }

//删除商品
function delCartProduct(shopId) {
    $.ajax({
        url:"http://localhost:8082/carts/delCartProduct.jhtml",
        type:"post",
        data:{"shopId":shopId},
        success:function (result) {
            if (result.code == 200) {
                initQueryList();
            }
        }
    })
}

//用户登录，购物车模版拼接
function initQueryList() {
    if(loginFlag){
        $.post({
            url:"http://localhost:8082/carts/initQueryList.jhtml",
            success:function(result){
                if(result.code==200){
                    var v_list=result.data.cartItemList;
                    var v_cartId=$("#cartId").html();
                    var v_html ="";
                    for(var i=0;i<v_list.length;i++){
                        var cart=v_list[i];
                        v_html += v_cartId.replace(/##shopName##/g,cart.shopName)
                            .replace(/##price##/g,cart.price)
                            .replace(/##imgPaths##/g,cart.image)
                            .replace(/##subTotalPrice##/g,cart.subTotalPrice)
                            .replace(/##count##/g,cart.count)
                            .replace(/##shopId##/g,cart.shopId);
                    }
                    $("#careDivId").html(v_html);
                    $("#totalCount").html(result.data.totalCount);
                    $("#totalPrice").html(result.data.totalPrice);
                }else if(result.code==1017){
                    $("#careDivId").html("<div style='text-align: center;font-size: 18px'>商品信息为空,<a href='index.html'>选购</a></div>");
                }
            }
        })
    }
}


