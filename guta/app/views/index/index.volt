{{ content() }}
    <div class="row"> 
        <div class="col-lg-12  v-center">
            <h1 class="text-center">Stocker, partager et accéder à tous vos fichiers en toute simplicité</h1>
            <br><br>
            
            <!-- Modal Signup -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Inscription</h4>
                        </div>
                        {{ form('user/create', 'method': 'post', "class": "col-lg-12", "style": "width:340px;margin:0 auto;") }}
                            <div class="modal-body">
                                <div class="form-group ">
                                    <label for="mail">Adresse mail</label>
                                    {{ email_field("email","class": "form-control input-lg",  "id": "inputEmail", "placeholder": "Adresse mail") }}
                                </div>
                                <div class="form-group ">
                                    <label> Nom d'utilisateur </label>
                                    {{ text_field("login", 'class': 'form-control input-lg', "id": "inputUsername","placeholder":"Nom d'utilisateur") }}
                                </div>
                                <div class="form-group ">
                                    <label> Mot de passe </label>
                                    {{ password_field("password", 'class': 'form-control input-lg', "id": "inputPassword","placeholder":"Mot de passe") }}
                                </div>
                            </div>
                            <div class="modal-footer">
                                {{ submit_button('Inscription', "class":"btn btn-primary center-block") }}
                            </div>
                        {{ end_form() }}
                    </div>
                </div>
            </div>
            <!-- /Modal Signup -->
            
            <!-- Login Form -->
            {{ form('session/start', 'role': 'form', 'class': "col-lg-12", 'style': "width:340px;margin:0 auto;") }}
                <div class="form-group ">
                    <label for="login">Nom d'utilisateur</label>
                    {{ text_field('login', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group ">
                    <label for="password">Mot de passe</label>
                    {{ password_field('password', 'class': "form-control input-lg") }}
                </div>
                {{ submit_button('Connexion', 'class': "btn btn-primary btn-lg col-lg-6") }}
                
                <a href="#myModal" role="button" class="btn btn-link col-md-3 col-md-offset-2" style="font-weight: bold;" data-toggle="modal">Inscription</a>
            {{ end_form() }}
        </div>
    </div> 
    <br><br>
    <!-- /row -->
</div> 
<!-- /container full -->

<div class="container">
    <hr>
    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="text-center"><span class="glyphicon glyphicon-hdd" aria-hidden="true"> Stocker</span></h3>
                </div>
                <div class="panel-body">
                    <p class="text-justify">
                        Téléchargez vos fichiers : documents, photos, vidéos, musiques et stockez les en ligne.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="text-center"><span class="glyphicon glyphicon-share" aria-hidden="true"> Partager</span></h3>
                </div>
                <div class="panel-body">
                    <p class="text-justify">
                        Choisissez avec qui vous souhaiter partager vos photos. Echangez des documents avec les membres de votre équipe.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="text-center"><span class="glyphicon glyphicon-cloud" aria-hidden="true"> Accéder</span></h3>
                </div>
                <div class="panel-body">
                    <p class="text-justify">
                        Tous vos documents accessibles où que vous soyez sur vos différents ordinateurs.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <br><br>
            <p class="text-center">© Copyright 2015</p>
            <br><br>
        </div>
    </div>
</div>

