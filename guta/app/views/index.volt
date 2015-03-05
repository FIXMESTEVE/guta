<!DOCTYPE html>
<html>
    <head>
        {{ get_title()}}
        {{ assets.outputCss() }}
    </head>
    <body>
        <div class="container-full">
            <nav role="navigation" class="navbar navbar-default">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <?php if($this->session->get('auth')) { ?>
                    {{ link_to("files/list/", "MyDropbox", "class": "navbar-brand") }}
                    <?php } else { ?>
                    {{ link_to("index", "MyDropbox", "class": "navbar-brand") }}
                    <?php } ?>
                </div>
                <?php echo $this->elements->getMenu(); ?>
            </nav>
        
        {{ content() }}
        {{ assets.outputJs() }}
    </body>
</html>