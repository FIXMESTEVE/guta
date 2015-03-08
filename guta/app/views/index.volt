<!DOCTYPE html>
<html>
    <head>
        {{ get_title()}}
        {{ assets.outputCss() }}
        {{ assets.outputJs() }}
        <script type="text/javascript">
            $(document).ready(function(){
                $('[data-toggle="popover"]').popover({ 
                    html : true, 
                    content: function() {
                        return $('#popover_content_wrapper').html();
                    }
                });   
            });
        </script>

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
                    {{ link_to("index", "MyDropbox", "class": "navbar-brand") }}
                </div>
                <?php echo $this->elements->getMenu(); ?>
            </nav>
        
        {{ content() }}
        {{ assets.outputJs() }}
    </body>
</html>