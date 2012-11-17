//========== GM AJAX ==========
//By: 		JacksonYarr
//License: 	Creative Commons Attribution 3.0 Unported License
//=============================

var requestArray = new Array();
requestArray.push("null");

function ajax_request_new()
{
id = requestArray.push(new XMLHttpRequest());
id = id-1;
return id;
}

function ajax_request_send(id,method,url,data)
{
	requestArray[id].open(method,url,true);
	requestArray[id].setRequestHeader("Content-type","application/x-www-form-urlencoded");
	requestArray[id].send(data);
	return true;
}

function ajax_check_reply(id)
{
	if (requestArray[id].readyState==4 && requestArray[id].status==200)
	{	
		return true;
	}
	else
	{
		return false;
	}
}

function ajax_check_failed(id)
{
	if (requestArray[id].readyState==4 && requestArray[id].status!=200)
	{	
		return true;
	}
	else
	{
		return false;
	}
}

function ajax_read_reply(id)
{
	return requestArray[id].responseText;
}

function ajax_clear_requests()
{
	requestArray.splice(0,requestArray.length,"null");
	return true;
}