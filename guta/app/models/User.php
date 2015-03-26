<?php

use Phalcon\Mvc\Model\Validator\Email as Email;
use Phalcon\Mvc\Model\Validator\Uniqueness as Uniqueness;
use Phalcon\Mvc\Model\Validator\PresenceOf as PresenceOf;
use Phalcon\Mvc\Model\Validator\Regex as RegexValidator;

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



        $this->validate(new PresenceOf([
          'field' => 'email',
          'message' => 'Une adresse mail est nécessaire.'
        ]));

        $this->validate(new Uniqueness([
            'field' => 'email',
            'message' => 'Cette adresse est déjà utilisée.'
        ]));

        $this->validate(new RegexValidator([
            'field' => 'email',
            'pattern' => "/^([a-z0-9_\.-]+)@([a-z0-9\.-]+)\.([a-z\.]{2,6})$/",
            'message' => "Cette adresse n'est pas une adresse email valide."
        ]));


        $this->validate(new PresenceOf([
          'field' => 'login',
          'message' => 'Un identifiant est nécessaire.'
        ]));

        $this->validate(new Uniqueness([
            'field' => 'login',
            'message' => 'Cet identifiant existe déjà.'
        ]));

        $this->validate(new RegexValidator([
            'field' => 'login',
            'pattern' => '/^[a-zA-Z0-9_-]{4,14}$/',
            'message' => "Le nom d'utilisateur doit comporter 4 à 14 caractères alpha-numériques (- et _ sont autorisés)."
        ]));


        $this->validate(new PresenceOf([
          'field' => 'password',
          'message' => 'Un mot de passe est nécessaire.'
        ]));

/*        $this->validate(new RegexValidator([
            'field' => 'password',
            'pattern' => '/^[a-zA-Z0-9?@\.;:!_-]{8,12}$/',
            'message' => "Le mot de passe doit comporter 8 à 12 caractères alpha-numériques (? @ . ; : ! _ et - sont autorisés)."
        ]));*/

        

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
