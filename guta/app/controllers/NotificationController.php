<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class NotificationController extends ControllerBase
{

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
    }

    public function readAction($id){
        //Passe a read cette notif dans la base de données
        $notif = Notification::findFirstByIdNotification($id);
        $notif->unread = 0;

        if (!$notif->save()) {
            foreach ($User->getMessages() as $message) {
                $this->flash->error($message);
            }
        }

        //REDIRECTION VERS LE FICHIER PARTAGE!
        //POUR LE MOMENT VERS LA LISTE
        return $this->dispatcher->forward(array(
            'controller' => 'files',
                'action' => 'list'
        ));
    }
}
