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
                    {{ link_to("index", "MyDropbox", "class": "navbar-brand") }}
                </div>
                <?php echo $this->elements->getMenu() ?>
        
                <!-- Collection of nav links and other content for toggling -->
                <!--div id="navbarCollapse" class="collapse navbar-collapse">
                    < <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#">Profile</a></li>
                        <li><a href="#">Messages</a></li>
                    </ul> >
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"></a></li>
                    </ul>
                </div-->
            </nav>
		
		{{ content() }}
		{{ assets.outputJs() }}
	</body>
</html>