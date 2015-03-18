//We add the contextual menu and prevent the clicks on the document to do what we want
$(document).on("ready", function(){
	$(menu()).appendTo("body");
})
$(document).on('click', 'a.menulink', function(event){
	event.preventDefault();
	menu_click($(this));
});

var target;
var folderPath;
var str = "view/";

$("tr.downloadable").bind("contextmenu", function(event){
	event.preventDefault();
	//Récup des infos du click
	$(this).find('a').each(function(){
		var pos = $(this).attr('href').indexOf(str);
		target = $(this).attr('href').substring(pos + str.length).replace(/\//g, '¤');
		folderPath = $(this).attr('href').substring(0, pos);
		console.log($(this).attr('href'));
		console.log(target);
	});
	$("ul.dropdown-menu").css({display: "block", top: event.pageY + "px", left: event.pageX + "px"});
});
$(document).bind("click", function(event){
	$("ul.dropdown-menu").hide();
});

//HTML of the contextual menu
menu = function(){
	string = "<ul class='dropdown-menu'><li>Context Menu</li><li class='divider'></li>";
	//contextual menu here
	string += "<li><a id='download' class='menulink' href=''>Download</a></li>"
	string += "<li><a id='delete' class='menulink' href=''>Delete</a></li>"
	string += "<li><a id='copy' class='menulink' href=''>Copy</a></li>"
	// menu's end
	string += "</ul>";
	return string;
}

function httpGet(theUrl)
{
    var xmlHttp = null;

    xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false );
    xmlHttp.send( null );
    return xmlHttp.responseText;
}

//Associate the actions of the contextual menu here
menu_click = function(object){
	switch(object.attr('id')){
	case 'download':
		$(location).attr('href', folderPath + "download/" + target);
		//var file = "testFile.txt";
		//$(location).attr('href', "http://localhost/guta/guta/public/files/download/" + file);
		break;
	case 'delete':
		$(location).attr('href', folderPath + "delete/" + target);
		break;
	case 'copy':
		//$(location).attr('href', folderPath + "copy/" + target);
		httpGet(folderPath + "copy/" + target);

		// taken from StackOverflow, by Anu - SO
		$("#notification").fadeIn("slow").append('Fichier copié');
		$(".dismiss").click(function(){
		       $("#notification").fadeOut("slow");
		});

		break;
	default:
		$(location).attr('href', object.attr('href'));
		break;
	}
}