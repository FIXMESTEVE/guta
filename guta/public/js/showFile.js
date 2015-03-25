var app = window.location.href
var index = app.indexOf("/list/") + 1
app = app.substr(0, index)
app += "getFile/"

/*
* Gestion des toggles buttons
*/
function manageToggledButton(){
  var toogledButtonID = localStorage.toggledButtonID_XYZ

  if(toogledButtonID == "changeViewToIcone"){
     $('#toggledButtonIcone').click()
  }else{
     $('#toggledButtonList').click()
  }
}

function showFile(path, file){
	var modalBody = document.getElementById("fileModalBody")
  var name = file.split('/')
  name = name[name.length -1]
  document.getElementById("myFileModalLabel").innerHTML = "Fichier : " + name

  path = path.replace(/\//g, "{}")
  file = file.replace(/\//g, "{}")
  var key = (path == "") ? "{}"+file : path+"{}"+file

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
  $(document).find('input').each(function(){
    $(this).prop('checked', false);
  })
	console.log("changeViewToList")
  localStorage.toggledButtonID_XYZ = "changeViewToList"
	document.getElementById("listViewTable").style.display = "inline"
	document.getElementById("iconeViewTable").style.display = "none"
}

function changeViewToIcone(){
  $(document).find('input').each(function(){
    $(this).prop('checked', false);
  })
	console.log("changeViewToIcone")
  localStorage.toggledButtonID_XYZ = "changeViewToIcone"
	document.getElementById("listViewTable").style.display = "none"
	document.getElementById("iconeViewTable").style.display = "inline"
}

$(function() {
  manageToggledButton()
});