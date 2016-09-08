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
class UnidadinformacionController extends AbstractActionController
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
        $lid= 0;
        $mid = 0;
        $params = $this->params()->fromQuery();
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        $lesson = $lessonObj->getLesson($lid);
        $module = $moduleObj->getModule($mid);
        $viewModel = new ViewModel(array('lesson' => $lesson, 'module' => $module, 'lid' => $lid, 'mid' => $mid));
        return $viewModel;
    }
    
    
    
    public function getListAction(){
        
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $lid = 0;
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        $queryOptions = \Util\DataTables::getListOptions($params);
        $unidadObj = new Unidadinformacion();
        $unidades = $unidadObj->getUnidades($queryOptions, $lid);
        echo json_encode(array('recordsTotal'=>$unidades['rows'], 'recordsFiltered'=>$unidades['rows'], 'data'=>$unidades['data']));
        //echo json_encode(array('data'=>$unidades));
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    public function updateRowAction()
    {
        $request = $this->getRequest();
        if ($data = $request->getPost('data')){
            //print_r($data); return; 
            $field = '';
            foreach ( $data as $d ) {
                foreach ( $d as $k => $f ){
                    $field = $k;
                }
            }
            //print_r(substr($field, 0, 3)); return;
            if (substr($field, 0, 7) == 'lec_ele') {
                $moduleObj = new Lesson();
                if ( $moduleObj->updateUnidad($data) ) {
                    echo json_encode($_POST);
                }
            }else{
                $unidadObj = new Unidadinformacion();
                if ($unidadObj->updateUnidad($data)) { 
                    echo json_encode($_POST);
                } 
            }            
        }
        
        return $this->response; //Desabilita View y Layout
    }
   
    
    
}