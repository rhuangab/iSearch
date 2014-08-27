function changeFavoriteStatusAndIcon()
{
    var source = event.target || event.srcElement;
    if(source.getAttribute("src") == "favorite.png")
        source.setAttribute("src", "favorite_on.png");
    else
        source.setAttribute("src", "favorite.png");
    
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
    var parameters = "pageID="+source.getAttribute("pageID")+"&username="+source.getAttribute("username");

    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById('hello').innerHTML=xmlhttp.responseText;
        }
    }
    xmlhttp.open("POST","changeFavoriteStatus.jsp",true);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send(parameters);
}