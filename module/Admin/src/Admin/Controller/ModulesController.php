<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2014
* @updated
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/

namespace Admin\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Admin\Model\Module;
use Zend\Captcha\Dumb;
use Zend\Debug\Debug;

/**
 * ModulesController
 *
 * @author
 *
 * @version
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 * getListAction();
 * updateRowAction();
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
    
    /**
     * Lista los modulos
     */
    public function listAction(){
        $params = $this->params()->fromQuery();
        $pid = 1;
        if (isset($params['pid']) && $params['pid']>1){
            $pid = $params['pid'];
        }
        $moduleObj = new Module();
        $breadcrumbs = $moduleObj->getBreadcrumbs($pid);
        return array('pid' => $pid, 'breadcrumbs' => $breadcrumbs);
    }
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function getListAction(){
        
        $request = $this->getRequest();
        $pid = 1;
        $params = $this->params()->fromQuery();
        $queryOptions = \Util\DataTables::getListOptions($params);
        if (isset($params['pid']) && $params['pid']>1){
            $pid = $params['pid'];
        }
        $moduleObj = new Module();
        $modules = $moduleObj->getModules($pid, $queryOptions);
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
        $pid = 1;
        $params = $this->params()->fromQuery();
        if (isset($params['pid']) && $params['pid']>1){
        	$pid = $params['pid'];
        }
        
        $moduleObj = new Module();
        $modules = $moduleObj->getAllModules();
        
        $viewModel = new ViewModel(array('modules' => $modules, 'id' => 0, 'pid' => $pid, 'breadcrumbs' => ' / <a>Add M&oacute;dulo</a>'));
        $viewModel->setTemplate('admin/modules/module_form.phtml');
        
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
            $data['pid'] = $_POST['pid'];
            $data['name'] = $_POST['name'];
            $data['description'] = $_POST['description'];
            $data['url'] = $_POST['url'];
            $data['icon'] = $_POST['icon'];
            $data['id'] = $_POST['id'];
            $moduleObj = new Module();
            if ( $moduleObj->saveModule($data) ) {
                $this->redirect()->toUrl('list?pid='.$data['pid']); // Volver a listar desde el modulo padre
            }
        }
        //Debug::dump($params);
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function deleteAction(){
        $params = $this->params()->fromQuery();
        if (isset($params['id']) && $params['id']>1){
            $data['pid'] = $params['pid'];
            $data['id'] = $params['id'];
            $moduleObj = new Module();
            if ( $moduleObj->deleteModule($data) ) {
                $this->redirect()->toUrl('list?pid='.$data['pid']); // Volver a listar desde el modulo padre
            }
        }
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    public function editAction(){
        $params = $this->params()->fromQuery();
        if (isset($params['id']) && $params['id']>0){
        	$id = $params['id'];        
            $moduleObj = new Module();
            $module = $moduleObj->getModule($id);
            $modules = $moduleObj->getAllModules();
            
            $viewModel = new ViewModel(array('module' => $module, 'modules' => $modules, 'id' => $module['COR_MOD_ID'], 'pid' => $module['COR_MOD_PID'], 'breadcrumbs' => ' / <a>Edit M&oacute;dulo</a>'));
            $viewModel->setTemplate('admin/modules/module_form.phtml');
        }else{
            $this->redirect()->toUrl('list'); 
        }
        
        return $viewModel;
    }
    
    
}





