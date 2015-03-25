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

<h1 class="text-center">Résultat de la recherche</h1>

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
                    <td><input type="checkbox" id="{{ url( "files/" ~ dir['path']) ~ "/"}}" /></td>
                    <td class="navigate"><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list/" ~ dir['path'] ~ "/", dir['name']) }}</span></td>
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
                    <td><input type="checkbox" id="{{ url( "files" ~ file['path'] ~ "/" ~ file['name']) }}" /></td>
                    <td class="navigate" href="#myFileModal" data-toggle="modal"><span class="glyphicon glyphicon-file"><a href="" path="{{ file['path'] }}" file="{{ file['name'] }}">{{ file['name'] }}</a></span></td>
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
