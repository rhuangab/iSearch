function test()
{
    var txtField = document.getElementById("textField");
    var testLabel = document.getElementById("testLabel");
    testLabel.innerHTML=txtField.value;
}

function clearWords()
{
	var testLabel = document.getElementById("testLabel");
    testLabel.innerHTML = "";
}

function findWords()
{
    var txtField = document.getElementById("textField");
    var testLabel = document.getElementById("testLabel");
    var prefix = txtField.value;

    var spacer = document.getElementById("spacer");
    if(prefix.indexOf(" ") != -1)
    {
        if(prefix.lastIndexOf(" ") <= 49)
        {
            spacer.innerHTML = prefix.substring(0,prefix.lastIndexOf(" "));
        }
    }
    prefix = prefix.trim();
    var index = prefix.lastIndexOf(" ");
    if(index != -1)
    {
        prefix = prefix.substring(index+1);
    }
    //AJAX
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var parameters = "prefix="+prefix;
    
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            //testLabel.innerHTML = xmlhttp.responseText;
            var responseText = xmlhttp.responseText;
            parseResponseText(responseText);
        }
    }
    xmlhttp.open("POST","findWords.jsp",true);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send(parameters);
}

function parseResponseText(responseText)
{
    var testLabel = document.getElementById("testLabel");
    if(responseText != null &&  responseText.length > 0)
    {
        var res = responseText.trim().split(" ");
        var innerHTML = "";
        for(var i = 0; i <res.length;i++)
        {
            innerHTML += "<li class=\"list-group-item\">"+res[i]+"</li>";
        }
        testLabel.innerHTML = innerHTML;
    }
}