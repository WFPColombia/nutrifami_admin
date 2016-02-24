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

namespace Commodity\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Commodity\Model\Kits;
use Zend\Debug\Debug;

/**
 * KitsController
 * 
 * @author Abel
 *
 *
 * METODOS
 * indexAction();
 * listAction();
 *
 */
class KitsController extends AbstractActionController
{
    /**
     * The default action - show the home page
     */
    public function indexAction()
    {
        
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
    	$kitsObj = new Kits();
    	$queryOptions = \Util\DataTables::getListOptions($params);
    	//Debug::dump($queryOptions); die;
    	$kits = $kitsObj->getAllKits($queryOptions);
    	echo json_encode(array('recordsTotal'=>$kits['rows'], 'recordsFiltered'=>$kits['rows'], 'data'=>$kits['data']));
    	//echo json_encode(array('data'=>$modules));
    
    	return $this->response; //Desabilita View y Layout
    }
    
    
    /**
     * Lista los modulos
     */
    public function commoditiesAction(){
        $params = $this->params()->fromQuery(); 
        return array('kid' => $params['kid']);
    }
    
    
    public function getCommoditiesAction(){
        $params = $this->params()->fromQuery();
        $kitsObj = new Kits();
    	$queryOptions = \Util\DataTables::getListOptions($params);
        $commodities = $kitsObj->getCommoditiesByKit($params['kid'], $queryOptions);
        echo json_encode(array('recordsTotal'=>$commodities['rows'], 'recordsFiltered'=>$commodities['rows'], 'data'=>$commodities['data']));
    	
        return $this->response; //Desabilita View y Layout
    }
    

}
