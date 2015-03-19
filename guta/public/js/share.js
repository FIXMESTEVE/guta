//Envoyer en POST la liste des fichiers et l'adresse mail rentrée

$("#inputEmail").keydown(function(e){
	if(e.keyCode == 13)
		share();
});

share = function(){
	var files = [];
	//On  récupère les checkbox
	$(document).find('input').each(function(){
		if($(this).prop('checked')){
			str = "files/";
			pos = $(this).attr('id').indexOf(str);
			target = $(this).attr('id').substring(pos + str.length);
			files.push(target);
		}
	});
	//On récupère l'adresse mail
	var email = $('#inputEmail').val();

	//On envoie en POST à file/share/
	$.post("/guta/guta/files/share", { paths: files, userMail: email })
		.always($('#inputEmail').val(''));
}