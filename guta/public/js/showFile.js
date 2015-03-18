app = "http://localhost/ped/guta/guta/files/getFile/"

function showFile(path, file){
	var modalBody = document.getElementById("fileModalBody")
	path = path.replace(/\//g, "{}")
	var key = (path == "") ? "{}"+file : path+"{}"+file

	document.getElementById("myFileModalLabel").innerHTML = "Fichier : " + file

    $.ajax({
   		url : app + key,
       	type : 'GET',
       	success : function(data, status){
           	console.log("success fetching file content")
           	modalBody.innerHTML = ""
           	modalBody.innerHTML = JSON.parse(data)
       	},

       	error : function(resultat, statut, erreur){
       		console.log("error")
           	modalBody.innerHTML = "Impossible d'afficher le contenu du fichier !"
       	},

       	complete : function(resultat, statut){
       	}
    });
}

function changeViewToList(){
	console.log("changeViewToList")
	document.getElementById("listViewTable").style.display = "inline"
	document.getElementById("iconeViewTable").style.display = "none"
}

function changeViewToIcone(){
	console.log("changeViewToIcone")
	document.getElementById("listViewTable").style.display = "none"
	document.getElementById("iconeViewTable").style.display = "inline"
}