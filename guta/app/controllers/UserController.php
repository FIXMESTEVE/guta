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
     * Edits a User
     *
     * @param string $idUser
     */
    public function editAction()
    {
        $user = $this->session->get('auth');
        $User = User::findFirstByidUser($user['idUser']);
        if (!$User) {
            $this->flash->error("User was not found");
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "index"
            ));
        }

        $this->view->idUser = $User->idUser;

        $this->tag->setDefault("idUser", $User->idUser);
        $this->tag->setDefault("login", $User->login);
        $this->tag->setDefault("email", $User->email);
    }

    /**
     * Creates a new User
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->response->redirect("");
            return;
        }

        $user = new User();
        $user->email = $this->request->getPost("email", "email");;
        $user->login = $this->request->getPost("login");
        $password = $this->request->getPost("password");
        if(!preg_match("/^[a-zA-Z0-9?@\.;:!_-]{8,12}$/", $password)) {
            $this->flash->error("Le mot de passe doit comporter 8 à 12 caractères alpha-numériques (? @ . ; : ! _ et - sont autorisés).");
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "signup"
            ));
        }
        $user->password = $this->security->hash($password);

        if (!$user->save()) {
            $this->flash->error($user->getMessages()[0]);
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "signup"
            ));

        } else {
            $ds          = DIRECTORY_SEPARATOR;  // '/'
            $storeFolder = 'uploadedFiles';   // the folder where we store all the files
            if(!file_exists(dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder))
                mkdir(dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder);
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

            exec("svn checkout --force file:///".$svnrep.$ds.$user." ".$targetPath);

            $this->response->redirect("");
            return;

            /*$this->flash->success("L'inscription s'est déroulée correctement.");
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "index"
            ));*/
        }
    }

    /**
     * Saves a User edited
     *
     */
    public function saveAction()
    {
        if (!$this->request->isPost()) {
            $this->response->redirect("");
            return;
        }

        $idUser = $this->request->getPost("idUser");

        $user = User::findFirstByidUser($idUser);
        if (!$user) {
            $this->flash->error("User does not exist " . $idUser);
            return $this->dispatcher->forward(array(
                "controller" => "user",
                "action" => "edit"
            ));
        }

        $user->login = $this->request->getPost("login");;
        $user->email =$this->request->getPost("email", "email");
        $password = $this->request->getPost("password");
        $user->password = $this->security->hash($password);
        
        if (!$user->save()) {
            $this->flash->error($user->getMessages()[0]);
            return $this->dispatcher->forward(array(
                "controller" => "user",
                "action" => "edit"
            ));
        }

        $this->flash->success("User was updated successfully");
        return $this->dispatcher->forward(array(
            "controller" => "files",
            "action" => "list"
        ));
    }

    /**
     * Deletes a User
     *
     * @param string $idUser
     */
/*    public function deleteAction($idUser)
    {
        $User = User::findFirstByidUser($idUser);
        if (!$User) {
            $this->flash->error("User was not found");
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "index"
            ));
        }

        if (!$User->delete()) {
            foreach ($User->getMessages() as $message) {
                $this->flash->error($message);
            }
            return $this->dispatcher->forward(array(
                "controller" => "index",
                "action" => "index"
            ));
        }
        $this->flash->success("User was deleted successfully");
        return $this->dispatcher->forward(array(
            "controller" => "index",
            "action" => "index"
        ));
    }*/
}
