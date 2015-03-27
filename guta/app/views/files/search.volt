{{ content() }}

<div class="btn-group pull-right" role="group" aria-label="..." style="margin-right:10%" data-toggle="buttons">
    <label class="btn btn-default active" id="toggledButtonList" onclick="changeViewToList()">
        <input type="radio" class="btn btn-default" name="options" autocomplete="off" checked /><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
    </label>
    <label class="btn btn-default" id="toggledButtonIcone" onclick="changeViewToIcone()">
        <input type="radio" class="btn btn-default" name="options" autocomplete="off" /><span class="glyphicon glyphicon-th" aria-hidden="true"></span>
    </label>
</div>

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
                <label>Date et heure</label>
                <div id="versionsRows"><button class='btn btn-lg btn-warning'><span class='glyphicon glyphicon-refresh spinning'></span> Chargement...</button></div>
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
                    <td class="navigate"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;{{ link_to("files/list/" ~ dir['path'] ~ "/", dir['name']) }}</td>
                    <td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
                    <td></td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Télécharger" id="download" class="btn btn-success btn-xs btn-operation"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Partager" id="share" href='#shareModal' data-toggle='modal' class="btn btn-info btn-xs btn-operation"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Versions précédentes" id='version' href="#myVersionsModal" data-toggle='modal' class="btn btn-primary btn-xs btn-operation" disabled><span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span></button>
                            <button type="button" title="Copier" id="copy" class="btn btn-warning btn-xs btn-operation" disabled><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" id="delete" class="btn btn-danger btn-xs btn-operation"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
                </tr>
            {% endfor %}
            {% for file in files %}
                <tr class="downloadable contextMenu">
                    <td><input type="checkbox" id="{{ url( "files" ~ file['path'] ~ "/" ~ file['name']) }}" /></td>
                    <td class="navigate" href="#myFileModal" data-toggle="modal"><span class="glyphicon glyphicon-file"></span><a href="" path="{{ file['path'] }}" file="{{ file['name'] }}">&nbsp;&nbsp;{{ file['name'] }}</a></td>
                    <td>{% if file['size'] != null %} {{ file['size'] }} {% endif %}</td>
                    <td>{{ file['modifyDate'] }}</td>
                    <td>
                        <div class="btn-group pull-right" role="group">
                            <button type="button" title="Télécharger" id="download" class="btn btn-success btn-xs btn-operation"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                            <button type="button" title="Partager" id="share" href='#shareModal' data-toggle='modal' class="btn btn-info btn-xs btn-operation"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                            <button type="button" title="Versions précédentes" id='version' href="#myVersionsModal" data-toggle='modal' class="btn btn-primary btn-xs btn-operation"><span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span></button>
                            <button type="button" title="Copier" id="copy" class="btn btn-warning btn-xs btn-operation"><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>
                            <button type="button" title="Supprimer" id="delete" class="btn btn-danger btn-xs btn-operation"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </div>
                    </td>
                </tr>
            {% endfor %}
        </tbody>
    </table>
</div>

<div class="row" id="iconeViewTable" style="display:none;">
    {% for dir in directories %}
        <div class="bloc col-sm-6 col-md-8 contextMenu">
            <div class="thumbnail">
                <div class="navigate">
                    <input type="checkbox" id="{{ url( "files/" ~ dir['path']) ~ "/"}}" hidden='true'/>
                    <span class="glyphicon glyphicon-folder-open"></span>
                    <div class="caption">
                        <h3>{{ link_to("files/list/" ~ dir['path'] ~ "/", dir['name']) }}</h3>
                        <p>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</p>
                        <p><br></br></p> 
                   </div>
                </div>
                <div class="btn-group " role="group">
                    {% if dir['name'] != '..' %}
                        <button type="button" title="Télécharger" id="download" class="btn btn-success btn-xs btn-operation" disabled><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                        <button type="button" title="Partager" id="share" href='#shareModal' data-toggle='modal' class="btn btn-info btn-xs btn-operation"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                        <button type="button" title="Versions précédentes" id='version' href="#myVersionsModal" data-toggle='modal' class="btn btn-primary btn-xs btn-operation" disabled><span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span></button>
                        <button type="button" title="Copier" id="copy" class="btn btn-warning btn-xs btn-operation" disabled><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>
                        <button type="button" title="Supprimer" id="delete" class="btn btn-danger btn-xs btn-operation"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                    {% endif %}
                </div>
            </div>
        </div>
    {% endfor %}
    {% for file in files %}
        <div class="bloc col-sm-6 col-md-8 downloadable contextMenu">
            <div class="thumbnail">
                <div class="navigate" href="#myFileModal" data-toggle="modal">
                    <input type="checkbox" id="{{ url( "files" ~ file['path'] ~ "/" ~ file['name']) }}" hidden='true'/>
                    <span class="glyphicon glyphicon-file"></span>
                    <div class="caption">
                        <h3 class="downloadable"><a title="{{ file['name'] }}" href="" path="{{ file['path'] }}" file="{{ file['name'] }}">{{ file['name'] }}</a></h3>
                        <p>Taille : {% if file['size'] != null %} {{ file['size'] }} {% endif %}</p>
                        <p>Dernière modification le {{ file['modifyDate'] }}</p>
                    </div>
                </div>
                <div class="btn-group " role="group">
                    <button type="button" title="Télécharger" id="download" class="btn btn-success btn-xs btn-operation"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span></button>
                    <button type="button" title="Partager" id="share" href='#shareModal' data-toggle='modal' class="btn btn-info btn-xs btn-operation"><span class="glyphicon glyphicon-share" aria-hidden="true"></span></button>
                    <button type="button" title="Versions précédentes" id='version' href="#myVersionsModal" data-toggle='modal' class="btn btn-primary btn-xs btn-operation"><span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span></button>
                    <button type="button" title="Copier" id="copy" class="btn btn-warning btn-xs btn-operation"><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>
                    <button type="button" title="Supprimer" id="delete" class="btn btn-danger btn-xs btn-operation"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                </div>
            </div>
        </div>
    {% endfor %}
</div>

<!--notification popup for copied files -->
<div id="copyNotification" style="display: none;">
  <span class="dismiss"><a title="dismiss this notification">X</a></span>
</div>
