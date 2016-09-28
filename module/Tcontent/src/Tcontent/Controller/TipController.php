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
use Tcontent\Model\Tips;

/**
 * ModulesController
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 *
 */
class TipController extends AbstractActionController
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
        $tipsObj = new Tips();
        $tips = $tipsObj->getTips($queryOptions, $lid);
        echo json_encode(array('recordsTotal'=>$tips['rows'], 'recordsFiltered'=>$tips['rows'], 'data'=>$tips['data']));
        //echo json_encode(array('data'=>$unidades));
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    public function updateRowAction()
    {
        $request = $this->getRequest();
        if ($data = $request->getPost('data')){
            $tipsObj = new Tips();
            if ($tipsObj->updateTip($data)) { 
                echo json_encode($_POST);
            }            
        }
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    public function addAction()
    {
        $mid = 0;
        $lid = 0;
        $params = $this->params()->fromQuery();
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        
        $viewModel = new ViewModel(array('id' => 0, 'mid' => $mid, 'lid' => $lid, 'breadcrumbs' => ' / <a>Add Unidad de Información</a>'));
        $viewModel->setTemplate('tcontent/tip/tip_form.phtml');
        
        return $viewModel;
        
    }
    
    
    
    public function editAction(){
        $params = $this->params()->fromQuery();
        $mid = 0;
        $lid = 0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['id']) && $params['id']>0){
        	$id = $params['id'];        
            $tipObj = new Tips();
            $tip = $tipObj->getTip($id);
            
            $viewModel = new ViewModel(array('tip' => $tip, 'id' => $tip['tip_id'], 'mid' => $mid, 'lid' => $lid, 'breadcrumbs' => ' / <a>Edit Tip</a>'));
            $viewModel->setTemplate('tcontent/tip/tip_form.phtml');
        }else{
            $this->redirect()->toUrl('list?mid='.$mid.'&lid='.$lid); 
        }
        
        return $viewModel;
    }
    
    
    
    
    public function saveAction()
    {
        $request = $this->getRequest();
        if ($request->isPost()) { 
            //print_r($_POST); die;
            $data['texto'] = $_POST['texto'];
            $data['descripcion'] = $_POST['descripcion'];
            $data['tags'] = $_POST['tags'];
            $data['id'] = $_POST['id'];
            $data['lid'] = $_POST['lid'];
            $data['mid'] = $_POST['mid'];
            $tipObj = new Tips();
            if ( $nObj = $tipObj->saveTip($data) ) { 
                //print_r( $nObj );
                $this->redirect()->toUrl('list?mid='.$data['mid'].'&lid='.$data['lid']); // Volver a listar desde el modulo padre
            }
        }
        //Debug::dump($params);
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    
    public function deleteAction(){
        $params = $this->params()->fromQuery();
        $mid = 0;
        $lid = 0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['lid']) && $params['lid']>0) {
            $lid= $params['lid'];
        }
        if (isset($params['id']) && $params['id']>1){
            $data['id'] = $params['id'];
            $tipObj = new Tips();
            if ( $tipObj->deleteTip($data) ) {
                $this->redirect()->toUrl('list?mid='.$mid.'&lid='.$lid); // Volver a listar desde el modulo padre
            }
        }
        return $this->response; //Desabilita View y Layout
    }
    
    
    
}