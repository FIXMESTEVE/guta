<div class="container" style="margin-top:40px">
    <div class="row">
        <div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong> Connexion </strong>
                </div>
                <div class="panel-body">
                    {{ form('session/start', 'role': 'form') }}
                        <fieldset>
                            <div class="row">
                                <div class="center-block">
                                    <img class="profile-img"
                                        src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120" alt="">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                            	<i class="glyphicon glyphicon-user"></i>
                                            </span> 
                                            {{ text_field('login', 'class': "form-control input-lg", "placeholder":"Nom d'utilisateur") }}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-lock"></i>
                                            </span>
                                            {{ password_field('password', 'class': "form-control input-lg", "placeholder":"Mot de passe") }}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="submit" class="btn btn-lg btn-primary btn-block" value="Connexion">
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    {{ end_form() }}
                </div>
                <div class="panel-footer ">
                    Vous n'êtes pas encore inscrit? {{ link_to("index/signup",  "S'inscrire ici.") }}
                </div>
            </div>
        </div>
    </div>
</div>