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
                                <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
                                {{ submit_button('Inscription', "class":"btn btn-primary") }}
                            </div>
                        {{ end_form() }}
                    </div>
                </div>
            </div>
            
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
                
                <a href="#myModal" role="button" class="btn btn-link col-md-3 col-md-offset-3" data-toggle="modal">Inscription</a>
            {{ end_form() }}
        </div>
    </div> <!-- /row -->


    <div class="row"> 
        <div class="col-lg-12 text-center v-center" style="font-size:39pt;">
            <a href="#"><i class="icon-google-plus"></i></a>
            <a href="#"><i class="icon-facebook"></i></a>
            <a href="#"><i class="icon-twitter"></i></a>
            <a href="#"><i class="icon-github"></i></a>
            <a href="#"><i class="icon-pinterest"></i></a>
        </div>
    </div>
    <br><br><br><br><br>
</div> <!-- /container full -->

<div class="container">

    <hr>
    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading"><h3>Hello.</h3></div>
                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra varius quam sit amet vulputate. 
                    Quisque mauris augue, molestie tincidunt condimentum vitae, gravida a libero. Aenean sit amet felis 
                    dolor, in sagittis nisi. Sed ac orci quis tortor imperdiet venenatis. Duis elementum auctor accumsan. 
                    Aliquam in felis sit amet augue.
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading"><h3>Hello.</h3></div>
                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra varius quam sit amet vulputate. 
                    Quisque mauris augue, molestie tincidunt condimentum vitae, gravida a libero. Aenean sit amet felis 
                    dolor, in sagittis nisi. Sed ac orci quis tortor imperdiet venenatis. Duis elementum auctor accumsan. 
                    Aliquam in felis sit amet augue.
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading"><h3>Hello.</h3></div>
                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra varius quam sit amet vulputate. 
                    Quisque mauris augue, molestie tincidunt condimentum vitae, gravida a libero. Aenean sit amet felis 
                    dolor, in sagittis nisi. Sed ac orci quis tortor imperdiet venenatis. Duis elementum auctor accumsan. 
                    Aliquam in felis sit amet augue.
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <br><br>
            <p class="pull-right"><a href="http://www.bootply.com">Template from Bootply</a> &nbsp; ©Copyright 2013 ACME<sup>TM</sup> Brand.</p>
            <br><br>
        </div>
    </div>
</div>

