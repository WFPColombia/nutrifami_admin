<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2016
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/

namespace Tfrances\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Captcha\Dumb;
use Zend\Debug\Debug;
use Tfrances\Model\Lesson;
use Tfrances\Model\Module;
use Tfrances\Model\ModuleElement;

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
class LessonsController extends AbstractActionController
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
        $mid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        $module = $moduleObj->getModule($mid);
        $viewModel = new ViewModel(array('module' => $module, 'mid' => $mid));
        return $viewModel;
    }
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function getListAction(){
        
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $mid = 0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        $queryOptions = \Util\DataTables::getListOptions($params);
        $lessonObj = new Lesson();
        $lessons = $lessonObj->getLessons($queryOptions, $mid);
        echo json_encode(array('recordsTotal'=>$lessons['rows'], 'recordsFiltered'=>$lessons['rows'], 'data'=>$lessons['data']));
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
            //print_r($data); return; 
            $field = '';
            foreach ( $data as $d ) {
                foreach ( $d as $k => $f ){
                    $field = $k;
                }
            }
            //print_r(substr($field, 0, 3)); return;
            if (substr($field, 0, 3) == 'mod') {
                $moduleObj = new Module();
                if ( $moduleObj->updateLesson($data) ) {
                    echo json_encode($_POST);
                }
            }else{
                $lessonObj = new Lesson();
                if ($lessonObj->updateLesson($data)) {
                    echo json_encode($_POST);
                } 
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
        $mid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        
        $viewModel = new ViewModel(array('id' => 0, 'mid' => $mid, 'breadcrumbs' => ' / <a>Add Lección</a>'));
        $viewModel->setTemplate('tfrances/lessons/lesson_form.phtml');
        
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
            $data['icono'] = $_POST['icono'];
            $data['imagen'] = $_POST['imagen'];
            $data['audio'] = $_POST['audio'];
            $data['mensaje_final'] = $_POST['mensaje_final'];
            $data['audio_final'] = $_POST['audio_descripcion'];
            $data['id'] = $_POST['id'];
            $data['mid'] = $_POST['mid'];
            $lessonObj = new Lesson();
            if ( $nObj = $lessonObj->saveLesson($data) ) { 
                //print_r( $nObj );
                $this->redirect()->toUrl('list?mid='.$nObj['module_id']); // Volver a listar desde el modulo padre
            }else {
                $this->redirect()->toUrl('list?mid='.$data['mid']); // Volver a listar desde el modulo padre
            }
        }
        //Debug::dump($params);
        
        return $this->response; //Desabilita View y Layout
    }
    
    
    
    
    
    
    public function editAction(){
        $params = $this->params()->fromQuery();
        $mid=0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['id']) && $params['id']>0){
        	$id = $params['id'];        
            $lessonObj = new Lesson();
            $lesson = $lessonObj->getLesson($id);
            
            $viewModel = new ViewModel(array('lesson' => $lesson, 'id' => $lesson['lec_id'], 'mid' => $mid, 'breadcrumbs' => ' / <a>Edit M&oacute;dulo</a>'));
            $viewModel->setTemplate('tfrances/lessons/lesson_form.phtml');
        }else{
            $this->redirect()->toUrl('list?mid='.$mid); 
        }
        
        return $viewModel;
    }
    
    
    
    
    /**
     * 
     * @return \Zend\Stdlib\ResponseInterface
     */
    public function deleteAction(){
        $params = $this->params()->fromQuery();
        $mid = 0;
        if (isset($params['mid']) && $params['mid']>0) {
            $mid= $params['mid'];
        }
        if (isset($params['id']) && $params['id']>1){
            $data['id'] = $params['id'];
            $lessonObj = new Lesson();
            if ( $lessonObj->deleteLesson($data) ) {
                $this->redirect()->toUrl('list?mid='.$mid); // Volver a listar desde el modulo padre
            }
        }
        return $this->response; //Desabilita View y Layout
    }
    
    
}