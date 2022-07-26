
		var upload1, upload2;

		window.onload = function() {
			upload1 = new SWFUpload({
				
				
				// Backend Settings   上传文件访问的后台地址
				upload_url: "FileUploadServlet?saveDataId=saveDataId1",
				//post_params: {"PHPSESSID" : "<?php echo session_id(); ?>"},

				// File Upload Settings
				file_size_limit : "3600 MB",	// 100MB  文件上传大小，（这里不管用）
				file_types : "*.*",  //限制上传文件类型   ”*.jpg;*.jpeg;*.gif;*.png;*.bmp;”
				file_types_description : "All Files",  //文件类型描述
				file_upload_limit : 10,//允许同时上传文件的个数
				file_queue_limit : 0,  //允许队列存在的文件数量，默认值为0，即不限制

				// Event Handler Settings (all my handlers are in the Handler.js file)
				swfupload_preload_handler : preLoad,  //如果falsh版本不够深
				swfupload_load_failed_handler : loadFailed,
				file_dialog_start_handler : fileDialogStart,//文件选择对话框显示之前触发。只能同时存在一个文件对话框。
				file_queued_handler : fileQueued,//当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
				file_queue_error_handler : fileQueueError, //当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件
				file_dialog_complete_handler : fileDialogComplete,  //设置swf监听fileDialogComplete 事件  选择好上传的文件就自动开始上传
				upload_start_handler : uploadStart, //在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作
				upload_progress_handler : uploadProgress, //该函数用于侦听文件选择对话框关闭的事件，
				upload_error_handler : uploadError,//上传出错
				upload_success_handler : uploadSuccess,//上传成功
				upload_complete_handler : uploadComplete,//上传完成，无论上传过程中出错还是上传成功，都会触发该事件，并且在那两个事件后被触发

				// Button Settings
				button_image_url : "./scripts/swfupload/images/XPButtonUploadText_61x22.png",
				button_placeholder_id : "spanButtonPlaceholder1",//上传按钮占位符的id
				button_width: 61,  //按钮宽度
				button_height: 22,//按钮高度
				//button_image_url: "http://labs.goodje.com/swfu/swfu_bgimg.jpg",//按钮背景图片路径
//				button_text_style: ‘.btn-txt{color: #666666;font-size:20px;font-family:"微软雅黑"}‘,
//				button_text_top_padding: 6,
//				button_text_left_padding: 65,

				
				// Flash Settings
				//swfupload压缩包解压后swfupload.swf的url
				flash_url : "./scripts/swfupload/swfupload.swf",
				flash9_url : "./scripts/swfupload/swfupload_fp9.swf",
			
                //一些自定义的信息，默认值为一个空对象{}
				custom_settings : { 
					progressTarget : "fsUploadProgress1",
					cancelButtonId : "btnCancel1"
				},
				
				debug:false,   //debug模式，可以在页面看到详细信息debug:false,   //debug模式，可以在页面看到详细信息
			});
			upload2 = new SWFUpload({
				// Backend Settings
				upload_url: "FileUploadServlet?saveDataId=saveDataId2",
				//post_params: {"PHPSESSID" : "<?php echo session_id(); ?>"},

				// File Upload Settings
				file_size_limit : "200",	// 200 kb
				file_types : "*.jpg;*.gif;*.png",
				file_types_description : "Image Files",
				file_upload_limit : "10",
				file_queue_limit : "5",

				// Event Handler Settings (all my handlers are in the Handler.js file)
				swfupload_preload_handler : preLoad,
				swfupload_load_failed_handler : loadFailed,
				file_dialog_start_handler : fileDialogStart,
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,

				// Button Settings
				button_image_url : "./scripts/swfupload/images/XPButtonUploadText_61x22.png",
				button_placeholder_id : "spanButtonPlaceholder2",
				button_width: 61,
				button_height: 22,
				
				flash_url : "./scripts/swfupload/swfupload.swf",
				flash9_url : "./scripts/swfupload/swfupload_fp9.swf",

				swfupload_element_id : "flashUI2",		// Setting from graceful degradation plugin
				degraded_element_id : "degradedUI2",	// Setting from graceful degradation plugin

				custom_settings : {
					progressTarget : "fsUploadProgress2",
					cancelButtonId : "btnCancel2"
				},

				// Debug Settings
				debug: false
			});
	     }
