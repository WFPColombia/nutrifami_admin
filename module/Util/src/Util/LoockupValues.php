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

use Admin\Model\Loockup;
/**
 * Acceder a los valores loockUp definidos para la aplicación.
 * tener en cuenta los campos:
 * LUT_COD_TYPE
 * LUT_COD_ABBREVIATION
 * 
 * @author Abel Moreno
 * 
 * 
 * METODOS
 * getStatus($status);
 * getPrivilegesList();
 *
 */
class LoockupValues
{

    /**
     * 
     * $status values:
     * ACTIVE, INACTIVE
     * 
     * @param string $status
     * @return Ambigous <boolean, multitype:, ArrayObject, NULL, \ArrayObject, unknown>
     */
    public static function getStatus ($status = '') 
    {
        $lut = new Loockup();
        $result = $lut->getElement("STATUS", $status);
        return $result;
    }
    
    
    /**
     * Trae un arreglo con los privilegios manejados en la aplicacion.
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public static function getPrivilegesList () {
        $lut = new Loockup();
        $result = $lut->getList('PRIVILEGES', false);
        $privileges = array();
        foreach ( $result as $r ) {
            $privileges[$r['LUT_COD_ABBREVIATION']] = array(
                                                        'name' => $r['LUT_COD_NAME'], 
                                                        'abbreviation' => $r['LUT_COD_ABBREVIATION'], 
                                                        'id' => $r['LUT_COD_ID']
                                                        );
        }
        return $privileges;
    }
    
}

?>