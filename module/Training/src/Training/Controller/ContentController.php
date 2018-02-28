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
use User\Model\User;

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
    
    public function usersAction(){
        $trainingObj = new Training();
        $cid= 0;
        $params = $this->params()->fromQuery();
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        $training = $trainingObj->getTraining($cid);
        
        $userObj = new User();
        $users = $userObj->getUsersList();
        $users_list = Array();
        foreach ( $users as $u ) {
            $users_list[] = Array('value' => $u['COR_USR_ID'], 'label' => $u['COR_USR_NAME']);
        }
        
        $viewModel = new ViewModel(array('training' => $training, 'cid' => $cid, 'users_list' => json_encode($users_list)));
        return $viewModel;
    }
    
    public function getListUsersAction(){
        $request = $this->getRequest();
        $params = $this->params()->fromQuery();
        $queryOptions = \Util\DataTables::getListOptions($params);
        $trainingObj = new Training();
        $cid = 0;
        if (isset($params['cid']) && $params['cid']>0) {
            $cid= $params['cid'];
        }
        $users = $trainingObj->getAdminUsers($queryOptions, $cid);
        //print_r($users); die;
        echo json_encode(array('recordsTotal'=>$users['rows'], 'recordsFiltered'=>$users['rows'], 'data'=>$users['data']));
        
        return $this->response; //Desabilita View y Layout
    }
    
    public function saveUserAction(){
        $request = $this->getRequest();
        if ($request->isPost()) {
            $data['use_id'] = $_POST['input_user_id'];
            $data['cap_id'] = $_POST['input_training_id'];
            $data['pro_id'] = $_POST['input_rol'];
            $trainingObj = new Training();
            if ( $trainingObj->saveUser($data) ) { 
                //print_r( $nObj );
                $this->redirect()->toUrl('/training/content/users?cid='.$data['cap_id']); // Volver a listar capacitaciones
            }else {
                echo "Saving Error";
            }
        }
        
        return $this->response; //Desabilita View y Layout
    }
    
    public function deleteUserAction(){
        $params = $this->params()->fromQuery();
        if (isset($params['id']) && $params['id']>1){
            $data['id'] = $params['id'];
            $data['cap_id'] = $params['cid'];
            $trainingObj = new Training();
            if ( $trainingObj->deleteUser($data) ) {
                $this->redirect()->toUrl('/training/content/users?cid='.$data['cap_id']); // Volver a listar capacitaciones
            }else {
                echo "Deleting Error";
            }
        }else {
            echo "Deleting Error";
        }
        
        return $this->response; //Desabilita View y Layout
    }
    
    
}