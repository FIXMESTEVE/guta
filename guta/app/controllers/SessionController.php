<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class SessionController extends ControllerBase
{

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
    public function registerSession($user)
    {
        $this->session->set('auth', array(
            'idUser' => $user->idUser,
            'login' => $user->login
        ));
    }

    /**
     *  Searches for User
     */
    public function startAction()
    {
        if ($this->request->isPost()) {

            //Receiving the variables sent by POST
            $login = $this->request->getPost("login");
            $password = $this->request->getPost("password");

            $user = User::findFirstByLogin($login);

            if (!$user) {
                echo '<div class="alert alert-danger" role="alert">';
                $this->flash->error("Cet utilisateur n'existe pas.");
                echo '</div>';
                
                return $this->dispatcher->forward(array(
                    'controller' => 'index',
                    'action' => 'index'
                ));

            } elseif (!$this->security->checkHash($password, $user->password)) {
                echo '<div class="alert alert-danger" role="alert">';
                $this->flash->error("Mot de passe incorrect");
                echo '</div>';
                
                return $this->dispatcher->forward(array(
                    'controller' => 'index',
                    'action' => 'index'
                ));
            } else {

                $this->registerSession($user);

                echo '<div class="alert alert-success" role="alert">';
                $this->flash->success('Bienvenue ' . $user->login);
                echo '</div>';

                $ds = DIRECTORY_SEPARATOR;  // '/'
                $storeFolder = 'uploadedFiles';   // the folder where we store all the files
                $user = $user->idUser;
                $userPath = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds;
                
                $this->response->redirect("files/list/");
                return;
            }
        }
        /*if ($this->request->isPost()) {

            //Receiving the variables sent by POST
            $login = $this->request->getPost('login');
            $password = $this->request->getPost('password');

            $password =  $this->security->hash($password); //bcrypt

            //Find for the user in the database
            $user = User::findFirst(array(
                "login = :login: AND password = :password:",
                "bind" => array('login' => $login, 'password' => $password)
            ));
            if ($user != false) {

                $this->registerSession($user);

                $this->flash->success('Welcome ' . $user->login);

                //REDIRECTION APRES SUCCES DE CONNEXION VERS LA PAGE DES FICHIERS: ACTUELLEMENT VERS LA PAGE D'INSCRIPTION
                return $this->dispatcher->forward(array(
                    'controller' => 'User',
                    'action' => 'index'
                ));
            }

            $this->flash->error('Wrong login/password');
        }

        //Forward to the login form again
        return $this->dispatcher->forward(array(
            'controller' => 'index',
            'action' => 'index'
        ));*/
    }

    public function endAction(){
        $this->session->destroy();

        $this->response->redirect("index");
        /*$this->dispatcher->forward(array(
            'controller' => 'index',
            'action' => 'index'
        ));*/
        return;
    }
}
