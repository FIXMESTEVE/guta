<?php

class IndexController extends ControllerBase
{

	public function initialize()
    {
        $this->tag->setTitle('MyDropbox');

        $this->assets
            ->addCss("css/bootstrap.min.css")
            ->addCss("css/styles.css");

        $this->assets
            ->addJs("js/jquery-1.11.2.min.js")
            ->addJS("js/bootstrap.min.js");
    }


    public function indexAction()
    {
        $this->view->template = "partials/SignInForm";
    }


    public function signupAction()
    {
        $this->view->pick("index/index");
        $this->view->template = "partials/SignUpForm";
    }

}

