<?php

use Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{

<<<<<<< HEAD
	public function initialize()
    {
        \Phalcon\Tag::setTitle('MyDropbox');

		$this->assets
    		->addCss("css/bootstrap.min.css")
    		->addCss("css/styles.css");

    	$this->assets
    		->addJs("js/jquery-1.11.2.min.js")
    		->addJS("js/bootstrap.min.js");
=======
    public function initialize()
    {
        \Phalcon\Tag::setTitle('MyDropbox');

        $this->assets
            ->addCss("css/bootstrap.min.css")
            ->addCss("css/styles.css");

        $this->assets
            ->addJs("js/jquery-1.11.2.min.js")
            ->addJS("js/bootstrap.min.js");
>>>>>>> dee10db68518b348ab8f5894778821903246243f
    }
}
