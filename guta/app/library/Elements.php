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
        $phql = "SELECT Notification.* FROM Notification INNER JOIN Sharedfile ON Sharedfile.idShared_File = Notification.id_SharedFile WHERE Sharedfile.id_user = " . $id . " OR Sharedfile.id_owner = " . $id;
        $notifs = $this->modelsManager->executeQuery($phql);
    
        $badge = 0;
        $content= '<div id="popover_content_wrapper" style="display: none"><div class="list-group">';

        foreach ($notifs as $notif) {
            if($notif->unread){
                $badge ++;
                $content .= $this->tag->linkTo(array('notification/read/' . $notif->idNotification, '<b>' . $notif->date . '</b> : ' . $notif->message, 'class' => 'list-group-item active'));
              
            }else
             $content .= $this->tag->linkTo(array('notification/read/' . $notif->idNotification, '<b>' . $notif->date . '</b> : ' . $notif->message, 'class' => 'list-group-item'));
        }
        $content.="</div></div>";

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
    
        // Partager
        /*$this->manageActiveLI('share', 'index', $controllerName, $actionName);
        echo $this->tag->linkTo('share' . '/' . 'index', 'Partager');
        echo '</li>';*/

        // Transférer
        /*$this->manageActiveLI('files', 'index', $controllerName, $actionName);
        echo $this->tag->linkTo('files' . '/' . 'index', 'Transférer');
        echo '</li>';*/
        /*echo '<form class="navbar-form navbar-left" role="form">';
        echo '<button href="#myUploadModal" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-cloud-upload" style="color:blue;" aria-hidden="true"></span></button>';
        echo '</form>';

        // Nouveau dossier
        echo '<form class="navbar-form navbar-left" role="form">';
        echo '<button href="#myModal" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-folder-open" style="color:blue;" aria-hidden="true"></span></button>';
        echo '</form>';*/

         // Recherche
        /*echo $this->tag->form(array("files/search", "method" => "post", "class" =>"navbar-form navbar-left", "role" => "search"));
        echo '<div class="form-group">';
        echo $this->tag->textfield(array("pattern", "class" => "form-control", "id" => "inputSearch", "placeholder" =>"Recherche"));
        echo '</div>';
        echo $this->tag->submitButton(array("Go!", "class" => "btn btn-default"));
        echo $this->tag->endForm();*/

        echo '<form class="navbar-form navbar-left" role="form">';
        echo '<div class="btn-group" role="group" aria-label="...">'.
             '<button href="#" title="Partager" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-share" style="color:blue;" aria-hidden="true"></span></button>'.
             '<button href="#myUploadModal" title="Transférer" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-cloud-upload" style="color:blue;" aria-hidden="true"></span></button>'.
             '<button href="#myModal" title="Nouveau dossier" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-folder-open" style="color:blue;" aria-hidden="true"></span></button>'.
            '</div>';
        echo '</form>';

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
        echo $this->tag->linkTo('session' . '/' . 'end', 'Déconnection');
        echo '</li>';

        echo '</ul>';
        echo '</div>';
    }
}

