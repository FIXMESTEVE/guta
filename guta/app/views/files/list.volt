{{ content() }}

<h1 class="text-center">Mes fichiers</h1>

<div class="btn-group pull-right" role="group" aria-label="..." style="margin-right:10%" data-toggle="buttons">
    <label class="btn btn-default active" id="toggledButtonList" onclick="changeViewToList()">
        <input type="radio" class="btn btn-default" name="options" autocomplete="off" checked /><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
    </label>
    <label class="btn btn-default" id="toggledButtonIcone" onclick="changeViewToIcone()">
        <input type="radio" class="btn btn-default" name="options" autocomplete="off" /><span class="glyphicon glyphicon-th" aria-hidden="true"></span>
    </label>
</div>

{% if !inSharedDirectory %}
{{ form('files/paste' ~ currentDir, 'method': 'post') }}
    <button type="submit" class="btn btn-default pull-right" style="margin-right:10%">
      <span class="glyphicon glyphicon-paste" aria-hidden="false"></span> Coller
    </button>
{{ end_form() }}
{% endif %}

{{ form('files/search', 'method': 'post', "class": "form-inline", "style": "width:340px;margin:0 auto;") }}
<div class="form-group">
	{{ text_field("pattern", 'class': 'form-control', "id": "inputSearch","placeholder":"Recherche") }}
</div>
{{ submit_button('Valider', "class":"btn btn-default") }}
{{ end_form() }}
<br><br>

<!-- Modal affichage fichier -->
<div class='modal fade' id='myFileModal' tabindex='-1' role='dialog' aria-labelledby='myFileModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                <h4 class='modal-title' id='myFileModalLabel'></h4>
            </div>
            <div id='fileModalBody'>
            </div>
        </div>
    </div>
</div>

<!-- Modal creation folder -->
<div class="modal fade" id="newFolderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        {{ form('files/createFolder' ~ currentDir, 'method': 'post', 'class': 'col-lg-12') }}
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Nouveau dossier</h4>
                </div>
                <div class='modal-body'>
                    <div class='form-group '>
                        <label> Nom du dossier </label>
                        <br><br>
                        {{ text_field('foldername', 'class': 'form-control input-lg', 'id': 'inputUsername','placeholder':'Nom de dossier') }}
                    </div>
                </div>
                <div class='modal-footer'>
                    {{ submit_button('Valider', 'class':'btn btn-primary center-block') }}
                </div>
            </div>
       {{ end_form() }}
    </div>
</div>


<!-- Modal upload -->
<div class='modal fade' id='uploadModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                <h4 class='modal-title' id='myUploadLabel'>Upload</h4>
            </div>
        
            <div class='modal-body'>
                {{ form('files/upload' ~ currentDir, 'method': 'post', 'class': 'dropzone') }}
                {{end_form()}}
            </div>
        </div>
    </div>
</div>

<!-- Modal share -->
<div class='modal fade' id='shareModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                <h4 class='modal-title' id='myModalLabel'>Partager avec :</h4>
            </div>
                <div class='modal-body'>
                    <div class='form-group '>
                        <label for='mail'>Adresse mail</label>
                        {{ email_field('email','class': 'form-control input-lg',  'id': 'inputEmail', 'placeholder': 'Adresse mail') }}
                    </div>
                    <div class='form-group '>   
                        <label id='shareInfo'></label>
                    </div>
                </div>
                <div class='modal-footer'>
                    <button type='button' class='btn btn-primary center-block' onclick='share()'>Partager</button>
                </div>
        </div>
    </div>
</div>

<!-- Modal previous versions of a file -->
<div class='modal fade' id='myVersionsModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
        <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                <h4 class='modal-title' id='myVersionsLabel'>Versions</h4>
            </div>
        
            <div class='modal-body'>
                <div class='table-responsive' id='versionsTable' style='display:inline;'>
                    <thead>
                        <tr>
                            <th>Date et heure</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for ver in output %}
                            <tr>
                                <td>{{ ver }}</td>
                            </tr>
                        {% endfor %}
                    </tbody>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Vue liste -->
<div class="table-responsive" id="listViewTable" style="display:inline;">
    <table class="table table-striped table-hover" style="width:80%" data-sortable>
		<thead>
			<tr>
				<th>#</th>
				<th>Nom</th>
				<th>Taille</th>
				<th>Modification</th>
                <th></th>
			</tr>
		</thead>
		<tbody>
			{% for dir in directories %}
				<tr class="contextMenu">
					<td><input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ dir['name']) ~ "/"}}" /></td>
					<td class="navigate"><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
				</tr>
			{% endfor %}
            {% for dir in sharedDirectories %}
                <tr class="shared contextMenu">
                    <td><input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ dir['realPath'])}}" disabled="true"/></td>
                    <td class="navigate"><span class="glyphicon glyphicon-share-alt"><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ currentDir ~ "/" ~ dir['realPath'], dir['name']) }}</span></span></td>
                    <td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
                    <td></td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
                </tr>
            {% endfor %}
			{% for file in files %}
				<tr class="downloadable contextMenu">
					<td><input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ file['name']) }}" /></td>
					<td class="navigate" href="#myFileModal" data-toggle="modal"><span class="glyphicon glyphicon-file"><a href="" path="{{ currentDir }}" file="{{ file['name'] }}">{{ file['name'] }}</a></span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
				</tr>
			{% endfor %}
            {% for file in sharedFiles %}
                <tr class="downloadable shared contextMenu">
                    <td><input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ file['realPath']) }}" disabled="true"/></td>
                    <td class="navigate" href="#myFileModal" data-toggle="modal"><span class="glyphicon glyphicon-share-alt"><span class="glyphicon glyphicon-file"><a href="" path="{{ currentDir }}" file="{{ file['realPath'] }}">{{ file['name'] }}</a></span></span></td>
                    <td>{% if file['size'] != null %} {{ file['size'] }} {% endif %}</td>
                    <td>{{ file['modifyDate'] }}</td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
                </tr>
            {% endfor %}
		</tbody>
	</table>
</div>

<!-- Vue icône -->
<div class="row" id="iconeViewTable" style="display:none;">
	{% for dir in directories %}
	  	<div class="bloc col-sm-6 col-md-8 contextMenu">
	    	<div class="thumbnail">
                <div class="navigate">
                    <input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ dir['name']) ~ "/"}}" hidden='true'/>
	      		    <span class="glyphicon glyphicon-folder-open"></span>
	      		    <div class="caption">
	        		    <h3>{{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</h3>
	        		    <p>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</p>
                        <p><br></br></p> 
	      		   </div>
                </div>
                <div class="btn-group " role="group">
                    <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                    <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                    <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                </div>
	    	</div>
	  	</div>
	{% endfor %}
    {% for dir in sharedDirectories %}
        <div class="bloc col-sm-6 col-md-8 shared contextMenu">
            <div class="thumbnail">
                <div class="navigate">
                    <input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ dir['realPath']) ~ "/"}}" hidden='true'/>
                    <span class="glyphicon glyphicon-share-alt"><span class="glyphicon glyphicon-folder-open"></span></span>
                    <div class="caption">
                        <h3>{{ link_to("files/list" ~ currentDir ~ "/" ~ dir['realPath'], dir['name']) }}</h3>
                        <p>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</p>
                        <p><br></br></p>
                    </div>
                </div>
                <div class="btn-group " role="group">
                    <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                    <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                    <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                </div>
            </div>
        </div>
    {% endfor %}
	{% for file in files %}
		<div class="bloc col-sm-6 col-md-8 downloadable contextMenu">
    		<div class="thumbnail">
                <div class="navigate" href="#myFileModal" data-toggle="modal">
                    <input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ file['name']) }}" hidden='true'/>
        			<span class="glyphicon glyphicon-file"></span>
    			    <div class="caption">
    				    <h3 class="downloadable"><a title="{{ file['name'] }}" href="" path="{{ currentDir }}" file="{{ file['name'] }}">{{ file['name'] }}</a></h3>
    				    <p>Taille : {% if file['size'] != null %} {{ file['size'] }} {% endif %}</p>
    				    <p>Dernière modification le {{ file['modifyDate'] }}</p>
    			    </div>
    		    </div>
                <div class="btn-group " role="group">
                    <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                    <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                    <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                </div>
            </div>
    	</div>
	{% endfor %}
    {% for file in sharedFiles %}
        <div class="bloc col-sm-6 col-md-8 shared downloadable contextMenu">
            <div class="thumbnail">
                <div class="navigate" href="#myFileModal" data-toggle="modal">
                    <input type="checkbox" id="{{ url( "files" ~ currentDir ~ "/" ~ file['realPath']) }}" hidden='true'/>
                    <span class="glyphicon glyphicon-share-alt"><span class="glyphicon glyphicon-file"></span></span>
                    <div class="caption">
                        <h3 class="downloadable"><a title="{{ file['name'] }}" href="" path="{{ currentDir }}" file="{{ file['realPath'] }}">{{ file['name'] }}</a></h3>
                        <p>Taille : {% if file['size'] != null %} {{ file['size'] }} {% endif %}</p>
                        <p>Dernière modification le {{ file['modifyDate'] }}</p>
                    </div>
                </div>
                <div class="btn-group " role="group">
                    <button type="button" title="Partager" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                    <button type="button" title="Télécharger" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                    <button type="button" title="Supprimer" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                </div>
            </div>
        </div>
    {% endfor %}

</div>

<!--notification popup for copied files -->
<div id="copyNotification" style="display: none;">
  <span class="dismiss"><a title="dismiss this notification">X</a></span>
</div>
