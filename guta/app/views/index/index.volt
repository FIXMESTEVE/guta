    <div class="row"> 
        <div class="col-lg-12  v-center">
            <h1 class="text-center">Stocker, partager et accéder à tous vos fichiers en toute simplicité</h1>
            <br><br>
<<<<<<< HEAD
  
            {{ form('user/create', 'method': 'post', "class": "col-lg-12", "style": "width:340px;margin:0 auto;") }}
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
                {{ submit_button('Inscription', "class":"btn btn-primary btn-lg") }}
            {{ end_form() }}
=======
            {{ form('session/start', 'role': 'form', 'class': "col-lg-12", 'style': "width:340px;margin:0 auto;") }}
            <div class="form-group ">
                <label for="login">Login</label>
                {{ text_field('login', 'class': "form-control input-lg") }}
            </div>
            <div class="form-group ">
                <label for="password">Password</label>
                {{ password_field('password', 'class': "form-control input-lg") }}
            </div>
            {{ submit_button('Login', 'class': "btn btn-primary btn-lg") }}
        </form>
>>>>>>> dee10db68518b348ab8f5894778821903246243f
        </div>
    </div>
 
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

