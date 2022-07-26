/*
	A simple class for displaying file information and progress
	Note: This is a demonstration only and not part of SWFUpload.
	Note: Some have had problems adapting this class in IE7. It may not be suitable for your application.
*/

// Constructor
// file is a SWFUpload file object
// targetID is the HTML element id attribute that the FileProgress HTML structure will be added to.
// Instantiating a new FileProgress object with an existing file will reuse/update the existing DOM elements
function formatBytes(bytes) {
	var s = ['Byte', 'KB', 'MB', 'GB', 'TB', 'PB'];
	var e = Math.floor(Math.log(bytes)/Math.log(1024));
	return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
}
function FileProgress(file, targetID) {
	this.fileProgressID = file.id;
	this.opacity = 100;
	this.height = 0;
	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement("div");
		this.fileProgressWrapper.className = "progressWrapper";
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement("div");
		this.fileProgressElement.className = "progressContainer";

		//红色差号连接
		var progressCancel = document.createElement("a");
		progressCancel.className = "progressCancel";
		progressCancel.href = "#";
		//progressCancel.style.visibility = "hidden";
		progressCancel.appendChild(document.createTextNode(" "));

		
		var progressText = document.createElement("div");
		progressText.className = "progressName";
		
		var downloadLink = document.createElement("a");
		downloadLink.href = "#";
		downloadLink.target='_blank';
		var fileName = file.name;
		if(fileName.length>30){
			fileName = file.name.substring(0,30)+"...";
		}
		downloadLink.appendChild(document.createTextNode(fileName));
		//添加上传的文件名  可点击下载
		progressText.appendChild(downloadLink);
		//var fileSize = file.size;//文件大小
		//var fileSize = formatBytes(file.size);
		//var KB = parseInt(fileSize/1024);//KB
		/*if(KB==0){
			var temp = fileSize%1024;
			if(temp>99){
				KB = "0."+temp;
			}
			if(temp>9&&temp<100){
				KB = "0.0"+temp;
			}
			if(temp<10){
				KB = "0.00"+temp;
			}
			
		}*/
		//var MB = parseInt(KB/1024);//MB
		//var l = MB%KB;
		//alert(l);
		//var fileLength = MB;
		//var GB = parseInt(MB/1024);//GB
		
		
		//显示上传文件的大小
		//progressText.appendChild(document.createTextNode(" ("+fileSize+")"));
		var sel=document.createElement("select");
		sel.options.length=2;
		sel.options[0].text = "正式文件"; 
		sel.options[0].value = "1";
		sel.options[1].text = "延伸阅读"; 
		sel.options[1].value = "2";
		sel.options[0].selected="selected"
		var span = document.createElement("span");
		//span.className = "zhuren";
		span.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		progressText.appendChild(span);
		progressText.appendChild(sel);
		var progressBar = document.createElement("div");
		progressBar.className = "progressBarInProgress";
		
		var progressStatus = document.createElement("div");
		progressStatus.className = "progressBarStatus";
		progressStatus.innerHTML = "&nbsp;";

		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);//[2]
		this.fileProgressElement.appendChild(progressBar);   //[3]

		this.fileProgressWrapper.appendChild(this.fileProgressElement);

		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
	} else {
		this.fileProgressElement = this.fileProgressWrapper.firstChild;
		this.reset();
	}

	this.height = this.fileProgressWrapper.offsetHeight;
	this.setTimer(null);


}

/**
 * 显示文件大小
 */
FileProgress.prototype.setTimer = function (timer) {
	this.fileProgressElement["FP_TIMER"] = timer;
};
FileProgress.prototype.getTimer = function (timer) {
	return this.fileProgressElement["FP_TIMER"] || null;
};

/**
 * 重置
 */
FileProgress.prototype.reset = function () {
	this.fileProgressElement.className = "progressContainer";

	this.fileProgressElement.childNodes[2].innerHTML = "&nbsp;";
	this.fileProgressElement.childNodes[2].className = "progressBarStatus";
	
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = "0%";
	
	this.appear();	
};

/*
 * 返回已经上传的百分比
 */
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = "progressContainer green";
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = percentage + "%";

	this.appear();	
};
FileProgress.prototype.setComplete = function () {
	this.fileProgressElement.className = "progressContainer blue";
	this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	this.fileProgressElement.childNodes[3].style.width = "";

	var oSelf = this;
	//oSelf.disappear();
	this.setTimer(setTimeout(function () {
		oSelf.disappear();
	}, 10000));
};
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

	var oSelf = this;
	this.setTimer(setTimeout(function () {
		oSelf.disappear();
	}, 5000));
};
/*
 * 上传中 点击差号触发此方法
 */
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";
	this.disappear();
	/*var oSelf = this;
	this.setTimer(setTimeout(function () {
		oSelf.disappear();
	}, 2000));*/
};
/*
 * 显示错误信息
 */
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.childNodes[2].innerHTML = status;
};
FileProgress.prototype.setCloseWin = function () {
	
};
Array.prototype.remove=function(dx)
　{
　　if(isNaN(dx)||dx>this.length){return false;}
　　for(var i=0,n=0;i<this.length;i++)
　　{
　　　　if(this[i]!=this[dx])
　　　　{
　　　　　　this[n++]=this[i]	
　　　　}
　　}
　　this.length-=1
　}
//设置文件类型
FileProgress.prototype.setFileType = function(id,saveData){
	//alert(serverData+"\n"+saveData);
	//下载
	var _now = this;
	var obj=_now.fileProgressElement.childNodes[1].getElementsByTagName("select")[0];
	obj.onchange = function () {
		var val=obj.options[obj.options.selectedIndex].value;
		//alert(id+","+val);
		$.ajax({
			type : 'post',
			url : "http://localhost:8080/Eread_Hn_Dev/meet_uploadFileType.action?fileid="+id+"&filetype="+val,
			//url : "../../uploadFileType.action?id="+id+"&filetype="+val,
			//data : 'id='+serverData,
			success : function(data) {
			//遍历，删除隐藏域的值
			if(data.state){
				
			}else{
				_now.fileProgressElement.className = "progressContainer red";
				_now.fileProgressElement.childNodes[3].className = "progressBarError";
				_now.fileProgressElement.childNodes[3].style.width = "";
				_now.fileProgressElement.childNodes[2].innerHTML = "操作失败"
			}
		},
		error:function(data){
			_now.fileProgressElement.className = "progressContainer red";
			_now.fileProgressElement.childNodes[3].className = "progressBarError";
			_now.fileProgressElement.childNodes[3].style.width = "";
			_now.fileProgressElement.childNodes[2].innerHTML = "操作失败"
		}
		});
	};	
}
//设置删除下载
FileProgress.prototype.setDownDeleteLink = function(serverData,saveData,id){
	//下载
	this.fileProgressElement.childNodes[1].childNodes[0].href = serverData;
	var _now = this;
	//删除
	_now.fileProgressElement.childNodes[0].onclick = function () {
			//alert("id:"+id);
			$.ajax({
				type : 'post',
				url : "meet_deleteFile.action?fileid="+id,
				//url : "../../meeting/subMeetingAction!delefile1.action?deleteid="+id,
				//data : 'id='+serverData,
				success : function(data) {
					//遍历，删除隐藏域的值
					var _oldData = $("#"+saveData+"").val();
					//alert(saveData);
					var _oldDataArray = _oldData.split("|");
					//alert(_oldDataArray.length);
					if(_oldDataArray.length>0){
						for(var i=0;i<_oldDataArray.length;i++){
							var _uploadPathData = JSON.parse(_oldDataArray[i]).filenameindisk;
							//alert("_uploadPathData:"+_uploadPathData);
							if(_uploadPathData==serverData){
								_oldDataArray.remove(i);
								//alert("FUCK:"+_oldDataArray);
								break;
							}
						}
					}else{
						_now.fileProgressElement.className = "progressContainer red";
						_now.fileProgressElement.childNodes[3].className = "progressBarError";
						_now.fileProgressElement.childNodes[3].style.width = "";
						_now.fileProgressElement.childNodes[2].innerHTML = "删除文件失败"
					}
					var _newData;
						if(_oldDataArray.length>0){
						for(var i=0;i<_oldDataArray.length;i++){
								if(i==0){
									_newData = 	_oldDataArray[0];
								}else{
									_newData+="|"+_oldDataArray[i];
								}
							
						}
						//alert("_newData:"+_newData);
						$("#"+saveData+"").val(_newData);
					}else{
						$("#"+saveData+"").val("");
					}
					_now.disappear();
					
				},
				error:function(data){
					//alert("error");
					_now.fileProgressElement.className = "progressContainer red";
					_now.fileProgressElement.childNodes[3].className = "progressBarError";
					_now.fileProgressElement.childNodes[3].style.width = "";
					_now.fileProgressElement.childNodes[2].innerHTML = "删除文件失败"
				}
		});
	};	
}

// 取消上传
FileProgress.prototype.toggleCancel = function (show,swfUploadInstance) {
	var _now = this;
	if(swfUploadInstance){
		var fileID = _now.fileProgressID;
		_now.fileProgressElement.childNodes[0].onclick = function () {
			swfUploadInstance.cancelUpload(fileID);
			return false;
		};
	}
	
};

FileProgress.prototype.appear = function () {
	if (this.getTimer() !== null) {
		clearTimeout(this.getTimer());
		this.setTimer(null);
	}
	
	if (this.fileProgressWrapper.filters) {
		try {
			this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 100;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=100)";
		}
	} else {
		this.fileProgressWrapper.style.opacity = 1;
	}
		
	this.fileProgressWrapper.style.height = "";
	
	this.height = this.fileProgressWrapper.offsetHeight;
	this.opacity = 100;
	this.fileProgressWrapper.style.display = "";
	
};

// Fades out and clips away the FileProgress box.
FileProgress.prototype.disappear = function () {

	var reduceOpacityBy = 15;
	var reduceHeightBy = 4;
	var rate = 30;	// 15 fps

	if (this.opacity > 0) {
		this.opacity -= reduceOpacityBy;
		if (this.opacity < 0) {
			this.opacity = 0;
		}

		if (this.fileProgressWrapper.filters) {
			try {
				this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = this.opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=" + this.opacity + ")";
			}
		} else {
			this.fileProgressWrapper.style.opacity = this.opacity / 100;
		}
	}

	if (this.height > 0) {
		this.height -= reduceHeightBy;
		if (this.height < 0) {
			this.height = 0;
		}

		this.fileProgressWrapper.style.height = this.height + "px";
	}

	if (this.height > 0 || this.opacity > 0) {
		var oSelf = this;
		this.setTimer(setTimeout(function () {
			oSelf.disappear();
		}, rate));
	} else {
		this.fileProgressWrapper.style.display = "none";
		this.setTimer(null);
	}
};