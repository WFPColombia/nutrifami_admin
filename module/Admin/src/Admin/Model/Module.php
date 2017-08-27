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

use Admin\Model\Tables\ModuleTable;
use Doctrine\Common\Util\Debug;
/**********************************************************
* MODELO Module
* =======================================================
*
*	ATRIBUTOS
*	$moduleTable   // Tabla modulos
*
*
* 	METODOS
*   getAllModules();
*   getModules($pid = 1);
*
**********************************************************/
class Module
{
    protected $moduleTable;
    
    public function __construct()
    {
        $this->moduleTable = new ModuleTable();
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
    public function getModules($pid = 1, $options = Array())
    {
        $modules = $this->moduleTable->getModules($pid, $options);
        return $modules;
    }
    
    
    public function updateModule(Array $data){
        return $this->moduleTable->updateModule($data);
    }
    
    
    public function getParentsTree ($idModule, $layers = array()) 
    {
        $count = count($layers);
        if ($idModule > 1) {
            $layers[$count] = $this->moduleTable->getModule($idModule);
            return ( $this->getParentsTree($layers[$count]['COR_MOD_PID'], $layers) );
        }else{
            $tree = array();
            $child = $layers[0];
            for ($i=1; $i<$count; $i++) {
                $temp = $layers[$i];
                $temp['children'] = $child;
                $child = $temp;
            }
            $tree = $child;
            return $tree;
        }
    }
    
    
    public function getBreadcrumbs($idModule, $layers = array())
    {
        $count = count($layers);
        if ($idModule > 1) {
        	$layers[$count] = $this->moduleTable->getModule($idModule);
        	return ( $this->getBreadcrumbs($layers[$count]['COR_MOD_PID'], $layers) );
        }else{
        	$breadcrumbs = '';
        	for ($i=0; $i<$count; $i++) {
        	    $breadcrumbs = '/ <a href="?pid='.$layers[$i]['COR_MOD_ID'].'">'.$layers[$i]['COR_MOD_NAME'].'</a> '.$breadcrumbs;
        	}
        	return $breadcrumbs;
        }
    }
    
    
    
    public function saveModule($data){
        $dataTable = array();
        if ( isset($data['pid']) ) {
            $dataTable['COR_MOD_PID'] = $data['pid'];
        }
        if ( isset($data['name']) ) {
            $dataTable['COR_MOD_NAME'] = $data['name'];
        }
        if ( isset($data['description']) ) {
            $dataTable['COR_MOD_DESCRIPTION'] = $data['description'];
        }
        if ( isset($data['url']) ) {
            $dataTable['COR_MOD_URL'] = $data['url'];
        }
        if ( isset($data['icon']) ) {
            $dataTable['COR_MOD_ICON'] = $data['icon'];
        }
        $statusElement= \Util\LoockupValues::getStatus('ACTIVE');
        
        $dataTable['LUT_COD_STATUS'] = $statusElement['LUT_COD_ID'];
        if ( isset($data['id']) && $data['id']>0 ) {
            $dataTable['COR_MOD_ID'] = $data['id'];
            return $this->moduleTable->updateByFieldsModule($dataTable);
        }else {
            return $this->moduleTable->insertModule($dataTable);
        }
    }
    
    
    
    public function deleteModule($data){
        if ($data['id']>0) {
            $dataTable['COR_MOD_ID'] = $data['id'];
            $statusElement = \Util\LoockupValues::getStatus('INACTIVE');
            $dataTable['LUT_COD_STATUS'] = $statusElement['LUT_COD_ID'];
            return $this->moduleTable->updateByFieldsModule($dataTable);
        }else {
            return false;
        }
    }
    
    
    
    public function getModule ($id) 
    {
        return $this->moduleTable->getModule($id);
    }
    
    
}

?>