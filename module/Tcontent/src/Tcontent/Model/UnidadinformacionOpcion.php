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

use Tcontent\Model\Tables\UnidadinformacionXOpcionTable;
use Tcontent\Model\Tables\UnidadinformacionOpcionTable;
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
* __construct();
*
**********************************************************/
class UnidadinformacionOpcion
{
    protected $opcionTable;
    protected $unidadXOpcionTable;


    public function __construct()
    {
        $this->opcionTable = new UnidadinformacionOpcionTable();
        $this->unidadXOpcionTable = new UnidadinformacionXOpcionTable();
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllOpciones(){
        return $this->opcionTable->fetchAll();
    }
    
    /**
     * 
     * @param number $pid
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getOpciones($options = Array(), $uid)
    {
        $opciones = $this->opcionTable->getOpciones($options, $uid);
        return $opciones;
    }
    
    
    public function updateOpcion(Array $data){
        return $this->opcionTable->updateOpcion($data);
    }    
    
    
    public function saveOpcion($data){ 
        $dataTable = array();
        return $dataTable;
    }
    
    
    
    public function deleteOpcion($dataOrigin){
        return '';
    }
    
    
    
    public function getOpcion ($id) 
    {
        return $this->opcionTable->getOpcion($id);
    }
    
    
}

?>