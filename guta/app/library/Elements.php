<?php
use Phalcon\Mvc\User\Component;
/**
 * Elements
 *
 * Helps to build UI elements for the application
 */
class Elements extends Component
{
    private function isActive($targetedController, $targetedAction, $currentController, $currentAction){
        if($targetedController == $currentController)
            if($targetedAction == $currentAction)
                return true;
        return false;
    }

    private function manageActiveLI($targetedController, $targetedAction, $currentController, $currentAction){
        if($this->isActive($targetedController, $targetedAction, $currentController, $currentAction))
            echo '<li class="active">';
        else
            echo '<li>';
    }

    private function addNotification($id){
        $phql = "SELECT Notification.* FROM Notification INNER JOIN Sharedfile ON Sharedfile.idShared_File = Notification.id_SharedFile WHERE Sharedfile.id_user = " . $id;
        $notifs = $this->modelsManager->executeQuery($phql);
    
        $badge = 0;
        $content= '<div id="popover_content_wrapper" style="display: none"><div class="list-group">';

        foreach ($notifs as $notif) {
            if($notif->unread){
                $badge ++;
                $content .='<div class="list-group-item active">';
                $content .= $this->tag->linkTo(array('notification/read/' . $notif->idNotification, '<b>' . $notif->date . '</b> : ' . $notif->message, 'class' => 'list-group-item active', 'style' => 'padding: 0; border: 0px; margin: 0, 5px, 5px, 5px;'));
            }else {
                $content .='<div class="list-group-item">';
                $content .= $this->tag->linkTo(array('notification/delete/' . $notif->idNotification, "<button type='button' class='close' aria-label='Close'><span aria-hidden='true'>&times;</span></button>", 'style' => 'border: 0px;'));
                $content .= '</br>';
                $content .= $this->tag->linkTo(array('notification/read/' . $notif->idNotification, '<b>' . $notif->date . '</b> : ' . $notif->message, 'class' => 'list-group-item',  'style' => 'padding: 0; border: 0px; margin: 0, 5px, 5px, 5px;'));
            }
            $content .='</div>';
        }
        $content.= "</div></div>";

        echo $content;
        echo '<li data-container="body" data-toggle="popover" data-placement="bottom"><a style="cursor:pointer;">
        <span class="glyphicon glyphicon-bell" aria-hidden="true"></span> Notifications <span class="badge">'.$badge.'</span></a></li>';
    }

     /* Builds header menu with left and right items
     *
     * @return string
     */
    public function getMenu()
    {
        $auth = $this->session->get('auth');

        if (!$auth) return;

        $controllerName = $this->view->getControllerName();
        $actionName = $this->view->getActionName();

        // MENU PARTIE GAUCHE
        echo '<div class="collapse navbar-collapse" id="navbarCollapse">';
        echo '<ul class="nav navbar-nav">';

        // Mes fichiers
        $this->manageActiveLI('files', 'list', $controllerName, $actionName);
        echo $this->tag->linkTo('files' . '/' . 'list', 'Mes fichiers');
        echo '</li>';
       
        // Checking if in a shared directory and desactivating share, upload and new direcotry modals
        if(!is_numeric(current(explode('/', substr($_SERVER['REQUEST_URI'], strlen($this->url->getBaseUri() . "files/list/")))))) {
            echo '<div class="navbar-form navbar-left">';
            echo '<div class="btn-group" role="group" aria-label="...">'.
                '<button href="#shareModal" title="Partager" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-share" style="color:#375a7f;" aria-hidden="true"></span></button>';
            if(substr($_SERVER['REQUEST_URI'], strlen($this->url->getBaseUri() . "files/")) != "search")
                echo '<button href="#uploadModal" title="Transférer" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-open" style="color:#375a7f;" aria-hidden="true"></span></button>'.
                    '<button href="#newFolderModal" title="Nouveau dossier" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-folder-open" style="color:#375a7f;" aria-hidden="true"></span></button>'.
                    '</div>';
            echo '</div>';
        }
        echo '</ul>';


        // MENU PARTIE DROITE
        echo '<ul class="nav navbar-nav navbar-right">';

        // Notifications
        $this->addNotification($auth['idUser']);

        // User
        $this->manageActiveLI('user', 'edit', $controllerName, $actionName);
        echo $this->tag->linkTo('user' . '/' . 'edit'. '/' . $auth['idUser'], $auth['login']);
        echo '</li>';

        // Déconnection
        echo '<li>';
        echo $this->tag->linkTo('session' . '/' . 'end', '<span class="glyphicon glyphicon-off" style="color:white;" aria-hidden="true"></span>');
        echo '</li>';

        echo '</ul>';
        echo '</div>';
    }
}

