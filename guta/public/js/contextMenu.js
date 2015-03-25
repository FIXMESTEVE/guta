//We add the contextual menu and prevent the clicks on the document to do what we want
$(document).on("ready", function(){
	$(menu()).appendTo("body");
})
$(document).on('click', 'a.menulink', function(event){
	event.preventDefault();
	menu_click($(this));
});

var clicked;

$(".contextMenu").bind("contextmenu", function(event){
	event.preventDefault();
	clicked = $(this);
	$("ul.dropdown-menu").css({display: "block", top: event.pageY + "px", left: event.pageX + "px"});
	$("li.share").css({display: "block"});
	$("li.delete").css({display: "block"});
	$("li.copy").css({display: "block"});
	$("li.download").hide();
});
$('.navigate').bind("click", function(event){
	event.preventDefault();
	var file = false;
	$(this).find('span').each(function(){
		if($(this).attr('class').search('glyphicon-file') != -1){
			file = true;
		}
	})
	if(!file){
		$(this).find('a').each(function(){
			$(location).attr('href', $(this).attr('href'));
		})
	}
	else{
		$(this).find('a').each(function(){
			showFile($(this).attr('path'), $(this).attr('file'));
		})
	}
});
$(".shared").bind("contextmenu", function(event){
	$("li.share").hide();
	$("li.delete").hide();
	$("li.copy").hide();
});
$(".downloadable").bind("contextmenu", function(event){
	$("li.download").css({display: "block"});
});
$(document).bind("click", function(event){
	$("ul.dropdown-menu").hide();
	$("li.download").hide();
});

//HTML of the contextual menu
menu = function(){
	string = "<ul class='dropdown-menu'>";
	//contextual menu here
	string += "<li class='download'><a id='download' class='menulink' href=''>Télécharger</a></li>"
	string += "<li class='share'><a id='share' class='menulink' href='#shareModal' data-toggle='modal'>Partager</a></li>"
	string += "<li class='divider'></li>";
	string += "<li class='delete'><a id='delete' class='menulink' href=''>Supprimer</a></li>"
	string += "<li class='copy'><a id='copy' class='menulink' href=''> <span class='glyphicon glyphicon-copy' aria-hidden='true'></span> Copier</a></li>"
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
	var pos;
	var target;
	var folderPath;
	var str = "files/";
	clicked.find('input').each(function(){
		pos = $(this).attr('id').indexOf(str);
		target = $(this).attr('id').substring(pos + str.length).replace(/\//g, '¤');
		folderPath = $(this).attr('id').substring(0, pos) + "files/";
	});
	switch(object.attr('id')){
	case 'download':
		$(location).attr('href', folderPath + "download/" + target);
		break;
	case 'delete':
		$(location).attr('href', folderPath + "delete/" + target);
		break;
	case 'copy':
		httpGet(folderPath + "copy/" + target);

		// taken from StackOverflow, by Anu - SO
		$("#copyNotification").fadeIn("slow").html('Fichier ' + target +' copié <span class="dismiss"><a title="dismiss this notification">X</a></span>');
		$(".dismiss").click(function(){
		       $("#copyNotification").fadeOut("slow");
		});
		break;
	case 'share':
		//We just check the checkbox and then go to the share modal
		var checkbox;
		clicked.find('input').each(function(){
			checkbox = $(this);
		});
		checkbox.prop('checked', true);
		break;
	default:
		break;
	}
}