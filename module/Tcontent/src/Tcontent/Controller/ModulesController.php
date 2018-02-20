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
use Training\Model\Training;

/**
 * ModulesController
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 * getListAction();
 * updateRowAction();
 * addAction();
 * saveAction();
 * editAction();
 * deleteAction();
 *
 */
class ModulesController extends AbstractActionController
{

    /**
     * The default action - show the home page
     */
    public function indexAction()
    {
        // TODO Auto-generated ModulesController::indexAction() default action
    }
    
    public function listAction(){
        $trainingObj = new Training();
        $cid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        $training = $trainingObj->getTraining($cid);
        $viewModel = new ViewModel(array('training' => $training, 'cid' => $cid));
        return $viewModel;
    }
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function getListAction(){
        
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $cid= 0;
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        $queryOptions = \Util\DataTables::getListOptions($params);
        $moduleObj = new Module();
        $modules = $moduleObj->getModules($queryOptions, $cid);
        echo json_encode(array('recordsTotal'=>$modules['rows'], 'recordsFiltered'=>$modules['rows'], 'data'=>$modules['data']));
        //echo json_encode(array('data'=>$modules));
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    
    /**
     * Actualiza el registro indicado
     * 
     * @return multitype:unknown |\Zend\Stdlib\ResponseInterface
     */
    public function updateRowAction()
    {
        $request = $this->getRequest();
        
        if ($data = $request->getPost('data')){
            //print_r($_POST); return; 
            $moduleObj = new Module();
            if ($moduleObj->updateModule($data)) {
                echo json_encode($_POST);
            }
        }
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    /**
     * 
     * @return \Zend\View\Model\ViewModel
     */
    public function addAction()
    {
        $cid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        
        $viewModel = new ViewModel(array('id' => 0, 'cid' => $cid, 'breadcrumbs' => ' / <a>Add M&oacute;dulo</a>'));
        $viewModel->setTemplate('tcontent/modules/module_form.phtml');
        
        return $viewModel;
        
    }
    
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function saveAction()
    {
        $request = $this->getRequest();
        if ($request->isPost()) {
            $data['titulo'] = $_POST['titulo'];
            $data['descripcion'] = $_POST['descripcion'];
            $data['imagen'] = $_POST['imagen'];
            $data['audio'] = $_POST['audio'];
            $data['audio_descripcion'] = $_POST['audio_descripcion'];
            $data['id'] = $_POST['id'];
            $data['cid'] = $_POST['cid'];
            $moduleObj = new Module();
            if ( $moduleObj->saveModule($data) ) {
                $this->redirect()->toUrl('list?cid='.$data['cid']); // Volver a listar desde el modulo padre
            }else {
                $this->redirect()->toUrl('list?cid='.$data['cid']); // Volver a listar desde el modulo padre
            }
        }
        //Debug::dump($params);
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    
    
    
    public function editAction(){
        $cid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        if (isset($params['id']) && $params['id']>0){
        	$id = $params['id'];        
            $moduleObj = new Module();
            $module = $moduleObj->getModule($id);
            
            $viewModel = new ViewModel(array('module' => $module, 'id' => $module['mod_id'], 'cid' => $cid, 'breadcrumbs' => ' / <a>Edit M&oacute;dulo</a>'));
            $viewModel->setTemplate('tcontent/modules/module_form.phtml');
        }else{
            $this->redirect()->toUrl('list'); 
        }
        
        return $viewModel;
    }
    
    
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function deleteAction(){
        $cid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        if (isset($params['id']) && $params['id']>1){
            $data['id'] = $params['id'];
            $moduleObj = new Module();
            if ( $moduleObj->deleteModule($data) ) {
                $this->redirect()->toUrl('list?cid='.$cid); // Volver a listar desde el modulo padre
            }
        }
        return $this->response; //Desabilita View y Layout
    }
    
    
}