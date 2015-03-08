<?php
use Phalcon\Mvc\User\Component;
/**
 * Elements
 *
 * Helps to build UI elements for the application
 */
class Elements extends Component
{
    private $_headerMenu = array(
        'navbar-left' => array(
            'files' => array(
                'caption' => 'Upload',
                'action' => 'index'
            ),
            'share' => array(
                'caption' => 'Share',
                'action' => 'index'
            ),
            'addDirectory' => array(
                'caption' => 'New directory',
                'action' => 'index'
            )
        ),
        
    );
    
     /* Builds header menu with left and right items
     *
     * @return string
     */
    public function getMenu()
    {
        $auth = $this->session->get('auth');
        if ($auth) {
            $this->_headerMenu['navbar-right']['user'] = array(
                'caption' => $auth['login'],
                'action' => 'edit',
                'params' => $auth['idUser']
            );
            $this->_headerMenu['navbar-right']['session'] = array(
                'caption' => 'Déconnection',
                'action' => 'end'
            );

            $controllerName = $this->view->getControllerName();
            foreach ($this->_headerMenu as $position => $menu) {
                echo '<div class="nav-collapse">';
                echo '<ul class="nav navbar-nav ', $position, '">';

                foreach ($menu as $controller => $option) {
                    if ($controllerName == $controller) {
                        echo '<li class="active">';
                    } else {
                        echo '<li>';
                    }

                    if(isset($option['params']))
                        echo $this->tag->linkTo($controller . '/' . $option['action'] . '/' . $option['params'], $option['caption']);
                    else
                        echo $this->tag->linkTo($controller . '/' . $option['action'], $option['caption']);
                    echo '</li>';
                }
                
                    echo '</ul>';
                    echo '</div>';
                }

            $phql = "SELECT Notification.* FROM Notification INNER JOIN Sharedfile ON Sharedfile.idShared_File = Notification.id_SharedFile WHERE Sharedfile.id_user = " . $auth['idUser'] . " OR Sharedfile.id_owner = " . $auth['idUser'];
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
            echo '<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="bottom" 
                ><span class="glyphicon glyphicon-bell" aria-hidden="true"></span> Notifications <span class="badge">'.$badge.'</span></button>';
        } else {

        }
    }
}

