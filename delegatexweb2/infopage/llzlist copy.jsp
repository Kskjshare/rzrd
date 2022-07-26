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
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <nav></nav>
            <div id="infotable">
                <h1>联络站一览表</h1>
                <table id="siteForm">
                    <!-- <tr><td>序号</td><td>所属乡镇（街道）</td><td>站点名称</td><td>站长</td><td>站长电话</td><td>联络员</td><td>联络员电话</td><td>活动时间</td><td>站点</td></tr> -->
                    <%
                        HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                        RssListView list = new RssListView(pageContext, "contactstation_look");
                        int a = 1, b = 1; 
//                        String[] group;
                        list.select().query();
                       
                        b = 1;
                        while (list.for_in_rows()) {
                                                     System.out.println(list.get("street")+"ccccccccc");

                    %>
                    <!-- <tr class="" cid="<% out.print(list.get("street"));%>"><td><% out.print(a);%></td>
                          <td><p street="<% out.print(list.get("street"));%>"></p></td>
                        <td><p><% out.print(list.get("title"));%></p></td> 
                        <td><p><% out.print(list.get("master"));%></p></td>
                        <td><p class="w220"><% out.print(list.get("mastertelephone"));%></p></td>
                        <td><p><% out.print(list.get("linkman"));%></p></td>
                        <td><p><% out.print(list.get("linkmantelephone"));%></p></td>
                        <td><p><% out.print(list.get("opentime"));%></p></td>
                        <td><span myid="<% out.print(list.get("myid"));%>">点击进入</span></td></tr> -->
                            <%
                                    a++;
                                    b = 0;
                                }
//                                }
                            %>
                </table>
                <input type="hidden" id="pid" value="<% out.print(req.get("pid"));%>">
            </div>
        </div>
        <div id="footer">
            <p>抚州市政协主办</p>
            <p>技术支持：抚州市政协信息中心</p>
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


                // console.log(json);

                 var str = [],children=[];
                //  var proId='';
                //  var val=1;
                //  var ccc=[];
                // console.log(json);
                // var newDats = []
    
                // console.log(json,"0");
                // var datas = json
                // var repeatIndex = 0
                // for(var i=0;i<datas.length-1;i++){
                //     // datas[i-1].children = [datas[i-1]]
                   
                //     if(datas[repeatIndex].allname ==datas[i+1].allname){
                //     //   if(repeatIndex )
                //        newDats.push({name:datas[i-1].allname,children:[datas[i-1]]})
                                      
                //         // datas[i-1].children.push(datas[i])
                //         newDats[repeatIndex].children.push(datas[i])
                //     }
                //     else{
                //         newDats.push({name:datas[i-1].allname,children:[datas[i-1]]})
                //         // newDats.push([])
                //         repeatIndex = i
                //     }

                // }


                // for(var i =0;i<datas.length;,i<++

                // console.log(newDats)

            //         var obj = {};
            //         arrays =json.reduce(function (item, next) {
            //             obj[next.allname] ? '' : obj[next.allname] = true && item.push(next);
            //             return item;

            //         }, []);

                    //  arrays.forEach((item,idx) => {
                    //     let name =item.allname;
                    //     console.log(item);
                    //     // item.children.push(item)
                    //     // item.children = [item]

                    //     // str.push()
                    //     // str.push([{item},{children}]);
                    
                    //   });

                    // console.log(json);
// 等下，缕缕   
                    // var arrINdex=[];
                    RssApi.View.List("contactstation_sub").keyvalue({ "pagesize": 100000}).condition({}).getJson(function (data) { 
                        // let count = 0;
                       str =` <tr><td>序号</td><td>所属乡镇（街道）</td><td>站点名称</td><td>站长</td><td>站长电话</td><td>联络员</td><td>联络员电话</td><td>活动时间</td><td>站点</td></tr>`
                        json.forEach((item,idex) => {

                            //  console.log(item,"00");
                            data.forEach((ele,idx) => {

                                if(item.id = ele.stationid){ 



                                    
                                    // if (idx == 0) {
                                    //     str += `<tr><td>\${idex}</td><td  rowspan='\${ele.count!=0?ele.count:" "}'>\${ele.allname}</td><td>\${ele.title}</td><td>\${ele.master}</td><td>\${ele.mastertelephone}
                                    //     </td><td>\${ele.linkman}</td><td>\${ele.linkmantelephone}</td><td>\${ele.opentime}</td><td>\${ele.myid}</td></tr>`
                                    // }else{
                                    //     str += `<tr><td>\${idex}</td><td>\${ele.title}</td><td>\${ele.master}</td><td>\${ele.mastertelephone}
                                    //      </td><td>\${ele.linkman}</td><td>\${ele.linkmantelephone}</td><td>\${ele.opentime}</td><td>\${ele.myid}</td></tr>`
                                    // }
                                     
                                }

                                // if (idx == 0) {
                                //     tableHtml += '<tr><td>' + opretion.siteindex + '</td><td rowspan="' + item.contactDtos.length + '">' + item.name + '</td><td>'+ ite.name +'</td><td>'+ ite.stationName +'</td><td>'+ ite.stationPhone +'</td><td>'+ ite.username +'</td><td>'+ ite.phone +'</td><td>'+ ite.openTime +'</td><td rowspan="' + item.contactDtos.length + '"><a href="'+ item.url +'" target="_blank"><div class="enterSite">鐐瑰嚮杩涘叆</div></a></td></tr>';
                                // }else{
                                //     tableHtml += '<tr><td>' + opretion.siteindex + '</td><td>'+ ite.name +'</td><td>'+ ite.stationName +'</td><td>'+ ite.stationPhone +'</td><td>'+ ite.username +'</td><td>'+ ite.phone +'</td><td>'+ ite.openTime +'</td></tr>';
                                // }
                             });
                            //  item["count"]=count

                            //  $('#siteForm').append(str) 
                            //  console.log(item.count,"00");


                            // str = '<tr><td>'+idex+'</td><td>'+item.allname?item.allname:'w'+'</td> <td>'+item.title+'</td>  <td>'+item.master+'</td> <td>'+item.mastertelephone+
                            //     '</td> <td>'+item.linkman+'</td>  <td>'+item.linkmantelephone+'</td>  <td>'+item.opentime+'</td>  <td>'+item.myid+'</td></tr>'

                        //    str = `<tr><td>\${idex}</td><td  rowspan='\${item.count!=0?item.count:" "}'>\${item.allname}<td>\${item.title}</td><td>\${item.master}</td><td>\${item.mastertelephone}
                        //          </td><td>\${item.linkman}</td><td>\${item.linkmantelephone}</td><td>\${item.opentime}</td><td>\${item.myid}</td></tr>`
                        //     $('#siteForm').append(str) 
                                
                            // if (item.count == 0) {
                            //     str = `<tr><td>\${idex}</td><td>\${item.allname}</td><td>\${item.title}</td><td>\${item.master}</td><td>\${item.mastertelephone}
                            //        </td><td>\${item.linkman}</td><td>\${item.linkmantelephone}</td><td>\${item.opentime}</td><td>\${item.myid}</td></tr>`
                               
                            // }else{
                            //     str = `<tr><td>\${idex}</td><td>\${item.title}</td><td>\${item.master}</td><td>\${item.mastertelephone}
                            //        </td><td>\${item.linkman}</td><td>\${item.linkmantelephone}</td><td>\${item.opentime}</td><td>\${item.myid}</td></tr>`
                              
                            // }
                            // $('#siteForm').append(str) 

                        });
                        $('#siteForm').append(str) 

                    });
                //    console.log(arrINdex,"00");


              });


            var ind = "1";

            $("#infotable td>span").click(function () {
                var myid = $(this).attr("myid")
                location.href = "/delegatexweb/infopage/delegationinfo.jsp?myid=" + myid
            })
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
