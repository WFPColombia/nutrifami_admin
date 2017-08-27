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
class CommoditiesController extends AbstractActionController
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
    	
    
    	return $this->response; //Desabilita View y Layout
    }
    
    

}
