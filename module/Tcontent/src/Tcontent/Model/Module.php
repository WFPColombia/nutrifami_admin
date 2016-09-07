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

use Tcontent\Model\Tables\ModuleTable;
use Tcontent\Model\Tables\ModuleElementTable;
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
* getAllModules();
* getModules();
*
**********************************************************/
class Module
{
    protected $moduleTable;
    protected $moduleElementTable;
    
    public function __construct()
    {
        $this->moduleTable = new ModuleTable();
        $this->moduleElementTable = new ModuleElementTable();
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllModules(){
        return $this->moduleTable->fetchAll();
    }
    
    /**
     * 
     * @param number $pid
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getModules($options = Array())
    {
        $modules = $this->moduleTable->getModules($options);
        return $modules;
    }
    
    
    public function updateModule(Array $data){
        return $this->moduleTable->updateModule($data);
    }    
    
    
    public function saveModule($data){
        $dataTable = array();
        if ( isset($data['titulo']) ) {
            $dataTable['mod_titulo'] = $data['titulo'];
        }
        if ( isset($data['descripcion']) ) {
            $dataTable['mod_descripcion'] = $data['descripcion'];
        }
        if ( isset($data['imagen']) ) {
            $dataTable['mod_imagen'] = $data['imagen'];
        }      
        if ( isset($data['audio']) ) {
            $dataTable['mod_audio'] = $data['audio'];
        }  
        if ( isset($data['audio_descripcion']) ) {
            $dataTable['mod_descripcion_audio'] = $data['audio_descripcion'];
        }    
        $dataTable['mod_activo'] = 1;
        if ( isset($data['id']) && $data['id']>0 ) {
            $dataTable['mod_id'] = $data['id'];
            return $this->moduleTable->updateByFieldsModule($dataTable);
        }else { 
            return $this->moduleTable->insertModule($dataTable);
        }
    }
    
    
    
    public function deleteModule($data){
        if ($data['id']>0) {
            $dataTable['mod_id'] = $data['id'];
            $dataTable['mod_activo'] = 0;
            return $this->moduleTable->updateByFieldsModule($dataTable);
        }else {
            return false;
        }
    }
    
    
    
    public function getModule ($id) 
    {
        return $this->moduleTable->getModule($id);
    }
    
    public function updateLesson(Array $data){
        return $this->moduleElementTable->updateLesson($data);
    }
    
    
}

?>