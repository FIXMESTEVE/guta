
<?php echo $this->getContent(); ?>
<div align="center">
    <h1>Modifier votre profil</h1>
</div>

<!-- Login Form -->
<br/><br/>
<div class="row"> 
        <div class="v-center">
            {{ form('user/save','role': 'form', 'class': "form-horizontal", 'style': "width:20%;margin:0 auto;") }}
                <div class="form-group input-group">
                    <span class="input-group-addon" for="login"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
                    {{ text_field('login', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon" for="Email" style="font-weight: bold;"> @ </span>
                    {{ text_field('email', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon" for="password"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></span>
                    {{ password_field('password', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group">
                    <?php echo $this->tag->hiddenField("idUser") ?>
                    <div class="col-sm-offset-2 col-sm-10">
                        <?php //echo $this->tag->submitButton("Save") ?>
                        {{ submit_button('Enregistrer', "class":"btn btn-primary btn-lg") }}
                    </div>
                </div>
            {{ end_form() }}
        </div>
</div>