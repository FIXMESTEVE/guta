//Envoyer en POST la liste des fichiers et l'adresse mail rentrée

var share = function(){
	var files = [];
	//On  récupère les checkbox
	$(document).find('input').each(function(){
		if($(this).prop('checked')){
			files.push($(this).attr('id'));
		}
	});
	//On récupère l'adresse mail
	var email = $('#inputEmail').val();

	//On envoie en POST à file/share/
	$.post("/guta/guta/files/share", { paths: files, userMail: email });
}