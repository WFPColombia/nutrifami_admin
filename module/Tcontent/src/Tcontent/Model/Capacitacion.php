<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2016
* @updated 
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/
namespace Tcontent\Model;

use Tcontent\Model\Tables\CapacitacionElementTable;
use Doctrine\Common\Util\Debug;
/**********************************************************
* MODELO Module
* =======================================================
*
* ATRIBUTOS
* $moduleTable   // Tabla modulos
*
*
* METODOS
*
**********************************************************/
class Capacitacion
{
    protected $capacitacionElementTable;
    
    public function __construct()
    {
        $this->capacitacionElementTable = new CapacitacionElementTable();
    }
    
    
    public function updateModule(Array $data){
        return $this->capacitacionElementTable->updateModule($data);
    }
    
    
}

?>