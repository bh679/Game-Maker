/* OpenTok START */
function createRecorder() {
    var recDiv = document.createElement('div');
    recDiv.setAttribute('id', 'recorderElement');
    document.getElementById('snap-cam').appendChild(recDiv);
    recorder = recorderManager.displayRecorder(token, recDiv.id, {width: 640, height: 480, style: {showControlBar: false, showMicButton: false}});
    recorder.addEventListener('recordingStarted', recStartedHandler);
    recorder.addEventListener('recordingStopped', recStoppedHandler);
    recorder.addEventListener('playbackStarted', playbackStartedHandler);
    recorder.addEventListener('archiveSaved', archiveSavedHandler);
}
function archiveSavedHandler(event) {
}
function recStartedHandler(event) {
}
function recStoppedHandler(event) {
}
function playbackStartedHandler(event) {
}
/* OpenTok END */

/* WebRTC START */
var is_webkit = false;
function gotStream(stream) {
	var output = document.getElementById('output');
	var source;
	if (!is_webkit) {
		source = stream;
	} else {
		source = window.webkitURL.createObjectURL(stream);
	}
	output.src = source;
}
function gotStreamFailed() {
	console.log('No stream');
}
if (navigator.webkitGetUserMedia) {
	is_webkit = true;
	navigator.webkitGetUserMedia({video:true}, gotStream, gotStreamFailed);
} else if (navigator.getUserMedia) {
	// Opera
	navigator.getUserMedia({video:true}, gotStream, gotStreamFailed);

} else {
	$('#output').hide();
	// Flash fallback
	recorderManager = TB.initRecorderManager(apiKey);
	createRecorder();
}

function takePhoto()
{
	var c = document.getElementById('photo'); // canvas
	var v = document.getElementById('output'); // video
	c.width = 640;
	c.height = 480;
	c.getContext('2d').drawImage(v, 0, 0);
	var dataUrl = c.toDataURL('image/jpeg');
	dataUrl = dataUrl.replace(/^data:image\/(png|jpeg);base64,/, "");
	return dataUrl;
}
/* WebRTC END */

$(document).ready(function() {
	$('#PictureSnapForm input.btn').click(function(event) {
		event.preventDefault();
		var imgData;
		if (typeof recorder !== 'undefined') {
			imgData = recorder.getImgData();
		} else {
			imgData = takePhoto();
		}
		$('#picture').val(imgData);
		$('#PictureSnapForm').submit();
		$('#PictureSnapForm .submit').hide();
		$('.loader').show();
	});
});
