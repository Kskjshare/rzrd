<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .popupwrap .popnav{background:#82bee9;height: 30px;width: 474px;padding: 2px 5px; }
           .popupwrap{ -webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}
            .popupwrap .popnav li{float: left;width: 118px;height: 28px;line-height: 28px;text-align: center;color: #fff;font-size: 14px;cursor: pointer;}
            .popupwrap .popnav .sel{background: #fff ; color:#82bee9;border: #6caddc solid 1px;border-radius: 3px; }
            #botnav{padding: 5px;background: #f0f0f0;cursor: default;color:#82bee9;position: absolute;bottom: 0;width: 98% }
            #botnav span,#botnav em{width: 28px;display: inline-block;height: 28px;text-align: center;line-height: 28px;background:#fff;border: #cbcbcb solid 1px;border-radius: 2px;margin: 0 6px;color:#323232  }
            #botnav .sel{color: #fff;background:#82bee9 }
            #botnav input{width: 44px;height: 28px;margin: 0 12px;padding: 0 2px;color:#323232}
            #botnav b{width: 42px;height: 24px;text-align: center;display: inline-block;background:#82bee9 ;color: #fff; border-radius: 2px;line-height: 24px }
            /*.supersearch {height: 270px;}*/
            .supersearch span{font-size: 14px;color: #186aa3;padding: 0 10px;cursor: pointer;}
            .supersearch tr{;text-align: center; }
            .supersearch tr:first-child{text-align: left;}
            .supersearch tr td{padding:0px 15px;line-height: 30px;} 
            .supersearch input{width: 100%}
            .supersearch input[type='radio']{width: 10px}
            .supersearch tr:nth-child(3){display: none}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <ul class="popnav"><li class="sel">建议基本信息</li><li>提出者信息</li><li>建议办理信息</li></ul>
                <table class="wp100 cellbor supersearch">
                    <tr><td colspan="6"><span supadd>添加</span><span supedit>编辑</span><span supinsert>插加</span><span supdelete>删除</span><span alldelete>全删</span></td></tr>
                    <tr><td></td><td>连接符</td><td>字段名称</td><td>比较符</td><td>查询内容</td><td></td></tr>
                    <tr class="disno"><td><input type="radio" name="su"></td><td><select class="w60" name="linksign" dict-select="linksign"></select></td><td><input type="text"></td><td><select class="w40" name="comparesign" dict-select="comparesign"></select></td><td><input type="text"></td><td></td></tr>
                </table>
                <ol id="botnav"><span pageup><</span><em class="sel">1</em><span pagedown>></span>跳转到<input text="number"><b>确定</b></ol>
            </div>
            <div class="footer">
                <button type="button" inspect>检查</button>
                <button type="button" query>查询</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $("ul>li").click(function () {
                $(this).addClass("sel").siblings().removeClass("sel");
            })
            $(".footer>[query]").click(function () {
                parent.quicksearch("/suggest/list.jsp?id=" + formfun("id") + "&sortid=" + formfun("sortid") + "&title=" + formfun("title") + "&matter=" + formfun("matter") + "&reviewclass=" + formfun("reviewclass") + "&methoded=" + formfun("methoded") + "&realname=" + formfun("realname"))
                popuplayer.close();
            })
            $(".footer>[reset]").click(function () {
                $("[name]").val("");
            })
            $(".footer>[cancel]").click(function () {
                popuplayer.close();
            })
            function formfun(name) {
                var val = $("[name='" + name + "']").val() == undefined ? "" : $("[name='" + name + "']").val()
                return val;
            }
            //添加
            var lishi =[$(".popupwrap").html()];
            $("[supadd]").click(function () {
                var clone = $(".disno").eq(0).clone();
                $(".supersearch tbody").append(clone);
                smapage($("#botnav .sel").text())
            })
            //插入
            $("[supinsert]").click(function () {
                var clone = $(".disno").eq(0).clone();
                $(".supersearch input:checked").parents("tr").before(clone);
                smapage($("#botnav .sel").text())
            })
            //删除
            $("[supdelete]").click(function () {
                $(".supersearch input:checked").parents("tr").remove();
                smapage($("#botnav .sel").text())
            })
            //全删
            $("[alldelete]").off("click").click(function () {
                var clone = $(".disno").eq(0).clone();
                $(".disno").remove();
                $(".supersearch tbody").append(clone);
                smapage($("#botnav .sel").text())
            })
            //c
//            $("[supdelete]").click(function () {
//                $(".supersearch input:checked").parents("tr").remove();
//                smapage($("#botnav .sel").text())
//            })
            $("#botnav>em").click(function () {
                $(this).addClass("sel").siblings("em").removeClass("sel");
            })
            function smapage(e) {
                console.log(e)
                var smallpage = 5;
                var nowpage = parseInt(e);
                var num = parseInt(($(".disno").length - 2) / smallpage);
                //翻页按钮变动
                if ($("#botnav em").length < num + 1) {
                    $("[pagedown]").before("<em>" + (num + 1) + "</em>");
                }
                if ($("#botnav em").length > num + 1) {
                    var sl = $("#botnav em").length - num - 1
                    for (var i = 0; i < sl; i++) {
                    $("[pagedown]").prev("em").remove();
                   }
                }
                //添加自动翻页
//                if ($(".disno").length > smallpage * nowpage + 1) {
                $(".disno").hide();
                $(".disno").each(function () {
                    if (smallpage * nowpage + 1 > $(this).index() - 2 && $(this).index() - 2 > smallpage * (nowpage-1)) {
                        $(this).show();
                    }
                })
//                }
                $("#botnav>em").off("click").click(function () {
                    $(this).addClass("sel").siblings("em").removeClass("sel");
                    smapage($(this).text())
                })
//                var html = $(".popupwrap").html();
//                lishi.push(html)
//                console.log(lishi)
            }
        </script>
    </body>
</html>
