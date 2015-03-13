
<?php echo $this->getContent(); ?>
<div align="center">
    <h1>Modifier votre profil</h1>
</div>

<!-- Login Form -->
<div class="row"> 
        <div class="v-center">
            {{ form('User/save','role': 'form', 'class': "form-horizontal", 'style': "width:35%;margin:0 auto;") }}
                <div class="form-group ">
                    <label for="avatar" class="col-sm-2 control-label">Avatar</label>
                    <div id="avatar" class="col-sm-10">
                        <?php
                        echo Phalcon\Tag::image(array("avatars/".$idUser.".gif", "id" => "avatarPicture", "style" => "width: 84px;"));
                        ?>
                        
                        <div id="avatarOverlay">
                            <div id="overlayButton"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><input type="file" id="upload" /></div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="login" class="col-sm-2 control-label">Nom d'utilisateur</label>
                    <div class="col-sm-10">
                        {{ text_field('login', 'class': "form-control input-lg") }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="Email" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        {{ text_field('email', 'class': "form-control input-lg") }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">Mot de passe</label>
                    <div class="col-sm-10">
                        {{ password_field('password', 'class': "form-control input-lg") }}
                    </div>
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