
/* This is an example of how to cancel all the files queued up.  It's made somewhat generic.  Just pass your SWFUpload
object in to this method and it loops through cancelling the uploads. */
/*
 * 当点击Cancel Uploads 触发此方法，取消上传
 */
function cancelQueue(instance) {
	document.getElementById(instance.customSettings.cancelButtonId).disabled = true;
	instance.stopUpload();
	var stats;
	
	do {
		stats = instance.getStats();
		instance.cancelUpload();
	} while (stats.files_queued !== 0);
	
}

/* **********************
   Event Handlers
   These are my custom event handlers to make my
   web application behave the way I went when SWFUpload
   completes different tasks.  These aren't part of the SWFUpload
   package.  They are part of my application.  Without these none
   of the actions SWFUpload makes will show up in my application.
   ********************** */
function preLoad() {
	if (!this.support.loading) {
		alert("您需要安装Flash Player9.028或以上版本才能使用上传!");
		return false;
	}
}
function loadFailed() {
	alert("加载文件失败!");
}

function fileDialogStart() {
	/* I don't need to do anything here */
}

/*
 * 当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）
 */
function fileQueued(file) {
	try {
		// You might include code here that prevents the form from being submitted while the upload is in
		// progress.  Then you'll want to put code in the Queue Complete handler to "unblock" the form
		var progress = new FileProgress(file, this.customSettings.progressTarget); //file是选择的文件，progressTarget是显示区域div的id
		progress.setStatus("等待...");
		progress.toggleCancel(true, this);

	} catch (ex) {
		this.debug(ex);
	}

}

function fileQueueError(file, errorCode, message) {
	try {
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			alert("您添加的文件数量太多了。\n" + (message === 0 ? "您已达到上传限制。" : "您上传 " + (message > 1 ? "不能超过 " + message + " 个文件。" : "一个文件。")));
			return;
		}

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			progress.setStatus("文件太大了。");
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			progress.setStatus("无法上传零字节的文件。");
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			progress.setStatus("无效的文件类型。");
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			alert("您添加的文件数量太多了。  " +  (message > 1 ? "您仅能添加 " +  message + " 个文件。" : "您不能添加更多的文件。"));
			break;
		default:
			if (file !== null) {
				progress.setStatus("Unhandled Error");
			}
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

/*
 * swf监听事件，
 * 用户选择好文件后就自动开始上传
 */
function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (this.getStats().files_queued > 0) {
			//将 Cancel Uploads 按钮设置成可点击 disabled =false 
			document.getElementById(this.customSettings.cancelButtonId).disabled = false;
		}
		var postobj = { "submeetingid":document.getElementById("meetingidv").value, "cmid":document.getElementById("cmid").value};
        this.setPostParams(postobj);
		/* I want auto start and I can do that here */
		this.startUpload();
	} catch (ex)  {
        this.debug(ex);
	}
}

function uploadStart(file) {
	try {
		/* I don't want to do any file validation or anything,  I'll just update the UI and return true to indicate that the upload should start */
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus("正在上传...");
		progress.toggleCancel(true,this);
	}
	catch (ex) {
	}
	
	return true;
}

/*
 * 该函数用于侦听文件选择对话框关闭的事件，如果用户选择并且成功加入上传队列的文件数大于0即立即开始上传，另外禁用上传按钮，以防出错。
 */
function uploadProgress(file, bytesLoaded, bytesTotal) {//分别是当前上传的文件对象，当前以上传大小（单位：字节），当前上传的文件总大小（单位：字节）。
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);//上传进度的百分比%
		var daxiao = Math.ceil(bytesTotal / 1024 / 1024);
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setProgress(percent);
		progress.setStatus("总大小"+daxiao+"MB,已经上传"+percent+"%");
	} catch (ex) {
		this.debug(ex);
	}
}

/*
 * 上传成功时触发,然后动态给 红色差号添加 onclick事件
 */
function uploadSuccess(file, serverData) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);//这怎么一直返回一。。。。纠结
		//progress.setComplete();
		progress.setStatus("上传完成");
		//alert(serverData);
		var jsonObj = JSON.parse(serverData);
		var _filePath = jsonObj.filenameindisk;
		if(_filePath==undefined){
			progress.setStatus(jsonObj.error);
			progress.setError();
			//progress.toggleCancel(true,this);
		}else{
			var saveData = jsonObj.saveDataId;
			//alert(saveData);
			//设置下载删除
			progress.setDownDeleteLink(_filePath,saveData,jsonObj.ID);
			//progress.setFileType(jsonObj.ID,saveData);
			//progress.setCloseWin();
			//传值给页面
			var oldData = $("#"+saveData+"").val();
			var newData;
			if(oldData!=""){
				newData = oldData+"|"+serverData;	
			}else{
				newData = serverData;
			}
			
			$("#"+saveData+"").val(newData);
			
		}
		
		
	} catch (ex) {
		this.debug(ex);
	}
}

/*
 * 上传完成，无论上传过程中出错还是上传成功，都会触发该事件，并且在那两个事件后被触发
 * 
 * **在window平台下，那么服务端的处理程序在处理完文件存储以后，必须返回一个非空值，否则uploadError/uploadSuccess事件都不会被触发，随后的uploadComplete事件也无法触发
 * 
 */
function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued === 0) {
			document.getElementById(this.customSettings.cancelButtonId).disabled = true;
		} else {	
			this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}

}
/*
 * 上传出错时触发
 */
function uploadError(file, errorCode, message) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus("上传错误: " + message);
			this.debug("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
			progress.setStatus("Configuration Error");
			this.debug("Error Code: No backend file, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus("上传失败");
			this.debug("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus("Server (IO) Error");
			this.debug("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus("安全性错误");
			this.debug("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			progress.setStatus("超过上传限制");
			this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
			progress.setStatus("文件没有找到");
			this.debug("Error Code: The file was not found, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			progress.setStatus("验证失败，上传跳过");
			this.debug("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			if (this.getStats().files_queued === 0) {
				document.getElementById(this.customSettings.cancelButtonId).disabled = true;
			}
			progress.setStatus("取消");
			progress.setCancelled();
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus("停止");
			break;
		default:
			progress.setStatus("未知错误: " + error_code);
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}