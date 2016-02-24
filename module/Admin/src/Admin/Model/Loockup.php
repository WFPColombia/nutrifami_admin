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
namespace Admin\Model;

use Admin\Model\Tables\LoockupTable;
/**********************************************************
* MODELO Loockup
* =======================================================
*
*	ATRIBUTOS
*	$moduleTable   // Tabla modulos
*
*
* 	METODOS
*
**********************************************************/
class Loockup
{
    protected $moduleTable;
    
    public function __construct()
    {
        $this->moduleTable = new LoockupTable();
    }
    

    public function getElement ( $type = "", $abbreviation = "" ) {
        $result = $this->moduleTable->getElement($type, $abbreviation);
        return $result;
    }
    
    
    
    public function getList ( $type = "", $getParent = true ){
        $result = $this->moduleTable->getList($type, $getParent);
        return $result;
    }
    
    
    
    
}

?>