
<?php echo $this->getContent(); ?>
<div align="center">
    <h1>Modifier votre profil</h1>
</div>

<!-- Login Form -->
<div class="row"> 
        <div class="col-lg-12 v-center">
            {{ form('User/save','role': 'form', 'class': "col-lg-12", 'style': "width:340px;margin:0 auto;") }}
                <div class="form-group ">
                    <label for="avatar">Avatar</label>
                    <div id="avatar">
                        <?php
                        echo Phalcon\Tag::image(array("avatars/".$idUser.".gif", "id" => "avatarPicture", "style" => "width: 84px;"));
                        ?>
                        
                        <div id="avatarOverlay">
                            <div id="overlayButton"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><input type="file" id="upload" /></div>
                        </div>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="login">Nom d'utilisateur</label>
                    {{ text_field('login', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group ">
                    <label for="Email">Email</label>
                    {{ text_field('email', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group ">
                    <label for="password">Mot de passe</label>
                    {{ password_field('password', 'class': "form-control input-lg") }}
                </div>
                <div class="form-group">
                    <?php echo $this->tag->hiddenField("id") ?>
                    <?php echo $this->tag->submitButton("Save") ?>
                </div>
            {{ end_form() }}
        </div>
</div>