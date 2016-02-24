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
use Zend\Captcha\Dumb;
use Zend\Debug\Debug;
use Admin\Model\Rol;
use Admin\Model\Module;

/**
 * RolesController
 *
 * @author
 *
 * @version
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 *
 */
class RolesController extends AbstractActionController
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
        
    }
    
    /**
     * Usando DataTable js
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function getListAction()
    {
        $params = $this->params()->fromQuery();
        $rolObj = new Rol();
        $queryOptions = \Util\DataTables::getListOptions($params);
        //Debug::dump($queryOptions); die;
        $roles = $rolObj->getAllRoles($queryOptions);
        echo json_encode(array('recordsTotal'=>$roles['rows'], 'recordsFiltered'=>$roles['rows'], 'data'=>$roles['data']));
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
    		$rolObj = new Rol();
    		if ($rolObj->updateRol($data)) {
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
    
    	$viewModel = new ViewModel(array('id' => 0, 'breadcrumbs' => ' / <a>Add Rol</a>'));
    	$viewModel->setTemplate('admin/roles/rol_form.phtml');
    
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
    		$data['name'] = $_POST['name'];
    		$data['description'] = $_POST['description'];
    		$data['id'] = $_POST['id'];
    		$rolObj = new Rol();
    		if ( $rolObj->saveRol($data) ) {
    			$this->redirect()->toUrl('list'); // Volver a listar desde el modulo padre
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
    		$data['id'] = $params['id'];
    		$rolObj = new Rol();
    		if ( $rolObj->deleteRol($data) ) {
    			$this->redirect()->toUrl('list'); // Volver a listar desde el modulo padre
    		}
    	}
    	return $this->response; //Desabilita View y Layout
    }
    
    
    
    public function editAction(){
    	$params = $this->params()->fromQuery();
    	if (isset($params['id']) && $params['id']>0){
    		$id = $params['id'];
    		$rolObj = new Rol();
    		$rol = $rolObj->getRol($id);
    
    		$viewModel = new ViewModel(array('rol' => $rol, 'id' => $rol['COR_ROL_ID'], 'breadcrumbs' => ' / <a>Edit Rol</a>'));
    	    $viewModel->setTemplate('admin/roles/rol_form.phtml');
    	}else{
    		$this->redirect()->toUrl('list');
    	}
    
    	return $viewModel;
    }
    
    
    
    
    public function allowAction(){
        $params = $this->params()->fromQuery();
        $privilegesList = \Util\LoockupValues::getPrivilegesList();
        if (isset($params['id']) && $params['id']>0){
    		$id = $params['id'];
            $rolObj = new Rol();
    		$rol = $rolObj->getRol($id);
    		$modules = $rolObj->getModulesByRol($id);
            $viewModel = new ViewModel(array('rol' => $rol, 'privileges'=>$privilegesList, 'modules'=>$modules));
            $viewModel->setTerminal(true);
            return $viewModel;
        }else {
            $viewModel = new ViewModel();
            $viewModel->setTerminal(true);
            return $viewModel;
        }
    }
    
    
    
    public function setPrivilegesAction()
    {
        $params = $this->params()->fromPost(); 
        $rolObj = new Rol();
        if ( $rolObj->savePrivileges($params['rol_id'], $params['privileges']) ){
            echo 'ok';
        }
        return $this->response; //Desabilita View y Layout
    }
    
    
    
}





