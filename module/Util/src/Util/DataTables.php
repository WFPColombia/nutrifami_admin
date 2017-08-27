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
namespace Util;

/**
 * Clase creada para manejar las funcionalidades requeridas por
 * DataTables js (https://datatables.net/) en el servidor.
 * 
 * @author Abel Moreno
 * 
 * 
 * METODOS
 * getListOptions(Array $params);
 *
 */
class DataTables
{
    
    /**
     * 
     * Retorna un arreglo con:
     * $return['where'];    // String con clausula where
     * $return['limit'];    // Arreglo length y start
     * $return['order'];    // String clausula order
     * 
     *  
     * @param array $params
     * @return array
     */
    public static function getListOptions(Array $params)
    {
        $where = " ";
        if ( trim($params['search']['value']) != '' ) {
            $count = 0; // No agregar OR si es la primera colomna
            foreach ( $params['columns'] as $column ) {
                if ( trim($column['data']) != '' ){
                    if ( $count > 0) {
                        $where .= " OR ";
                    }
                    $where .= $column['data']." LIKE '%".trim($params['search']['value'])."%'";
                    $count++;
                }
            }            
        }else {
            $where = "1=1";
        }
        $limit = Array('length'=>(int)$params['length'], 'start'=>(int)$params['start']);
        $order = $params['columns'][$params['order'][0]['column']]['data']." ".$params['order'][0]['dir'];
        return Array('where'=>$where, 'limit'=>$limit, 'order'=>$order);
    }
    
}

?>