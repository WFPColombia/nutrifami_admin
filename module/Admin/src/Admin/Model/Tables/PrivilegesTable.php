<?php
namespace Admin\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;
use Zend\Db\Sql\Sql;

class PrivilegesTable extends AbstractTableGateway
{
    protected $table = 'core_mod_by_rol_priv';
    
    public function __construct()
    {
    	//$this->adapter = $adapter;
    	//$this->initialize();
    
    	$this->featureSet = new Feature\FeatureSet();
    	$this->featureSet->addFeature(new Feature\GlobalAdapterFeature());
    	$this->initialize();
    }
    
    
    /**
     * Elimina el privilegio anterior, si existe, y agrega el nuevo
     * Si se agregan todos los privilegios del rol llamar antes deletePrivilegesRol()
     *  
     * @param unknown $data
     * @return Ambigous <number, \Zend\Db\TableGateway\mixed>
     */
    public function addPrivilege($data){
        $this->delete(array('COR_MOD_ID' => $data['COR_MOD_ID'], 'COR_ROL_ID' => $data['COR_ROL_ID'], 'LUT_COD_PRIVILEGE' => $data['LUT_COD_PRIVILEGE']));
        $data['COR_MRP_VALUE'] = 1;
        return $this->insert($data);
    }
    
    /**
     * Borrar todos los privilegios del rol indicado.
     * 
     * @param unknown $COR_ROL_ID
     * @return Ambigous <number, \Zend\Db\TableGateway\mixed>
     */
    public function deletePrivilegesRol($COR_ROL_ID){
        return ( $this->delete(array('COR_ROL_ID' => $COR_ROL_ID)) );
    }
    
    
}

?>