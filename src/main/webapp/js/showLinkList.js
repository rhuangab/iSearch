function showLinkList(id)
{
    var linkList = document.getElementById(id);
    if(linkList.style.display == 'block'){
        linkList.style.display = 'none';
    }else {
        linkList.style.display = 'block';
    }
}