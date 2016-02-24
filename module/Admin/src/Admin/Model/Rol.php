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

use Admin\Model\Tables\RolTable;
use Zend\Debug\Debug;
use Admin\Model\Tables\PrivilegesTable;
/**********************************************************
* MODELO Module
* =======================================================
*
*	ATRIBUTOS
*	$moduleTable   // Tabla modulos
*
*
* 	METODOS
*   getAllRoles();
*
**********************************************************/
class Rol
{
    protected $rolTable;
    
    public function __construct()
    {
        $this->rolTable = new RolTable();
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllRoles($options = Array()){
        return $this->rolTable->getRoles($options);
    }
    
    
    public function updateRol(Array $data){
    	return $this->rolTable->updateRol($data);
    }
    
    
    public function saveRol($data){
    	$dataTable = array();
    	if ( isset($data['name']) ) {
    		$dataTable['COR_ROL_NAME'] = $data['name'];
    	}
    	if ( isset($data['description']) ) {
    		$dataTable['COR_ROL_DESCRIPTION'] = $data['description'];
    	}
    	$statusElement= \Util\LoockupValues::getStatus('ACTIVE');
    	$dataTable['LUT_COD_STATUS'] = $statusElement['LUT_COD_ID'];
    	if ( isset($data['id']) && $data['id']>0 ) {
    		$dataTable['COR_ROL_ID'] = $data['id'];
    		return $this->rolTable->updateByFieldsRol($dataTable);
    	}else {
    		return $this->rolTable->insertRol($dataTable);
    	}
    }
    
    
    
    
    public function deleteRol($data){
    	if ($data['id']>0) {
    		$dataTable['COR_ROL_ID'] = $data['id'];
    		$statusElement = \Util\LoockupValues::getStatus('INACTIVE');
    		$dataTable['LUT_COD_STATUS'] = $statusElement['LUT_COD_ID'];
    		return $this->rolTable->updateByFieldsRol($dataTable);
    	}else {
    		return false;
    	}
    }
    
    
    
    public function getRol ($id)
    {
    	return $this->rolTable->getRol($id);
    }
    
    
    public function getPrivilegesByRol($id){
        $privileges = $this->rolTable->getPrivilegesByRol($id);
        $list = Array();
        foreach ($privileges as $p){
            if ( !isset($list[$p['COR_MOD_ID']]) ){ $list[$p['COR_MOD_ID']] = Array(); }
            $list[$p['COR_MOD_ID']][$p['LUT_COD_ABBREVIATION']] = Array('id'=>$p['LUT_COD_ID'], 'name'=>$p['LUT_COD_NAME'], 'abbreviation'=>$p['LUT_COD_ABBREVIATION'] );
        }
        return $list;
    }
    
    
    public function getModulesByRol ($id) {
        $moduleObject = new Module();
        $modulesList = $moduleObject->getAllModules();
        $privileges = $this->getPrivilegesByRol($id);
        
        $modules = Array();
        
        // Construye un arbol de los modulos existentes de la aplicacion (children indica modulos hijos)
        // y a cada modulo se le agrega un array privileges indicando los privilegios que el rol indicado posee
        // REVISAR UNA FUNCION "RECURSIVA" para que la construcciondea mas general ya que solo esta de 2 niveles
        foreach ( $modulesList as $m) {
            if ( $m['COR_MOD_PID'] > 1 && $m['COR_MOD_ID'] > 1 ) {
                if ( !isset( $modules[$m['COR_MOD_PID']] ) ) {
                    $modules[$m['COR_MOD_PID']] = Array("children"=>array());
                }
                if ( !isset( $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']] ) ) {
                	$modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']] = Array();
                }
                $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['id'] = $m['COR_MOD_ID'];
                $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['pid'] = $m['COR_MOD_PID'];
                $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['name'] = $m['COR_MOD_NAME'];
                $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['description'] = $m['COR_MOD_DESCRIPTION'];
                if ( isset( $privileges[$m['COR_MOD_ID']] )){
                    $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['privileges'] = $privileges[$m['COR_MOD_ID']];
                }else{
                    $modules[$m['COR_MOD_PID']]["children"][$m['COR_MOD_ID']]['privileges'] = array();
                }
            }elseif ( $m['COR_MOD_ID'] > 1 ) {
                if ( !isset( $modules[$m['COR_MOD_PID']] ) ) {
                	$modules[$m['COR_MOD_ID']] = Array("children"=>array());
                }
                $modules[$m['COR_MOD_ID']]['id'] = $m['COR_MOD_ID'];
                $modules[$m['COR_MOD_ID']]['pid'] = $m['COR_MOD_PID'];
                $modules[$m['COR_MOD_ID']]['name'] = $m['COR_MOD_NAME'];
                $modules[$m['COR_MOD_ID']]['description'] = $m['COR_MOD_DESCRIPTION'];
                if ( isset( $privileges[$m['COR_MOD_ID']] )){
                	$modules[$m['COR_MOD_ID']]['privileges'] = $privileges[$m['COR_MOD_ID']];
                }else{
                    $modules[$m['COR_MOD_ID']]['privileges'] = array();
                }
            }
        }
        // Fin foreach
        
        return $modules; 
    }
    
    
    /**
     * 
     * Agrega los privilegios de acuerdo al rol
     * 
     * @param number $rol_id
     * @param unknown $privileges
     * @return boolean
     */
    public function savePrivileges($rol_id = 0, $privileges = array())
    {   
    	$privilegesObj = new PrivilegesTable();
    	$ok = true;
    	if ( $privilegesObj->deletePrivilegesRol($rol_id) > -1 ) {
        	foreach ( $privileges as $LUT_COD_PRIVILEGE => $modules ){
        	    foreach ( $modules as $COR_MOD_ID => $module) {
        	        $data = array( 'COR_MOD_ID'=>$COR_MOD_ID, 'COR_ROL_ID'=>$rol_id, 'LUT_COD_PRIVILEGE'=>$LUT_COD_PRIVILEGE );
                        if (!$privilegesObj->addPrivilege($data)){
        	            $ok = false;
        	        }
        	    }
        	}
    	}else{
    	    $ok = false;
    	}
    	return $ok;
    }
    
    
}

?>