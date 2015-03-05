<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class ListController extends ControllerBase
{

	/**
	 * Display user's directory
	 *
	 */
    public function indexAction()
    {

    	/*if ($this->session->has("idUser")) {

        	$idUser = $this->session->get("idUser");

        	$User = User::findFirstByidUser($idUser);

        	$this->persistent->idUser = $User->idUser;

        	exec("cd " . $UserId);

			exec("ls 2>&1", $output);

			$this->view->setVar('result', $output);
        }*/

        if($this->persistent->way == null)
        	$this->persistent->way = "4/";

        $UserId = $this->persistent->way;

    	exec("ls 2>&1", $output);

		//exec("cd " . $UserId);*/

		$this->view->setVar('result', $output);
    }

    /*
     * Display content of a subdirectory
     *
     */
    public function viewAction($file) {

    	$this->persistent->way = $this->persistent->way . $file;

    	echo($this->persistent->way);

    	return $this->dispatcher->forward(array(
                "controller" => "List",
                "action" => "index"
            ));
    }

    public function addAction($file) {

    }

}

