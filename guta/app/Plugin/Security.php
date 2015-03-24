<?php

use Phalcon\Events\Event,
    Phalcon\Mvc\Dispatcher,
    Phalcon\Mvc\User\Plugin;

class Security extends Plugin
{

	private function _getAcl(){
		//Create the ACL
		$acl = new Phalcon\Acl\Adapter\Memory();

		//The default action is DENY access
		$acl->setDefaultAction(Phalcon\Acl::DENY);

		//Register two roles, Users is registered users
		//and guests are users without a defined identity
		$roles = array(
		    'users' => new Phalcon\Acl\Role('Users'),
		    'guests' => new Phalcon\Acl\Role('Guests')
		);
		foreach ($roles as $role) {
		    $acl->addRole($role);
		}

		//Accessible en guest
		$publicResources = array(
			'index' => array('index', 'signup'),
			'user' => array('create'),
			'session' => array('start', 'end')
		);
		foreach ($publicResources as $resource => $actions) {
		    $acl->addResource(new Phalcon\Acl\Resource($resource), $actions);
		}
		//Accessible en user
		$privateResources = array(
			'files' => array('upload', 'delete', 'download', 'list', 'copy', 'paste', 'getVersion', 'getFile', 'viewPDF', 'readFile', 'createFolder', 'search', 'share'),
			'notification' => array('read'),
			'user' => array('edit', 'delete', 'save')
		);
		foreach ($privateResources as $resource => $actions) {
		    $acl->addResource(new Phalcon\Acl\Resource($resource), $actions);
		}

		//Grant access to private area only to role Users
		foreach ($privateResources as $resource => $actions) {
		    foreach ($actions as $action) {
		        $acl->allow('Users', $resource, $action);
		    }
		}
		//Grant access to public areas to both users and guests
		foreach ($roles as $role) {
		    foreach ($publicResources as $resource => $actions) {
		        $acl->allow($role->getName(), $resource, $actions);
		    }
		}
		return $acl;
	}

    public function beforeExecuteRoute(Event $event, Dispatcher $dispatcher)
    {
        $auth = $this->session->get('auth');
        if (!$auth) {
            $role = 'Guests';
        } else {
            $role = 'Users';
        }

        //Active controller and action
        $controller = $dispatcher->getControllerName();
        $action = $dispatcher->getActionName();

        //Access control list
        $acl = $this->_getAcl();

		$allowed = $acl->isAllowed($role, $controller, $action);
        if ($allowed != Phalcon\Acl::ALLOW) {
        	$this->flash->error("Vous n'avez pas accès à cette partie du site");
        	$dispatcher->forward(
                array(
                    'controller' => 'index',
                    'action' => 'index'
                )
            );
            return false;
        }
    }

}