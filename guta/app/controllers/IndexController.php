<?php

class IndexController extends ControllerBase
{

	public function initialize()
    {
        \Phalcon\Tag::setTitle('MyDropbox');
    }

    public function indexAction()
    {
    	$this->assets
    		->addCss("css/bootstrap.min.css")
    		->addCss("css/styles.css");

    	$this->assets
    		->addJs("js/jquery-1.11.2.min.js")
    		->addJS("js/bootstrap.min.js");
    }

}

