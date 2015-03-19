{{ content() }}

<h1 class="text-center">Inscription</h1>
<div align="left">
{{ form('user/create', 'method': 'post', "class": "col-lg-12", "style": "width:340px;margin:0 auto;") }}
    <div class="form-group input-group">
        <span class="input-group-addon" for="mail">Adresse mail</span>
        {{ email_field("email","class": "form-control",  "id": "inputEmail", "placeholder": "Adresse mail") }}
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
</div>