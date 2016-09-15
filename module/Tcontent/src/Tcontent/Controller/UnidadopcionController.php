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
use Tcontent\Model\UnidadinformacionOpcion;

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
    
    
    public function getListAction(){
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $uid = 0;
        if (isset($params['uid']) && $params['uid']>0) {
            $uid= $params['uid'];
        }
        $queryOptions = \Util\DataTables::getListOptions($params);
        $opcionObj = new UnidadinformacionOpcion();
        $opciones = $opcionObj->getOpciones($queryOptions, $uid); 
        echo json_encode(array('recordsTotal'=>$opciones['rows'], 'recordsFiltered'=>$opciones['rows'], 'data'=>$opciones['data']));
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
            if (substr($field, 0, 9) == 'uni_inf_x' || substr($field, 0, 20) == 'uni_inf_opc_feedback') {
                $unidadObj = new Unidadinformacion();
                if ( $unidadObj->updateOpcion($data) ) {
                    echo json_encode($_POST);
                }
            }else{
                $opcionObj = new UnidadinformacionOpcion();
                if ($opcionObj->updateOpcion($data)) { 
                    echo json_encode($_POST);
                } 
            }            
        }
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    
    public function addAction()
    {
        $mid = 0;
        $lid = 0;
        $uid = 0;
        $params = $this->params()->fromQuery();
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['uid']) && $params['uid']>0) {
            $uid= $params['uid'];
        }
        
        $viewModel = new ViewModel(array('id' => 0, 'mid' => $mid, 'lid' => $lid, 'uid' => $uid, 'breadcrumbs' => ' / <a>Add Opción y/o respuesta</a>'));
        $viewModel->setTemplate('tcontent/unidadopcion/opcion_form.phtml');
        
        return $viewModel;
        
    }
    
    
    
    public function editAction(){
        $params = $this->params()->fromQuery();
        $mid = 0;
        $lid = 0;
        $uid = 0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['uid']) && $params['uid']>0) {
            $uid= $params['uid'];
        }
        if (isset($params['id']) && $params['id']>0){
        	$id = $params['id'];        
            $opcionObj = new UnidadinformacionOpcion();
            $opcion = $opcionObj->getOpcion($id);
            
            $viewModel = new ViewModel(array('opcion' => $opcion, 'id' => $opcion['uni_inf_opc_id'], 'mid' => $mid, 'lid' => $lid, 'uid' => $uid, 'breadcrumbs' => ' / <a>Edit Opción y/o respuesta</a>'));
            $viewModel->setTemplate('tcontent/unidadopcion/opcion_form.phtml');
        }else{
            $this->redirect()->toUrl('list?mid='.$mid.'&lid='.$lid.'&uid='.$uid); 
        }
        
        return $viewModel;
    }
    
    
    
    
    
}