<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2016
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/

namespace Tcontent\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Captcha\Dumb;
use Zend\Debug\Debug;
use Tcontent\Model\Module;
use Tcontent\Model\Lesson;
use Tcontent\Model\Unidadinformacion;

/**
 * ModulesController
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 *
 */
class UnidadopcionController extends AbstractActionController
{

    /**
     * The default action - show the home page
     */
    public function indexAction()
    {
        // TODO Auto-generated ModulesController::indexAction() default action
    }
    
    public function listAction(){
        $moduleObj = new Module();
        $lessonObj = new Lesson();
        $unidadObj = new Unidadinformacion();
        $uid = 0;
        $lid = 0;
        $mid = 0;
        $params = $this->params()->fromQuery();
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['uid']) && $params['uid']>0) {
            $uid= $params['uid'];
        }
        $lesson = $lessonObj->getLesson($lid);
        $module = $moduleObj->getModule($mid);
        $unidad = $unidadObj->getUnidad($uid);
        
        $viewModel = new ViewModel(array('unidad' => $unidad, 'lesson' => $lesson, 'module' => $module, 'uid' => $uid, 'lid' => $lid, 'mid' => $mid));
        return $viewModel;
    }
    
    
    
    
    
}