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

$("tr").bind("contextmenu", function(event){
	event.preventDefault();
	$(this).find('a').each(function(){
		var pos = $(this).attr('href').indexOf(str);
		target = $(this).attr('href').substring(pos + str.length).replace(/\//g, '¤');
		folderPath = $(this).attr('href').substring(0, pos);
	});
	$("ul.dropdown-menu").css({display: "block", top: event.pageY + "px", left: event.pageX + "px"});
	$("li.download").hide();
});
$("tr.downloadable").bind("contextmenu", function(event){
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
	string += "<li class='share'><a id='share' class='menulink' href=''>Partager</a></li>"
	string += "<li class='divider'></li>";
	string += "<li><a id='delete' class='menulink' href=''>Supprimer</a></li>"
	// menu's end
	string += "</ul>";
	return string;
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
		//var file = "testFile.txt";
		//$(location).attr('href', "http://localhost/guta/guta/public/files/download/" + file);
		break;
	default:
		$(location).attr('href', object.attr('href'));
		break;
	}
}