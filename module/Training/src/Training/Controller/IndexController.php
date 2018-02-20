<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2018
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/

namespace Training\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Captcha\Dumb;
use Zend\Debug\Debug;
use Training\Model\Training;

/**
 * IndexController
 *
 *
 * METODOS
 * indexAction();
 *
 */
class IndexController extends AbstractActionController
{

    /**
     * The default action - show the home page
     */
    public function indexAction()
    {
        $trainingObj = new Training();
        $trainings = $trainingObj->getAllTrainings();
        print_r($trainings);
        // TODO Auto-generated ModulesController::indexAction() default action
    }    
    
    
}