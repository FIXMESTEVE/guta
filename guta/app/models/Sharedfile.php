<?php

use Phalcon\Mvc\Model\Validator\PresenceOf as PresenceOf;

class Sharedfile extends \Phalcon\Mvc\Model
{
    /**
     *
     * @var integer
     */
    public $idShared_File;

    /**
     *
     * @var integer
     */
    public $id_user;

    /**
     *
     * @var integer
     */
    public $id_owner;

    /**
     *
     * @var integer
     */
    public $path;

    /**
     * Validations and business logic
     */
    public function validation()
    {
        $this->validate(new PresenceOf([
          'field' => 'idShared_File',
          'message' => 'Un identifiant de fichier est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'id_owner',
          'message' => 'Un identifiant propriétaire est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'id_user',
          'message' => 'Un identifiant utilisateur est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'path',
          'message' => 'Un chemin est nécessaire.'
        ]));

        if ($this->validationHasFailed() == true) {
            return false;
        }
    }

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSource('Sharedfile');
    }

    public function getSource()
    {
        return 'Sharedfile';
    }
}
