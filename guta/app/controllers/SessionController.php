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
     * Searches for User
     */
    public function startAction()
    {
        if ($this->request->isPost()) {

            //Receiving the variables sent by POST
            $login = $this->request->getPost('login');
            $password = $this->request->getPost('password');

            $password = $password; //bcrypt

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
        ));
    }

    public function endAction(){
        $this->session->destroy();

        return $this->dispatcher->forward(array(
            'controller' => 'index',
            'action' => 'index'
        ));
    }
}
