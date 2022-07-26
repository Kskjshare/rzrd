<%-- 
    Document   : llzlist
    Created on : 2018-7-13, 17:26:17
    Author     : Administrator
--%>

<%@page import="java.lang.String"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            body>div:first-child{margin-bottom: 100px;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }
            nav{margin: 21px 22px 0px 22px;height: 28px;z-index: 2;}
            nav>a{border: #eee solid 2px;padding: 5px 7.8px; margin-right: 3px;background: #f7f7f7;cursor: pointer;}
            nav>a:last-child{ margin-right: 0; }
            nav>.sel{border-bottom:#f7f7f7 solid 4px;}
            ul{border: #eee solid 2px;margin: 0 22px;padding: 6px 20px;background: #f7f7f7;margin-top: -2px;display: none}
            ul>li{list-style-type: none;display: inline-block; width: 124px;line-height: 28px;font-size: 14px;text-align: center;cursor: pointer;}
            .selul{display: block;}
            #infotable{margin: 8px 22px;border: #eee solid 2px;padding: 2px 0;}
            #infotable>h1{background: #f7f7f7;line-height: 42px;font-size: 14px;text-align: center;font-weight: 400;margin: 0;}
            #infotable>table{width: 1018px;margin: 20px auto;font-size: 12px;border: #eee solid thin;border-width:1px 0px 0px 1px;}
            #infotable>table .trnone{display: none}
            #infotable>table tr:first-child{background: #f7f7f7;text-align: center;}
            #infotable>table td{border: #eee solid thin;line-height: 28px;border-width:0px 1px 1px 0px;text-align: center;padding: 0; }
            #infotable>table td:first-child{ background: #f7f7f7;text-align: center;}
            #infotable>table td p{margin: 0;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #infotable>table td>.w220{max-width: 220px;margin: 0 auto;}
            #infotable>table td span{ display: inline-block; width: 74px; height: 23px; background: #88c7f3; text-align: center;line-height: 23px;color: #fff;border-radius: 5px;cursor:pointer; }
            #footer{ background: #eee; position: fixed;bottom: 0; width: 100%;text-align: center; margin: 0 auto;height: 88px; padding-top: 10px;left:0}
            #footer p{line-height: 22px;font-size: 14px; margin: 0;}
            #siteForm td >span >a{text-decoration: none; color: white; }
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <nav></nav>
            <div id="infotable">
                <h1>联络站一览表</h1>
                <table id="siteForm">
                  
                </table>
            </div>
        </div>
        <div id="footer">
            <p>汝州市人大常委会主办</p>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../data/dictdata.js" type="text/javascript"></script>
        <script src="/js/jquery.min.js" type="text/javascript"></script>
        <script src="/data/dictdata.js" type="text/javascript"></script>
           <script type="text/javascript" src="/js/rsseasy.min.js"></script>
        <script src="/js/rssapi.min.js" type="text/javascript"></script>
        <script src="/js/md5.min.js" type="text/javascript"></script>
        <script>
              RssApi.View.List("contactstation").keyvalue({ "pagesize": 100000}).condition({}).getJson(function (json) {  //这里是返回得json数据

                 var str ="";
                  str ='<tr><td>序号</td><td>所属乡镇（街道）</td><td>站点名称</td><td>站长</td><td>站长电话</td><td>联络员</td><td>联络员电话</td><td>活动时间</td><td>站点</td></tr>'

                  opretion = 1;
                 json.forEach((item,idex) => {
                        RssApi.View.List("contactstation_sub").keyvalue({ "pagesize": 100000}).condition({stationid:item.id}).getJson(function (data) { 
                                if(data.length){
                                    // console.log(data);
                                    data.forEach((ele,idx) => {
                                        let rowspan =data.length;
                                        // console.log(idx?true:false)
                                         var opentime = ele.opentime;
                                         if ( opentime == "" || opentime == null ) {
                                                opentime = "未知";
                                          }
                                          var master = ele.master;
                                         if ( master == "" || master == null ) {
                                                master = "未知";
                                          }
                                           var mastertelephone = ele.mastertelephone;
                                         if ( mastertelephone == "" || mastertelephone == null ) {
                                                mastertelephone = "未知";
                                          }
                                            if (idx == false) {
                                              //  str += '<tr><td>'+opretion+'</td><td rowspan="'+rowspan+'">'+ele.allname+'</td><td>'+ele.title+'</td><td>'+ele.master+'</td> <td>'+ele.mastertelephone+'</td> <td>'+ele.linkman+'</td>  <td>'+ele.linkmantelephone+'</td>  <td>'+ele.opentime+'</td>  <td rowspan="'+rowspan+'"><span  stationid="'+ele.stationid+'"><a href="/delegatexweb/infopage/delegationinfo.jsp?stationid='+ele.stationid+'">点击进入</span></td></tr>';
//                                              zyx 修改原因为所属乡镇（街道）列显示为空
                                               
                                                str += '<tr><td>'+opretion+'</td><td rowspan="'+rowspan+'">'+ele.allname+'</td><td>'+ele.title+'</td><td>'+ master +'</td> <td>'+mastertelephone+'</td> <td>'+ele.linkman+'</td>  <td>'+ele.linkmantelephone+'</td>  <td>'+ opentime+'</td>  <td rowspan="'+rowspan+'"><span  stationid="'+ele.stationid+'"><a href="/delegatexweb/infopage/delegationinfo.jsp?stationid='+ele.stationid+'">点击进入</span></td></tr>';
//                                               
//                                               zyx 修改结束
                                            }else{

                                                str += '<tr><td>'+opretion+'</td><td>'+ele.title+'</td>  <td>'+ master + '</td> <td>'+mastertelephone+'</td> <td>'+ele.linkman+'</td>  <td>'+ele.linkmantelephone+'</td>  <td>'+ opentime +'</td></tr>'
                                            }
                                            opretion++
                                    });
                                }
                                     $('#siteForm').html(str) 
                            });
                    });
              });


            var ind = "1";

            // $("#infotable #siteForm td>span").click(function () {
            //     console.log("1111");
            //     var stationid = $(this).attr("stationid")
            //     location.href = "/delegatexweb/infopage/delegationinfo.jsp?stationid=" + stationid;
            // })
            window.onscroll = function () {
                if ($(this).scrollTop() >= $(document).height() - $(window).height()) {
                    $("#footer").show();
                } else {
                    $("#footer").hide();
                }
            };
            if ($(document).height() > $(window).height()) {
                $("#footer").hide();
            }
//           

            $("p[street]").each(function () {
                var text = $(this).attr("street");
                console.log(text);
                $(this).text(dictdata["ssxarea"][text][0]);
            })
        </script>
    </body>
</html>
