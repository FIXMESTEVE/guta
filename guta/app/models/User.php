<?php

use Phalcon\Mvc\Model\Validator\Email as Email;
use Phalcon\Mvc\Model\Validator\Uniqueness as Uniqueness;
use Phalcon\Mvc\Model\Validator\PresenceOf as PresenceOf;

class User extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $idUser;

    /**
     *
     * @var string
     */
    public $login;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var string
     */
    public $password;

    /**
     *
     * @var string
     */
    public $avatar;

    /**
     * Validations and business logic
     */
    public function validation()
    {

        $this->validate( new Email([
            'field'    => 'email',
            'required' => true,
        ]));

        // Test if fields have a value different of nul and empty
        // string.
        $this->validate(new PresenceOf([
          'field' => 'login',
          'message' => 'Un identifiant est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'email',
          'message' => 'Une adresse mail est nécessaire.'
        ]));

        $this->validate(new PresenceOf([
          'field' => 'password',
          'message' => 'Un mot de passe est nécessaire.'
        ]));


        // Test if the login or the email doesn't already exist.
        $this->validate(new Uniqueness([
            'field' => 'email',
            'message' => 'Cette adresse est déjà utilisée.'
        ]));

        $this->validate(new Uniqueness([
            'field' => 'login',
            'message' => 'Cet identifiant existe déjà.'
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
        $this->setSource('User');
        /*$this->hasMany("idUser", "shared_file", "id_user");
        $this->hasMany("idUser", "shared_file", "id_owner");
        $this->hasMany("idUser", "folder", "id_user");*/
    }

}
