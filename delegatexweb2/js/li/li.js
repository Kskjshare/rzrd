var arry = [],
	mysuggestnav = "0",
	mysuggestnavYA = "0",
	myHDy = "0";
//var quill = new Quill('#editor', {
//    theme: 'snow'
//});
//below added by jackie//取出会议时间，判断当前时间是否在会议时间内
var nowedition = "1.9.9.3";
var flowtype="2";//议审委流程
var flowtype_ysw = "";
function loadmeeting()
{	
		var l_now = Date.parse(new Date()) / 1000;
		var l_startdate = "";
		var l_enddate = "";		
		//var missions = "", realname = "";
	if(flowtype=="2"){//议审委流程
		RssApi.Table.List("meeting").condition(new RssDict().keyvalue({
			"1": "1"
		}).getDict()).getJson(function(jsonn) {
			$.each(jsonn, function(k, v) {
				// missions = v.mission;
				 l_startdate=v.startdate;
				 l_enddate=v.enddate;
				 // alert("111:l_now:"+l_now);
				 // alert("111:l_startdate:"+l_startdate);
				 // alert("111:l_enddate:"+l_enddate);
				if (l_now < l_enddate && l_now > l_startdate) {
					flowtype_ysw = "21"; //3:议审委初审且在会议期间
				} else {
					flowtype_ysw = "22"; //3:议审委初审且不在会议期间
				}
			})
		})			
	}
}
loadmeeting();
//up added by jackie
function upfile1(file) {
	var formData = new FormData();
	formData.append("file", $(file)[0].files[0]);
	$.ajax({
		url: RssApp["WwwHost"] + "widget/upload.jsp",
		type: 'POST',
		data: formData,
		processData: false, // 告诉jQuery不要去处理发送的数据
		contentType: false, // 告诉jQuery不要去设置Content-Type请求头
		beforeSend: function() {
			console.log("正在进行，请稍候");
		},
		success: function(data) {
			data = JSON.parse(data);
			//            console.log(data.url);
			$("#suggestsub .fja").text(data.url);
			alert("上传成功");
		},
		error: function(data) {
			console.log("上传失败");
			alert("上传失败");
		}
	});
}

function upfile2(file) {
	var formData = new FormData();
	formData.append("file2", $(file)[0].files[0]);
	$.ajax({
		url: RssApp["WwwHost"] + "widget/upload.jsp",
		type: 'POST',
		data: formData,
		processData: false, // 告诉jQuery不要去处理发送的数据
		contentType: false, // 告诉jQuery不要去设置Content-Type请求头
		beforeSend: function() {
			console.log("正在进行，请稍候");
		},
		success: function(data) {
			data = JSON.parse(data);
			//            console.log(data.url);
			$("#suggestsubYA .fja").text(data.url)
			alert("上传成功");
		},
		error: function(data) {
			console.log("上传失败");
			alert("上传失败");
		}
	});
}

//导航条切换
$("nav>a").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel");
})
//登录页点击变蓝
$("#loginform li").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel")
})
//记住密码
$("#forget").change(function() {
	if ($(this).is(":checked")) {
		//      localStorage.password = $("input[name='pwd']").val();  
	} else {
		localStorage.password = "";
	}
})
$("#loginpage").load(function() {
	if (localStorage.password == "" || localStorage.password == undefined) {} else {
		$("input[name='account']").val(RssUser.Data.account);
		$("input[name='pwd']").val(localStorage.password);
		$("#forget").prop('checked');
	}
})
if (localStorage.password == "" || localStorage.password == undefined) {} else {
	$("input[name='account']").val(RssUser.Data.account);
	$("input[name='pwd']").val(localStorage.password);
	$("#forget").attr("checked", "checked");
}

var faqsajax;
//新闻提醒清除
$("#notice li").click(function() {
	$(this).find("span").removeAttr("value");
})
//评级
$("#handleevaluate li em a").click(function() {
	var ind = $(this).index();
	$(this).parent().find("a").each(function() {
		if ($(this).index() <= ind) {
			$(this).addClass("sel")
		} else {
			$(this).removeClass("sel")
		}
	})
})
//遮罩层
$("#zzc").click(function() {
	$("#zzc").hide();
})
$("section").load(function() {
	$("#zzc").hide();
})
var zzc = function(t, e) {
	$("#zzc ul").empty();
	$("#zzc").show();
	console.log(e)
	$.each(e, function(k, v) {
		console.log(k + "---" + v)
		$("#zzc ul").append("<li relationid='" + k + "'>" + v + "</li>")
	})
	$("#zzc li").off("click").click(function(e) {
		e.stopPropagation();
		t.text($(this).text());
		t.attr("relationid", $(this).attr("relationid"))
		//        $("#oldsuggest .search input").val($("#oldsuggest em").text())
		$("#zzc").hide();
	})
}

//遮罩层
$("#zzc6").click(function() {
	$("#zzc6").hide();
})
$("section").load(function() {
	$("#zzc6").hide();
})
var zzc6 = function(tt, ee) {
	$("#zzc6 ul").empty();
	$("#zzc6").show();
	$.each(ee, function(k, v) {
		$("#zzc6 ul").append("<li relationid='" + k + "'>" + v + "</li>")
	})
	$("#zzc6 li").off("click").click(function(ee) {
		ee.stopPropagation();
		tt.text($(this).text());
		tt.attr("relationid", $(this).attr("relationid"))
		$("#oldsuggest .search input").attr("placeholder", $("#oldsuggest em").text())
		$("#zzc6").hide();
	})
}

//置回建议列表
$("#zhihuiJY").load(function() {
	var missions = "";
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(ms) {
		$.each(ms, function(k, v) {
			missions = v.mission;
		})
	})

	$("#zhihuiJY .search button").off("click").click(function() {
		var key = $("#zhihuiJY .search input").val();
		if (key) {
			key = {
				'title': "{likeall~" + key + "}"
			};
		} else {
			key = "";
		}
		if (arry.indexOf("zhihuiJY") == "-1") {
			$("#zhihuiJY ul li").eq(0).siblings().remove();
			arry.push("zhihuiJY")
		} else {
			$("#zhihuiJY ul li").remove();
		}
		new Ajax("sortnum").keyvalue("key", $("#zhihuiJY .search input").val()).keyvalue("lwstate", "1").getJson(function(
			data) {
			$("#zhihuiJY article>p").text("共" + data[0].num + "条信息")


			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"lwstate": "1",
				"examination": "3",
				"myid": RssUser.Data.myid
			}).keyvalue(key).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#zhihuiJY ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				if (json.length == "0") {
					alert("未找到查询目标")
				}
				//查看
				$("#zhihuiJY .see").off().click(function() {
					var key = $(this).parent().attr("sortid");
					location.href = "#seesuggest"
					$('#seesuggest article .no1').remove();
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div><div class="no"  >置回原由：' + v.buyBack +
								'</div>')
						})

						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs11'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs11', {
								pdfurl: dz
							});
						})
						//                        console.log(json);
						//                        $("#seesuggest .divp").html(json[0].matter)
						//                        $("#seesuggest .divp").html(json[0].csname)
						//                        $("#seesuggest .divp").html(json[0].scname)
					})
				})
				//附议
				$("#zhihuiJY .ans").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					RssApi.Table.List("suggest").condition(new RssDict().keyvalue({
						"examination": 1,
						"id": key,
						"myid": RssUser.Data.myid
					}).getDict()).getJson(function(fy) {
						if (fy.length == "0") {
							RssApi.Edit("suggest").setLoading(true).keyvalue({
								"examination": 1,
								"isdbtshenhe": 2,
								"id": key,
								"myid": RssUser.Data.myid
							}).getJson(function(tj) {
								//                                RssApi.Edit("suggestscr").setLoading(true).keyvalue({
								//                                    "suggestid": key,
								//                                    "userid": missions,
								//                                    "myid": 0
								//                                }).getJson(function (sc) {
								//
								//                                })
								alert("重新提出成功")
								location.href = "#suggest";
							})
						} else {
							alert("已经重新提出过了");
						}
					})
				})
			}).getJson()
		})
	})
	if ($("#zhihuiJY .search input").val() == "" || $("#zhihuiJY .search input").val() == undefined) {
		$("#zhihuiJY .search button").click();
	}
	//    }).getJson();
})

//置回议案列表
$("#zhihuiYA").load(function() {
	var missions = "";
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(ms) {
		$.each(ms, function(k, v) {
			missions = v.mission;
		})
	})
	$("#zhihuiYA .search button").off("click").click(function() {
		var key = $("#zhihuiYA .search input").val();
		if (key) {
			key = {
				'title': "{likeall~" + key + "}"
			};
		} else {
			key = "";
		}
		if (arry.indexOf("zhihuiYA") == "-1") {
			$("#zhihuiYA ul li").eq(0).siblings().remove();
			arry.push("zhihuiYA")
		} else {
			$("#zhihuiYA ul li").remove();
		}

		new Ajax("sortnum").keyvalue("key", $("#zhihuiYA .search input").val()).keyvalue("lwstate", "2").getJson(function(
			data) {
			//            $("#zhihuiYA article>p").text("共" + data[0].num + "条信息")


			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"lwstate": "2",
				"examination": "3",
				"myid": RssUser.Data.myid
			}).keyvalue(key).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#zhihuiYA ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				if (json.length == "0") {
					alert("未找到查询目标")
				}
				//查看
				$("#zhihuiYA .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div><div class="no"  >置回原由：' + v.buyBack +
								'</div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs10'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs10', {
								pdfurl: dz
							});
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
					})
				})
				//附议
				$("#zhihuiYA .ans").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					RssApi.Table.List("suggest").condition(new RssDict().keyvalue({
						"examination": 1,
						"id": key,
						"myid": RssUser.Data.myid
					}).getDict()).getJson(function(json) {
						if (json.length == "0") {
							RssApi.Edit("suggest").setLoading(true).keyvalue({
								"examination": 1,
								"isdbtshenhe": 2,
								"id": key,
								"myid": RssUser.Data.myid
							}).getJson(function(jsonm) {
								//                                RssApi.Edit("suggestscr").setLoading(true).keyvalue({
								//                                    "suggestid": key,
								//                                    "userid": missions,
								//                                    "myid": 0
								//                                }).getJson(function (sc) {
								//
								//                                })
								alert("重新提出成功")
								location.href = "#suggest";
							})
						} else {
							alert("已经重新提出过了");
						}
					})
				})
			}).getJson()
		})
	})
	if ($("#zhihuiYA .search input").val() == "" || $("#zhihuiYA .search input").val() == undefined) {
		$("#zhihuiYA .search button").click();
	}
	//    }).getJson();
})


//附议建议列表
$("#suggestsec").load(function() {
	//    $("#suggestsec ul li").eq(0).siblings().remove();
	//    faqsajax = RssApi.View.List("sort").condition(new RssDict().keyvalue({"draft": "2", "lwstate": "1", "seconded": "1"}).getDict()).setFlushUI(function (json, append) {
	//        if (json.length != "10") {
	//            $('.nodata').hide();
	//        }else {
	//           $('.nodata').show();
	//        }
	//        $("#suggestsec ul").mapview(json, {
	//            "registertype": function (val) {
	//                var registertype = dictdata.registertype[val]
	//                return registertype;
	//            }
	//        }, append)
	$("#suggestsec .search button").off("click").click(function() {
		var key = $("#suggestsec .search input").val();
		if (key) {
			key = {
				'title': "{likeall~" + key + "}"
			};
		} else {
			key = "";
		}
		if (arry.indexOf("suggestsec") == "-1") {
			$("#suggestsec ul li").eq(0).siblings().remove();
			arry.push("suggestsec")
		} else {
			$("#suggestsec ul li").remove();
		}
		new Ajax("sortnum").keyvalue("key", $("#suggestsec .search input").val()).keyvalue("lwstate", "1").getJson(
			function(data) {
				$("#suggestsec article>p").text("共" + data[0].num + "条信息")


				faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
					"draft": "2",
					"lwstate": "1",
					"seconded": "1"
				}).keyvalue(key).getDict()).setFlushUI(function(json, append) {
					if (json.length != "10") {
						$('.nodata').hide();
					} else {
						$('.nodata').show();
					}
					$("#suggestsec ul").mapview(json, {
						"registertype": function(val) {
							var registertype = dictdata.registertype[val]
							return registertype;
						}
					}, append)
					if (json.length == "0") {
						alert("未找到查询目标")
					}
					//查看
					$("#suggestsec .see").click(function() {
						var key = $(this).parent().attr("sortid");
						RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
							"sortid": key
						}).getDict()).getJson(function(json) {
							var shijian = "",
								level = ""
							$("#seesuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
								},
								"level": function(val) {
									return level = dictdata.circles[val];
								}
							})
							$.each(json, function(k, v) {
								$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
									'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
									'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
									'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
									'</div><div class="no">附件：,' + v.enclosure + '</div>')
							})
						})
					})
					//附议
					$("#suggestsec .ans").off("click").click(function() {
						var key = $(this).parent().attr("sortid");
						RssApi.Table.List("secondeduser").condition(new RssDict().keyvalue({
							"suggestid": key,
							"userid": RssUser.Data.myid
						}).getDict()).getJson(function(json) {
							if (json.length == "0") {
								RssApi.Edit("secondeduser").setLoading(true).keyvalue({
									"suggestid": key,
									"userid": RssUser.Data.myid,
									"myid": RssUser.Data.myid
								}).getJson(function(json) {
									alert("联名提出成功")
									location.href = "#suggest";
								})
							} else {
								alert("已经联名提出过了");
							}
						})
					})
				}).getJson()
			})
	})
	if ($("#suggestsec .search input").val() == "" || $("#suggestsec .search input").val() == undefined) {
		$("#suggestsec .search button").click();
	}
	//    }).getJson();
})

//附议议案列表
$("#suggestsecYA").load(function() {
	$("#suggestsecYA .search button").off("click").click(function() {
		var key = $("#suggestsecYA .search input").val();
		if (key) {
			key = {
				'title': "{likeall~" + key + "}"
			};
		} else {
			key = "";
		}
		if (arry.indexOf("suggestsecYA") == "-1") {
			$("#suggestsecYA ul li").eq(0).siblings().remove();
			arry.push("suggestsecYA")
		} else {
			$("#suggestsecYA ul li").remove();
		}

		new Ajax("sortnum").keyvalue("key", $("#suggestsecYA .search input").val()).keyvalue("lwstate", "2").getJson(
			function(data) {
				$("#suggestsecYA article>p").text("共" + data[0].num + "条信息")


				faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
					"draft": "2",
					"lwstate": "2",
					"seconded": "1"
				}).keyvalue(key).getDict()).setFlushUI(function(json, append) {
					if (json.length != "10") {
						$('.nodata').hide();
					} else {
						$('.nodata').show();
					}
					$("#suggestsecYA ul").mapview(json, {
						"registertype": function(val) {
							var registertype = dictdata.registertype[val]
							return registertype;
						}
					}, append)
					if (json.length == "0") {
						alert("未找到查询目标")
					}
					//查看
					$("#suggestsecYA .see").off().click(function() {
						$('#seesuggest article .no1').remove();
						var key = $(this).parent().attr("sortid");
						RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
							"sortid": key
						}).getDict()).getJson(function(json) {
							var shijian = "",
								level = ""
							$("#seesuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
								},
								"level": function(val) {
									return level = dictdata.circles[val];
								}
							})
							$.each(json, function(k, v) {
								$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
									'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
									'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
									'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
									'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div>')
							})
							RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
								"suggestid": key
							}).keyvalue().getDict()).getJson(function(lm) {
								var lmr = ""
								$.each(lm, function(k, v) {
									lmr += v.realname + ",";
								})
								console.log(lmr);
								$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
							})
							var dfenclosure = $("#seesuggest article .fj span").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs9'>" + value + "</p>"
									$('#seesuggest article .fj').append(html);
								}
							})
							$('#seesuggest article  .fj span').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs9', {
									pdfurl: dz
								});
							})
							//                        $("#seesuggest .divp").html(json[0].matter)
						})
					})
					//附议
					$("#suggestsecYA .ans").off("click").click(function() {
						var key = $(this).parent().attr("sortid");
						RssApi.Table.List("secondeduser").condition(new RssDict().keyvalue({
							"suggestid": key,
							"userid": RssUser.Data.myid
						}).getDict()).getJson(function(json) {
							if (json.length == "0") {
								RssApi.Edit("secondeduser").setLoading(true).keyvalue({
									"suggestid": key,
									"userid": RssUser.Data.myid,
									"myid": RssUser.Data.myid
								}).getJson(function(json) {
									alert("联名提出成功")
									location.href = "#suggest";
								})
							} else {
								alert("已经联名提出过了");
							}
						})
					})
				}).getJson()
			})
	})
	if ($("#suggestsecYA .search input").val() == "" || $("#suggestsecYA .search input").val() == undefined) {
		$("#suggestsecYA .search button").click();
	}
	//    }).getJson();
})




//我的建议
$("#mysuggest").load(function() {
	$("#mysuggest nav>a").off("click").click(function() {
		$(this).addClass("sel").siblings().removeClass("sel");
		if (arry.indexOf("mysuggest") == "-1") {
			$("#mysuggest ul li").eq(0).siblings().remove();
			arry.push("mysuggest")
		} else {
			$("#mysuggest ul li").remove();
		}
		if ($(this).index() == "0") {
			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"lwstate": "1",
				"myid": RssUser.Data.myid
			}).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#mysuggest ul").mapview(json, {
					//                    "registertype": function (val) {
					//                        var registertype = dictdata.registertype[val]
					//                        return registertype;
					//                    }
				}, append)
				$("#mysuggest .del").show();
				//查看
				$("#mysuggest .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})

						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs8'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs8', {
								pdfurl: dz
							});
						})

						//                        $("#seesuggest .divp").html(json[0].matter)
					})
				})
				//办复信息
				$("#mysuggest .ans").off("click").click(function() {

					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办理单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>办理方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>办理附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>办理期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办理人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办理人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办理意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办理报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs7'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs7', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办理信息！</p>')
						}
					})

				})
				//删除
				$("#mysuggest .del").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					var t = $(this);
					RssApi.Delete("suggest").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).keyvalue().getDict()).getJson(function(json) {
						alert("删除成功");
						t.parents("li").remove();
						//                      $("#mysuggest").load();
					})
				})
				//办复信息
			}).getJson();
		} else {
			faqsajax = RssApi.View.List("second_suggest").setLoading(true).condition({
				"userid": RssUser.Data.myid,
				"lwstate": "1",
			}).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#mysuggest ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				$("#mysuggest .del").hide();
				//查看
				$("#mysuggest .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs14'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs14', {
								pdfurl: dz
							});
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
					})
				})
				//办复信息
				$("#mysuggest .ans").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					location.href = "#anssuggest"
					//                    $("#anssuggest").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							//                            $("#anssuggest article .zw").remove();
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办复单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>答复方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>答复附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>答复期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办复人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办复人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办复意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办复报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs7'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs7', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办复信息！</p>')
						}
					})
				})
				//删除
				$("#mysuggest .del").off("click").click(function() {
					var t = $(this);
					var key = $(this).parent().attr("sortid");
					RssApi.Delete("suggest").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).keyvalue().getDict()).getJson(function(json) {
						alert("删除成功");
						t.parents("li").remove();
						//                      $("#mysuggest").load();
					})
				})
				//办复信息
			}).getJson();
		}
	})
	if (mysuggestnav == "1") {
		$("#mysuggest nav>a").eq(0).click();
		mysuggestnav = "0";
	}
})

//我的议案
$("#mysuggestYA").load(function() {
	$("#mysuggestYA nav>a").off("click").click(function() {
		$(this).addClass("sel").siblings().removeClass("sel");
		if (arry.indexOf("mysuggestYA") == "-1") {
			$("#mysuggestYA ul li").eq(0).siblings().remove();
			arry.push("mysuggestYA")
		} else {
			$("#mysuggestYA ul li").remove();
		}
		if ($(this).index() == "0") {
			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"lwstate": "2",
				"myid": RssUser.Data.myid
			}).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#mysuggestYA ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				$("#mysuggestYA .del").show();
				//查看
				$("#mysuggestYA .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var aa = $('#seesuggest article  .fj').text();
					if (!(aa == "" || aa == undefined)) {
						$('#seesuggest article .pdfjs16').remove();
					}
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="fj no">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs16'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs16', {
								pdfurl: dz
							});
						})
					})
				})
				//办复信息
				$("#mysuggestYA .ans").off("click").click(function() {
					$("#anssuggest article a").remove();
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							//                            $("#anssuggest article .zw").remove();
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办复单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>答复方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>答复附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>答复期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办复人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办复人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办复意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办复报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs18'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs18', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办复信息！</p>')
						}
					})
				})
				//删除
				$("#mysuggestYA .del").off("click").click(function() {
					var t = $(this);
					var key = $(this).parent().attr("sortid");
					RssApi.Delete("suggest").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).keyvalue().getDict()).getJson(function(json) {
						alert("删除成功");
						//                      $("#mysuggestYA").load();
						t.parents("li").remove();
					})
				})
				//办复信息
			}).getJson();
		} else {
			faqsajax = RssApi.View.List("second_suggest").setLoading(true).condition({
				"userid": RssUser.Data.myid,
				"lwstate": "2",
			}).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#mysuggestYA ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				$("#mysuggestYA .del").hide();
				//查看
				$("#mysuggestYA .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var aa = $('#seesuggest article  .fj').text();
					if (!(aa == "" || aa == undefined)) {
						$('#seesuggest article .pdfjs17').remove();
					}
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="fj no">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs17'>" + value + "</a>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs17', {
								pdfurl: dz
							});
						})
					})
				})
				//办复信息
				$("#mysuggestYA .ans").off("click").click(function() {

					var aa = $("#anssuggest article .fj p").text();
					if (!(aa == "" || aa == undefined)) {
						$("#anssuggest article .fj p:last").remove();
					}
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							//                            $("#anssuggest article .zw").remove();
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办复单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>答复方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>答复附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>答复期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办复人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办复人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办复意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办复报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs19'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs19', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办复信息！</p>')
						}
					})

				})
				//删除
				$("#mysuggestYA .del").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					var t = $(this);
					RssApi.Delete("suggest").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).keyvalue().getDict()).getJson(function(json) {
						alert("删除成功");
						t.parents("li").remove();
						//                      $("#mysuggestYA").load();
					})
				})
				//办复信息
			}).getJson();
		}
	})
	if (mysuggestnavYA == "1") {
		$("#mysuggestYA nav>a").eq(0).click();
		mysuggestnavYA = "0";
	}
})

////我的活动
//$("#myHD").load(function () {
//      if (arry.indexOf("myHD") == "-1") {
//          $("#myHD ul li").eq(0).siblings().remove();
//          arry.push("myHD")
//      } else {
//          $("#myHD ul li").remove();
//      }
//          faqsajax = RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
//              "myid": RssUser.Data.myid
//          }).getDict()).setFlushUI(function (json, append) {
//              if (json.length != "10") {
//                  $('.nodata').hide();
//              } else {
//                  $('.nodata').show();
//              }
//              $("#myHD ul").mapview(json, {}, append)
//              $("#myHD .del").show();
//              //查看
//              $("#myHD .see").off("click").click(function () {
//                  var key = $(this).parent().attr("id");
//                  RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
//                      "id": key
//                  }).getDict()).getJson(function (json) {
//                      $("#activityHD article").mapview(json, {
//                          "shijian": function (val) {
//                              return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
//                          }
//                      })
//                      $("#activityHD .divp").html(json[0].note)
//                  })
//              })
//              //删除
//              $("#myHD .del").off("click").click(function () {
//              	var t=$(this);
//                  var key = $(this).parent().attr("id");
//                  RssApi.Delete("activities").setLoading(true).condition(new RssDict().keyvalue({
//                      "id": key
//                  }).keyvalue().getDict()).getJson(function (json) {
//                      alert("删除成功");
//						t.parents("li").remove(); 
//						$("#myHD .fenye li:first-child").show();
////						$("#myHD").load();
//                  })
//              })
//              //办复信息
//          }).getJson();
//})

//活动报名
$("#applyHD").load(function() {
	if (arry.indexOf("applyHD") == "-1") {
		$("#applyHD ul li").eq(0).siblings().remove();
		arry.push("applyHD")
	} else {
		$("#applyHD ul li").remove();
	}
	var sj = (new Date()).getTime() / 1000;
	faqsajax = RssApi.View.List("activities_userlist").setLoading(true).condition(new RssDict().keyvalue({
		"userid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		//        $("#applyHD ul").mapview(json, {
		//            
		//        }, append)

		$.each(json, function(k, v) {
			if (v.endshijian >= sj) {
				$("#applyHD ul").append('<li><div class="liico"><span >' + v.id + '</span></div><h1>' + v.title +
					'</h1><p >组织部门：' + v.department + '</p><p >召集人：' + v.myname + '</p><div class="lifoot" activitiesid=' + v.activitiesid +
					' id=' + v.id +
					'><a href="#activityHD" class="see"><span>查看信息</span></a><a class="ans"><span>报名参与</span></a></div></li>');
			}
		})

		//查看
		$("#applyHD .see").off("click").click(function() {
			var key = $(this).parent().attr("activitiesid");
			RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
				"id": key,
				"userid": RssUser.Data.myid
			}).getDict()).getJson(function(json) {
				$("#activityHD").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"endshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"beginshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"finishshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"classify": function(val) {
						return dictdata["activitiestypeclassify"][val];
					},
				})
				$("#activityHD .divp").html(json[0].note)
				$("#activityHD .hisbackaa").click(function() {
					location.href = "#applyHD";
				});
			})
		})
		//报名
		$("#applyHD .ans").off("click").click(function() {
			var key1 = $(this).parent().attr("id");
			var key = $(this).parent().attr("activitiesid");
			RssApi.Table.Details("activities_userlist").setLoading(true).condition(new RssDict().keyvalue({
				"activitiesid": key,
				"id": key1,
				"userid": RssUser.Data.myid
			}).getDict()).getJson(function(json) {
				console.log(json)
				if (json.jointype == "1") {
					RssApi.Edit("activities_userlist").keyvalue({
						"jointype": "2",
						"id": key1,
						"myid": json.myid,
						"userid": RssUser.Data.myid
					}).getJson(function(jsona) {
						console.log(jsona)
						alert("报名成功");
					})
				} else {
					alert("已经报名过了");
				}

			})
		})
		$("#applyHD .hisbackaa").click(function() {
			location.href = "#suggest";
		});

		//办复信息
	}).getJson();
})

//活动考勤
$("#marchHD").load(function() {
	if (arry.indexOf("marchHD") == "-1") {
		$("#marchHD ul li").eq(0).siblings().remove();
		arry.push("marchHD")
	} else {
		$("#marchHD ul li").remove();
	}
	var time = (new Date()).getTime() / 1000;
	//    var time = new Date();
	//    var year = time.getFullYear();
	//    var month = time.getMonth() + 1;
	//    var day = time.getDate();
	//    time = year + "-" + month + "-0" + day;
	faqsajax = RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
		"userid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {

		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		//        $("#marchHD ul").mapview(json, {}, append)
		$.each(json, function(k, v) {
			if (v.beginshijian <= time && v.finishshijian >= time) {
				$("#marchHD ul").append('<li><div class="liico"><span>' + v.id + '</span></div><h1>' + v.title +
					'</h1><p>组织部门：' + v.department + '</p><p>召集人：' + v.username + '</p><div class="lifoot" activitiesid=' + v.id +
					' id=' + v.idd +
					'><a href="#activityHD" class="see"><span>查看信息</span></a><a class="ans"><span>考勤参与</span></a></div></li>');
			}
		})

		$("#marchHD .del").show();
		//查看
		$("#marchHD .see").off("click").click(function() {
			var key = $(this).parent().attr("activitiesid");
			RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
				"id": key,
				"userid": RssUser.Data.myid
			}).getDict()).getJson(function(json) {
				$("#activityHD").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"endshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"beginshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"finishshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"classify": function(val) {
						return dictdata["activitiestypeclassify"][val];
					},
				})
				$("#activityHD .divp").html(json[0].note)
				$("#activityHD .hisbackaa").click(function() {
					location.href = "#marchHD";
				});
			})
		})
		$("#marchHD .hisbackaa").click(function() {
			location.href = "#suggest";
		});
		//考勤参与
		$("#marchHD .ans").off("click").click(function() {
			var key1 = $(this).parent().attr("id");
			var key = $(this).parent().attr("activitiesid");
			RssApi.Table.Details("activities_userlist").setLoading(true).condition(new RssDict().keyvalue({
				"activitiesid": key,
				"id": key1,
				"userid": RssUser.Data.myid,
			}).getDict()).getJson(function(json) {
				if (json.attendancetype == "1") {
					RssApi.Edit("activities_userlist").keyvalue({
						"id": key1,
						"myid": json.myid,
						"attendancetype": "2",
						"userid": RssUser.Data.myid
					}).getJson(function(json) {
						alert("考勤成功");
					})
				} else {
					alert("已经考勤过了");
				}
			})
		})
		//办复信息
	}).getJson();
})

////活动成果总结
//$("#resultsHD").load(function () {
//    if (arry.indexOf("resultsHD") == "-1") {
//        $("#resultsHD ul li").eq(0).siblings().remove();
//        arry.push("resultsHD")
//    } else {
//        $("#resultsHD ul li").remove();
//    }
//    faqsajax = RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
//        "myid": RssUser.Data.myid
//    }).getDict()).setFlushUI(function (json, append) {
//        if (json.length != "10") {
//            $('.nodata').hide();
//        } else {
//            $('.nodata').show();
//        }
//        $("#resultsHD ul").mapview(json, {
//            "shijian": function (val) {
//                        return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
//                    }
//        },append)
////        $("#resultsHD .del").show();
//        //查看
////        $("#resultsHD .see").off("click").click(function () {
////            var key = $(this).parent().attr("id");
////            RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
////                "id": key
////            }).getDict()).getJson(function (json) {
////                $("#activityHD article").mapview(json, {
////                    "shijian": function (val) {
////                        return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
////                    }
////                })
////                $("#activityHD .divp").html(json[0].note)
////            })
////        })
//        //办复信息
//    }).getJson();
//})

//活动成果总结
$("#resultsHD").load(function() {
	if (arry.indexOf("resultsHD") == "-1") {
		$("#resultsHD ul li").eq(0).siblings().remove();
		arry.push("resultsHD")
	} else {
		$("#resultsHD ul li").remove();
	}

	faqsajax = RssApi.View.List("activities").setLoading(true).condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		////console.log(json);
		$("#resultsHD ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#resultsHD ul li").click(function() {
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#resultsHDck"
			$("#resultsHDck").find("header>h1").text();
			RssApi.Details("activities").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#resultsHDck article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"endshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"beginshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"classify": function(val) {
						return dictdata["activitiestypeclassify"][val];
					},
				})
			})
		})
	}).getJson();
})



//办理评价
$("#suggesthandle").load(function() {
	if (arry.indexOf("suggesthandle") == "-1") {
		$("#suggesthandle ul li").eq(0).siblings().remove();
		arry.push("suggesthandle")
	} else {
		$("#suggesthandle ul li").remove();
	}
	faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
		"draft": "2",
		"lwstate": "1",
		"myid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		var draft, examination, deal, resume
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#suggesthandle ul").mapview(json, {
			"registertype": function(val) {
				var registertype = dictdata.registertype[val]
				return registertype;
			},
			"handle": function(val) {
				var handle = dictdata.handle[val]
				return handle;
			},
			"draft": function(val) {
				draft = val;
			},
			"examination": function(val) {
				examination = val;
			},
			"deal": function(val) {
				deal = val;
			},
			"iscs": function(val) {
				iscs = val;
			},
			"isxzsc": function(val) {
				isxzsc = val;
			},
			"resume": function(val) {
				resume = val;
				if (draft == "1") {
					return "草稿"
				} else if (deal == "1" && resume == "1") {
					return "已答复";
				} else if (deal == "1" && resume == "0") {
					return "已交办";
				} else if (examination == "2" && deal == "0" && draft == "2") {
					return "已审查";
				} else if (isxzsc == "1" && draft == "2") {
					return "已答复";
				} else if (iscs == "1" && draft == "2") {
					return "初审查";
				} else if (examination == "1" && draft == "2") {
					return "已提交";
				} else if (examination == "3") {
					return "已置回";
				}
			}
		}, append)
		//查看
		$("#suggesthandle ul>li").off("click").click(function() {
			var key = $(this).find("h1").attr("sortid");
			RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"sortid": key
			}).getDict()).getJson(function(json) {
				var draft, examination, deal, resume
				$("#handlesuggestinfo article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"draft": function(val) {
						draft = val;
					},
					"examination": function(val) {
						examination = val;
					},
					"deal": function(val) {
						deal = val;
					},
					"iscs": function(val) {
						iscs = val;
					},
					"isxzsc": function(val) {
						isxzsc = val;
					},
					"resume": function(val) {
						resume = val;
						if (draft == "1") {
							return "草稿"
						} else if (deal == "1" && resume == "1") {
							return "已答复";
						} else if (deal == "1" && resume == "0") {
							return "已交办";
						} else if (examination == "2" && deal == "0" && draft == "2") {
							return "已审查";
						} else if (isxzsc == "1" && draft == "2") {
							return "已答复";
						} else if (iscs == "1" && draft == "2") {
							return "初审查";
						} else if (examination == "1" && draft == "2") {
							return "已提交";
						} else if (examination == "3") {
							return "已置回";
						}
					},

				})
				$("#wuliuck").off("click").click(function() {
					location.href = "#processState";
					var sid = $(this).attr("rssid")
					RssApi.Details("suggest").condition(new RssDict().keyvalue({
						"id": sid
					}).getDict()).getJson(function(lcjson) {
						$("#processState article>ul").remove();
						var lcstate = "1";
						num[0] = lcstate;
						if (lcjson.examination == "5" && lcjson.isxzsc == "1" && lcjson.draft == "2") {
							lcstate = "6"
							////console.log(lcjson.examination)
						} else if (lcjson.examination == "3") {
							lcstate = "7"
						} else if (lcjson.deal == "1" && lcjson.resume == "1") {
							lcstate = "5"
						} else if (lcjson.deal == "1" && lcjson.resume == "0") {
							lcstate = "4"
						} else if (lcjson.examination == "2" && lcjson.deal == "0" && lcjson.draft == "2") {
							lcstate = "3"
						} else if (lcjson.iscs == "1" && lcjson.draft == "2") {
							lcstate = "2"
						}
						////console.log(lcstate);
						if (lcstate == "6") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>乡镇政府办审查人：' + lcjson.xzname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
									1000).toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else if (lcstate == "7") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.zhTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>置回</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.zhTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>置回人：' + lcjson.zhName +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else {
							for (var i = 1; i <= lcstate; i++) {
								switch (i) {
									case 1:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.shijian) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 2:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
												1000).toString("yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
										//                                    case 3:
										//                                        $("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("yyyy-MM-dd") + '</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>审查</b><img src="img/limg/sz.png"/><a class="time">' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") + '</a></div><img src="img/limg/name.png" /><a>审查人：' + lcjson.xzname + '</a></li><li class="processFoter"></li></ul>')
										//                                        break;
									case 3:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ReviewTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>复审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办审查人：' + lcjson.fsrname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 4:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.AssignedByTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>政府办</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.AssignedByTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办交办人：' + lcjson.zfbname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 5:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ResponseTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ResponseTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>答复单位：' + lcjson.realcompanyname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 6:
										break;
									case 7:
										break;
								}
							}
						}
					})
				});

				//评论条数
				RssApi.Table.List("suggest_praise").condition(new RssDict().keyvalue({
					"relationid": json[0].id,
					"myid": RssUser.Data.myid
				}).getDict()).getJson(function(date) {
					if (date.length > 0) {
						$("#tbdz").addClass('dj');
					} else {
						$("#tbdz").removeClass('dj')
					}

					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": json[0].id,
						"type": "1"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num) {
							znum = num.relnum
						}
						$("#handlesuggestinfo .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": json[0].id
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum) {
								snum = sunum.sugnum
							}
							$("#handlesuggestinfo .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": json[0].id
							}).getDict()).getJson(function(comment) {
								$("#handlesuggestinfo article>ul").empty();
								if (comment.length == "0") {
									$("#handlesuggestinfo article>ul").before('<div id="wpj">无评价</div>')
								}
								$.each(comment, function(k, v) {
									if (v.myid == RssUser.Data.myid) {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '<img src="img/limg/exit.png" /></li>')
									} else {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								sc();

							})
						})
					})
				})

				//点赞
				$("#tbdz").off("click").click(function() {
					var t = $(this);
					var zn = $("#handlesuggestinfo .ckfont").eq(0);
					var text_box = $("#add-num");
					if (t.hasClass('dj')) {
						RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({
							'id': t.attr("dzid")
						}).keymyid().getDict()).getJson(function(json) {
							t.removeClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
						});
						text_box.show().html("<em class='add-animation'>-1</em>");
						$(".add-animation").removeClass("hover");
					} else {
						RssApi.Edit("suggest_praise").keymyid().keyvalue('relationid', t.attr("rssid")).getJson(function(json) {
							t.addClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl + 1);
						});
						text_box.show().html("<em class='add-animation'>+1</em>");
						$(".add-animation").addClass("hover");
					}
				})

				//发送评论
				$("#evaluate").off("click").click(function() {
					var tid = $("#tbdz").attr("rssid")
					var pjtext = "<p>" + $("#pjtext").text() + "</p>"
					//                  var text_box = $("#add-num");
					if ($("#pjtext").text() != "") {
						RssApi.Edit("suggest_comment").keymyid().keyvalue({
							'suggestid': tid,
							'matter': pjtext
						}).getJson(function(json) {
							if (json.id > 0) {
								$("#handlesuggestinfo article>ul").append('<li PJid="' + json.id + '"><span>' + RssUser.Data.realname +
									'：</span>' + pjtext + '<img src="img/limg/exit.png" /></li>')
								$("#pjtext").text("")
								$("#handlesuggestinfo article").scrollTop($("#handlesuggestinfo article").height());
								var zn = $("#handlesuggestinfo .ckfont").eq(1);
								var sl = parseInt(zn.text())
								zn.text(sl + 1);
								$("#wpj").remove();
								sc();
								//                          text_box.show().html("<em class='add-animationa'>+1</em>");
								//                      	$(".add-animationa").addClass("hover");
							}
						});
					} else {
						alert("评论不能为空！");
					}
				})
				$("#handlesuggestinfo .divp").html(json[0].matter)
				location.href = "#handlesuggestinfo";
			})
		});

		//删除
		function sc() {

			$("#handlesuggestinfo ul>li>img").off("click").click(function() {
				var PJid = $(this).parent().attr("PJid");
				//              	alert(PJid);
				if (confirm("确认删除?")) {
					//              			RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({'id': t.attr("dzid")}).keymyid().getDict()).getJson(function (json) {
					RssApi.Delete("suggest_comment").condition(new RssDict().keyvalue({
						"id": PJid
					}).getDict()).getJson(function(json) {
						//              				alert("删除成功！");
						$("#handlesuggestinfo ul>li[PJid='" + PJid + "']").remove();
						var zn = $("#handlesuggestinfo .ckfont").eq(1);
						var sl = parseInt(zn.text())
						zn.text(sl - 1);
						$("#wpj").remove();
					});

				}
				//alert("删除");
			});
		}

		//查看
		$("#suggesthandle .ans").off("click").click(function() {
			var key = $(this).parent().attr("sortid");
			RssApi.Details("suggest_opinion").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				var star = ["business", "initiative", "communication", "counter", "consensus"]
				var checkbox = ["reply", "handle", "issue", "deal"]
				$("#handleevaluate article").mapview(json, {
					"seconded": function(val) {
						var seconded = dictdata.seconded[val]
						return seconded;
					},
					"permission": function(val) {
						var permission = dictdata.permission[val]
						return permission;
					},
					"suhandle": function(val) {
						var handle = dictdata.handle[val]
						return handle;
					}
				})
				$("[effect]").attr("relationid", json.effect);
				$("[effect]").text(dictdata.effect[json.effect])
				$.each(star, function(k, v) {
					var t = json[v];
					if (json[v]) {
						pingji(json[v], v)
					} else {
						$("[name ='" + v + "']").find("a").removeClass("sel");
					}
				})
				$("input[type='checkbox']").prop("checked", false);
				$.each(checkbox, function(k, v) {
					if (json[v] == "1") {
						$("input[name ='" + v + "']").prop("checked", true);
					}
				})
				$("[effect]").off("click").click(function() {
					zzc($(this), dictdata["effect"]);
				})
				$("#handleevaluate .normalbutton").off("click").click(function() {
					var k1 = {},
						k2 = {},
						k3 = "";
					$.each(star, function(k, v) {
						k1[v] = $("em[name='" + v + "']").find(".sel").length;
					})
					$.each(checkbox, function(k, v) {
						if ($("input[name='" + v + "']").is(":checked")) {
							k2[v] = "1";
						} else {
							k2[v] = "2";
						}
					})
					k3 = $("[effect]").attr("relationid");
					RssApi.Delete("opinion").condition(new RssDict().keyvalue({
						"proposal": key
					}).keyvalue().getDict()).getJson(function(json) {
						RssApi.Edit("opinion").setLoading(true).keyvalue(k1).keyvalue(k2).keyvalue({
							"myid": RssUser.Data.myid,
							"proposal": key,
							"effect": k3
						}).getJson(function(json) {
							alert("评价提交成功");
						})
					})
				})
			})
		})
	}).getJson();
})

//联名办理评价建议
$("#lmsuggesthandle").load(function() {
	if (arry.indexOf("lmsuggesthandle") == "-1") {
		$("#lmsuggesthandle ul li").eq(0).siblings().remove();
		arry.push("lmsuggesthandle")
	} else {
		$("#lmsuggesthandle ul li").remove();
	}
	faqsajax = RssApi.View.List("sortuser").setLoading(true).condition(new RssDict().keyvalue({
		"draft": "2",
		"lwstate": "1",
		"userid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		var draft, examination, deal, resume
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#lmsuggesthandle ul").mapview(json, {
			"registertype": function(val) {
				var registertype = dictdata.registertype[val]
				return registertype;
			},
			"handle": function(val) {
				var handle = dictdata.handle[val]
				return handle;
			},
			"draft": function(val) {
				draft = val;
			},
			"examination": function(val) {
				examination = val;
			},
			"deal": function(val) {
				deal = val;
			},
			"iscs": function(val) {
				iscs = val;
			},
			"isxzsc": function(val) {
				isxzsc = val;
			},
			"resume": function(val) {
				resume = val;
				if (draft == "1") {
					return "草稿"
				} else if (deal == "1" && resume == "1") {
					return "已答复";
				} else if (deal == "1" && resume == "0") {
					return "已交办";
				} else if (examination == "2" && deal == "0" && draft == "2") {
					return "已审查";
				} else if (isxzsc == "1" && draft == "2") {
					return "已答复";
				} else if (iscs == "1" && draft == "2") {
					return "初审查";
				} else if (examination == "1" && draft == "2") {
					return "已提交";
				} else if (examination == "3") {
					return "已置回";
				}
			}
		}, append)
		//查看
		$("#lmsuggesthandle ul>li").off("click").click(function() {
			var key = $(this).find("h1").attr("sortid");
			RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"sortid": key
			}).getDict()).getJson(function(json) {
				var draft, examination, deal, resume
				$("#handlesuggestinfo article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"draft": function(val) {
						draft = val;
					},
					"examination": function(val) {
						examination = val;
					},
					"deal": function(val) {
						deal = val;
					},
					"iscs": function(val) {
						iscs = val;
					},
					"isxzsc": function(val) {
						isxzsc = val;
					},
					"resume": function(val) {
						resume = val;
						if (draft == "1") {
							return "草稿"
						} else if (deal == "1" && resume == "1") {
							return "已答复";
						} else if (deal == "1" && resume == "0") {
							return "已交办";
						} else if (examination == "2" && deal == "0" && draft == "2") {
							return "已审查";
						} else if (isxzsc == "1" && draft == "2") {
							return "已答复";
						} else if (iscs == "1" && draft == "2") {
							return "初审查";
						} else if (examination == "1" && draft == "2") {
							return "已提交";
						} else if (examination == "3") {
							return "已置回";
						}
					},

				})
				$("#wuliuck").off("click").click(function() {
					location.href = "#processState";
					var sid = $(this).attr("rssid")
					RssApi.Details("suggest").condition(new RssDict().keyvalue({
						"id": sid
					}).getDict()).getJson(function(lcjson) {
						$("#processState article>ul").remove();
						var lcstate = "1";
						num[0] = lcstate;
						if (lcjson.examination == "5" && lcjson.isxzsc == "1" && lcjson.draft == "2") {
							lcstate = "6"
							////console.log(lcjson.examination)
						} else if (lcjson.examination == "3") {
							lcstate = "7"
						} else if (lcjson.deal == "1" && lcjson.resume == "1") {
							lcstate = "5"
						} else if (lcjson.deal == "1" && lcjson.resume == "0") {
							lcstate = "4"
						} else if (lcjson.examination == "2" && lcjson.deal == "0" && lcjson.draft == "2") {
							lcstate = "3"
						} else if (lcjson.iscs == "1" && lcjson.draft == "2") {
							lcstate = "2"
						}
						////console.log(lcstate);
						if (lcstate == "6") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>乡镇政府办审查人：' + lcjson.xzname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
									1000).toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else if (lcstate == "7") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.zhTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>置回</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.zhTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>置回人：' + lcjson.zhName +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else {
							for (var i = 1; i <= lcstate; i++) {
								switch (i) {
									case 1:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.shijian) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 2:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
												1000).toString("yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
										//                                    case 3:
										//                                        $("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("yyyy-MM-dd") + '</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>审查</b><img src="img/limg/sz.png"/><a class="time">' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") + '</a></div><img src="img/limg/name.png" /><a>审查人：' + lcjson.xzname + '</a></li><li class="processFoter"></li></ul>')
										//                                        break;
									case 3:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ReviewTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>复审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办审查人：' + lcjson.fsrname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 4:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.AssignedByTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>政府办</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.AssignedByTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办交办人：' + lcjson.zfbname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 5:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ResponseTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ResponseTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>答复单位：' + lcjson.realcompanyname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 6:
										break;
									case 7:
										break;
								}
							}
						}
					})
				});

				//评论条数
				RssApi.Table.List("suggest_praise").condition(new RssDict().keyvalue({
					"relationid": json[0].id,
					"myid": RssUser.Data.myid
				}).getDict()).getJson(function(date) {
					if (date.length > 0) {
						$("#tbdz").addClass('dj');
					} else {
						$("#tbdz").removeClass('dj')
					}

					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": json[0].id,
						"type": "1"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num) {
							znum = num.relnum
						}
						$("#handlesuggestinfo .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": json[0].id
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum) {
								snum = sunum.sugnum
							}
							$("#handlesuggestinfo .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": json[0].id
							}).getDict()).getJson(function(comment) {
								$("#handlesuggestinfo article>ul").empty();
								if (comment.length == "0") {
									$("#handlesuggestinfo article>ul").before('<div id="wpj">无评价</div>')
								}
								$.each(comment, function(k, v) {
									if (v.myid == RssUser.Data.myid) {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '<img src="img/limg/exit.png" /></li>')
									} else {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								sc();

							})
						})
					})
				})

				//点赞
				$("#tbdz").off("click").click(function() {
					var t = $(this);
					var zn = $("#handlesuggestinfo .ckfont").eq(0);
					var text_box = $("#add-num");
					if (t.hasClass('dj')) {
						RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({
							'id': t.attr("dzid")
						}).keymyid().getDict()).getJson(function(json) {
							t.removeClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
						});
						text_box.show().html("<em class='add-animation'>-1</em>");
						$(".add-animation").removeClass("hover");
					} else {
						RssApi.Edit("suggest_praise").keymyid().keyvalue('relationid', t.attr("rssid")).getJson(function(json) {
							t.addClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl + 1);
						});
						text_box.show().html("<em class='add-animation'>+1</em>");
						$(".add-animation").addClass("hover");
					}
				})

				//发送评论
				$("#evaluate").off("click").click(function() {
					var tid = $("#tbdz").attr("rssid")
					var pjtext = "<p>" + $("#pjtext").text() + "</p>"
					//                  var text_box = $("#add-num");
					if ($("#pjtext").text() != "") {
						RssApi.Edit("suggest_comment").keymyid().keyvalue({
							'suggestid': tid,
							'matter': pjtext
						}).getJson(function(json) {
							if (json.id > 0) {
								$("#handlesuggestinfo article>ul").append('<li PJid="' + json.id + '"><span>' + RssUser.Data.realname +
									'：</span>' + pjtext + '<img src="img/limg/exit.png" /></li>')
								$("#pjtext").text("")
								$("#handlesuggestinfo article").scrollTop($("#handlesuggestinfo article").height());
								var zn = $("#handlesuggestinfo .ckfont").eq(1);
								var sl = parseInt(zn.text())
								zn.text(sl + 1);
								$("#wpj").remove();
								sc();
								//                          text_box.show().html("<em class='add-animationa'>+1</em>");
								//                      	$(".add-animationa").addClass("hover");
							}
						});
					} else {
						alert("评论不能为空！");
					}
				})
				$("#handlesuggestinfo .divp").html(json[0].matter)
				location.href = "#handlesuggestinfo";
			})
		});

		//删除
		function sc() {

			$("#handlesuggestinfo ul>li>img").off("click").click(function() {
				var PJid = $(this).parent().attr("PJid");
				//              	alert(PJid);
				if (confirm("确认删除?")) {
					//              			RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({'id': t.attr("dzid")}).keymyid().getDict()).getJson(function (json) {
					RssApi.Delete("suggest_comment").condition(new RssDict().keyvalue({
						"id": PJid
					}).getDict()).getJson(function(json) {
						//              				alert("删除成功！");
						$("#handlesuggestinfo ul>li[PJid='" + PJid + "']").remove();
						var zn = $("#handlesuggestinfo .ckfont").eq(1);
						var sl = parseInt(zn.text())
						zn.text(sl - 1);
						$("#wpj").remove();
					});

				}
				//alert("删除");
			});
		}

		//查看
		$("#lmsuggesthandle .ans").off("click").click(function() {
			var key = $(this).parent().attr("sortid");
			RssApi.Details("suggest_opinion").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				var star = ["business", "initiative", "communication", "counter", "consensus"]
				var checkbox = ["reply", "handle", "issue", "deal"]
				$("#handleevaluate article").mapview(json, {
					"seconded": function(val) {
						var seconded = dictdata.seconded[val]
						return seconded;
					},
					"permission": function(val) {
						var permission = dictdata.permission[val]
						return permission;
					},
					"suhandle": function(val) {
						var handle = dictdata.handle[val]
						return handle;
					}
				})
				$("[effect]").attr("relationid", json.effect);
				$("[effect]").text(dictdata.effect[json.effect])
				$.each(star, function(k, v) {
					var t = json[v];
					if (json[v]) {
						pingji(json[v], v)
					} else {
						$("[name ='" + v + "']").find("a").removeClass("sel");
					}
				})
				$("input[type='checkbox']").prop("checked", false);
				$.each(checkbox, function(k, v) {
					if (json[v] == "1") {
						$("input[name ='" + v + "']").prop("checked", true);
					}
				})
				$("[effect]").off("click").click(function() {
					zzc($(this), dictdata["effect"]);
				})
				$("#handleevaluate .normalbutton").off("click").click(function() {
					var k1 = {},
						k2 = {},
						k3 = "";
					$.each(star, function(k, v) {
						k1[v] = $("em[name='" + v + "']").find(".sel").length;
					})
					$.each(checkbox, function(k, v) {
						if ($("input[name='" + v + "']").is(":checked")) {
							k2[v] = "1";
						} else {
							k2[v] = "2";
						}
					})
					k3 = $("[effect]").attr("relationid");
					RssApi.Delete("opinion").condition(new RssDict().keyvalue({
						"proposal": key
					}).keyvalue().getDict()).getJson(function(json) {
						RssApi.Edit("opinion").setLoading(true).keyvalue(k1).keyvalue(k2).keyvalue({
							"myid": RssUser.Data.myid,
							"proposal": key,
							"effect": k3
						}).getJson(function(json) {
							alert("评价提交成功");
						})
					})
				})
			})
		})
	}).getJson();
})


//办理评价议案
$("#suggesthandleYA").load(function() {
	if (arry.indexOf("suggesthandleYA") == "-1") {
		$("#suggesthandleYA ul li").eq(0).siblings().remove();
		arry.push("suggesthandleYA")
	} else {
		$("#suggesthandleYA ul li").remove();
	}
	faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
		"lwstate": "2",
		"draft": "2",
		"myid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		var draft, examination, deal, resume
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#suggesthandleYA ul").mapview(json, {
			"registertype": function(val) {
				var registertype = dictdata.registertype[val]
				return registertype;
			},
			"handle": function(val) {
				var handle = dictdata.handle[val]
				return handle;
			},
			"draft": function(val) {
				draft = val;
			},
			"examination": function(val) {
				examination = val;
			},
			"deal": function(val) {
				deal = val;
			},
			"iscs": function(val) {
				iscs = val;
			},
			"isxzsc": function(val) {
				isxzsc = val;
			},
			"resume": function(val) {
				resume = val;
				if (draft == "1") {
					return "草稿"
				} else if (deal == "1" && resume == "1") {
					return "已答复";
				} else if (deal == "1" && resume == "0") {
					return "已交办";
				} else if (examination == "2" && deal == "0" && draft == "2") {
					return "已审查";
				} else if (isxzsc == "1" && draft == "2") {
					return "已答复";
				} else if (iscs == "1" && draft == "2") {
					return "初审查";
				} else if (examination == "1" && draft == "2") {
					return "已提交";
				} else if (examination == "3") {
					return "已置回";
				}
			}
		}, append)
		//查看
		$("#suggesthandleYA ul>li").off("click").click(function() {
			var key = $(this).find("h1").attr("sortid");
			RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"sortid": key
			}).getDict()).getJson(function(json) {
				var draft, examination, deal, resume
				$("#handlesuggestinfo article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"draft": function(val) {
						draft = val;
					},
					"examination": function(val) {
						examination = val;
					},
					"deal": function(val) {
						deal = val;
					},
					"iscs": function(val) {
						iscs = val;
					},
					"isxzsc": function(val) {
						isxzsc = val;
					},
					"resume": function(val) {
						resume = val;
						if (draft == "1") {
							return "草稿"
						} else if (deal == "1" && resume == "1") {
							return "已答复";
						} else if (deal == "1" && resume == "0") {
							return "已交办";
						} else if (examination == "2" && deal == "0" && draft == "2") {
							return "已审查";
						} else if (isxzsc == "1" && draft == "2") {
							return "已答复";
						} else if (iscs == "1" && draft == "2") {
							return "初审查";
						} else if (examination == "1" && draft == "2") {
							return "已提交";
						} else if (examination == "3") {
							return "已置回";
						}
					},

				})
				$("#wuliuck").off("click").click(function() {
					location.href = "#processState";
					var sid = $(this).attr("rssid")
					RssApi.Details("suggest").condition(new RssDict().keyvalue({
						"id": sid
					}).getDict()).getJson(function(lcjson) {
						$("#processState article>ul").remove();
						var lcstate = "1";
						num[0] = lcstate;
						if (lcjson.examination == "5" && lcjson.isxzsc == "1" && lcjson.draft == "2") {
							lcstate = "6"
							////console.log(lcjson.examination)
						} else if (lcjson.examination == "3") {
							lcstate = "7"
						} else if (lcjson.deal == "1" && lcjson.resume == "1") {
							lcstate = "5"
						} else if (lcjson.deal == "1" && lcjson.resume == "0") {
							lcstate = "4"
						} else if (lcjson.examination == "2" && lcjson.deal == "0" && lcjson.draft == "2") {
							lcstate = "3"
						} else if (lcjson.iscs == "1" && lcjson.draft == "2") {
							lcstate = "2"
						}
						////console.log(lcstate);
						if (lcstate == "6") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>乡镇政府办审查人：' + lcjson.xzname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
									1000).toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else if (lcstate == "7") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.zhTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>置回</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.zhTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>置回人：' + lcjson.zhName +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else {
							for (var i = 1; i <= lcstate; i++) {
								switch (i) {
									case 1:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.shijian) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 2:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
												1000).toString("yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
										//                                    case 3:
										//                                        $("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("yyyy-MM-dd") + '</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>审查</b><img src="img/limg/sz.png"/><a class="time">' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") + '</a></div><img src="img/limg/name.png" /><a>审查人：' + lcjson.xzname + '</a></li><li class="processFoter"></li></ul>')
										//                                        break;
									case 3:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ReviewTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>复审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办审查人：' + lcjson.fsrname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 4:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.AssignedByTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>政府办</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.AssignedByTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办交办人：' + lcjson.zfbname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 5:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ResponseTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ResponseTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>答复单位：' + lcjson.realcompanyname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 6:
										break;
									case 7:
										break;
								}
							}
						}
					})
				});

				//评论条数
				RssApi.Table.List("suggest_praise").condition(new RssDict().keyvalue({
					"relationid": json[0].id,
					"myid": RssUser.Data.myid
				}).getDict()).getJson(function(date) {
					if (date.length > 0) {
						$("#tbdz").addClass('dj');
					} else {
						$("#tbdz").removeClass('dj')
					}

					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": json[0].id,
						"type": "2"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num) {
							znum = num.relnum
						}
						$("#handlesuggestinfo .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": json[0].id
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum) {
								snum = sunum.sugnum
							}
							$("#handlesuggestinfo .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": json[0].id
							}).getDict()).getJson(function(comment) {
								$("#handlesuggestinfo article>ul").empty();
								if (comment.length == "0") {
									$("#handlesuggestinfo article>ul").before('<div id="wpj">无评价</div>')
								}
								$.each(comment, function(k, v) {
									if (v.myid == RssUser.Data.myid) {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '<img src="img/limg/exit.png" /></li>')
									} else {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								sc();

							})
						})
					})
				})

				//点赞
				$("#tbdz").off("click").click(function() {
					var t = $(this);
					var zn = $("#handlesuggestinfo .ckfont").eq(0);
					var text_box = $("#add-num");
					if (t.hasClass('dj')) {
						RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({
							'id': t.attr("dzid")
						}).keymyid().getDict()).getJson(function(json) {
							t.removeClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
						});
						text_box.show().html("<em class='add-animation'>-1</em>");
						$(".add-animation").removeClass("hover");
					} else {
						RssApi.Edit("suggest_praise").keymyid().keyvalue('relationid', t.attr("rssid")).getJson(function(json) {
							t.addClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl + 1);
						});
						text_box.show().html("<em class='add-animation'>+1</em>");
						$(".add-animation").addClass("hover");
					}
				})

				//发送评论
				$("#evaluate").off("click").click(function() {
					var tid = $("#tbdz").attr("rssid")
					var pjtext = "<p>" + $("#pjtext").text() + "</p>"
					//                  var text_box = $("#add-num");
					if ($("#pjtext").text() != "") {
						RssApi.Edit("suggest_comment").keymyid().keyvalue({
							'suggestid': tid,
							'matter': pjtext
						}).getJson(function(json) {
							if (json.id > 0) {
								$("#handlesuggestinfo article>ul").append('<li PJid="' + json.id + '"><span>' + RssUser.Data.realname +
									'：</span>' + pjtext + '<img src="img/limg/exit.png" /></li>')
								$("#pjtext").text("")
								$("#handlesuggestinfo article").scrollTop($("#handlesuggestinfo article").height());
								var zn = $("#handlesuggestinfo .ckfont").eq(1);
								var sl = parseInt(zn.text())
								zn.text(sl + 1);
								$("#wpj").remove();
								sc();
								//                          text_box.show().html("<em class='add-animationa'>+1</em>");
								//                      	$(".add-animationa").addClass("hover");
							}
						});
					} else {
						alert("评论不能为空！");
					}
				})
				$("#handlesuggestinfo .divp").html(json[0].matter)
				location.href = "#handlesuggestinfo";
			})
		});

		//删除
		function sc() {

			$("#handlesuggestinfo ul>li>img").off("click").click(function() {
				var PJid = $(this).parent().attr("PJid");
				//              	alert(PJid);
				if (confirm("确认删除?")) {
					//              			RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({'id': t.attr("dzid")}).keymyid().getDict()).getJson(function (json) {
					RssApi.Delete("suggest_comment").condition(new RssDict().keyvalue({
						"id": PJid
					}).getDict()).getJson(function(json) {
						//              				alert("删除成功！");
						$("#handlesuggestinfo ul>li[PJid='" + PJid + "']").remove();
						var zn = $("#handlesuggestinfo .ckfont").eq(1);
						var sl = parseInt(zn.text())
						zn.text(sl - 1);
						$("#wpj").remove();
					});

				}
				//alert("删除");
			});
		}

		//查看
		$("#suggesthandleYA .ans").off("click").click(function() {
			var key = $(this).parent().attr("sortid");
			RssApi.Details("suggest_opinion").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				var star = ["business", "initiative", "communication", "counter", "consensus"]
				var checkbox = ["reply", "handle", "issue", "deal"]
				$("#handleevaluate article").mapview(json, {
					"seconded": function(val) {
						var seconded = dictdata.seconded[val]
						return seconded;
					},
					"permission": function(val) {
						var permission = dictdata.permission[val]
						return permission;
					},
					"suhandle": function(val) {
						var handle = dictdata.handle[val]
						return handle;
					}
				})
				$("[effect]").attr("relationid", json.effect);
				$("[effect]").text(dictdata.effect[json.effect])
				$.each(star, function(k, v) {
					var t = json[v];
					if (json[v]) {
						pingji(json[v], v)
					} else {
						$("[name ='" + v + "']").find("a").removeClass("sel");
					}
				})
				$("input[type='checkbox']").prop("checked", false);
				$.each(checkbox, function(k, v) {
					if (json[v] == "1") {
						$("input[name ='" + v + "']").prop("checked", true);
					}
				})
				$("[effect]").off("click").click(function() {
					zzc($(this), dictdata["effect"]);
				})
				$("#handleevaluate .normalbutton").off("click").click(function() {
					var k1 = {},
						k2 = {},
						k3 = "";
					$.each(star, function(k, v) {
						k1[v] = $("em[name='" + v + "']").find(".sel").length;
					})
					$.each(checkbox, function(k, v) {
						if ($("input[name='" + v + "']").is(":checked")) {
							k2[v] = "1";
						} else {
							k2[v] = "2";
						}
					})
					k3 = $("[effect]").attr("relationid");
					RssApi.Delete("opinion").condition(new RssDict().keyvalue({
						"proposal": key
					}).keyvalue().getDict()).getJson(function(json) {
						RssApi.Edit("opinion").setLoading(true).keyvalue(k1).keyvalue(k2).keyvalue({
							"myid": RssUser.Data.myid,
							"proposal": key,
							"effect": k3
						}).getJson(function(json) {
							alert("评价提交成功");
						})
					})
				})
			})
		})
	}).getJson();
})

//联名办理评价议案
$("#lmsuggesthandleYA").load(function() {
	if (arry.indexOf("lmsuggesthandleYA") == "-1") {
		$("#lmsuggesthandleYA ul li").eq(0).siblings().remove();
		arry.push("lmsuggesthandleYA")
	} else {
		$("#lmsuggesthandleYA ul li").remove();
	}
	faqsajax = RssApi.View.List("sortuser").setLoading(true).condition(new RssDict().keyvalue({
		"lwstate": "2",
		"draft": "2",
		"userid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		var draft, examination, deal, resume
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#lmsuggesthandleYA ul").mapview(json, {
			"registertype": function(val) {
				var registertype = dictdata.registertype[val]
				return registertype;
			},
			"handle": function(val) {
				var handle = dictdata.handle[val]
				return handle;
			},
			"draft": function(val) {
				draft = val;
			},
			"examination": function(val) {
				examination = val;
			},
			"deal": function(val) {
				deal = val;
			},
			"iscs": function(val) {
				iscs = val;
			},
			"isxzsc": function(val) {
				isxzsc = val;
			},
			"resume": function(val) {
				resume = val;
				if (draft == "1") {
					return "草稿"
				} else if (deal == "1" && resume == "1") {
					return "已答复";
				} else if (deal == "1" && resume == "0") {
					return "已交办";
				} else if (examination == "2" && deal == "0" && draft == "2") {
					return "已审查";
				} else if (isxzsc == "1" && draft == "2") {
					return "已答复";
				} else if (iscs == "1" && draft == "2") {
					return "初审查";
				} else if (examination == "1" && draft == "2") {
					return "已提交";
				} else if (examination == "3") {
					return "已置回";
				}
			}
		}, append)
		//查看
		$("#lmsuggesthandleYA ul>li").off("click").click(function() {
			var key = $(this).find("h1").attr("sortid");
			RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"sortid": key
			}).getDict()).getJson(function(json) {
				var draft, examination, deal, resume
				$("#handlesuggestinfo article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
					},
					"draft": function(val) {
						draft = val;
					},
					"examination": function(val) {
						examination = val;
					},
					"deal": function(val) {
						deal = val;
					},
					"iscs": function(val) {
						iscs = val;
					},
					"isxzsc": function(val) {
						isxzsc = val;
					},
					"resume": function(val) {
						resume = val;
						if (draft == "1") {
							return "草稿"
						} else if (deal == "1" && resume == "1") {
							return "已答复";
						} else if (deal == "1" && resume == "0") {
							return "已交办";
						} else if (examination == "2" && deal == "0" && draft == "2") {
							return "已审查";
						} else if (isxzsc == "1" && draft == "2") {
							return "已答复";
						} else if (iscs == "1" && draft == "2") {
							return "初审查";
						} else if (examination == "1" && draft == "2") {
							return "已提交";
						} else if (examination == "3") {
							return "已置回";
						}
					},

				})
				$("#wuliuck").off("click").click(function() {
					location.href = "#processState";
					var sid = $(this).attr("rssid")
					RssApi.Details("suggest").condition(new RssDict().keyvalue({
						"id": sid
					}).getDict()).getJson(function(lcjson) {
						$("#processState article>ul").remove();
						var lcstate = "1";
						num[0] = lcstate;
						if (lcjson.examination == "5" && lcjson.isxzsc == "1" && lcjson.draft == "2") {
							lcstate = "6"
							////console.log(lcjson.examination)
						} else if (lcjson.examination == "3") {
							lcstate = "7"
						} else if (lcjson.deal == "1" && lcjson.resume == "1") {
							lcstate = "5"
						} else if (lcjson.deal == "1" && lcjson.resume == "0") {
							lcstate = "4"
						} else if (lcjson.examination == "2" && lcjson.deal == "0" && lcjson.draft == "2") {
							lcstate = "3"
						} else if (lcjson.iscs == "1" && lcjson.draft == "2") {
							lcstate = "2"
						}
						////console.log(lcstate);
						if (lcstate == "6") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>乡镇政府办审查人：' + lcjson.xzname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
									1000).toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else if (lcstate == "7") {
							$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.zhTime) * 1000).toString(
									"yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>置回</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.zhTime) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>置回人：' + lcjson.zhName +
								'</a></li><li class="processFoter"></li></ul><ul><li>' + new Date(parseInt(lcjson.shijian) * 1000)
								.toString("yyyy-MM-dd") +
								'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
								new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
								'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
								'</a></li><li class="processFoter"></li></ul>')
						} else {
							for (var i = 1; i <= lcstate; i++) {
								switch (i) {
									case 1:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.shijian) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>提交</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.shijian) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>提交人：' + lcjson.realname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 2:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.InitialReviewTime) *
												1000).toString("yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>初审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.InitialReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>代表团审查人：' + lcjson.scname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
										//                                    case 3:
										//                                        $("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("yyyy-MM-dd") + '</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>审查</b><img src="img/limg/sz.png"/><a class="time">' + new Date(parseInt(lcjson.xzReviewTime) * 1000).toString("hh:mm") + '</a></div><img src="img/limg/name.png" /><a>审查人：' + lcjson.xzname + '</a></li><li class="processFoter"></li></ul>')
										//                                        break;
									case 3:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ReviewTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>复审</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ReviewTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办审查人：' + lcjson.fsrname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 4:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.AssignedByTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>政府办</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.AssignedByTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>县政府办交办人：' + lcjson.zfbname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 5:
										$("#processState article").prepend('<ul><li>' + new Date(parseInt(lcjson.ResponseTime) * 1000).toString(
												"yyyy-MM-dd") +
											'</li><li class="processHeader"></li><li class="processTP"><img src="img/limg/tp.png"/></li><li class="processFont"><div class="jb"><b>答复</b><img src="img/limg/sz.png"/><a class="time">' +
											new Date(parseInt(lcjson.ResponseTime) * 1000).toString("hh:mm") +
											'</a></div><img src="img/limg/name.png" /><a>答复单位：' + lcjson.realcompanyname +
											'</a></li><li class="processFoter"></li></ul>')
										break;
									case 6:
										break;
									case 7:
										break;
								}
							}
						}
					})
				});

				//评论条数
				RssApi.Table.List("suggest_praise").condition(new RssDict().keyvalue({
					"relationid": json[0].id,
					"myid": RssUser.Data.myid
				}).getDict()).getJson(function(date) {
					if (date.length > 0) {
						$("#tbdz").addClass('dj');
					} else {
						$("#tbdz").removeClass('dj')
					}

					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": json[0].id,
						"type": "2"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num) {
							znum = num.relnum
						}
						$("#handlesuggestinfo .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": json[0].id
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum) {
								snum = sunum.sugnum
							}
							$("#handlesuggestinfo .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": json[0].id
							}).getDict()).getJson(function(comment) {
								$("#handlesuggestinfo article>ul").empty();
								if (comment.length == "0") {
									$("#handlesuggestinfo article>ul").before('<div id="wpj">无评价</div>')
								}
								$.each(comment, function(k, v) {
									if (v.myid == RssUser.Data.myid) {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '<img src="img/limg/exit.png" /></li>')
									} else {
										$("#handlesuggestinfo article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								sc();

							})
						})
					})
				})

				//点赞
				$("#tbdz").off("click").click(function() {
					var t = $(this);
					var zn = $("#handlesuggestinfo .ckfont").eq(0);
					var text_box = $("#add-num");
					if (t.hasClass('dj')) {
						RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({
							'id': t.attr("dzid")
						}).keymyid().getDict()).getJson(function(json) {
							t.removeClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
						});
						text_box.show().html("<em class='add-animation'>-1</em>");
						$(".add-animation").removeClass("hover");
					} else {
						RssApi.Edit("suggest_praise").keymyid().keyvalue('relationid', t.attr("rssid")).getJson(function(json) {
							t.addClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl + 1);
						});
						text_box.show().html("<em class='add-animation'>+1</em>");
						$(".add-animation").addClass("hover");
					}
				})

				//发送评论
				$("#evaluate").off("click").click(function() {
					var tid = $("#tbdz").attr("rssid")
					var pjtext = "<p>" + $("#pjtext").text() + "</p>"
					//                  var text_box = $("#add-num");
					if ($("#pjtext").text() != "") {
						RssApi.Edit("suggest_comment").keymyid().keyvalue({
							'suggestid': tid,
							'matter': pjtext
						}).getJson(function(json) {
							if (json.id > 0) {
								$("#handlesuggestinfo article>ul").append('<li PJid="' + json.id + '"><span>' + RssUser.Data.realname +
									'：</span>' + pjtext + '<img src="img/limg/exit.png" /></li>')
								$("#pjtext").text("")
								$("#handlesuggestinfo article").scrollTop($("#handlesuggestinfo article").height());
								var zn = $("#handlesuggestinfo .ckfont").eq(1);
								var sl = parseInt(zn.text())
								zn.text(sl + 1);
								$("#wpj").remove();
								sc();
								//                          text_box.show().html("<em class='add-animationa'>+1</em>");
								//                      	$(".add-animationa").addClass("hover");
							}
						});
					} else {
						alert("评论不能为空！");
					}
				})
				$("#handlesuggestinfo .divp").html(json[0].matter)
				location.href = "#handlesuggestinfo";
			})
		});

		//删除
		function sc() {

			$("#handlesuggestinfo ul>li>img").off("click").click(function() {
				var PJid = $(this).parent().attr("PJid");
				//              	alert(PJid);
				if (confirm("确认删除?")) {
					//              			RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({'id': t.attr("dzid")}).keymyid().getDict()).getJson(function (json) {
					RssApi.Delete("suggest_comment").condition(new RssDict().keyvalue({
						"id": PJid
					}).getDict()).getJson(function(json) {
						//              				alert("删除成功！");
						$("#handlesuggestinfo ul>li[PJid='" + PJid + "']").remove();
						var zn = $("#handlesuggestinfo .ckfont").eq(1);
						var sl = parseInt(zn.text())
						zn.text(sl - 1);
						$("#wpj").remove();
					});

				}
				//alert("删除");
			});
		}

		//查看
		$("#lmsuggesthandleYA .ans").off("click").click(function() {
			var key = $(this).parent().attr("sortid");
			RssApi.Details("suggest_opinion").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				var star = ["business", "initiative", "communication", "counter", "consensus"]
				var checkbox = ["reply", "handle", "issue", "deal"]
				$("#handleevaluate article").mapview(json, {
					"seconded": function(val) {
						var seconded = dictdata.seconded[val]
						return seconded;
					},
					"permission": function(val) {
						var permission = dictdata.permission[val]
						return permission;
					},
					"suhandle": function(val) {
						var handle = dictdata.handle[val]
						return handle;
					}
				})
				$("[effect]").attr("relationid", json.effect);
				$("[effect]").text(dictdata.effect[json.effect])
				$.each(star, function(k, v) {
					var t = json[v];
					if (json[v]) {
						pingji(json[v], v)
					} else {
						$("[name ='" + v + "']").find("a").removeClass("sel");
					}
				})
				$("input[type='checkbox']").prop("checked", false);
				$.each(checkbox, function(k, v) {
					if (json[v] == "1") {
						$("input[name ='" + v + "']").prop("checked", true);
					}
				})
				$("[effect]").off("click").click(function() {
					zzc($(this), dictdata["effect"]);
				})
				$("#handleevaluate .normalbutton").off("click").click(function() {
					var k1 = {},
						k2 = {},
						k3 = "";
					$.each(star, function(k, v) {
						k1[v] = $("em[name='" + v + "']").find(".sel").length;
					})
					$.each(checkbox, function(k, v) {
						if ($("input[name='" + v + "']").is(":checked")) {
							k2[v] = "1";
						} else {
							k2[v] = "2";
						}
					})
					k3 = $("[effect]").attr("relationid");
					RssApi.Delete("opinion").condition(new RssDict().keyvalue({
						"proposal": key
					}).keyvalue().getDict()).getJson(function(json) {
						RssApi.Edit("opinion").setLoading(true).keyvalue(k1).keyvalue(k2).keyvalue({
							"myid": RssUser.Data.myid,
							"proposal": key,
							"effect": k3
						}).getJson(function(json) {
							alert("评价提交成功");
						})
					})
				})
			})
		})
	}).getJson();
})
//“一府一委两院”专项工作满意度测评
$("#yyl_evaluation").load(function() {
	if (arry.indexOf("yyl_evaluation") == "-1") {
		$("#yyl_evaluation ul li").eq(0).siblings().remove();
		arry.push("yyl_evaluation")
	} else {
		$("#yyl_evaluation ul li").remove();
	}
	faqsajax = RssApi.Table.List("yyl_evaluation").setLoading(true).setFlushUI(function(json, append) {

		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#yyl_evaluation ul").mapview(json, {
			"result": function(val) {
				if (val == "1") {
					return "满意";
				}
				if (val == "2") {
					return "基本满意";
				}
				if (val == "3") {
					return "不满意";
				}
			}
		}, append)
		$("#yyl_evaluation ul li").click(function() {
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#yyl_evaluationck"
			$("#yyl_evaluationck").find("header>h1").text();
			RssApi.Table.Details("yyl_evaluation").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#yyl_evaluationck article").mapview(json, {
					"result": function(val) {
						if (val == "1") {
							return "满意";
						}
						if (val == "2") {
							return "基本满意";
						}
						if (val == "3") {
							return "不满意";
						}
					}
				})
				if (json.note == "" || json.note == undefined) {
					$(".bz").hide()
				} else {
					$(".bz").show()
				}
			})
		})
	}).getJson();
})

//代表建议办理情况满意度测评
$("#user_cbdweval").load(function() {
	if (arry.indexOf("yyl_evaluation") == "-1") {
		$("#user_cbdweval ul li").eq(0).siblings().remove();
		arry.push("user_cbdweval")
	} else {
		$("#user_cbdweval ul li").remove();
	}
	faqsajax = RssApi.View.List("user_cbdweval").setLoading(true).condition(new RssDict().keyvalue({
		//        "classify": "1",
		"state": 3,
		//        "result":"(likeall~"+res+")"
	}).getDict()).setFlushUI(function(json, append) {

		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		var listBox = $('#user_cbdweval .fenye'),
			html = '',
			result = '',
			year = '',
			my = "",
			cbdwnote = "";
		$.each(json, function(k, v) {
			result = v.result ? v.result : '暂无评分';
			year = v.year ? v.year : '暂无年份';
			cbdwnote = v.cbdwnote ? v.cbdwnote : '暂无备注';
			if (result == '暂无评分') {
				my = "";
			}
			if (result >= 80) {
				my = "满意";
			}
			if (80 > result && result >= 60) {
				my = "基本满意";
			}
			if (result < 60) {
				my = "不满意";
			}
			////console.log(my);
			html += '<li><h1>' + v.allname + '</h1><div><p class="bb">[结果评定]：' + result + '&nbsp;&nbsp;' + my +
				'</p></div><p class="nf">年份：' + year + '</p><div><em>备注：</em>' + cbdwnote + '</div></li>';
		})
		listBox.append(html);
	}).getJson();
})
//代表履职满意度测评
$("#delegation_score").load(function() {
	if (arry.indexOf("delegation_score") == "-1") {
		$("#delegation_score ul li").eq(0).siblings().remove();
		arry.push("delegation_score")
	} else {
		$("#delegation_score ul li").remove();
	}

	RssApi.View.List("dbtuser").setLoading(true).condition(new RssDict().keyvalue({
		"state": 4,
		"level": 1
	}).getDict()).setFlushUI(function(json) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}

		function sortId(a, b) {
			return a.daibiaotuanCode - b.daibiaotuanCode
		}
		json.sort(sortId);
		$("#delegation_score ul").mapview(json, {

		})


		$("#delegation_score ul li").click(function() {
			$('#delegation_scoreck .fenye').empty();
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#delegation_scoreck"
			$("#seenotice").find("header>h1").text();
			var mission = $(this).find(".myid").text();
			////console.log(mission);
			faqsajax = RssApi.View.List("delegation_score").setLoading(true).condition(new RssDict().keyvalue({
				"mission": mission
			}).getDict()).setFlushUI(function(json, append) {
				////console.log(json);
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				var listBox = $('#delegation_scoreck .fenye'),
					html = '',
					delegate_score = '',
					year = '',
					my = '',
					note = '';
				$.each(json, function(k, v) {
					delegate_score = v.delegate_score ? v.delegate_score : '暂无评分';
					year = v.year ? v.year : '暂无年份';
					note = v.note ? v.note : '暂无备注';
					if (delegate_score == '暂无评分') {
						my = "";
					}
					if (delegate_score >= 80) {
						my = "满意";
					}
					if (80 > delegate_score && delegate_score >= 60) {
						my = "基本满意";
					}
					if (delegate_score < 60) {
						my = "不满意";
					}
					html += '<li><h1>' + v.realname + '</h1><p>[结果评定]：' + delegate_score + '&nbsp;' + my + '<span>年份：' +
						year + '</span></p><div><em>备注：</em>' + note + '</div></li>';
				})
				listBox.append(html);
			}).getJson();
		})
	}).getJson();
})

//课件
$("#courseware").load(function() {
	if (arry.indexOf("courseware") == "-1") {
		$("#courseware ul li").eq(0).siblings().remove();
		arry.push("courseware")
	} else {
		$("#courseware ul li").remove();
	}
	faqsajax = RssApi.View.List("courseware").setLoading(true).condition(new RssDict().keyvalue({
		//        "classify": "1",
		"objid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {

		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#courseware ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#courseware ul li").off().click(function() {
			$("#fz2").hide();
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#coursewareck"
			//            $("#coursewareck article")
			$("#coursewareck").find("header>h1").text();
			RssApi.Details("courseware").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#coursewareck article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					}
				})
				//                if(json.ico=="" || json.ico==undefined){$(".slt").hide()}else{$(".slt").show()}
				if (json.links == "" || json.links == undefined) {
					$(".wblj").hide()
				} else {
					$(".wblj").show()
				}
				if (json.enclosure == "" || json.enclosure == undefined) {
					$(".fj").hide()
				} else {
					$(".fj").show()
				}
				if (json.videosrc == "" || json.videosrc == undefined) {
					$(".sp").hide()
				} else {
					$(".sp").show()
				}
				var spa = $("#coursewareck .sp p").text();
				////console.log(spa);
				var bfa = "/upfile/" + spa;
				////console.log(bfa);
				var bf = document.getElementById('spbf1');
				bf.setAttribute("src", bfa);

				$(".fj p").off().click(function() {
					//                    alert("文件路径：com.rsseasy.lvzhi.file");
					var path = $(this).text();
					var dz = "/upfile/" + path;
					var pdfh5 = new Pdfh5('.pdfjs1', {
						pdfurl: dz
					});
				})
				//                $("#browser").click(function (ev) {
				//                    ev.preventDefault();
				//                    ev.stopPropagation();
				//                    JsAdapter.Browser("http://www.rsseasy.com").Submit();
				//                });
				var url = $("#coursewareck .wblj p").text();
				$("#coursewareck .wblj p").hide();
				$("#coursewareck .wblj a").text(url);
				$("#coursewareck .wblj a").attr("js-browser", url);

				//                $("#coursewareck .wblj p").click(function (ev) {
				//                    $(this).text();

				//                    ev.preventDefault();
				//                    ev.stopPropagation();
				//                    JsAdapter.Browser("http://tool.oschina.net/jscompress").Submit();
				//                    var res = $(this).text();
				//                    var btn = document.getElementById('btn');
				//                    btn.setAttribute("data-clipboard-text", res);
				//                    var clipboard = new ClipboardJS(btn);
				//                    clipboard.on('success', function (e) {
				////                        //////console.log(e);
				//                        $("#fz2").show();
				//                        setTimeout(function () {
				//                            $("#fz2").hide();
				//                        }, 1000);
				//                    });
				//
				//                    clipboard.on('error', function (e) {
				////                        ////console.log(e);
				//                    });
				//                })
			})
		})
	}).getJson();
})

//专题讲座
$("#lecture").load(function() {
	if (arry.indexOf("lecture") == "-1") {
		$("#lecture ul li").eq(0).siblings().remove();
		arry.push("lecture")
	} else {
		$("#lecture ul li").remove();
	}

	faqsajax = RssApi.View.List("lecture").setLoading(true).condition(new RssDict().keyvalue({
		//        "classify": "1",
		"objid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#lecture ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#lecture ul li").off().click(function() {
			$("#fz3").hide();
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#lectureck"
			$("#lectureck").find("header>h1").text();
			RssApi.Details("lecture").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#lectureck article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"joinshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"classify": function(val) {
						return dictdata.lectureclassify[val];
					}
				})
				//                if(json.ico=="" || json.ico==undefined){$(".slt").hide()}else{$(".slt").show()}
				if (json.links == "" || json.links == undefined) {
					$(".wblj").hide()
				} else {
					$(".wblj").show()
				}
				if (json.links == "" || json.links == undefined) {
					$(".zj").hide()
				} else {
					$(".zj").show()
				}
				if (json.links == "" || json.links == undefined) {
					$(".ks").hide()
				} else {
					$(".ks").show()
				}
				if (json.links == "" || json.links == undefined) {
					$(".xs").hide()
				} else {
					$(".xs").show()
				}
				if (json.enclosure == "" || json.enclosure == undefined) {
					$(".fj").hide()
				} else {
					$(".fj").show()
				}
				if (json.videosrc == "" || json.videosrc == undefined) {
					$(".sp").hide()
				} else {
					$(".sp").show()
				}
				var spa = $("#lectureck .sp p").text();
				//                ////console.log(spa);
				var bfa = "/upfile/" + spa;
				//                ////console.log(bfa);
				var bf = document.getElementById('spbf2');
				bf.setAttribute("src", bfa);

				$(".fj p").off().click(function() {
					//                    alert("文件路径：com.rsseasy.lvzhi.file");
					var path = $(this).text();
					var dz = "/upfile/" + path;
					var pdfh5 = new Pdfh5('.pdfjs2', {
						pdfurl: dz
					});
				})

				var url = $("#lectureck .wblj p").text();
				$("#lectureck .wblj p").hide();
				$("#lectureck .wblj a").text(url);
				$("#lectureck .wblj a").attr("js-browser", url);
				//                $(".wblj p").click(function () {
				//                    var res = $(this).text();
				//                    var btn = document.getElementById('btn3');
				//                    btn.setAttribute("data-clipboard-text", res);
				//                    var clipboard = new ClipboardJS(btn);
				//                    clipboard.on('success', function (e) {
				////                        ////console.log(e);
				//                        $("#fz3").show();
				//                        setTimeout(function () {
				//                            $("#fz3").hide();
				//                        }, 1000);
				//                    });
				//
				//                    clipboard.on('error', function (e) {
				////                        ////console.log(e);
				//                    });
				//                })
			})
		})
	}).getJson();
})

//履职参考
$("#reference").load(function() {
	if (arry.indexOf("reference") == "-1") {
		$("#reference ul li").eq(0).siblings().remove();
		arry.push("reference")
	} else {
		$("#reference ul li").remove();
	}

	faqsajax = RssApi.View.List("reference").setLoading(true).condition(new RssDict().keyvalue({
		//        "classify": "1",
		"objid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#reference ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#reference ul li").click(function() {
			$("#fz4").hide();
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#referenceck"
			$("#referenceck").find("header>h1").text();
			RssApi.Details("reference").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#referenceck article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					}
				})
				//                if(json.ico=="" || json.ico==undefined){$(".slt").hide()}else{$(".slt").show()}
				if (json.links == "" || json.links == undefined) {
					$(".wblj").hide()
				} else {
					$(".wblj").show()
				}
				if (json.enclosure == "" || json.enclosure == undefined) {
					$(".fj").hide()
				} else {
					$(".fj").show()
				}
				$(".fj p").off().click(function() {
					//                    alert("文件路径：com.rsseasy.lvzhi.file");
					var path = $(this).text();
					var dz = "/upfile/" + path;
					var pdfh5 = new Pdfh5('.pdfjs3', {
						pdfurl: dz
					});
				})

				var url = $("#referenceck .wblj p").text();
				$("#referenceck .wblj p").hide();
				$("#referenceck .wblj a").text(url);
				$("#referenceck .wblj a").attr("js-browser", url);
				//                $(".wblj p").click(function () {
				//                    var res = $(this).text();
				//                    var btn = document.getElementById('btn4');
				//                    btn.setAttribute("data-clipboard-text", res);
				//                    var clipboard = new ClipboardJS(btn);
				//                    clipboard.on('success', function (e) {
				////                        ////console.log(e);
				//                        $("#fz4").show();
				//                        setTimeout(function () {
				//                            $("#fz4").hide();
				//                        }, 1000);
				//                    });
				//
				//                    clipboard.on('error', function (e) {
				////                        ////console.log(e);
				//                    });
				//                })
			})
		})
	}).getJson();
})

//法律法规
//$("#statute").load(function () {
//    if (arry.indexOf("statute") == "-1") {
//        $("#statute ul li").eq(0).siblings().remove();
//        arry.push("statute")
//    } else {
//        $("#statute ul li").remove();
//    }
//
//    faqsajax = RssApi.Table.List("statute").setLoading(true).setFlushUI(function (json, append) {
//        if (json.length != "10") {
//            $('.nodata').hide();
//        } else {
//            $('.nodata').show();
//        }
//        $("#statute ul").mapview(json, {
//            "shijian": function (val) {
//                return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
//            }
//        }, append)
//        $("#statute ul li").click(function () {
//            //            location.href = "/app/infopage/notice.html";
//            var key = $(this).find("[rssid]").attr("rssid");
//            location.href = "#statuteck"
//            $("#statuteck").find("header>h1").text();
//            RssApi.Details("statute").setLoading(true).condition(new RssDict().keyvalue({
//                "id": key
//            }).getDict()).getJson(function (json) {
//                $("#statuteck article").mapview(json, {
//                    "shijian": function (val) {
//                        return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
//                    }
//                })
////                if(json.ico=="" || json.ico==undefined){$(".slt").hide()}else{$(".slt").show()}
//                if(json.links=="" || json.links==undefined){$(".wblj").hide()}else{$(".wblj").show()}
//                if(json.enclosure=="" || json.enclosure==undefined){$(".fj").hide()}else{$(".fj").show()}
//                $(".fj p").click(function () {
//                    var path=$(this).text();
//                 RssDownFile.Start("/upfile/"+path);
//             })
//            })
//        })
//    }).getJson();
//})
$("#statute nav>a").off("click").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel");
	var ind = $(this).index() + 1;
	if (arry.indexOf("statute") == "-1") {
		$("#statute ul li").eq(0).siblings().remove();
		arry.push("statute")
	} else {
		$("#statute ul li").remove();
	}

	faqsajax = RssApi.Table.List("statute").setLoading(true).condition(new RssDict().keyvalue({
		//        "classify": "1",
		"classify": ind
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#statute ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			},
			"classify": function(val) {
				if (val == "1") {
					return "宪法";
				}
				if (val == "2") {
					return "国家法律";
				}
				if (val == "3") {
					return "相关法规";
				}
			}
		}, append)
		$("#statute ul li").click(function() {
			$("#fz5").hide();
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("a").attr("rssid");
			//            ////console.log(key);
			location.href = "#statuteck"
			$("#statuteck").find("header>h1").text($("#statute").find(".sel").text() + "详情");
			RssApi.Table.Details("statute").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#statuteck article").mapview(json, {
					"shijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					}
				})
				//                if(json.ico=="" || json.ico==undefined){$(".slt").hide()}else{$(".slt").show()}
				if (json.links == "" || json.links == undefined) {
					$(".wblj").hide()
				} else {
					$(".wblj").show()
				}
				if (json.enclosure == "" || json.enclosure == undefined) {
					$(".fj").hide()
				} else {
					$(".fj").show()
				}

				$(".fj p").off().click(function() {
					//                    alert("文件路径：com.rsseasy.lvzhi.file");
					var path = $(this).text();
					var dz = "/upfile/" + path;
					var pdfh5 = new Pdfh5('.pdfjs4', {
						pdfurl: dz
					});
				})
				var url = $("#statuteck .wblj p").text();
				$("#statuteck .wblj p").hide();
				$("#statuteck .wblj a").text(url);
				$("#statuteck .wblj a").attr("js-browser", url);
				//                $(".wblj p").click(function () {
				//                    var res = $(this).text();
				//                    var btn = document.getElementById('btn5');
				//                    btn.setAttribute("data-clipboard-text", res);
				//                    var clipboard = new ClipboardJS(btn);
				//                    clipboard.on('success', function (e) {
				////                        ////console.log(e);
				//                        $("#fz5").show();
				//                        setTimeout(function () {
				//                            $("#fz5").hide();
				//                        }, 1000);
				//                    });
				//
				//                    clipboard.on('error', function (e) {
				////                        ////console.log(e);
				//                    });
				//                })
			})
		})
	}).getJson();
})
$('a[href="#statute"]').unbind().click(function() {
	$("#statute nav>a:first").click();
})

//交流社区、交流情况
$("#Communication").load(function() {
	if (arry.indexOf("Communication") == "-1") {
		$("#Communication ul li").eq(0).siblings().remove();
		arry.push("Communication")
	} else {
		$("#Communication ul li").remove();
	}

	faqsajax = RssApi.View.List("poll").setLoading(true).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#Communication ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#Communication ul li").click(function() {
			var key = $(this).find("[rssid]").attr("rssid");
			//            location.href = "#Communicationck"
			$("#Communicationck").find("header>h1").text();
			RssApi.View.List("poll").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				var shijian = "",
					type = ""
				$("#Communicationck article").mapview(json, {
					"shijian": function(val) {
						return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					},
					"type": function(val) {
						return type = dictdata.gztype[val];
					}
				})
				console.log(json[0].matter)
				$('#Communicationck article').html('<div class="divtop"><h1>' + json[0].title + '</h1><h4>发布者：' + json[0].realname +
					'</h4><h5>发布时间：' + shijian + '</h5><h5>工作分类：' + type +
					'</h5></div><div id="ckjy"><span class="dz">点赞：<b class="ckfont">0</b></span><span><u class="pl">评论：<b class="ckfont">0</b></u></span></div><div class="divp">' +
					json[0].matter +
					'</div><ul></ul><footer><div id="tbdz" bindattr="rssid"><img id="tbdzimg" src="img/limg/wdz.png"><span id="add-num"><em>+1</em></span></div><div id="pjevaluate"><p id="pjtext" contenteditable="true" placeholder="输入评价内容"></p></div><div><p id="evaluate">提交</p></div></footer>'
				);

				//评论条数
				RssApi.Table.List("suggest_praise").condition(new RssDict().keyvalue({
					"relationid": key,
					"myid": RssUser.Data.myid
				}).getDict()).getJson(function(date) {
					if (date.length > 0) {
						$("#tbdz").addClass('dj');
					} else {
						$("#tbdz").removeClass('dj')
					}

					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": key,
						//                        "type": "4"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num.relnum != undefined && num.relnum != "") {
							znum = num.relnum
						}
						//                        ////console.log(znum);
						//                        $('.ckfont').eq(0).empty()
						$("#Communicationck .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": key
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum.sugnum != undefined && sunum.sugnum != "") {
								snum = sunum.sugnum
							}
							$("#Communicationck .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": key
							}).getDict()).getJson(function(comment) {
								$("#Communicationck article>#wpj").empty();
								$("#Communicationck article>ul").empty();
								if (comment.length == "0") {
									$("#Communicationck article>ul").hide();
									$("#Communicationck article>ul").before('<div id="wpj">无评价</div>')
								}

								$.each(comment, function(k, v) {
									$("#Communicationck #wpj").remove();
									$("#Communicationck article>ul").show();
									if (v.myid == RssUser.Data.myid) {
										$("#Communicationck article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '<img src="img/limg/exit.png" /></li>')
									} else {
										$("#Communicationck article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								sc();

							})
						})
					})
				})

				//点赞
				$("#Communicationck #tbdz").off("click").click(function() {
					var t = $(this);
					var zn = $("#Communicationck .ckfont").eq(0);
					var text_box = $("#add-num");
					if (t.hasClass('dj')) {
						RssApi.Delete("suggest_praise").condition(new RssDict().keyvalue({
							'relationid': key,
							"myid": RssUser.Data.myid
						}).keymyid().getDict()).getJson(function(jsonn) {
							t.removeClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
						});
						text_box.show().html("<em class='add-animation'>-1</em>");
						$(".add-animation").removeClass("hover");
					} else {
						RssApi.Edit("suggest_praise").keymyid().keyvalue('relationid', key).getJson(function(json) {
							t.addClass('dj')
							var sl = parseInt(zn.text())
							zn.text(sl + 1);
						});
						text_box.show().html("<em class='add-animation'>+1</em>");
						$(".add-animation").addClass("hover");
					}
				})

				//发送评论
				$("#Communicationck #evaluate").off("click").click(function() {
					var pjtext = "<p>" + $("#pjtext").text() + "</p>"
					var pj = $("#pjtext").text();
					//                  var text_box = $("#add-num");
					if ($("#pjtext").text() != "") {
						RssApi.Table.List("mingancitype_classify").keyvalue("pagesize", "10000").condition(new RssDict().keyvalue({
							"state": 0
						}).getDict()).getJson(function(mgc) {
							var tf = true;
							$.each(mgc, function(k, v) {
								if (v.name != null) {
									if (pj.indexOf(v.name) >= 0) {
										alert("发表内容包含敏感词['" + v.name + "']!");
										return tf = false;
									}
								}
							})
							if (tf == true) {
								RssApi.Edit("suggest_comment").keymyid().keyvalue({
									'suggestid': key,
									'matter': pjtext
								}).getJson(function(json) {
									if (json.id > 0) {
										$("#Communicationck article>ul").show();
										$("#Communicationck article>ul").append('<li PJid="' + json.id + '"><span>' + RssUser.Data.realname +
											'：</span>' + pjtext + '<img src="img/limg/exit.png" /></li>')
										$("#pjtext").text("")
										$("#Communicationck article").scrollTop($("#Communicationck article").height());
										var zn = $("#Communicationck .ckfont").eq(1);
										var sl = parseInt(zn.text())
										zn.text(sl + 1);
										$("#Communicationck #wpj").remove();
										sc();
									}
								});
							}
						})
					} else {
						alert("评论不能为空！");
					}
				})
				$("#Communicationck .divp").html(json.matter)
				location.href = "#Communicationck"
			})
			//删除
			function sc() {

				$("#Communicationck ul>li>img").off("click").click(function() {
					var PJid = $(this).parent().attr("PJid");
					if (confirm("确认删除?")) {
						RssApi.Delete("suggest_comment").condition(new RssDict().keyvalue({
							"id": PJid
						}).getDict()).getJson(function(json) {
							$("#Communicationck ul>li[PJid='" + PJid + "']").remove();
							var zn = $("#Communicationck .ckfont").eq(1);
							var sl = parseInt(zn.text())
							zn.text(sl - 1);
							$("#Communicationck article>ul").hide();
							$("#Communicationck article>ul").before('<div id="wpj">无评价</div>')
							//                            $("#Communicationck #wpj").remove();
						});

					}
					//alert("删除");
				});
			}
		})
	}).getJson();
})

//意见征询
$("#opinion nav>a").off("click").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel");
	var ind = $(this).index() + 1;
	if (arry.indexOf("opinion") == "-1") {
		$("#opinion ul li").eq(0).siblings().remove();
		arry.push("opinion")
	} else {
		$("#opinion ul li").remove();
	}
	if (ind == "1") {
		faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "0",
			"consultation": "0",
			"myid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#opinion ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				}
			}, append)
			$("#opinion ul li").click(function() {
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("a").attr("rssid");
				//                ////console.log(key);
				location.href = "#opinionckW"
				$("#opinionckW").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
				RssApi.Details("sort").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#opinionckW article").mapview(json, {
						"shijian": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						}
					})
				})
			})
		}).getJson();
	}
	if (ind == "2") {
		faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "1",
			"myid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#opinion ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				}
			}, append)
			$("#opinion ul li").off().click(function() {
				var aa = $('#opinionckY article .fj p:first').text();
				if (!(aa == "" || aa == undefined)) {
					$('#opinionckY article .fj p:last').remove();
				}
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("[rssid]").attr("rssid");
				//                ////console.log(key);
				location.href = "#opinionckY"
				$("#opinionckY").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
				RssApi.Details("sort").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#opinionckY article").mapview(json, {
						"shijian": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"organize": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"degree": function(val) {
							if (val == "1") {
								return "已解决";
							}
							if (val == "2") {
								return "正在解决";
							}
							if (val == "3") {
								return "列入计划解决";
							}
							if (val == "4") {
								return "因条件限制无法解决";
							}
						},
						"way": function(val) {
							if (val == "1") {
								return "书面";
							}
							if (val == "2") {
								return "平台（上传附件）";
							}
							if (val == "3") {
								return "其他";
							}
						}
					})
					//                    $("#opinionckY article .fj")
					var dfenclosure = $("#opinionckY article .fj p").text();
					var str = dfenclosure.split(",");
					//                    ////console.log(str);
					var html = ""
					$.each(str, function(idx, value) {
						if (value != "") {
							html = "<p class='pdfjs5'>" + value + "</p>"
							$('#opinionckY article .fj').append(html);
						}
					})

					$('#opinionckY article .fj p:first').hide();
					$(".fj p").off().click(function() {
						//                        alert("文件路径：com.rsseasy.lvzhi.file");
						var path = $(this).text();
						var dz = "/upfile/" + path;
						var pdfh5 = new Pdfh5('.pdfjs5', {
							pdfurl: dz
						});
					})
				})
			})
		}).getJson();
	}
	if (ind == "3") {
		faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "1",
			"consultation": "0",
			"myid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#opinion ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				}
			}, append)
			$("#opinion ul li").click(function() {
				$("#opinionckDBYJ article .bh p").remove();
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("[rssid]").attr("rssid");
				//                ////console.log(key);
				location.href = "#opinionckDBYJ"
				$("#opinionckDBYJ").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
				RssApi.Details("sort").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#opinionckDBYJ article").mapview(json, {})
					var html = "<p>" + key + "</p>"
					$("#opinionckDBYJ article .bh").append(html);
					$("#opinionckDBYJ article .bh p").hide();
				})
			})
		}).getJson();
	}
	if (ind == "4") {
		faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "1",
			"consultation": "1",
			"myid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#opinion ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				}
			}, append)
			$("#opinion ul li").click(function() {
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("[rssid]").attr("rssid");
				//                ////console.log(key);
				location.href = "#opinionckYJ"
				$("#opinionckYJ").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
				RssApi.Details("sort").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#opinionckYJ article").mapview(json, {
						"shijian": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"effect": function(val) {
							return dictdata.effect[val];
						}
					})
					if (json.comments == "" || json.comments == undefined) {
						$(".bf").hide()
					} else {
						$(".bf").show()
					}
					$(".fj p").off().click(function() {
						//                        alert("文件路径：com.rsseasy.lvzhi.file");
						var path = $(this).text();
						var dz = "/upfile/" + path;
						var pdfh5 = new Pdfh5('.pdfjs', {
							pdfurl: dz
						});

					})
				})
			})
		}).getJson();
	}

})
$('a[href="#opinion"]').unbind().click(function() {
	$("#opinion nav>a:first").click();
})

$("#opinionckDBYJ").load(function() {
	$("#opinionckDBYJ input").val("");
	$("#opinionckDBYJ .ql-editor").text("");
})
$("#opinionckDBYJ .normalbutton").click(function() {
	var proposal = $("#opinionckDBYJ .divtop .bh>p").text();
	var companyidlist = $("#opinionckDBYJ .divtop .cb>h4").text();
	var sf = $("#opinionckDBYJ .sf select").val();
	var rw = $("#opinionckDBYJ .rw select").val();
	var title = Date.parse(new Date($("#opinionckDBYJ input").val()));
	var textarea = $("#opinionckDBYJ .ql-editor").html();
	var sj = parseInt(title / 1000).toString();
	var aa = companyidlist.split(",");
	if (textarea == "" || textarea == "<p><br></p>") {
		alert("请填写内容");
	} else {
		RssApi.View.List("suggest_company").setLoading(true).condition(new RssDict().keyvalue({
			"type": 2,
			"suggestid": proposal
		}).getDict()).getJson(function(json) {
			//        ////console.log(json);
			if (sj.length != 10) {
				alert("请输入有效时间");
			} else {
				var ss = 0;
				$.each(json, function(k, v) {
					//                    ////console.log(v.companyid);
					RssApi.Edit("opinion").setLoading(true).keyvalue({
						"reply": sf,
						"effect": rw,
						"proposal": proposal,
						"replyshijian": sj,
						"opinion": textarea,
						"companyid": v.companyid,
						"myid": RssUser.Data.myid
					}).getJson(function(jsonsa) {
						ss++;
					})
				})
				var my = 0;
				$.each(json, function(k, v) {
					my = v.myid;
				})
				RssApi.Edit("suggest").setLoading(true).keyvalue({
					"consultation": 1,
					"id": proposal,
					"myid": my
				}).getJson(function(jsonas) {})
				if (ss != json.length) {
					alert("提交成功");
					//                    $("#opinionckDBYJ article ul>li input").val("");
					//                    $("#opinionckDBYJ article textarea").val("");
					$("#opinion nav>a:last").click();
					location.href = "#opinion";
				}
			}
		});
	}
})

//联名意见征询
$("#Ajoint nav>a").off("click").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel");
	var ind = $(this).index() + 1;
	if (arry.indexOf("Ajoint") == "-1") {
		$("#Ajoint ul li").eq(0).siblings().remove();
		arry.push("Ajoint")
	} else {
		$("#Ajoint ul li").remove();
	}
	if (ind == "1") {
		faqsajax = RssApi.View.List("sortuser").setLoading(true).condition(new RssDict().keyvalue({
			"resume": "1",
			"userid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#Ajoint ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				},
				"resumetype": function(val) {
					if (val == "1") {
						return "已填写意见";
					} else {
						return "未填写意见";
					}
				}
			}, append)
			$("#Ajoint ul li").off().click(function() {
				$("#AjointckY article .qt").remove();
				var aa = $('#AjointckY article .fj p:first').text();
				if (!(aa == "" || aa == undefined)) {
					$('#AjointckY article .fj p:last').remove();
				}
				var key = $(this).find("[rssid]").attr("rssid");
				location.href = "#AjointckY"
				$("#AjointckY").find("header>h1").text($("#Ajoint").find(".sel").text() + "详情");
				RssApi.Details("sortuser").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#AjointckY article").mapview(json, {
						"shijian": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"organize": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"degree": function(val) {
							if (val == "1") {
								return "已解决";
							}
							if (val == "2") {
								return "正在解决";
							}
							if (val == "3") {
								return "列入计划解决";
							}
							if (val == "4") {
								return "因条件限制无法解决";
							}
						},
						"way": function(val) {
							if (val == "1") {
								return "书面（以邮寄方式）";
							}
							if (val == "2") {
								return "平台";
							}
							if (val == "3") {
								return "其他";
							}
						}
					})
					//                    $("#opinionckY article .fj")
					var dfenclosure = $("#AjointckY article .fj p").text();
					var str = dfenclosure.split(",");
					//                    ////console.log(str);
					var html = ""
					$.each(str, function(idx, value) {
						if (value != "") {
							html = "<p class='pdfjs21'>" + value + "</p>"
							$('#AjointckY article .fj').append(html);
						}
					})
					RssApi.View.List("suggestcomments").keyvalue("pagesize", "10000").condition(new RssDict().keyvalue({
						"suggestid": key,
						"resume": "1",
						"resumetype": "1",
						"userid": RssUser.Data.myid
					}).getDict()).getJson(function(lmr) {
						$.each(lmr, function(k, v) {
							$("#AjointckY article").append('<div class="qt"><b>其他代表意见</b><br><p>' + v.comments + '</p></div>');
						})
					})

					$('#AjointckY article .fj p:first').hide();
					$(".fj p").off().click(function() {
						var path = $(this).text();
						var dz = "/upfile/" + path;
						var pdfh5 = new Pdfh5('.pdfjs21', {
							pdfurl: dz
						});
					})
				})
			})
		}).getJson();
	}
	if (ind == "2") {
		faqsajax = RssApi.View.List("sortuser").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "1",
			"resumetype": "0",
			"userid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#Ajoint ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				},
				"resumetype": function(val) {
					if (val == "1") {
						return "已填写意见";
					} else {
						return "未填写意见";
					}
				}
			}, append)
			$("#Ajoint ul li").click(function() {
				$("#AjointkDBYJ article .bh p").remove();
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("[rssid]").attr("rssid");
				//                ////console.log(key);
				location.href = "#AjointkDBYJ"
				$("#AjointkDBYJ").find("header>h1").text($("#Ajoint").find(".sel").text() + "详情");
				RssApi.Details("sort").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {
					$("#AjointkDBYJ article").mapview(json, {})
					var html = "<p>" + key + "</p>"
					$("#AjointkDBYJ article .bh").append(html);
					$("#AjointkDBYJ article .bh p").hide();
				})
			})
		}).getJson();
	}
	if (ind == "3") {
		faqsajax = RssApi.View.List("sortuser").setLoading(true).condition(new RssDict().keyvalue({
			//        "classify": "1",
			"resume": "1",
			"resumetype": "1",
			"userid": RssUser.Data.myid
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			$("#Ajoint ul").mapview(json, {
				"shijian": function(val) {
					return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				},
				"resumetype": function(val) {
					if (val == "1") {
						return "";
					} else {
						return "未填写意见";
					}
				}
			}, append)
			$("#Ajoint ul li").click(function() {
				$("#AjointckYJ article .bf").remove()
				//            location.href = "/app/infopage/notice.html";
				var key = $(this).find("[rssid]").attr("rssid");
				//                ////console.log(key);
				location.href = "#AjointckYJ"
				$("#AjointckYJ").find("header>h1").text($("#Ajoint").find(".sel").text() + "详情");
				RssApi.Details("sortuser").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(json) {

					$("#AjointckYJ article").mapview(json, {
						"shijian": function(val) {
							return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"effect": function(val) {
							return dictdata.effect[val];
						}
					})
					RssApi.View.List("suggestcomments").keyvalue().condition(new RssDict().keyvalue({
						"suggestid": key,
						"resume": "1",
						"resumetype": "1",
						"userid": RssUser.Data.myid
					}).getDict()).getJson(function(lmra) {
						$.each(lmra, function(k, v) {
							$("#AjointckYJ article").append('<div class="bf"><b>' + v.realname + ' &nbsp;&nbsp;代表意见</b><br><p>' +
								v.comments + '</p></div><div class="bf"><b>满意度</b><br><p>' + dictdata.effect[v.effect] +
								'</p></div>');
						})
					})

				})
			})
		}).getJson();
	}

})
$('a[href="#Ajoint"]').unbind().click(function() {
	$("#Ajoint nav>a:first").click();
})

$("#AjointkDBYJ").load(function() {
	$("#AjointkDBYJ input").val("");
	//    $("#AjointkDBYJ textarea").val("");
	$("#AjointkDBYJ .ql-editor").text("");
})
$("#AjointkDBYJ .normalbutton").click(function() {
	var proposal = $("#AjointkDBYJ .divtop .bh>p").text();
	var companyidlist = $("#AjointkDBYJ .divtop .cb>h4").text();
	var sf = $("#AjointkDBYJ .sf select").val();
	var rw = $("#AjointkDBYJ .rw select").val();
	var title = Date.parse(new Date($("#AjointkDBYJ input").val()));
	var textarea = $("#AjointkDBYJ .ql-editor").html();
	var sj = parseInt(title / 1000).toString();
	var aa = companyidlist.split(",");
	if (textarea == "" || textarea == "<p><br></p>") {
		alert("请填写内容");
	} else {
		RssApi.View.List("suggest_company").setLoading(true).condition(new RssDict().keyvalue({
			"type": 2,
			"suggestid": proposal
		}).getDict()).getJson(function(json) {
			//        ////console.log(json);
			if (sj.length != 10) {
				alert("请输入有效时间");
			} else {
				var ss = 0;
				$.each(json, function(k, v) {
					//                    ////console.log(v.companyid);
					RssApi.Edit("suggestcomments").setLoading(true).keyvalue({
						"suggestid": proposal,
						"effect": rw,
						"replyshijian": sj,
						"comments": textarea,
						"userid": RssUser.Data.myid,
						"myid": RssUser.Data.myid
					}).getJson(function(jsonst) {
						ss++;
					})
					RssApi.Table.List("secondeduser").condition(new RssDict().keyvalue({
						"suggestid": proposal,
						"userid": RssUser.Data.myid
					}).getDict()).getJson(function(sr) {
						var idd = 0;
						$.each(sr, function(kk, vv) {
							idd = vv.id;
						})
						RssApi.Edit("secondeduser").setLoading(true).keyvalue({
							"resumetype": 1,
							"myid": RssUser.Data.myid,
							"id": idd
						}).getJson(function(json) {})
					})
				})

				if (ss != json.length) {
					alert("提交成功");
					//                    $("#AjointkDBYJ article ul>li input").val("");
					//                    $("#AjointkDBYJ article textarea").val("");
					$("#Ajoint nav>a:last").click();
					location.href = "#Ajoint";
				}
			}
		});
	}
})

//本次会议建议议案查询
$("#newsuggest").load(function() {
	$("#newsuggest .search button").off("click").click(function() {
		var key = $("#newsuggest .search input").val();
		var likeall = {};
		if (key == undefined || key == "") {

		} else {
			likeall = {
				'title': "{likeall~" + key + "}"
			};
		}
		if (arry.indexOf("newsuggest") == "-1") {
			$("#newsuggest ul li").eq(0).siblings().remove();
			arry.push("newsuggest")
		} else {
			$("#newsuggest ul li").remove();
		}
		RssApi.Details("sugsessnum1").condition(new RssDict().keyvalue({
			"draft": "2",
			"sessionid": "25"
		}).getDict()).getJson(function(json) {
			var num = 0;
			if (json.sessionnum) {
				num = json.sessionnum;
			}
			$("#newsuggest .monifooter").text("共" + num + "条信息");
			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"sessionid": "25"
			}).keyvalue(likeall).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#newsuggest ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)

				//查看
				$("#newsuggest .see").off().click(function() {
					$('#seesuggest article .no1').remove();
					var key = $(this).parent().attr("sortid");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs13'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs13', {
								pdfurl: dz
							});
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
					})
				})

				//办复信息
				$("#newsuggest .ans").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					location.href = "#anssuggest"
					//                    $("#anssuggest").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							//                            $("#anssuggest article .zw").remove();
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办复单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>答复方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>答复附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>答复期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办复人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办复人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办复意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办复报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs20'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs20', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办复信息！</p>')
						}
					})
				})
				if (json.length == "0") {
					alert("未找到查询目标")
				}
			}).getJson();
		})
	})
	if ($("#newsuggest .search input").val() == "") {
		$("#newsuggest .search button").click();
	}
})
var ceshi1 = "1";

//历届会议议案建议查询
$("#oldsuggest").load(function() {
	var session = {},
		sid = "0";
	$("#oldsuggest ul li").eq(0).siblings().remove();
	RssApi.Table.List("session_classify").condition(new RssDict().keyvalue({
		"state": "1"
	}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			session[v.id] = v.name
			$("#oldsuggest [sessionid]").attr("relationid", v.id)
			$("#oldsuggest [sessionid]").text(v.name)
		})
		$("#oldsuggest [sessionid]").off("click").click(function() {
			zzc6($(this), session);
		})
		if ($("#oldsuggest .search input").val() == "") {
			$("#oldsuggest .search button").click();
		}
	})
	$("#oldsuggest .search button").off("click").click(function() {
		var key = $("#oldsuggest .search input").val();
		var likeall = {};
		if (key == undefined || key == "") {

		} else {
			likeall = {
				'title': "{likeall~" + key + "}"
			};
		}
		var sessionid = $("#oldsuggest [sessionid]").attr("relationid");
		if (arry.indexOf("oldsuggest") == "-1") {
			$("#oldsuggest ul li").eq(0).siblings().remove();
			arry.push("oldsuggest")
		} else {
			$("#oldsuggest ul li").remove();
		}
		RssApi.Details("sugsessnum1").condition(new RssDict().keyvalue({
			"draft": "2",
			"sessionid": sessionid
		}).getDict()).getJson(function(data) {
			var num = 0;
			if (data.sessionnum) {
				num = data.sessionnum;
			}
			$("#oldsuggest .monifooter").text("共" + num + "条信息");
			faqsajax = RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
				"draft": "2",
				"sessionid": sessionid
			}).keyvalue(likeall).getDict()).setFlushUI(function(json, append) {
				if (json.length != "10") {
					$('.nodata').hide();
				} else {
					$('.nodata').show();
				}
				$("#oldsuggest ul").mapview(json, {
					"registertype": function(val) {
						var registertype = dictdata.registertype[val]
						return registertype;
					}
				}, append)
				//查看
				$("#oldsuggest .see").off().click(function() {
					var key = $(this).parent().attr("sortid");
					$('#seesuggest article .no1').remove();
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"sortid": key
					}).getDict()).getJson(function(json) {
						var shijian = "",
							level = ""
						$("#seesuggest article").mapview(json, {
							"shijian": function(val) {
								return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm");
							},
							"level": function(val) {
								return level = dictdata.circles[val];
							}
						})
						$.each(json, function(k, v) {
							$("#seesuggest article").append('<div class="divtop"><h1 >' + v.sessionname + '</h1><h2>[第' + v.realid +
								'号]</h2><h3>' + v.title + '</h3><h4 >提出者:' + v.realname + '</h4><h4 shijian>' + shijian +
								'</h4></div><div class="divp">' + v.matter + '</div><div class="no"  >会议次数：' + v.csname +
								'</div><div class="no"  >层次：' + level + '</div><div class="no">审查分类：' + v.scname +
								'</div><div class="no fj">附件：<span>' + v.enclosure + '<span></div>')
						})
						RssApi.View.List("second_user").setLoading(true).condition(new RssDict().keyvalue({
							"suggestid": key
						}).keyvalue().getDict()).getJson(function(lm) {
							var lmr = ""
							$.each(lm, function(k, v) {
								lmr += v.realname + ",";
							})
							console.log(lmr);
							$('#seesuggest article .fj').before('<div class="no1">联名代表：' + lmr + '</div>');
						})
						var dfenclosure = $("#seesuggest article .fj span").text();
						var str = dfenclosure.split(",");
						////console.log(str);
						var html = ""
						$.each(str, function(idx, value) {
							if (value != "") {
								html = "<p class='pdfjs12'>" + value + "</p>"
								$('#seesuggest article .fj').append(html);
							}
						})
						$('#seesuggest article  .fj span').hide();
						$(".fj p").off().click(function() {
							//                                alert("文件路径：com.rsseasy.lvzhi.file");
							var path = $(this).text();
							var dz = "/upfile/" + path;
							var pdfh5 = new Pdfh5('.pdfjs12', {
								pdfurl: dz
							});
						})
						//                        $("#seesuggest .divp").html(json[0].matter)
					})
				})

				//办复信息
				$("#oldsuggest .ans").off("click").click(function() {
					var key = $(this).parent().attr("sortid");
					location.href = "#anssuggest"
					//                    $("#anssuggest").find("header>h1").text($("#opinion").find(".sel").text() + "详情");
					RssApi.View.List("sort").setLoading(true).condition(new RssDict().keyvalue({
						"id": key
					}).getDict()).getJson(function(json) {
						$("#anssuggest article .zw").remove();
						if (json[0].resumeinfo) {
							//                            $("#anssuggest article .zw").remove();
							var shijian = "",
								organize = "",
								degree = "",
								way = ""
							$("#anssuggest article").mapview(json, {
								"shijian": function(val) {
									return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"organize": function(val) {
									return organize = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
								},
								"degree": function(val) {
									if (val == "1") {
										return degree = "已解决";
									}
									if (val == "2") {
										return degree = "正在解决";
									}
									if (val == "3") {
										return degree = "列入计划解决";
									}
									if (val == "4") {
										return degree = "因条件限制无法解决";
									}
								},
								"way": function(val) {
									if (val == "1") {
										return way = "书面";
									}
									if (val == "2") {
										return way = "平台（上传附件）";
									}
									if (val == "3") {
										return way = "其他";
									}
								}
							})
							$.each(json, function(k, v) {
								$("#anssuggest article").append('<div class="divtop"><h1>' + v.title + '</h1><h4>发布者：' + v.realname +
									'</h4><h4>发布时间：' + shijian + '</h4></div><div class="divp">' + v.matter +
									'</div><div class="bf"><b>办复单位</b><br><p>' + v.realcompanyname +
									'</p></div><div class="bf"><b>答复方式</b><br><p >' + way +
									'</p></div><div class="fj"><b>答复附件</b><br><p class="pdfjs6">' + v.dfenclosure +
									'</p></div><div class="bf"><b>答复期限</b><br><p >' + organize +
									'</p></div><div class="bf"><b>办理情况</b><br><p>' + degree +
									'</p></div><div class="bf"><b>办复人</b><br><p>' + v.BanFuName +
									'</p></div><div class="bf"><b>办复人电话</b><br><p>' + v.BanFutel +
									'</p></div><div class="bf"><b>办复意见说明</b><br><p >' + v.comments +
									'</p></div><div class="bf"><b>办复报告</b><br><div><p>' + v.resumeinfo + '</p></div></div>')
							})
							var dfenclosure = $("#anssuggest article .pdfjs6").text();
							var str = dfenclosure.split(",");
							////console.log(str);
							var html = ""
							$.each(str, function(idx, value) {
								if (value != "") {
									html = "<p class='pdfjs21'>" + value + "</p>"
									$('#anssuggest article .fj').append(html);
								}
							})
							$('#anssuggest article .pdfjs6').hide();
							$(".fj p").off().click(function() {
								//                                alert("文件路径：com.rsseasy.lvzhi.file");
								var path = $(this).text();
								var dz = "/upfile/" + path;
								var pdfh5 = new Pdfh5('.pdfjs21', {
									pdfurl: dz
								});
							})
						} else {
							$("#anssuggest article .divtop").remove();
							$("#anssuggest article .divp").remove();
							$("#anssuggest article .bf").remove();
							$("#anssuggest article .fj").remove();

							$("#anssuggest article").append('<p class="zw">暂无办复信息！</p>')
						}
					})
				})
				if (json.length == "0") {
					alert("未找到查询目标")
				}
			}).getJson();
		})
	})


	//    })
})
//建议议案
$("#suggestsubYA").load(function() {
	var session = {},
		sid = "0",
		meetingnum = {},
		reviewclass = {},
		circless = [],
		mission = {};
	RssApi.Table.List("session_classify").condition(new RssDict().keyvalue({
		"state": "1"
	}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			session[v.id] = v.name
			$("#suggestsubYA [sessionid]").attr("relationid", v.id)
			$("#suggestsubYA [sessionid]").text(v.name)
		})
		$("#suggestsubYA [sessionid]").off("click").click(function() {
			zzc($(this), session);
		})
	})
	RssApi.Table.List("companytypeee_classify").condition(new RssDict().keyvalue({}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			meetingnum[v.id] = v.name
			$("#suggestsubYA [meetingnum]").attr("relationid", v.id)
			$("#suggestsubYA [meetingnum]").text(v.name)
		})
		$("#suggestsubYA [meetingnum]").off("click").click(function() {
			zzc($(this), meetingnum);
		})
	})
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(json) {
		var aa = (json[0].circleslist).split(",");
		console.log(aa)
		$.each(aa, function(k, v) {
			if (v != "") {
				console.log(k + ":" + v)
				circless.push(dictdata["circles"][v])
				$("#suggestsubYA [circless]").attr("relationid", v)
				$("#suggestsubYA [circless]").text(circless)
			}
		})
		$("#suggestsubYA [circless]").off("click").click(function() {
			zzc($(this), circless);
		})
	})
	RssApi.Table.List("companytypee_classify").condition(new RssDict().keyvalue({}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			reviewclass[v.id] = v.name
			$("#suggestsubYA [reviewclass]").attr("relationid", v.id)
			$("#suggestsubYA [reviewclass]").text(v.name)
		})
		$("#suggestsubYA [reviewclass]").off("click").click(function() {
			zzc($(this), reviewclass);
		})
	})
	var missions = "",
		realname = "";
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(jsonn) {
		$.each(jsonn, function(k, v) {
			missions = v.mission;
		})
	})
	$("#suggestsubYA .lmr").off().click(function() {
		var span = $("#suggestsubYA .span").text().split(",");
		location.href = "#dbt"
		if (arry.indexOf("dbt") == "-1") {
			$("#dbt ul li").eq(0).siblings().remove();
			arry.push("dbt")
		} else {
			$("#dbt ul li").remove();
		}
		$("#dbt article .dbta").text(realname);
		faqsajax = RssApi.Table.List("user").setLoading(true).keyvalue("pagesize", "10000").condition(new RssDict().keyvalue({
			"mission": missions,
			"myid": "{notin~" + RssUser.Data.myid + "}"
		}).getDict()).setFlushUI(function(jsona, append) {
			//            $("#dbt article ul").mapview(jsona, {
			//                
			//            }, append)
			let html = "";
			var flag = false;
			$.each(jsona, function(k, v) {
				for (var i = 0; i < span.length; i++) {
					if (v.myid == span[i]) {
						flag = true;
						break;
					}
				}
				html += '<li><input type="checkbox" ' + (flag ? "checked" : "") + ' name="myid"  myid="' + v.myid +
					'" realname="' + v.realname + '" /><em>' + v.realname + '</em><span class="dh">' + v.telphone +
					'</span></li>';
				flag = false;
			})
			$("#dbt article ul").html(html);
			//除了表头（第一行）以外所有的行添加click事件.
			$("#dbt ul>li").slice(0).click(function() {
				// 切换样式
				$(this).toggleClass("tr_active");
				// 找到checkbox对象
				var chks = $("input[type='checkbox']", this);
				var tag = $(this).attr("tag");
				if (tag == "selected") {
					// 之前已选中，设置为未选中
					$(this).attr("tag", "");
					chks.prop("checked", false);
				} else {
					// 之前未选中，设置为选中
					$(this).attr("tag", "selected");
					chks.prop("checked", true);
				}

			});
			$("#dbt article .submitName").off().click(function() {
				var id_array = new Array();
				var name_array = new Array();
				$('input[name="myid"]:checked').each(function() {
					id_array.push($(this).attr("myid")); //向数组中添加元素  
					name_array.push($($(this)).attr("realname")); //向数组中添加元素  
				});
				var idstr = id_array.join(','); //将数组元素连接起来以构建一个字符串  
				var namestr = name_array.join(',');
				$("#suggestsubYA span").text(idstr)
				$("#suggestsubYA [mission]").val(namestr);
				location.href = "#suggestsubYA"
			});
		}).getJson();
	})
	//    $("#suggestsubYA .fj .fja").text("");
	//    $("#suggestsubYA article .fj .fja").text("");
	//    $("#suggestsubYA article .marginb input").val("");
	//    $("#suggestsubYA article textarea").val("");
	//    $("#suggestsubYA article .lmr span").text("");

    //loadmeeting();//added by jackie//只需一次载入meeting即可，不需要重复载入
	$("#suggestsubYA .normalbutton").off().click(function() {
		var zhi = ($("#suggestsubYA .span").text()).split(",");
		if (zhi.length < 9) {
			alert("议案的附议人数得大于等于10人！");
			//            alert(zhi.length);
		} else {
			//            alert(zhi.length);
			var k1 = {}
			//        console.log($("#suggestsub span").text());
			k1["sessionid"] = $("#suggestsubYA [sessionid]").attr("relationid");
			k1["meetingnum"] = $("#suggestsubYA [meetingnum]").attr("relationid");
			k1["level"] = $("#suggestsubYA [circless]").text();

			k1["reviewclass"] = $("#suggestsubYA [reviewclass]").attr("relationid");
			//        k1["mission"] = $("#suggestsubYA .lmr span").text();
			k1["title"] = $("#suggestsubYA .marginb input").val();
			k1["matter"] = $("#suggestsubYA .ql-editor").html();
			k1["myid"] = RssUser.Data.myid;
			k1["draft"] = "2";
			k1["reviewopinion"] = "0";
			k1["permission"] = "0";
			k1["sugyears"] = "0";
			k1["seconded"] = "0";
			k1["sugformation"] = "0";
			// alert("flowtype_ysw11::" + flowtype_ysw);
			k1["isysw"] = flowtype_ysw; //测试，还要加是否会议期间的判断//added by jackie
			var date = new Date;
			var year = date.getFullYear();
			var mydate = year.toString();
			k1["year"] = mydate;
			k1["ProposedBill"] = Date.parse(new Date()) / 1000;
			k1["shijian"] = Date.parse(new Date()) / 1000;
			k1["enclosure"] = $("#suggestsubYA .fja").text() + ",";
			console.log(Date.parse(new Date()) / 1000);
			var sj = Date.parse(new Date()) / 1000;
			var userid = ($("#suggestsubYA .span").text()).split(",");
			k1["numpeople"] = userid.length;
			console.log(userid);
			if (k1["level"] == "乡镇人大代表") {
				k1["level"] = 0;
			} else {
				k1["level"] = 1;
			}

			console.log(k1["level"]);
			if (k1["title"] != "" && k1["matter"] != "") {
				RssApi.Edit("suggest").setLoading(true).keyvalue(k1).keyvalue({
					"lwstate": "2"
				}).getJson(function(jsons) {
					var sortid = jsons.id;
					console.log(sortid);
					RssApi.View.Details("sort_num").condition(new RssDict().keyvalue({
						"type": "2"
					}).getDict()).getJson(function(e) {
						var numzhi = "";
						//                    console.log(e.length + "-----e");
						if (e.length == "0" || e.length == undefined) {
							numzhi = 1;
						} else {
							numzhi = parseInt(e.num) + 1;
						}
						console.log(numzhi);
						RssApi.Edit("sort").keyvalue({
							"sortid": sortid,
							"realid": sortid,
							"type": "2",
							"myid": 0
						}).getJson(function(jsonaa) {
							RssApi.Edit("suggestscr").setLoading(true).keyvalue({
								"suggestid": sortid,
								"userid": missions,
								"myid": 0
							}).getJson(function(aa) {
								for (var i = 0; i < userid.length; i++) {
									RssApi.Edit("secondeduser").setLoading(true).keyvalue({
										"suggestid": sortid,
										"userid": userid[i],
										"myid": RssUser.Data.myid,
									}).getJson(function(jsonnn) {})
								}
							})

							if (jsonaa.id) {
								alert("增加成功")
								$("#suggestsubYA article li input").val("");
								$("#suggestsubYA article .fj label input").val("");
								$("#suggestsubYA article .span").text("");
								$("#suggestsubYA .fj .fja").text("");
								$("#suggestsubYA .ql-editor").text("");
								$("#suggestsubYA [mission]").val("");
								location.href = "#suggest"
							} else {
								alert("失败")
							}
						})
					})
				})
			} else {
				alert("议案标题和内容不能为空");
			}
		}
	})
})
//$("#suggestsubYA .normalbutton").click(function () {
//    alert("ddd");
//    var k1 = {},
//            k2 = {};
//    $("#suggestsubYA input[type='checkbox']").each(function () {
//        if ($(this).is(":checked")) {
//            $(this).val("1")
//        } else {
//            $(this).val("2")
//        }
//    });
//    $("#suggestsubYA input").each(function () {
//        var t = $(this).attr("name");
//        k1[t] = $(this).val();
//    })
//    k1["matter"] = $("#suggestsubYA textarea").val();
//    k1["myid"] = RssUser.Data.myid;
//    k1["draft"] = "2";
//    RssApi.Edit("suggest").setLoading(true).keyvalue(k1).keyvalue({"lwstate": "2"}).getJson(function (json) {
//        var sortid = json.id;
//        RssApi.Details("sort_num").condition(new RssDict().keyvalue({
//            "type": "2"
//        }).getDict()).getJson(function (e) {
//            var num = parseInt(e.num) + 1
//            RssApi.Edit("sort").keyvalue({
//                "sortid": sortid,
//                "realid": num,
//                "type": "2",
//                "myid": RssUser.Data.myid
//            }).getJson(function (json) {
//                if (json.id) {
//                    alert("增加成功")
//                }
//            })
//        })
//    })
//})
//建议建议
$("#suggestsub").load(function() {
	//    $("#suggestsub article .fj .fja").text("");
	//    $("#suggestsub article .marginb input").val("");

	//    $("#suggestsub article .lmr span").text("");
	var session = {},
		sid = "0",
		meetingnum = {},
		reviewclass = {},
		circless = [],
		mission = {};
	RssApi.Table.List("session_classify").condition(new RssDict().keyvalue({
		"state": "1"
	}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			session[v.id] = v.name
			$("#suggestsub [sessionid]").attr("relationid", v.id)
			$("#suggestsub [sessionid]").text(v.name)
		})
		$("#suggestsub [sessionid]").off("click").click(function() {
			zzc($(this), session);
		})
	})
	RssApi.Table.List("companytypeee_classify").condition(new RssDict().keyvalue({}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			meetingnum[v.id] = v.name
			$("#suggestsub [meetingnum]").attr("relationid", v.id)
			$("#suggestsub [meetingnum]").text(v.name)
		})
		$("#suggestsub [meetingnum]").off("click").click(function() {
			zzc($(this), meetingnum);
		})
	})
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(json) {
		var aa = (json[0].circleslist).split(",");
		console.log(aa)
		$.each(aa, function(k, v) {
			if (v != "") {
				console.log(k + ":" + v)
				circless.push(dictdata["circles"][v])
				$("#suggestsub [circless]").attr("relationid", v)
				$("#suggestsub [circless]").text(circless)
			}
		})
		$("#suggestsub [circless]").off("click").click(function() {
			zzc($(this), circless);
		})
	})
	RssApi.Table.List("companytypee_classify").condition(new RssDict().keyvalue({}).getDict()).getJson(function(json) {
		$.each(json, function(k, v) {
			reviewclass[v.id] = v.name
			$("#suggestsub [reviewclass]").attr("relationid", v.id)
			$("#suggestsub [reviewclass]").text(v.name)
		})
		$("#suggestsub [reviewclass]").off("click").click(function() {
			zzc($(this), reviewclass);
		})
	})
	var missions = "",
		realname = "";
	RssApi.Table.List("user").condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(jsonn) {
		$.each(jsonn, function(k, v) {
			missions = v.mission;
		})
	})
	$("#suggestsub .lmr").off().click(function() {
		var span = $("#suggestsub .span").text().split(",");
		//        $("#suggestsub .lmr span").empty();
		location.href = "#dbt"
		if (arry.indexOf("dbt") == "-1") {
			$("#dbt ul li").eq(0).siblings().remove();
			arry.push("dbt")
		} else {
			$("#dbt ul li").remove();
		}
		$("#dbt article .dbta").text(realname);
		faqsajax = RssApi.Table.List("user").setLoading(true).keyvalue("pagesize", "10000").condition(new RssDict().keyvalue({
			"mission": missions,
			"myid": "{notin~" + RssUser.Data.myid + "}"
		}).getDict()).setFlushUI(function(jsona, append) {
			let html = "";
			var flag = false;
			$.each(jsona, function(k, v) {
				for (var i = 0; i < span.length; i++) {
					if (v.myid == span[i]) {
						flag = true;
						break;
					}
				}
				html += '<li><input type="checkbox" ' + (flag ? "checked" : "") + ' name="myid"  myid="' + v.myid +
					'" realname="' + v.realname + '" /><em>' + v.realname + '</em><span class="dh">' + v.telphone +
					'</span></li>';
				flag = false;
			})
			$("#dbt article ul").html(html);
			//除了表头（第一行）以外所有的行添加click事件.
			$("#dbt ul>li").slice(0).click(function() {
				// 切换样式
				$(this).toggleClass("tr_active");
				// 找到checkbox对象
				var chks = $("input[type='checkbox']", this);
				var tag = $(this).attr("tag");
				if (tag == "selected") {
					// 之前已选中，设置为未选中
					$(this).attr("tag", "");
					chks.prop("checked", false);
				} else {
					// 之前未选中，设置为选中
					$(this).attr("tag", "selected");
					chks.prop("checked", true);
				}
			});
			$("#dbt article .submitName").off().click(function() {
				var id_array = new Array();
				var name_array = new Array();
				$('input[name="myid"]:checked').each(function() {
					id_array.push($(this).attr("myid")); //向数组中添加元素  
					name_array.push($($(this)).attr("realname")); //向数组中添加元素  
				});
				var idstr = id_array.join(','); //将数组元素连接起来以构建一个字符串  
				var namestr = name_array.join(',');
				location.href = "#suggestsub"
				$("#suggestsub span").text(idstr)
				$("#suggestsub [mission]").val(namestr);
			});
		}).getJson();
	})
	//    $("#suggestsub .fj .fja").text("");
	//    $(".fj label").append('<input type="file" class="file"  name="file" accept=".pdf" onchange="upfile1(this);" multiple>');
   //loadmeeting();//added by jackie////只需一次载入meeting即可，不需要重复载入
	$("#suggestsub .normalbutton").off().click(function() {
		var k1 = {}
		//        console.log($("#suggestsub span").text());
		k1["sessionid"] = $("#suggestsub [sessionid]").attr("relationid");
		k1["meetingnum"] = $("#suggestsub [meetingnum]").attr("relationid");
		k1["level"] = $("#suggestsub [circless]").text();
		k1["reviewclass"] = $("#suggestsub [reviewclass]").attr("relationid");
		//        k1["mission"] = $("#suggestsub .lmr span").text();
		k1["title"] = $("#suggestsub .marginb input").val();
		k1["matter"] = $("#suggestsub .ql-editor").html();
		k1["myid"] = RssUser.Data.myid;
		k1["draft"] = "2";
		k1["reviewopinion"] = "0";
		k1["permission"] = "0";
		k1["sugyears"] = "0";
		k1["seconded"] = "0";
		k1["sugformation"] = "0";
		
		// alert("flowtype_ysw11::" + flowtype_ysw);
        k1["isysw"] = flowtype_ysw; //测试，还要加是否会议期间的判断//added by jackie
		
		var date = new Date;
		var year = date.getFullYear();
		var mydate = year.toString();
		k1["year"] = mydate;
		k1["ProposedBill"] = Date.parse(new Date()) / 1000;
		k1["shijian"] = Date.parse(new Date()) / 1000;
		k1["enclosure"] = $("#suggestsub .fja").text() + ",";
		console.log(Date.parse(new Date()) / 1000);
		var sj = Date.parse(new Date()) / 1000;
		var userid = ($("#suggestsub .span").text()).split(",");
		k1["numpeople"] = userid.length;
		console.log(k1["matter"]);
		if (k1["level"] == "乡镇人大代表") {
			k1["level"] = 0;
		} else {
			k1["level"] = 1;
		}
		if (k1["title"] != "" && k1["matter"] != "") {
			RssApi.Edit("suggest").setLoading(true).keyvalue(k1).keyvalue({
				"lwstate": "1"
			}).getJson(function(jsons) {
				var sortid = jsons.id;
				console.log(sortid);
				RssApi.View.Details("sort_num").condition(new RssDict().keyvalue({
					"type": "1"
				}).getDict()).getJson(function(e) {
					var numzhi = "";
					console.log(e.length + "-----e");
					if (e.length == "0" || e.length == undefined) {
						numzhi = 1;
					} else {
						numzhi = parseInt(e.num) + 1;
					}
					console.log(numzhi);
					RssApi.Edit("sort").keyvalue({
						"sortid": sortid,
						"realid": sortid,
						"type": "1",
						"myid": 0
					}).getJson(function(jsonaa) {
						RssApi.Edit("suggestscr").setLoading(true).keyvalue({
							"suggestid": sortid,
							"userid": missions,
							"myid": 0
						}).getJson(function(aa) {
							for (var i = 0; i < userid.length; i++) {
								RssApi.Edit("secondeduser").setLoading(true).keyvalue({
									"suggestid": sortid,
									"userid": userid[i],
									"myid": RssUser.Data.myid,
								}).getJson(function(jsonnn) {})
							}
						})

						if (jsonaa.id) {
							alert("增加成功")
							$("#suggestsub article li input").val("");
							$("#suggestsub article .fj label input").val("");
							$("#suggestsub .span").text("");
							$("#suggestsub .fj .fja").text("");
							$("#suggestsub .ql-editor").text("");
							//                            $("#suggestsub span").text("")
							$("#suggestsub [mission]").val("");
							location.href = "#suggest"
						} else {
							alert("失败")
						}
					})
				})
			})
		} else {
			alert("建议标题和内容不能为空");
		}
	})
})



//通知公告
$("#noticesel li").click(function() {
	var ind = $(this).index();
	location.href = "#noticebulletin";
	$("#noticebulletin nav>a").eq(ind).click();
})

$("#noticebulletin nav>a").off("click").click(function() {
	$(this).addClass("sel").siblings().removeClass("sel");
	var ind = $(this).index() + 1;
	if (arry.indexOf("noticebulletin") == "-1") {
		$("#noticebulletin ul li").eq(0).siblings().remove();
		arry.push("noticebulletin")
	} else {
		$("#noticebulletin ul li").remove();
	}
	faqsajax = RssApi.View.List("lzmessage_news_user").setLoading(true).condition(new RssDict().keyvalue({
		"fbstate": "1",
		"infotype": ind,
		"myid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#noticebulletin ul").mapview(json, {
			"fbshijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
			}
		}, append)
		$("#noticebulletin ul li").click(function() {
			$("#fz1").hide();
			//            location.href = "/app/infopage/notice.html";
			var key = $(this).find("[rssid]").attr("rssid");
			location.href = "#seenotice"
			$("#seenotice").find("header>h1").text($("#noticebulletin").find(".sel").text() + "详情");
			RssApi.Details("lzmessage_news_user").setLoading(true).condition(new RssDict().keyvalue({
				"id": key
			}).getDict()).getJson(function(json) {
				$("#seenotice article").mapview(json, {
					"fbshijian": function(val) {
						return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
					}
				})
				if (json.ico == "" || json.ico == undefined) {
					$(".slt").hide()
				} else {
					$(".slt").show()
				}
				if (json.links == "" || json.links == undefined) {
					$(".wblj").hide()
				} else {
					$(".wblj").show()
				}
				if (json.enclosure == "" || json.enclosure == undefined) {
					$(".fj").hide()
				} else {
					$(".fj").show()
				}

				$(".fj p").off().click(function() {
					//                    alert("文件路径：com.rsseasy.lvzhi.file");
					var path = $(this).text();
					var dz = "/upfile/" + path;
					var pdfh5 = new Pdfh5('.pdfjs', {
						pdfurl: dz
					});
				})

				var url = $("#seenotice .wblj p").text();
				$("#seenotice .wblj p").hide();
				$("#seenotice .wblj a").text(url);
				$("#seenotice .wblj a").attr("js-browser", url);

				//                $(".wblj p").click(function () {
				//                    var res = $(this).text();
				//                    ////console.log(res);
				//                    var btn = document.getElementById('btn2');
				//                    btn.setAttribute("data-clipboard-text", res);
				//                    var clipboard = new ClipboardJS(btn);
				//                    clipboard.on('success', function (e) {
				//                        ////console.log(e);
				//                        $("#fz1").show();
				//                        setTimeout(function () {
				//                            $("#fz1").hide();
				//                        }, 1000);
				//                    });
				//
				//                    clipboard.on('error', function (e) {
				//                        ////console.log(e);
				//                    });
				//                })
			})
		})
	}).getJson();
})

//扫一扫
$("#scanninghref").click(function() {
	JsAdapter.onQRcodeDecode = function(json) {
		var val = json["qrcode"];
		if (val == "" || val == undefined) {
			alert("用户不存在！")
		} else {
			RssApi.Details("user_delegation").condition(new RssDict().keyvalue({
				"myid": val
			}).getDict()).getJson(function(json) {
				$("#scanning article").mapview(json, {
					//性别
					"sex": function(val) {
						return dictdata["sex"][val];
					},
					//党派
					"clan": function(val) {
						return dictdata["clan"][val];
					},
					//民族
					"nationid": function(val) {
						return dictdata["nationalityid"][val][0];
					},
					//界别
					"circles": function(val) {
						return dictdata["circles"][val];
					},
					//代表团
					"delegationname": function(val) {
						return val ? val : "无";
					}
				})
				$("#scanning .normalbutton").off("click").click(function() {
					RssApi.Table.List("user_friend").condition(new RssDict().keyvalue({
						"friendid": val,
						"myid": RssUser.Data.myid
					}).getDict()).getJson(function(json) {
						if (json.length == "0") {
							RssApi.Edit("user_friend").keyvalue({
								"friendid": val,
								"myid": RssUser.Data.myid
							}).getJson(function(json) {
								if (json.id) {
									alert("成功");
								}
							});
						} else {
							alert("好友已存在")
						}
					});
				});
				if (json.account) {
					location.href = "#scanning"
				} else {
					alert("用户不存在！")
				}
			});
		}
	};
	JsAdapter.QRcodeScan().Submit();
})


//二维码
//$("#my").load(function () {
//    $("#doublecode").find("canvas").remove();
//    $("#doublecode").qrcode({"text": RssUser.Data.myid});
//    $("#doublecode").qrcode({"text": "http://219.159.165.98:81/newhtml.html"});
//})
//意见反馈
$("[name='type']").click(function() {
	zzc($(this), dictdata["fbtype"]);
})
$("#feedback").load(function() {
	$(this).find("[res='myname']").text(RssUser.Data.realname)
	$(this).find("[res='mytelphone']").text(RssUser.Data.telphone)
})
$("#feedback .normalbutton").click(function() {
	var type = $("#feedback>article>ul>li:nth-of-type(1)>em").attr("relationid");
	var title = $("#fdtitle").val();
	var matter = $("#fdmatter").val();
	if (title != "" && matter != "") {
		RssApi.Edit("feed_back").setLoading(true).keyvalue({
			"classifyid": type,
			"title": title,
			"description": matter,
			"myid": RssUser.Data.myid
		}).getJson(function(json) {
			if (json.id) {
				alert("提交成功");
				$("#fdtitle").val("");
				$("#fdmatter").val("");
			}
		})
	} else {
		alert("反馈的标题和内容不能为空！");
	}
})
//我的日志
$("#mylog").load(function() {
	if (arry.indexOf("mylog") == "-1") {
		$("#mylog ul li").eq(0).siblings().remove();
		arry.push("mylog")
	} else {
		$("#mylog ul li").remove();
	}
	faqsajax = RssApi.Table.List("syslog").setLoading(true).condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).setFlushUI(function(json, append) {
		if (json.length != "10") {
			$('.nodata').hide();
		} else {
			$('.nodata').show();
		}
		$("#mylog ul").mapview(json, {
			"shijian": function(val) {
				return new Date(parseInt(val) * 1000).toString("yyyy-MM-dd hh:mm:ss");
			}
		}, append)
	}).getJson();
})

//登录日志
if (RssUser.Data.myid) {
	RssApi.Edit("syslog").keyvalue({
		"logclass": "1",
		"logtitle": "手机登录成功",
		"matter": "手机app登录",
		"myid": RssUser.Data.myid
	}).getJson(function(json) {
		if (json.id) {
			//            alert("登录成功");
		}
	})
}

$("#sqmysub").load(function() {
	$("#sqmysub input").val("");
	$("#sqmysub textarea").val("");
})
$("#sqmysub .normalbutton").click(function() {
	var title = $("#sqmysub input").val();
	var textarea = $("#sqmysub .ql-editor").html();
	var type = $("#sqmysub option:selected").val()
	if (title == "" || textarea == "<p><br></p>") {
		alert("标题和内容不能为空");
	} else {
		RssApi.Table.List("mingancitype_classify").keyvalue("pagesize", "10000").condition(new RssDict().keyvalue({
			"state": 0
		}).getDict()).getJson(function(mgc) {
			var tf = true;
			$.each(mgc, function(k, v) {
				if (v.name != null) {
					if (title.indexOf(v.name) >= 0) {
						alert("发表标题包含敏感词['" + v.name + "']!");
						return tf = false;
					}
					if (textarea.indexOf(v.name) >= 0) {
						alert("发表内容包含敏感词['" + v.name + "']!");
						return tf = false;
					}
				}
			})
			if (tf == true) {
				RssApi.Edit("poll").setLoading(true).keyvalue({
					"title": title,
					"matter": textarea,
					"type": type,
					"myid": RssUser.Data.myid
				}).getJson(function(json) {
					if (json.id) {
						alert("提交成功");
						$("#sqmysub input").val("");
						//                        $("#sqmysub textarea").val("");
						$("#sqmysub .ql-editor").text("");
						location.href = "#suggest"
					}
				})
			}
		})
	}
})

$("#mysqmy").load(function() {
	if (arry.indexOf("mysqmy") == "-1") {
		$("#mysqmy ul li").eq(0).siblings().remove();
		arry.push("mysqmy")
	} else {
		$("#mysqmy ul li").remove();
	}
	RssApi.Details("poll_num").condition(new RssDict().keyvalue({
		"state": "1",
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(json) {
		var num = 0;
		if (json.statenum) {
			var num = json.statenum;
		}
		$("#mysqmy .monifooter").text("共" + num + "条信息");
		faqsajax = RssApi.Table.List("poll").setLoading(true).condition(new RssDict().keyvalue({
			"myid": RssUser.Data.myid,
			"state": "1"
		}).getDict()).setFlushUI(function(json, append) {
			if (json.length != "10") {
				$('.nodata').hide();
			} else {
				$('.nodata').show();
			}
			var shijian = "";
			$("#mysqmy ul").mapview(json, {
				"shijian": function(val) {
					return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
				},
				"type": function(val) {
					return dictdata.gztype[val];
				}
			})
			$.each(json, function(k, v) {
				var matter = $(v.matter).text(),
					title = "";
				//                if ((v.matter).indexOf("</")) {matter = $(v.matter).text()} else {title = v.matter;}
				if (v.title == "" || v.title == undefined) {
					title = "无标题"
				} else {
					title = v.title;
				}
				$("#mysqmy ul").append('<li><h1 rssid="' + v.id + '">' + title + '</h1><p>' + matter + '</p><span>' +
					shijian + '</span></li>');
			});

			$("#mysqmy ul li").click(function() {
				var key = $(this).find("[rssid]").attr("rssid");
				location.href = "#mysqmyck"
				$("#mysqmyck").find("header>h1").text();
				RssApi.View.List("poll").setLoading(true).condition(new RssDict().keyvalue({
					"id": key
				}).getDict()).getJson(function(jsons) {
					console.log(jsons);
					var shijian = "",
						type = ""
					$("#mysqmyck article").mapview(jsons, {
						"shijian": function(val) {
							return shijian = new Date(parseInt(val) * 1000).toString("yyyy-MM-dd");
						},
						"type": function(val) {
							return type = dictdata.gztype[val];
						}
					})
					console.log(jsons[0].matter)
					$('#mysqmyck article').html('<div class="divtop"><h1>' + jsons[0].title + '</h1><h4>发布者：' + jsons[0].realname +
						'</h4><h5>发布时间：' + shijian + '</h5><h5>工作分类：' + type +
						'</h5></div><div id="ckjy"><span class="dz">点赞：<b class="ckfont">0</b></span><span><u class="pl">评论：<b class="ckfont">0</b></u></span></div><div class="divp">' +
						jsons[0].matter + '</div><ul></ul>');
					RssApi.Details("s_praise_num").condition(new RssDict().keyvalue({
						"relationid": key,
						//                        "type": "4"
					}).getDict()).getJson(function(num) {
						var znum = "0";
						if (num.relnum != undefined && num.relnum != "") {
							znum = num.relnum
						}
						//                        ////console.log(znum);
						//                        $('.ckfont').eq(0).empty()
						$("#mysqmyck .ckfont").eq(0).text(znum);
						RssApi.Details("suggest_comment_num").condition(new RssDict().keyvalue({
							"suggestid": key
						}).getDict()).getJson(function(sunum) {
							var snum = "0";
							if (sunum.sugnum != undefined && sunum.sugnum != "") {
								snum = sunum.sugnum
							}
							$("#mysqmyck .ckfont").eq(1).text(snum);
							RssApi.View.List("suggest_comment").keyvalue("pagesize", "100").condition(new RssDict().keyvalue({
								"suggestid": key
							}).getDict()).getJson(function(comment) {
								$("#mysqmyck article>#wpj").empty();
								$("#mysqmyck article>ul").empty();
								if (comment.length == "0") {
									$("#mysqmyck article>ul").hide();
									$("#mysqmyck article>ul").before('<div id="wpj">无评价</div>')
								}

								$.each(comment, function(k, v) {
									$("#mysqmyck #wpj").remove();
									$("#mysqmyck article>ul").show();
									if (v.myid == RssUser.Data.myid) {
										$("#mysqmyck article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									} else {
										$("#mysqmyck article>ul").prepend('<li PJid="' + v.id + '"><span>' + v.realname +
											'：</span>' + v.matter + '</li>')
									}

								})
								//                                sc();
							})
						})
					})
				})
			})

		}).getJson();
	})
})
//账号安全
$("#accountsoft").load(function() {
	RssApi.Table.List("user").setLoading(true).condition(new RssDict().keyvalue({
		"myid": RssUser.Data.myid
	}).getDict()).getJson(function(json) {

		$("#accountsoft ul").mapview(json, {

		})
		$("[userpwd]").off("click").click(function() {
			var t = $(this),
				dict = t.attrmap(t.attr("userpwd"));
			dict["account"] = RssUser.Data.account;
			try {
				ValidatedV2.dictset(dict).keyset("oldpwd").isPwd().keyset("pwd").isPwd().keyset("repwd").isPwd().isEqual(dict[
					"pwd"]);
				new Ajax("userpwd").keyvalue(dict).getJson(function(json) {
					if (json["state"] == "ok") {
						alert('已成功修改密码');
					} else if (json["state"] == "no") {
						alert('密码输入错误');
					}
				});
			} catch (e) {
				RssCode.alert(e);
			}
		});
		//         $("#accountsoft .normalbutton").click(function () {
		//
		//             
		//        })
	})
})

//统计
$("[suggesttype]").off("click").click(function() {
	var lwstatee = $(this).attr("suggesttype"); //建议议案
	$("#suggesttype nav>a").off("click").click(function() {
		$(this).addClass("sel").siblings().removeClass("sel");
		var ind = $(this).index();
		$("#suggesttype article>div").eq(ind).show().siblings("div").hide();
		var memutype = $(this).attr("memutype"); //统计类型
		var sessionide = "";
		optionajax(memutype, lwstatee, sessionide);
	})
	location.href = "#suggesttype"
	optionajax("1", lwstatee, "");
	if (lwstatee == "1") {
		$("#suggesttype header h1").text("建议统计");
		$("#suggesttype article nav a").eq(0).text("建议状态");
		$("#suggesttype article nav a").eq(1).text("代表团建议");
	} else {
		$("#suggesttype header h1").text("议案统计");
		$("#suggesttype article nav a").eq(0).text("议案状态");
		$("#suggesttype article nav a").eq(1).text("代表团议案");
	}
})
//$("#suggesttype").load(function () {

//    $("#suggesttype nav>a").eq(0).click();
//    var myChart1 = echarts.init(document.getElementById('bzt'));
//    var myChart2 = echarts.init(document.getElementById('zxt'));
//    var myChart3 = echarts.init(document.getElementById('ldt'));
//    var myChart4 = echarts.init(document.getElementById('zzt'));
//    //    var data = genData(50);
//    option = {
//        tooltip: {
//            trigger: 'item',
//            formatter: "{a} <br/>{b}: {c} ({d}%)"
//        },
//        //    legend: {
//        //        orient: 'vertical',
//        //        x: 'left',
//        //        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
//        //    },
//        series: [{
//                name: '访问来源',
//                type: 'pie',
//                radius: ['50%', '70%'],
//                avoidLabelOverlap: false,
//                label: {
//                    normal: {
//                        show: false,
//                        position: 'center'
//                    },
//                    emphasis: {
//                        show: true,
//                        textStyle: {
//                            fontSize: '30',
//                            fontWeight: 'bold'
//                        }
//                    }
//                },
//                labelLine: {
//                    normal: {
//                        show: false
//                    }
//                },
//                data: [{
//                        value: 335,
//                        name: '1'
//                    },
//                    {
//                        value: 310,
//                        name: '2'
//                    },
//                    {
//                        value: 234,
//                        name: '3'
//                    },
//                    {
//                        value: 135,
//                        name: '4'
//                    },
//                    {
//                        value: 1548,
//                        name: '5'
//                    }
//                ]
//            }]
//    };
//    myChart1.setOption(option);
//
//    option = {
//        xAxis: {
//            type: 'category',
//            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
//        },
//        yAxis: {
//            type: 'value'
//        },
//        series: [{
//                data: [820, 932, 901, 934, 1290, 1330, 1320],
//                type: 'line'
//            }]
//    };
//    myChart2.setOption(option);
//    option = {
//        //    title: {
//        //        text: '基础雷达图'
//        //    },
//        tooltip: {},
//        //    legend: {
//        //        data: ['预算分配（Allocated Budget）', '实际开销（Actual Spending）']
//        //    },
//        radar: {
//            // shape: 'circle',
//            name: {
//                textStyle: {
//                    color: '#fff',
//                    backgroundColor: '#999',
//                    borderRadius: 3,
//                    padding: [3, 5]
//                }
//            },
//            indicator: [{
//                    name: '1',
//                    max: 6500
//                },
//                {
//                    name: '2',
//                    max: 16000
//                },
//                {
//                    name: '3',
//                    max: 30000
//                },
//                {
//                    name: '4',
//                    max: 38000
//                },
//                {
//                    name: '5',
//                    max: 52000
//                },
//                {
//                    name: '6',
//                    max: 25000
//                }
//            ]
//        },
//        series: [{
//                //        name: '预算 vs 开销（Budget vs spending）',
//                type: 'radar',
//                // areaStyle: {normal: {}},
//                data: [{
//                        value: [4300, 10000, 28000, 35000, 50000, 19000],
//                        name: '预算分配（Allocated Budget）'
//                    },
//                    {
//                        value: [5000, 14000, 28000, 31000, 42000, 21000],
//                        name: '实际开销（Actual Spending）'
//                    }
//                ]
//            }]
//    };
//    myChart3.setOption(option);
//    option = {
//        xAxis: {
//            type: 'category',
//            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
//        },
//        yAxis: {
//            type: 'value'
//        },
//        series: [{
//                data: [120, 200, 150, 80, 70, 110, 130],
//                type: 'bar'
//            }]
//    };
//    myChart4.setOption(option);
//})

//登录页面载入loginpage//loginform相当于系统启动时..不怎么起作用
$("#loginpage").load(function() {
	//alert("111");
})
//alert("启动001。。。");
//自动检测新版本，系统启动时
function autocheckversion() {
	RssApi.Table.List("soft_grade").setLoading(true).keyvalue({
		"pagesize": "1"
	}).getJson(function(json) {
		if (nowedition != json[0].version) {
			RssDialog.onConfig = function() {
				// JsAdapter.Push({
				//     "adapter": "SoftUpdate",
				//     "url": RssApp.UpHost + json[0].url
				// }).Submit();
				update_ksd(RssApp.UpHost + json[0].url); //更新函数,在下面//Added by Jackie
			}
			RssDialog.SetTitle("发现新版本").setConfig("立即升级").AddHtml(json[0].remark).Popup();
		}
	})

}
autocheckversion();

//检查更新//手动检测
$("#update").load(function() {
	RssApi.Table.List("soft_grade").setLoading(true).keyvalue({
		"pagesize": "1"
	}).getJson(function(json) {
		$("#nowedition").text("当前版本：v" + nowedition)
		$("#newedition").text("最新版本：v" + json[0].version)
		if (nowedition != json[0].version) {
			$("#update article").find("a").text("点击获取新版本");
		} else {
			$("#update article").find("a").text("无需更新");
		}
		$("#update article").find("a").click(function() {
			if ($(this).text() == "点击获取新版本") {
				RssDialog.onConfig = function() {
					// JsAdapter.Push({
					//     "adapter": "SoftUpdate",
					//     "url": RssApp.UpHost + json[0].url
					// }).Submit();
					update_ksd(RssApp.UpHost + json[0].url); //更新函数,在下面//Added by Jackie
				}
				RssDialog.SetTitle("发现新版本").setConfig("立即升级").AddHtml(json[0].remark).Popup();
			}
		})
	})
})

$("[href='#mysuggest']").click(function() {
	mysuggestnav = "1";
})
$("[href='#mysuggestYA']").click(function() {
	mysuggestnavYA = "1";
})
$("[href='#myHD']").click(function() {
	myHDy = "1";
})

$(".hisbacka").click(function() {
	location.href = "#suggest";
});


//点击加载更多
$('.nodata').on("click", function() {
	var t = $(this);
	faqsajax.nextpage().lastpage(function() {
		t.hide();
	}).getJson();
});

var pingji = function(ind, name) {
	$("[name ='" + name + "']").find("a").each(function() {
		if ($(this).index() <= ind - 1) {
			$(this).addClass("sel")
		} else {
			$(this).removeClass("sel")
		}
	})
}

//ks.update_ksd==========//有进度条
function update_ksd(url) {
	var options = {
		method: "GET"
	};
	dtask = plus.downloader.createDownload(url, options);
	dtask.addEventListener("statechanged", function(task, status) {
		switch (task.state) {
			case 1: // 开始  
				break;
			case 2: //已连接到服务器  
				break;
			case 3: // 已接收到数据  
				var current = parseInt(100 * task.downloadedSize / task.totalSize);
				//RssProgBar.prototype.Progress(100,current);
				// RssProgBar.prototype.Html();
				var pg = document.getElementById('pg');
				//setInterval(function(e){				
				//   if(pg.value!=100) pg.value=current;//pg.value++;
				//   else pg.value=0;				
				//},100);
				//console.log(current);
				break;
			case 4: // 下载完成  plus.notification.compProgressNotification("下载完成");//插件调用  
				plus.runtime.install(plus.io.convertLocalFileSystemURL(task.filename), //安装APP  
					{
						force: true
					},
					function() {

					},
					function() {
						mui.toast('安装失败');
					});
				break;
		}
	});
	dtask.start();
}

//ks.update_ksd==========
function update_ksd_old(url) {
	//console.log(url);
	//创建下载管理对象
	//alert("rrr:"+url);
	//plus.nativeUI.showWaiting("下载wgt文件..."+url);
	var dtask = plus.downloader.createDownload(url, {}, function(d, status) {
		// 下载完成
		//alert("status:"+status);
		if (status == 200) { //下载成功后的回调函数
			plus.nativeUI.toast("下载成功，准备安装");
			//安装程序，第一个参数是路径，默认的下载路径在_downloads里面
			// plus.runtime.install(url,{},function(){
			//     plus.nativeUI.toast('安装成功');},function(){plus.nativeUI.toast('安装失败');});
			// plus.nativeUI.closeWaiting();
			//下载成功,d.filename是文件在保存在本地的相对路径，使用下面的API可转为平台绝对路径
			//var fileSaveUrl = plus.io.convertLocalFileSystemURL(d.filename);
			//plus.nativeUI.toast( "绝对路径看d.filename:::" + d.filename );
			//plus.nativeUI.toast( "绝对路径看fileSaveUrl:::" + fileSaveUrl );
			plus.runtime.openFile(d.filename); //选择软件打开文件，页就安装了

		} else {
			alert("下载失败 " + status);
		}
	});
	//alert("ok");
	//dtask.addEventListener( "statechanged", onStateChanged, false );
	dtask.start(); //开始下载任务
}
