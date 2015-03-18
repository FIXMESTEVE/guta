{{ content() }}

<h1 class="text-center">Mes fichiers</h1>
<!--button href="#myModal" role="button" class="btn btn-primary pull-right" style="margin-right: 10%;" data-toggle="modal">Nouveau dossier</button-->
<!--button href="#myUploadModal" role="button"  data-toggle="modal">Uploader des fichiers</button-->
<div class="btn-group" role="group" aria-label="...">
  	<button type="button" class="btn btn-default" onClick="changeViewToList()"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span></button>
  	<button type="button" class="btn btn-default" onClick="changeViewToIcone()"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></button>
</div>

{{ form('files/search', 'method': 'post', "class": "form-inline", "style": "width:340px;margin:0 auto;") }}
<div class="form-group">
	{{ text_field("pattern", 'class': 'form-control', "id": "inputSearch","placeholder":"Recherche") }}
</div>
{{ submit_button('Valider', "class":"btn btn-default") }}
{{ end_form() }}
<br><br>

<!-- Modal affichage fichier -->
<div class="modal fade" id="myFileModal" tabindex="-1" role="dialog" aria-labelledby="myFileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myFileModalLabel"></h4>
            </div>
            <div id="fileModalBody">
            </div>
        </div>
    </div>
</div>

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


<!-- Modal creation folder -->
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


<!-- Vue liste -->
<div class="table-responsive" id="listViewTable" style="display:inline;">
    <table class="table table-striped table-hover" style="width:80%" data-sortable>
		<thead>
			<tr>
				<th>Nom</th>
				<th>Taille</th>
				<th>Modification</th>
			</tr>
		</thead>
		<tbody>
			{% for dir in directories %}
				<tr>
					<td><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
				</tr>
			{% endfor %}
			{% for file in files %}
				<tr class="downloadable">
					<td><span class="glyphicon glyphicon-file"><a href="#myFileModal" data-toggle="modal" onclick="showFile( '{{ currentDir }}', '{{ file['name'] }}')">{{ file['name'] }}</a></span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>

					<!--td><span class="glyphicon glyphicon-file"> {{ link_to("files/view" ~ currentDir  ~ "/" ~ file['name'], file['name']) }}</span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td-->
				</tr>
			{% endfor %}
		</tbody>
	</table>
</div>

<!-- Vue icône -->
<div class="row" id="iconeViewTable" style="display:none;">
	{% for dir in directories %}
	  	<div class="bloc col-sm-6 col-md-8">
	    	<div class="thumbnail">
	      		<span class="glyphicon glyphicon-folder-open"></span>
	      		<div class="caption">
	        		<h3>{{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</h3>
	        		<p>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</p>
	      		</div>
	    	</div>
	  	</div>
	{% endfor %}

	{% for file in files %}
		<div class="bloc col-sm-6 col-md-8">
    		<div class="thumbnail">
    			<span class="glyphicon glyphicon-file"></span>
    			<div class="caption">
    				<h3 class="downloadable"><a title="{{ file['name'] }}" href="#myFileModal" data-toggle="modal" onclick="showFile( '{{ currentDir }}', '{{ file['name'] }}')">{{ file['name'] }}</a></h3>
    				<p>Taille : {% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</p>
    				<p>Dernière modification le {{ file['modifyDate'] }}</p>
    			</div>
    		</div>
    	</div>
	{% endfor %}
</div>
  