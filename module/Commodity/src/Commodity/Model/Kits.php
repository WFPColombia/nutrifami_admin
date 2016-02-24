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
namespace Commodity\Model;

use Commodity\Model\Tables\KitsTable;
use Commodity\Model\Tables\CommoditiesTable;


/**
 * 
 * @author 
 * 
 * 
 * 
 * METODOS
 * 
 * __construct()
 * getAllKits($options = Array())
 *
 */
class Kits
{
    
    protected $kitsTable;
    protected $commoditiesTable;
    
    
    public function __construct()
    {
    	$this->kitsTable = new KitsTable();
    	$this->commoditiesTable = new CommoditiesTable();
    }
    
    public function getAllKits($options = Array()){
        return $this->kitsTable->getKits($options);
    }
    
    public function getCommoditiesByKit($kid, $options = Array()){
        return $this->commoditiesTable->getCommoditiesByKit($kid, $options);
    }
    
    
    
}

?>