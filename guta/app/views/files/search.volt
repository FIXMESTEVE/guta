{{ content() }}

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
<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                <h4 class='modal-title' id='myModalLabel'>Nouveau dossier</h4>
            </div>
            {{ form('files/createFolder' ~ currentDir, 'method': 'post', 'class': 'col-lg-12', 'style': 'width:340px;margin:0 auto;') }}
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
            {{ end_form() }}
        </div>
    </div>
</div>


<!-- Modal upload -->
<div class='modal fade' id='myUploadModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
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
<div class='modal fade' id='myShareModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
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

<h1 class="text-center">Recherche</h1>

<table class="table table-hover" style="width:80%" data-sortable>
	<thead>
		<tr>
			<th>#</th>
			<th>Nom</th>
			<th>Taille</th>
			<th>Modification</th>
		</tr>
	</thead>
	<tbody>
		
			{% for dir in directories %}
				<tr>
					<td><input type="checkbox" id="{{ url( "files/"~ dir['path']) ~ "/"}}" /></td>
					<td><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list/" ~ dir['path'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
				</tr>
			{% endfor %}
			{% for file in files %}
				<tr class="downloadable">
					<td><input type="checkbox" id="{{ url( "files" ~ file['path']) ~ "/" ~ file['name'] }}" /></td>
					<td><span class="glyphicon glyphicon-file"><a href="#myFileModal" data-toggle="modal" onclick="showFile( '{{ file['path'] }}', '{{ file['name'] }}')">{{ file['name'] }}</a></span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>
				</tr>
			{% endfor %}
		
	</tbody>
</table>
