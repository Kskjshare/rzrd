// $("button").click(function () {
//     
// $.get("/widget/upload.jsp", {'n': spid,}, function (json) {
//        if(json==1){
//            window.location.reload();
//        }
//    });
//    });
    
    

            $('button').click(function(){
                    var formData = new FormData();
            formData.append("file", $("#file")[0].files[0]);        //第一个参数：参数名称  第二个参数：值


            $.ajax({
            url: "/widget/upload.jsp?",
                    type: 'post',
                    data: formData,
                    processData: false, // 告诉jQuery不要去处理发送的数据

                    contentType: false, // 告诉jQuery不要去设置Content-Type请求头

                    beforeSend: function () {
                    console.log("正在进行，请稍候");
                    },
                    success: function (data) {
                        var json = eval('(' + data + ')');
                   $.get("/delegation/excel.jsp", {'n': json.url}, function (e) {
                     var a = JSON.parse(e);
                       alert("成功导入"+a.rowsnum+"条数据")
                      popuplayer.close(); 
                      parent.quicksearch("/delegation/list.jsp?"+Math.floor(Math.random()*100))
                   });
                    },
                    error: function (data) {
//                    console.log("error");
                    }
            });
            });

//function ajaxFileUpload(obj) {
//    $.ajaxFileUpload
//            (
//                    {
//                        url: '../widget/upload.jsp', //用于文件上传的服务器端请求地址
//                        secureuri: false, //是否需要安全协议，一般设置为false
//                        fileElementId: "file", //文件上传域的ID
//                        dataType: 'json', //返回值类型 一般设置为json
//                        success: function (data, status)  //服务器成功响应处理函数
//                        {
//                            if (typeof (data.error) != 'undefined') {
//                                if (data.error == '' || data.error == "null") {
//                                    $.get("/delegation/excel.jsp",{"url":data.url},function(result){
//                                        
//                                    })
//                                } else {
//                                    alert(data.error);
//                                }
//                            }
//                        },
//                        error: function (data, status, e)//服务器响应失败处理函数
//                        {
//                            alert(e);
//                        }
//                    }
//            )
//    return false;
//}