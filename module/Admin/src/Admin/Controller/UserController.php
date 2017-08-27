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

/**********************************************************
 * CONTROLADOR UserController
 * ======================================================= 
 * 
 *	ATRIBUTOS
 *
 *
 * 	METODOS
 *	indexAction();
 *	listAction();
 *  
 **********************************************************/
class UserController extends AbstractActionController
{
    public function indexAction()
    {
        return array();
    }
    
    public function listAction()
    {
        return array('module_title' => 'Administración / Usuarios');
    }
}
