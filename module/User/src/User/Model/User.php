<?php
/**********************************************************
 * CLIENTE: PMA Colombia
 * ========================================================
 * 
 * @copyright PMA Colombia 2014
 * @updated 11/06/2014 14:00
 * @version 1
 * @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
 **********************************************************/
namespace User\Model;

use User\Model\Tables\UserTable;
use Zend\Debug\Debug;
use Zend\Authentication\Storage;

/**********************************************************
 * MODELO User
 * ======================================================= 
 * 
 *  Extiende de Storage\Session de ZF2 por lo que se tienen
 *  los atributos y metodos de la clase de la cual se
 *  extiende. (Zend\Authentication\Storage\Session.php)
 *  
 * 
 *	ATRIBUTOS
 *	$userTable   // Tabla usuarios
 *
 *
 * 	METODOS
 *	login($username = '', $password = '');
 *  logout();
 *  setActiveUser($data);
 *  getActiveUser();
 *  isLogin();
 *  getModules($userId, $parentId);
 *  getPrivileges($userId, $moduleId);
 *  
 **********************************************************/
class User extends Storage\Session
{
    protected $userTable;
    protected $userModules; // Lista de modulos por id
    protected $userModulesUrl; // Lista de modulos por url
    
    
    /** 
     * Llama al contructor de Storage\Session e instancia
     * userTable.
     */
    public function __construct()
    {
        //  Contructor de la clase 
        parent::__construct();  
        
    	$this->userTable = new UserTable();	// Inicializa la tabla
    	$this->userModules = Array();  // Lista de modulos por id
    	$this->userModulesUrl = Array();  // Lista de modulos por url
    }
    
    /**
     * Recibe el usuario y contrase�a, devuelve verdadero si
     * el usuario existe.
     * 
     * @param string $username
     * @param string $password
     * @return boolean
     */
    public function login($username = '', $password = '')
    {
        $user = $this->userTable->getUser($username, $password);
        if ($user){
            $modules = $this->getModules($user['COR_USR_ID']);  // modulos en arbol
            $user['modules'] = array('list'=>array('id'=>$this->userModules, 'url'=>$this->userModulesUrl), 'tree'=>$modules);
            $this->setActiveUser($user);
            return true;
        }
        return false;
    }
    
    
    /**
     * Limpia la sesion
     */
    public function logout(){
        $this->clear();
    }
    
    
    /**
     * Guarda el objeto $data dentro de la sesion del usuario.
     * 
     * @param unknown $data
     */
    public function setActiveUser($data){
        $this->write($data);    // Funcion heredada 
    }
    
    
    /**
     * 
     * @return \Zend\Authentication\Storage\mixed
     */
    public function getActiveUser(){
        return $this->read();   // Funcion heredada
    }
    
    
    /**
     * Si no hay elementos en la sesion del usuario devuelve falso,
     * es decir, si la sesion esta vacia devuelve falso y sino 
     * devuelve verdadero.
     * 
     * @return boolean
     */
    public function isLogin(){
        return !$this->isEmpty();   // Funcion heredada
    }
    
    
    /**
     * Carga los modulos y submodulos que estan asignados a un 
     * usuario por los roles que le corresponden.
     * 
     * @param number $userId
     * @param number $parentId
     * @return multitype:unknown
     */
    public function getModules($userId = 0, $parentId = 1){
        $modules = $this->userTable->getModulesByParent($userId, $parentId);
        $modulesUser = array();
        foreach ($modules as $module) {
            $modulesUser[$module['id']] = $module;
            
            // Lista_X_Id Lista de modulos por id
            $this->userModules[$module['id']] = $module;
            $this->userModules[$module['id']]['privileges'] = $this->getPrivileges($userId, $module['id']);
            // Fin Lista_X_Id
            
            // Lista_X_Url
            if ( $module['url'] != '' ){
                $this->userModulesUrl[$module['url']] = $module;
                $this->userModulesUrl[$module['url']]['privileges'] = $this->userModules[$module['id']]['privileges'];
            }
            // Fin Lista_X_Url
            
            $modulesUser[$module['id']]['children'] = $this->getModules($userId, $module['id']);
        }
        return $modulesUser;        
    }
    
    
    /**
     * Devuelve los privilegios por usuario y modulo indicado. 
     * 
     * @param number $userId
     * @param number $moduleId
     * @return multitype:boolean
     */
    public function getPrivileges($userId = 0, $moduleId = 0){
        $privileges = $this->userTable->getModulePrivileges($userId, $moduleId);
        $pList = array();
        foreach ($privileges as $privilege) {
        	$pList[$privilege['privilege']] = true;
        }
        return $pList;
    }
    
}

?>