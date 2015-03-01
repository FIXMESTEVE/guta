<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class ListController extends ControllerBase
{

    public function indexAction()
    {
    	
    	if (!$this->session->has("idUser")) {

        	$idUser = $this->session->get("idUser");

        	$User = User::findFirstByidUser($idUser);

        	$login = $User->login;

        	$cmd = "mkdir TEST";

        	exec($cmd);

			$cmd = "ls TEST/ 2>&1";

			exec($cmd, $output);

			foreach ($output as $item) {
				$tab[] = $item;
			}

			$this->view->setVar('result', $tab);
        }
    }

    public function addAction($file) {

    }

}

