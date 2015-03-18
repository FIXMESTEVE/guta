{{ content() }}

<h1 class="text-center">Mes fichiers</h1>
<!--button href="#myModal" role="button" class="btn btn-primary pull-right" style="margin-right: 10%;" data-toggle="modal">Nouveau dossier</button-->
<!--button href="#myUploadModal" role="button"  data-toggle="modal">Uploader des fichiers</button-->


{{ form('files/search', 'method': 'post', "class": "form-inline", "style": "width:340px;margin:0 auto;") }}
<div class="form-group">
{{ text_field("pattern", 'class': 'form-control', "id": "inputSearch","placeholder":"Recherche") }}
</div>
{{ submit_button('Valider', "class":"btn btn-default") }}
{{ end_form() }}
<br><br>


<!-- Modal creation folder -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Nouveau dossier</h4>
            </div>
            {{ form('files/createFolder' ~ currentDir, 'method': 'post', "class": "col-lg-12", "style": "width:340px;margin:0 auto;") }}
                <div class="modal-body">
                    <div class="form-group ">
                        <label> Nom du dossier </label>
                        <br><br>
                        {{ text_field("foldername", 'class': 'form-control input-lg', "id": "inputUsername","placeholder":"Nom de dossier") }}
                    </div>
                </div>
                <div class="modal-footer">
                    {{ submit_button('Valider', "class":"btn btn-primary center-block") }}
                </div>
            {{ end_form() }}
        </div>
    </div>
</div>


<!-- Modal upload -->
<div class="modal fade" id="myUploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    	<div class="modal-content">
	       <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	            <h4 class="modal-title" id="myUploadLabel">Upload</h4>
	        </div>
        
        	<div class="modal-body">
				{{ form("files/upload" ~ currentDir, 'method': 'post', "class": "dropzone") }}
				{{end_form()}}
            </div>
        </div>
    </div>
</div>

<!-- Modal share -->
<div class="modal fade" id="myShareModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Partager avec :</h4>
            </div>
                <div class="modal-body">
                    <div class="form-group ">
                        <label for="mail">Adresse mail</label>
                        {{ email_field("email","class": "form-control input-lg",  "id": "inputEmail", "placeholder": "Adresse mail") }}
                    </div>
                    <div class="form-group ">
                    	{% if shareInfo != null %}
                    		<label>{{ shareInfo }}</label>
                    	{% endif %}
            		</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary center-block" onclick="">Partager</button>
                </div>
            {{ end_form() }}
        </div>
    </div>
</div>


<!--<table class="table table-hover" style="width:80%" data-sortable>-->
<div class="table-responsive">
    <table class="table table-striped table-hover" style="width:80%" data-sortable>
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
					<td><input type="checkbox" id="{{ currentDir ~ "/" ~ dir['name'] }}" /></td>
					<td><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
				</tr>
			{% endfor %}
			{% for file in files %}
				<tr class="downloadable">
					<td><input type="checkbox" id="{{ currentDir ~ "/" ~ file['name'] }}" /></td>
					<td><span class="glyphicon glyphicon-file"> {{ link_to("files/view" ~ currentDir  ~ "/" ~ file['name'], file['name']) }}</span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>
				</tr>
			{% endfor %}
		</tbody>
	</table>
</div>
  