<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            body{overflow: auto;}
            ul{margin:70px auto;min-width: 272px;padding-left: 50px}
            ul>li{;width: 120px;height: 120px;border:#cbcbcb solid 1px;border-radius: 6px;text-align: center;display: inline-block;background:#f0f5fc;margin:0 50px;margin-bottom: 45px ;cursor: pointer; }
            ul>li img{margin-top: 15px;margin-bottom: 10px;}
            .rz{
                /* width: 100%; */
                /* height: 79%; */
                margin-left: 15px;
                display: inherit;
            }
            .rizhi{
                position: absolute;
                width: 258px;
                left: 68%;
                top: 63%;
                padding-bottom: 8px;
                display: inline-table;
            }
            p>em{color: red;font-size: large;}
            .rz span{font-size: 8px !important;float: left;}
            .red{color:red;}
            .hr0{ height:1px;border:none;border-top:1px dashed #1E90FF;}  
            .rzz{font-size: 14px;}
            .rizhi em{margin: 6px;}
            span:hover{color: red}
            /*b{font-size: small;}*/
            .xq{font-size: 12px;}
        </style>
    </head>
    <body>
        <ul>
            <!--            <li transadapter="append" select="false" powerid="13" ><img src="../css/limg/homepage1.png" alt=""/><p>添加代表信息</p></li>
                        <li bindli="mywelcomerepresentative" powerid="13"><img src="../css/limg/homepage2.png" alt=""/><p>代表信息管理</p></li>
                        <li powerid="3" eqli="3"><img src="../css/limg/homepage3.png" alt=""/><p>建议议案审查</p></li>
                        <li powerid="6" eqli="6"><img src="../css/limg/homepage4.png" alt=""/><p>信息统计分析</p></li>
                        <li powerid="7" eqli="8"><img src="../css/limg/homepage5.png" alt=""/><p>系统管理</p></li>
                        <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>学习培训</p></li>
                        <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>工作交流</p></li>
                        <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>双联培训</p></li>-->
            <%
                CookieHelper cookie = new CookieHelper(request, response);
                String powerid = cookie.Get("powergroupid");
                if (powerid.equals("16") || powerid.equals("8") || UserList.MyID(request).equals("1")) {
            %>
            <li powerid="2" id="adddelegate"><img src="../css/limg/homepage1.png" alt=""/><p>添加代表信息</p></li>
                <%
                    }
                    if (powerid.equals("5")) {
                %>
            <li powerid="2"  bindclick="my" eqli="1" eqid="mywelcomerepresentative"><img src="../css/limg/homepage2.png" alt=""/><p>代表信息查看</p></li>
                <%
                } else {
                %>
            <li powerid="2"  bindclick="my" eqli="1" eqid="mywelcomerepresentative"><img src="../css/limg/homepage2.png" alt=""/><p>代表信息管理</p></li>
                <%
                    }
                %>


            <li powerid="44"  bindclick="top3" eqid="top3reviewprocessing"><img src="../css/limg/homepage3.png" alt=""/><p>建议议案审查</p></li>
            <li powerid="60" bindclick="top3" eqli="12" eqid="top3statisticscompany"><img src="../css/limg/homepage4.png" alt=""/><p>信息统计分析</p></li>
            <li powerid="6"  bindclick="top1" eqli="1"  eqid="myrechargestaff"><img src="../css/limg/homepage5.png" alt=""/><p>系统管理</p></li>
            <!--<li powerid="70"  bindclick="top4"><img src="../css/limg/homepage6.png" alt=""/><p>学习培训</p></li>-->
            <li powerid="75"  bindclick="top5"><img src="../css/limg/homepage6.png" alt=""/><p>工作交流</p></li>
            <!--            <li powerid="80" bindclick="top6"><img src="../css/limg/homepage6.png" alt=""/><p>双联服务</p></li>
                        <li powerid="82" bindclick="top7"><img src="../css/limg/homepage6.png" alt=""/><p>代表网</p></li>-->

            <li powerid="188" class="rizhi">
                <p><em>系统提示</em></p>

                <%
                    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                    String keywhere = "";
                    String view = "sort";
                    if (cookie.Get("powergroupid").equals("16")) {
                        keywhere = "draft=2";
                        view = "sort";
                    } else {
                        if (cookie.Get("powergroupid").equals("8")) {
                            keywhere = "draft=2 and fsrID=" + UserList.MyID(request);
                            view = "scr_suggest";
                        } else if (cookie.Get("powergroupid").equals("22")) {
                            keywhere = "draft=2 and userid=" + UserList.MyID(request);
                            view = "scr_suggest";
                        } else if (cookie.Get("powergroupid").equals("25")) {
                            keywhere = "draft=2 and fsrID=" + UserList.MyID(request);
                            view = "scr_suggest";
                        } else if (cookie.Get("powergroupid").equals("18")) {
                            keywhere = "draft=2";
                            view = "scr_suggest";
                        } else {
                            if (cookie.Get("powergroupid").equals("23")) {
                                keywhere = "draft=2";
                            } else {
                                keywhere = "draft=2 and myid=" + UserList.MyID(request);
                            }
                            view = "sort";
                        }
                    }
//                    通知
                    RssListView tz = new RssListView(pageContext, "lzmessage_newsuser");
                    tz.select().where("myid=?", UserList.MyID(request)).get_page_desc("id");
                    tz.pagesize = 10000000;
                    int tza = 0;
                    while (tz.for_in_rows()) {
                        tza++;
                    }
//                    课件
                    RssListView kj = new RssListView(pageContext, "courseware");
                    kj.select().where("objid=?", UserList.MyID(request)).get_page_desc("id");
                    kj.pagesize = 10000000;
                    int kja = 0;
                    while (kj.for_in_rows()) {
                        kja++;
                    }
//                    讲座
                    RssListView jz = new RssListView(pageContext, "lecture");
                    jz.select().where("objid=?", UserList.MyID(request)).get_page_desc("id");
                    jz.pagesize = 10000000;
                    int jza = 0;
                    while (jz.for_in_rows()) {
                        jza++;
                    }
//                    宪法
                    RssList xf = new RssList(pageContext, "statute");
                    xf.select().where("classify=1").get_page_desc("id");
                    xf.pagesize = 10000000;
                    int xfa = 0;
                    while (xf.for_in_rows()) {
                        xfa++;
                    }
//                    国法
                    RssList gf = new RssList(pageContext, "statute");
                    gf.select().where("classify=2").get_page_desc("id");
                    gf.pagesize = 10000000;
                    int gfa = 0;
                    while (gf.for_in_rows()) {
                        gfa++;
                    }
//                    法规
                    RssList fg = new RssList(pageContext, "statute");
                    fg.select().where("classify=3").get_page_desc("id");
                    fg.pagesize = 10000000;
                    int fga = 0;
                    while (fg.for_in_rows()) {
                        fga++;
                    }
//                    履职参考
                    RssListView lzck = new RssListView(pageContext, "reference");
                    lzck.select().where("objid=?", UserList.MyID(request)).get_page_desc("id");
                    lzck.pagesize = 10000000;
                    int lz = 0;
                    while (lzck.for_in_rows()) {
                        lz++;
                    }
                    int peixun = xfa + gfa + fga + kja + jza + lz; // 学习培训

//                    活动
                    RssListView hd = new RssListView(pageContext, "activities_userlist");
                    hd.select().where("endshijian>=" + System.currentTimeMillis() / 1000 + " and userid=?", UserList.MyID(request)).get_page_desc("id");
                    hd.pagesize = 10000000;
                    int hda = 0;
                    while (hd.for_in_rows()) {
                        hda++;
                    }
//                    意见征询
                    RssListView yjzx = new RssListView(pageContext, "sortuser");
                    RssListView yjzx1 = new RssListView(pageContext, "suggest_opinion");
                    int yjzxa1 = 0;
                    int yjzxa2 = 0;
                    if (cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16") || cookie.Get("powergroupid").equals("23")) {
                        yjzx = new RssListView(pageContext, "suggestcomments");
                        yjzx.select().where("examination=2").query();
                        yjzx1.select().where("consultation=1").query();
                        while (yjzx1.for_in_rows()) {
                            yjzxa1++;
                        }
                    } else {
                        yjzx.select().where("consultation=1 and userid=?", UserList.MyID(request)).get_page_desc("id");
                    }
                    yjzx.pagesize = 10000000;
                    while (yjzx.for_in_rows()) {
                        yjzxa2++;
                    }
                    int yjzxmk = yjzxa2 + yjzxa1;

                    // 联名建议议案
                    RssListView list1 = new RssListView(pageContext, "sort");
                    list1.query("SELECT userid,resume,consultation,COUNT(*) AS num FROM sortuser_list_view WHERE draft=2 and userid=" + UserList.MyID(request) + " GROUP BY userid,resume,consultation");
                    String[] use = {"0", "0"};
                    while (list1.for_in_rows()) {
                        if (list1.get("resume").equals("1") && list1.get("consultation").equals("0")) {
                            use[0] = list1.get("num");
                        } else if (list1.get("resume").equals("1") && list1.get("consultation").equals("1")) {
                            use[1] = list1.get("num");
                        }
                    }
                    int lm = Integer.parseInt(use[0]) + Integer.parseInt(use[1]);

                    RssListView list = new RssListView(pageContext, view);
                    list.pagesize = 10000000;
                    list.select().where(keywhere).get_page_desc("id");
                    int a = 0;
                    int b = 0;
                    int c = 0;
                    int d = 0;
                    int e = 0;
                    int s = 0;
                    int x = 0;
                    int m = 0;
                    int z = 0;
                    int xlwsca = 0;
                    int djba = 0;
                    int sta = 0;
                    int aa = 0;
                    int bb = 0;
                    int cc = 0;
                    int dd = 0;
                    int ee = 0;
                    int ss = 0;
                    int xx = 0;
                    int mm = 0;
                    int zz = 0;
                    int xlwscb = 0;
                    int djbb = 0;
                    int stb = 0;
                    int aaa = 0;
                    int bbb = 0;
                    int ccc = 0;
                    int ddd = 0;
                    int eee = 0;
                    int sss = 0;
                    int xxx = 0;
                    int mmm = 0;
                    int zzz = 0;
                    int xlwsc = 0;
                    int djb = 0;
                    int st = 0;
                    while (list.for_in_rows()) {
                        if (list.get("lwstate").equals("1")) {
                            a++;
                            if (list.get("examination").equals("1")) {
                                d++;
                            }
                            if (list.get("examination").equals("2") && list.get("resume").equals("0") && list.get("handlestate").equals("3") && list.get("deal").equals("1") && list.get("isxzsc").equals("0")) {
                                b++;
                            }
                            if (list.get("examination").equals("3")) {
                                c++;
                            }
                            if (list.get("resume").equals("0") && list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                e++;
                            }
                            if (list.get("isxzsc").equals("1")) {
                                x++;
                            }
                            if (list.get("handlestate").equals("2")) {
                                m++;
                            }
                            if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                s++;
                            }
                            if (list.get("handlestate").equals("3") && list.get("deal").equals("1")) {
                                z++;
                            }
                            if (list.get("handlestate").equals("3") && list.get("examination").equals("2") && list.get("deal").equals("0")) {
                                djba++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                sta++;
                            }
                            if (list.get("examination").equals("2") && list.get("deal").equals("0") && list.get("undertake").equals("0")) {
                                xlwsca++;
                            }
                        }
                        if (list.get("lwstate").equals("2")) {
                            aa++;
                            if (list.get("examination").equals("1")) {
                                dd++;
                            }
                            if (list.get("examination").equals("2") && list.get("resume").equals("0") && list.get("handlestate").equals("3") && list.get("deal").equals("1") && list.get("isxzsc").equals("0")) {
                                bb++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc++;
                            }
                            if (list.get("resume").equals("0") && list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                ee++;
                            }
                            if (list.get("isxzsc").equals("1")) {
                                xx++;
                            }
                            if (list.get("handlestate").equals("2")) {
                                mm++;
                            }
                            if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                ss++;
                            }
                            if (list.get("handlestate").equals("3") && list.get("deal").equals("1")) {
                                zz++;
                            }
                            if (list.get("handlestate").equals("3") && list.get("examination").equals("2") && list.get("deal").equals("0")) {
                                djbb++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                stb++;
                            }
                            if (list.get("examination").equals("2") && list.get("deal").equals("0") && list.get("undertake").equals("0")) {
                                xlwscb++;
                            }
                        }
                    }
                    aaa = a + aa;// 全部
                    bbb = b + bb; // 待办复

                    ccc = c + cc; // 置回
                    ddd = d + dd; // 待审查
                    eee = e + ee; // 代表团已审查
                    sss = s + ss; // 承办单位已办复
                    xxx = x + xx; // 乡政政府办审查
                    mmm = m + mm; // 拟主办单位
                    djb = djba + djbb; //待交办
                    zzz = z + zz; // 县政府办审查
                    xlwsc = xlwsca + xlwscb; // 选联委已审查
                    st = sta + stb; //被申退
                %>
                <%
//                    16系统管理员  8选联委  23县政府办   18承办单位  22代表团  25乡镇政府办
                    if (powerid.equals("0") || powerid.equals("16") || powerid.equals("8") || powerid.equals("23") || powerid.equals("18") || powerid.equals("22") || powerid.equals("25")) {
                %>
                <div class="rz">
                    <%
                        if (!(powerid.equals("23") || powerid.equals("16") || powerid.equals("18") || powerid.equals("8") || powerid.equals("25"))) {
                    %>
                    <span powerid="159"  bindclick="top3" eqli="4" eqid="top3reviewDBTsituation">您有<em class="red"><% out.print(ddd);%></em>条待审查信息</span><br>
                    <%
                        }
                        if (powerid.equals("25")) {
                    %>
                    <span powerid="183" bindclick="top3" eqli="5" eqid="top3handlezfbsubmit">您有<em class="red"><% out.print(eee);%></em>条待办复信息</span><br>
                    <%
                        }
                        if (!(powerid.equals("22") || powerid.equals("23") || powerid.equals("18") || powerid.equals("25"))) { %>
                    <span powerid="45" bindclick="top3" eqli="4" eqid="top3reviewsituation">您有<em class="red"><% out.print(eee);%></em>条初审查信息</span><br>
                    <!--<span>您有<% out.print(b);%>条待交办信息</span><br>-->
                    <%
                        }
                        if (powerid.equals("23")) {
                    %>
                    <span powerid="48" bindclick="top3" eqli="5" eqid="top3handlecompany">您有<em class="red"><% out.print(mmm);%></em>条拟承办单位信息</span><br>
                    <span powerid="49" bindclick="top3" eqli="5" eqid="top3handlesubmit">您有<em class="red"><% out.print(djb);%></em>条待交办的信息</span><br>
                    <span powerid="48" bindclick="top3" eqli="5" eqid="top3handlecompany">您有<em class="red"><% out.print(st);%></em>条承办单位申退信息</span><br>
                    <%
                        }
                        if (powerid.equals("16")) {
                    %>
                    <span powerid="49" bindclick="top3" eqli="5" eqid="top3handlesubmit">您有<em class="red"><% out.print(djb);%></em>条待交办信息</span><br>
                    <%
                        }
                        if (!(powerid.equals("25") || powerid.equals("23") || powerid.equals("18"))) { %>
                    <span bindclick="top3">您有<em class="red"><% out.print(bbb);%></em>条待办复的信息</span><br>
                    <%
                        }
                        if (!(powerid.equals("25") || powerid.equals("18"))) {
                    %>
                    <span bindclick="top3">您有<em class="red"><% out.print(sss);%></em>条已办复的信息</span><br>
                    <%
                        }
                        if (powerid.equals("18")) { %>
                    <span powerid="50" bindclick="top3" eqli="5" eqid="top3handlereply">您有<em class="red"><% out.print(bbb);%></em>条待办复的信息</span><br>
                    <%
                        }
                        if (powerid.equals("8") || powerid.equals("23") || powerid.equals("16")) {
                    %>
                    <span powerid="25"  bindclick="top2" eqli="7" eqid="top2consultsubmit">您有<em class="red"><% out.print(yjzxmk);%></em>条新的意见征询</span><br>
                    <%
                        }
                        if (powerid.equals("22")) {
                    %>
                    <span powerid="21"  bindclick="top2" eqli="3" eqid="top2consult1notice" >您有<em class="red"><% out.print(tza);%></em>条新的通知公告</span><br>
                    <%
                        }
                    %>
                </div>
                <%                    }
                    if (powerid.equals("5")) {
                %>
                <div class="rz">
                    <span powerid="21"  bindclick="top2" eqli="3" eqid="top2consult1notice" class="tza">您有<em class="red"><% out.print(tza);%></em>条新的通知公告</span><br>
                    <span powerid="30"  bindclick="top2" eqli="7" eqid="top2consult7notice3" class="hda">您有<em class="red"><% out.print(hda);%></em>条新的活动报名</span><br>
                    <span powerid="37"  bindclick="top4" class="peixun">您有<em class="red"><% out.print(peixun);%></em>条学习培训</span><br>
                    <span bindclick="top3">您有<em class="red"><% out.print(eee);%></em>条代表团管理员已审查信息</span><br>
                    <span bindclick="top3">您有<em class="red"><% out.print(xlwsc);%></em>条选联委已审查信息</span><br>
                    <span bindclick="top3">您有<em class="red"><% out.print(zzz);%></em>条县政府办已交办信息</span><br>
                    <span bindclick="top3">您有<em class="red"><% out.print(xxx);%></em>条乡镇政府办已交办信息</span><br>
                    <span bindclick="top3">您有<em class="red"><% out.print(sss);%></em>条承办单位已办复信息</span><br>
                    <span powerid="24"  bindclick="top2" eqli="7" eqid="top2consultmonitor">您有<em class="red"><% out.print(lm);%></em>条联名建议议案已办复</span><br>
                    <span powerid="170"  bindclick="top3" eqli="11" eqid="top3consult5report">您有<em class="red"><% out.print(ccc);%></em>条已置回议案建议信息</span><br>

                    <%
                        }
                    %>
                </div>

                <hr class="hr0" /> 
                <em class="xq">详情&nbsp;请进入对应信息模块查收...</em>
            </li>
        </ul>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>

            $("[bindclick]").click(function () {
                parent.bindli($(this).attr("bindclick"))
            })
            $("[eqli]").click(function () {
//                parent.eqli($(this).attr("eqli"))
                parent.leftclick($(this).attr("eqid"))
            })
//            $(".tza").click(function () {
//                popuplayer.display("/newinformation/list.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $(".hda").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $(".peixun").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            }
//            )$("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            }
//            )
//            $("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })
//            $("#adddelegate").click(function () {
//                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
//            })





            $("#adddelegate").click(function () {
                popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
            })
//            $(".rizhi").click(function () {
//                location.href = "/suggest/list.jsp";
//            })
        </script>
    </body>
</html>
