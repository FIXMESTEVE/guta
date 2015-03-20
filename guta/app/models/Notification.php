<?php

use Phalcon\Mvc\Model\Validator\PresenceOf as PresenceOf;
use Phalcon\Mvc\Model\Manager as ModelsManager;

class Notification extends \Phalcon\Mvc\Model
{
    /**
     *
     * @var integer
     */
    public $idNotification;

    public $date;

    /**
     *
     * @var string
     */
    public $message;

    /**
     *
     * @var string
     */
    public $id_SharedFile;

    /**
     *
     * @var boolean
     */
    public $unread;

    /**
     * Validations and business logic
     */
    public function validation()
    {
        $this->validate(new PresenceOf([
          'field' => 'message',
          'message' => 'Un message est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'unread',
          'message' => 'Un booléen indiquant la lecture de la notif est nécessaire'
        ]));

        if ($this->validationHasFailed() == true) {
            return false;
        }
    }

    public function beforeValidationOnCreate()
    {
        $this->date = date('Y-m-d H:i:s');
    }

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSource('Notification');
    }

}
