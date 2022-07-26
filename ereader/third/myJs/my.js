function getXmlHttpRequest() {
	var xhr = null;
	if ((typeof XMLHttpRequest) != 'undefined') {
		xhr = new XMLHttpRequest();
	} else {
		xhr = new ActiveXObject('Microsoft.XMLHttp');
	}
	return xhr;
}

function getBroswerType() {
	var browserType = "msie";
	if ($.browser.msie) {
		browserType = "msie"
	} else if ($.browser.safari) {
		browserType = "safari"
	} else if ($.browser.mozilla) {
		browserType = "mozilla"
	} else if ($.browser.opera) {
		browserType = "opera"
	} else {
		browserType = "msie"
	}
	return browserType;
}
$(function() {
	$.fn.tab = function(options) {
		var defaults = {
			queryType : "#queryType",
			currentClass : "current",
			tabNav : "#head>li",
			// tabContent:"#content>td",
			eventType : "click"
		};
		var options = $.extend(defaults, options);
		this.each(function() {
			var _this = $(this);
			_this.find(options.tabNav).bind(
					options.eventType,
					function() {
						$(this).addClass(options.currentClass).siblings()
								.removeClass(options.currentClass)
						//alert($(this).html());
						//$('#showTitle').html($(this).html());
					});
		});
		return this;
	}
	$.fn.suggest = function(options) {
		var defaults = {
			param1 : "#queryType",
			wordinput : "#word",
			autoNode : "#auto",
			word : "word",
			// words:{"word":$('#word').val()},
			action : "admin_suggest.action"
		};
		var options = $.extend(defaults, options);
		var timeoutId;
		var highligthindex = -1;
		var wordInit;
		var wordinputOffset = $(options.wordinput).offset();
		// alert(wordinputOffset.left+","+wordinputOffset.top);
		$(options.autoNode).hide().css('border', '3px solid #FFF').css('left',
				wordinputOffset.left).css('background', 'white').css('top',
				wordinputOffset.top + $(options.wordinput).height() + 6).css(
				'position', 'absolute').width($(options.wordinput).width() + 4);
		$(options.wordinput).keyup(function(event) {
			var wordText = $(this).val();
			// $(this).css('color','red');
				var param = $(options.param1).val();
				var keyCode = event.which;
				if (wordText != "") {
					if (keyCode >= 65 && keyCode <= 90 || keyCode == 8
							|| keyCode == 46
							|| (keyCode >= 48 && keyCode <= 57)
							|| keyCode == 32) {
						clearInterval(timeoutId);
						timeoutId = setTimeout(function() {
							$.post(options.action, {
								"word" : wordText,
								"param" : param
							}, function(data) {
								var xml;
								if (data) {
									xml = getIEXML(data);
									var jsonStr = $(xml).find(options.word);
									// alert(jsonStr);
									$(options.autoNode).html("");
									// for(var i=0;i<jsonStr.length;i++){
									jsonStr.each(function(i) {

										var newDivNode = $('<div>').attr("id",
												i);
										var wordNode = $(this);

										newDivNode.html(wordNode.text())
												.appendTo($(options.autoNode));
										newDivNode.mouseover(function() {
											$(this)
													.css('background',
															'#c091e4');
										});
										newDivNode.mouseout(function() {
											$(this).css('background', 'white');
										});
										newDivNode
												.click(function() {
													var comText = $(this)
															.text();
													$(options.wordinput).val(
															comText);
													hideAutoNode();
													$(options.wordinput).get(0)
															.focus();
												});
									});

									// }
									$(options.wordinput).blur(function() {
										setTimeout(function() {
											hideAutoNode()
										}, 500);
										// // hideAutoNode();
										});
									if (jsonStr.length > 0) {
										$(options.autoNode).show().css(
												'border', '1px solid #e4dbeb');
									} else {
										hideAutoNode();
									}
								}
							}), "xml"
						}, 500)
						wordInit = $(this).val();
						// alert("wordInit:"+wordInit);
					} else if (keyCode == 38 || keyCode == 40) {
						// alert("wordInit:"+wordInit);

						var autoNodes = $(options.autoNode).children();
						if (keyCode == 38) {

							if (highligthindex != -1) {

								autoNodes.eq(highligthindex).css('background',
										'white');
								highligthindex--;
							} else {
								$(options.wordinput).val(wordInit);
								highligthindex = autoNodes.length - 1;
							}
							getComtext(highligthindex, wordInit);

						} else if (keyCode == 40) {
							if (highligthindex != autoNodes.length - 1) {
								autoNodes.eq(highligthindex).css('background',
										'white');
								highligthindex++;
							} else {
								autoNodes.eq(highligthindex).css('background',
										'white');
								highligthindex = -1;
							}
							getComtext(highligthindex, wordInit);
						}

					} else if (keyCode == 13) {
						if (highligthindex != -1) {
							highligthindex = -1;
						} else {
							$(options.wordinput).get(0).blur();
						}

						$(options.autoNode).hide();
					}
				} else {
					$(options.autoNode).hide();
				}
			});
		function getComtext(highligthindex, wordInit) {
			var comText = $(options.autoNode).children().eq(highligthindex)
					.text();
			if (highligthindex == -1) {
				$(options.wordinput).val(wordInit);
			} else {
				$(options.wordinput).val(comText);
			}
			if (highligthindex != -1) {
				$(options.autoNode).children().eq(highligthindex).css(
						'background', '#c091e4');
			}
		}
		function hideAutoNode() {
			$(options.autoNode).hide();
			highligthindex = -1;

		}
	}

	function getIEXML(data) {
		var xml;
		// alert("ok");
		if (($.browser.msie)) {
			xml = new ActiveXObject("Microsoft.XMLDOM");
			xml.async = false;
			xml.loadXML(data);
		} else {
			xml = data;
			// alert("ok");
		}
		return xml;
	}
	$.fn.detail = function(options) {
		// alert("OK");
		var defaults = {
			table : "#liucheng",
			usernames : "#usernames",
			title : "title",
			details : "#details",
			action : "handleTask_getCheckerDetail.action"
		};
		var options = $.extend(defaults, options);
		$(options.table).find(options.usernames).each(function() {
			var username = $(this).attr(options.title);
			// alert("username:"+username);
				var timeId;
				// alert($(this));
				$(this).hover(
						function(e) {
							timeId = setTimeout(function() {
								// alert(options.action);
									$.post(options.action, {
										"username" : username
									},
											function(data) {
												if (data) {
													var message = eval("("
															+ data + ")");
													$('#name').text(
															message.name);
													$('#company').text(
															message.company);
													$('#bumen').text(
															message.bumen);
													$('#phone').text(
															message.phone);
													$('#jobduty').text(
															message.jobduty);
													// alert("T:"+$('#jobduty').text());
											var windowobj = $(window);
											var left = e.clientX + 20
													+ windowobj.scrollLeft();
											var top = e.clientY - 10
													+ windowobj.scrollTop();
											// alert("left:"+left);
											// alert("top:"+top);
											// alert($('#details').show());
											$(options.details)
													.css('left', left).css(
															'top', top).css(
															'background',
															'white');
											$(options.details).show();
										}
									});
								}, 50);

						}, function() {
							clearTimeout(timeId);
							$(options.details).hide();
						}).css('cursor', "pointer");
			});
	};

	$.fn.checkAll = function(options) {
		var defaults = {
			// 全选复选框ID
			selAll : "#selAll",
			// 操作按钮
			modifyAll : "#deleteAlls",
			// 所操作的表格
			table : "#table",
			// 操作的action
			action : "admin_deleteAlls.action",
			// 传递的参数
			idSubmit : "id"
		}
		var options = $.extend(defaults, options);
		$(options.selAll).click(
				function() {
					var checknodes=$(this).parent().parent().parent().siblings().find(':checkbox');
							
					var checkstatus=$(this).attr('checked');
					if(checkstatus=='checked'){
						checknodes.attr('checked', $(this).attr('checked'));
					}else{
						checknodes.removeAttr("checked");
					}
				})
		$(options.modifyAll).click(
				function() {
					//var r = window.confirm("确定执行批量操作吗");
					$.messager.confirm("确认", "确定执行批量操作吗", function (r) {
					if (!r)
						return;
					var tt = $(options.table).find(
							'input[value][type=checkbox]:checked').not(
							$(options.selAll)[0]);
					var sel = tt.length;
					// alert("sel:"+sel);
					if (!sel) {
						//alert("请选择操作数据");
						$.messager.alert('提示','请选择操作数据',"info");
						return;
					}
					var ids = tt.map(function() {
						return $(this).val();
					}).get().join(',');
					 //alert("ids:"+ids);
					//var id = options.idSubmit;
					//alert("id:"+id);
					$.post(options.action, {
						"fileids": ids
					}, function(data) {
						if (data) {
							// alert("data"+data);
							var json = eval("(" + data + ")");
							//alert(json.state);
							if (json.state) {
								setTimeout(toPage($('#page').val()), 1500);
							} else {
								//alert("批量修改失败");
								$.messager.alert('提示','批量修改失败',"info");
							}
						}
					});
					});	
				});
	};

	// 执行批量修改操作
	$.fn.checkAll2 = function(options) {
		var defaults = {
			selAll : "#selAll",
			modifyAll : "#modifyAll",
			table : "#datalist",
			action : "admin_modifyAlls.action"
		}
		var options = $.extend(defaults, options);
		$(options.selAll).click(
				function() {
					$(this).parent().parent().siblings().find(':checkbox')
							.attr('checked', $(this).attr('checked'));
				})
		$(options.modifyAll).click(
				function() {
					var r = window.confirm("确定执行批量操作吗");
					if (!r)
						return;
					var tt = $(options.table).find(
							'input[value][type=checkbox]:checked');
					var sel = tt.length;
					// alert("sel:"+sel);
					if (!sel) {
						alert("请选择操作数据");
						return;
					}
					var ids = tt.map(function() {
						return $(this).val();
					}).get().join(',');
					// alert("ids:"+ids);
					var type = $('#type').val();
					$.post(options.action, {
						"ids" : ids,
						"type" : type
					}, function(data) {
						if (data) {
							// alert("data"+data);
							var result = eval("(" + data + ")");
							if (result[0].pass == true) {
								alert("批量修改成功");
								setTimeout(toPage($('#page').val()), 1500);
							} else {
								alert("批量修改失败");
							}
						}
					});
				});
	};
	$.fn.tableCss = function() {
		var defaults = {
			selAll : "#selAll",
			modifyAll : "#modifyAll",
			table : "#table1",
			action : "jquery_checkAll.action"
		}

		var options = $.extend(defaults, options);
		// this.css('font-size','8px');
		this.find('tr').each(function() {
			// $(this).find('input[type=text]').css('size','10');
				$(this).css('font-size', '12px');
				$(this).find('td:even').width('110px').css('background',
						'#BFD6FC').css('cursor', 'pointer').css('text-align',
						'left');
				$(this).find('textarea').width('200px').height('80px');
				// .css('style','background:#BFD6FC;cursor:pointer;text-align:left;width');
			});

	};
	$.fn.tips = function(options) {
		var defaults = {
			width : "200px",
			mytips : "#tips",
			// info:"审批意见",
			type : "input[type=hidden]",
			table : "#liucheng"
		};
		var options = $.extend(defaults, options);
		// var mytip=$(options.mytips);
		// mytips.show();
		var windowobj = $(window);
		// alert("ok");
		// var
		// tab=$('<div>').attr("id","newDiv").css('position','absolute').width(options.width)
		// .css('border','1px solid
		// gray').css('background-color','#fff').appendTo(options.mytips).hide();
		$(options.table).find(options.mytips).each(
				function() {
					var nowTips = $(this);
					var tab = $('<div>').attr("id", "newDivPlu").css(
							'position', 'absolute').width(options.width).css(
							'border', '1px solid gray').css('background-color',
							'#fff').css('padding', '6px 6px 6px 12px').css(
							'text-align', 'left').appendTo(options.mytips)
							.hide();

					// alert(nowTips.text());
					nowTips.mousemove(function(e) {
						// alert("OK");
							$('#newDivPlu').html("");
							if (nowTips.children(options.type).length > 0) {
								$('#newDivPlu').html(
										nowTips.children(options.type).val());
								// alert("nowTips.children('input[type=hidden]').val():"+nowTips.children('input[type=hidden]').val());
							} else {
								$('#newDivPlu').html(nowTips.text());
								if (nowTips.text() == ""
										|| nowTips.text() == null) {
									$('#newDivPlu').hide();
								}
							}
							var left = windowobj.scrollLeft() + e.clientX + 20;
							var top = windowobj.scrollTop() + e.clientY;
							$('#newDivPlu').show().css('left', left).css('top',
									top);
						});
					nowTips.mouseout(function() {
						// alert("ok");
							$('#newDivPlu').hide();
						});
				});

	};
	// 根据条件查询是否存在
	$.fn.checkExist = function(options) {
		var defaults = {
			param1 : "#company",
			param2 : "#deptName",
			// 返回的结果
			results : "#deptId",
			// paramname1:"upperdeptname",
			// paramname2:"deptName",
			// info:"审批意见",
			info : "公司或部门不存在",
			infoId : "#companyMsg",
			action : "admin_checkExist.action",
			eventType : "blur"
		};
		// 传递参数1
		var options = $.extend(defaults, options);
		$(options.param2).bind(options.eventType, function() {
			var paramV1 = options.paramname1;
			// 传递参数2
				var paramV2 = options.paramname2;
				var company = $(options.param1).val();
				var deptName = $(options.param2).val();
				// alert("OK");
				$.post(options.action, {
					"upperdeptname" : company,
					"deptName" : deptName
				}, function(data) {
					var json = eval("(" + data + ")");
					if (json.pass == "true") {
						//返回结果的标签类型

						if (json.departmentID != null) {
							$(options.results).val(json.departmentID);
						}
						$(options.infoId).text("");
					} else {
						$(options.infoId).css('color', 'red')
								.text(options.info);
					}

				});
			});

	};

	//短信催办
	$.fn.sendMsM = function(options) {
		var defaults = {
			table : "#dataList",
			hrefOn : "#sms",
			eventType : "click",
			msmCheckUser : "#msmCheckUser",
			message : "短信发送",
			action : "handleTask_sendMsM.action"
		};

		var options = $.extend(defaults, options);
		//alert("ok");
		$(options.table).find(options.hrefOn).each(function() {
			//alert("ok1");
				var aValue = $(this).next('input[type=hidden]').val();
				//alert("aValue:"+aValue);
				var sms = $(this);
				sms.bind(options.eventType, function() {
					//				sms.html("发送短信中...");
						//				sms.attr("disabled", "disabled");
						sms.hide();
						$.post(options.action, {
							"worknos" : aValue
						}, function(data) {
							var json = eval("(" + data + ")");
							if (json.pass) {
								alert(options.message + "成功");
								sms.show();
							} else {
								alert(options.message + "失败");
								sms.show();
							}
						});
					});

			});

	};
});