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
class ContentController extends AbstractActionController
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
    
    public function listAction() {
        return array();
    }
    
    public function getListAction() {
        
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $queryOptions = \Util\DataTables::getListOptions($params);
        $trainingObj = new Training();
        $trainings = $trainingObj->getTrainings($queryOptions);
        echo json_encode(array('recordsTotal'=>$trainings['rows'], 'recordsFiltered'=>$trainings['rows'], 'data'=>$trainings['data']));
        //echo json_encode(array('data'=>$modules));
        
        return $this->response; //Desabilita View y Layout
    }
    
    
}