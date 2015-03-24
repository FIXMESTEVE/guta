<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class UserController extends ControllerBase
{
    public function initialize()
    {
        $this->assets
            ->addCss("css/bootstrap.min.css")
            ->addCss("css/design.css")
            ->addCss("css/hideMenuIcone.css");

        $this->assets
            ->addJs("js/jquery-1.11.2.min.js")
            ->addJS("js/bootstrap.min.js")
            ->addJs("js/utils.js");
    }

    
    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
    }

    /**
     * Searches for User
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, "User", $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = array();
        }
        $parameters["order"] = "idUser";

        $User = User::find($parameters);
        if (count($User) == 0) {
            $this->flash->notice("The search did not find any User");
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "index"
            ));
        }

        $paginator = new Paginator(array(
            "data" => $User,
            "limit"=> 10,
            "page" => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
    }

    /**
     * Displayes the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a User
     *
     * @param string $idUser
     */
    public function editAction($idUser)
    {
        if (!$this->request->isPost()) {

            $User = User::findFirstByidUser($idUser);
            if (!$User) {
                $this->flash->error("User was not found");
                return $this->dispatcher->forward(array(
                    "controller" => "User",
                    "action" => "index"
                ));
            }

            $this->view->idUser = $User->idUser;

            $this->tag->setDefault("idUser", $User->idUser);
            $this->tag->setDefault("login", $User->login);
            $this->tag->setDefault("email", $User->email);
            //$this->tag->setDefault("password", $User->password);
            $this->tag->setDefault("avatar", "avatars/default.gif");
            
        }
    }

    /**
     * Creates a new User
     */
    public function createAction()
    {

        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "index"
            ));
        }

        $User = new User();

        $User->login = $this->request->getPost("login");
        $User->email = $this->request->getPost("email", "email");
        $password = $this->request->getPost("password");
        $User->password = $this->security->hash($password);

        if (!$User->save()) {
            foreach ($User->getMessages() as $message) { 
                $this->flash->error($message);  
            }
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "new"
            ));
        } else {

            $ds          = DIRECTORY_SEPARATOR;  // '/'
            $storeFolder = 'uploadedFiles';   // the folder where we store all the files
            $user = $User->idUser;
            $svnrep = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . "svnrep";
            if(!file_exists($svnrep))
                mkdir($svnrep);
            if(!file_exists(dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . "svnrep".$ds.$user)){
                //create svn repo
                chdir($svnrep);
                exec("svnadmin create ".$user);
                chdir("..");
            }

            $targetPath = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds;

            //mkdir($targetPath);
            //chdir($targetPath);
            exec("svn checkout --force file:///".$svnrep.$ds.$user." ".$targetPath);

            

            //exec("git init " . $targetPath, $output, $result);
            
            //exec("git config user.name \"someone\"");
            //exec("git config user.email \"someone@someplace.com\"");
            //file_put_contents($targetPath.$ds."resultCreate", implode("\r\n", $output), FILE_APPEND);

            $this->flash->success("L'inscription s'est déroulée correctement.");
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "index"
            ));
        }
    }

    /**
     * Saves a User edited
     *
     */
    public function saveAction()
    {
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "index"
            ));
        }

        $idUser = $this->request->getPost("idUser");

        $User = User::findFirstByidUser($idUser);
        if (!$User) {
            $this->flash->error("User does not exist " . $idUser);
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "index"
            ));
        }

        $User->login = $this->request->getPost("login");
        $User->email = $this->request->getPost("email", "email");
        $password = $this->request->getPost("password");
        $User->password = $this->security->hash($password);
        $User->avatar = $this->request->getPost("avatar");
        
        if (!$User->save()) {
            foreach ($User->getMessages() as $message) {
                $this->flash->error($message);
            }
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "edit",
                "params" => array($User->idUser)
            ));
        }

        $this->flash->success("User was updated successfully");
        return $this->dispatcher->forward(array(
            "controller" => "Files",
            "action" => "list"
        ));
    }

    /**
     * Deletes a User
     *
     * @param string $idUser
     */
    public function deleteAction($idUser)
    {
        $User = User::findFirstByidUser($idUser);
        if (!$User) {
            $this->flash->error("User was not found");
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "index"
            ));
        }

        if (!$User->delete()) {
            foreach ($User->getMessages() as $message) {
                $this->flash->error($message);
            }
            return $this->dispatcher->forward(array(
                "controller" => "User",
                "action" => "search"
            ));
        }
        $this->flash->success("User was deleted successfully");
        return $this->dispatcher->forward(array(
            "controller" => "User",
            "action" => "index"
        ));
    }
}
