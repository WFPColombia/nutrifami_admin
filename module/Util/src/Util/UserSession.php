<?php
namespace Util;

use User\Model\User;
use Zend\Http\PhpEnvironment\Request;

class UserSession
{
       
    
    public static function getId() {
        $user = new User();
        if ($user->isLogin()) {
            $data = $user->getActiveUser();
            return $data['COR_USR_ID'];
        }
        return '';
    }
    
    public static function getUsername() {
        $user = new User();
        if ($user->isLogin()) {
            $data = $user->getActiveUser();
            return $data['COR_USR_NAME'];
        }
        return '';
    }
    
    public static function getName() {
        $user = new User();
        if ($user->isLogin()) {
            $data = $user->getActiveUser();
            return $data['COR_USR_FIRST_NAME'];
        }
        return '';
    }
    
    
    public static function getLastName() {
    	$user = new User();
    	if ($user->isLogin()) {
    		$data = $user->getActiveUser();
    		return $data['COR_USR_LAST_NAME'];
    	}
    	return '';
    }
    
    
    public static function getFullName() {
    	$user = new User();
    	if ($user->isLogin()) {
    		$data = $user->getActiveUser();
    		return $data['COR_USR_FIRST_NAME'].' '.$data['COR_USR_LAST_NAME'];
    	}
    	return '';
    }
    
    
    public static function isLogin(){
        $user = new User();
        return $user->isLogin();
    }
    
    
    public static function getModulesTree(){
        $user = new User();
        if ($user->isLogin()) {
        	$data = $user->getActiveUser();
        	return $data['modules']['tree'];
        }
        return '';
    }   
    
    
    public static function isAddPrivilege(){
        $user = new User();
        if ($user->isLogin()) {
            $fc = new Request();
            $url = $fc->getUri()->getPath();
            $data = $user->getActiveUser();
            $privileges = $data['modules']['list']['url'][$url]['privileges'];
            if ( isset($privileges['ADD']) && $privileges['ADD'] ) {
                return true;
            }else {
                return false;
            }
        }else {
            return false;
        }
    }
    
    public static function isEditPrivilege(){
    	$user = new User();
    	if ($user->isLogin()) {
    		$fc = new Request();
    		$url = $fc->getUri()->getPath();
    		$data = $user->getActiveUser();
    		$privileges = $data['modules']['list']['url'][$url]['privileges'];
    		if ( isset($privileges['EDIT']) && $privileges['EDIT'] ) {
    			return true;
    		}else {
    			return false;
    		}
    	}else {
    		return false;
    	}
    }
    
    public static function isDeletePrivilege(){
    	$user = new User();
    	if ($user->isLogin()) {
    		$fc = new Request();
    		$url = $fc->getUri()->getPath();
    		$data = $user->getActiveUser();
    		$privileges = $data['modules']['list']['url'][$url]['privileges'];
    		if ( isset($privileges['DELETE']) && $privileges['DELETE'] ) {
    			return true;
    		}else {
    			return false;
    		}
    	}else {
    		return false;
    	}
    }
    
    public static function isHidePrivilege(){
    	$user = new User();
    	if ($user->isLogin()) {
    		$fc = new Request();
    		$url = $fc->getUri()->getPath();
    		$data = $user->getActiveUser();
    		$privileges = $data['modules']['list']['url'][$url]['privileges'];
    		if ( isset($privileges['HIDE']) && $privileges['HIDE'] ) {
    			return true;
    		}else {
    			return false;
    		}
    	}else {
    		return false;
    	}
    }
    
    public static function isHidePrivilegeByController($url){
    	$user = new User();
    	if ($user->isLogin()) {
    		$data = $user->getActiveUser(); 
                if ( isset($data['modules']['list']['url'][$url]['privileges']) ){
                    $privileges = $data['modules']['list']['url'][$url]['privileges'];
                    if ( isset($privileges['HIDE']) && $privileges['HIDE'] ) {
                            return true;
                    }else {
                            return false;
                    }
                }
    	}else {
    		return false;
    	}
    }
    
    
    public static function getTrainingsInfo(){
        $user = new User();
        if ($user->isLogin()) {
        	$data = $user->getActiveUser();
        	return $data['trainings'];
        }
        return '';
    }     
    
    public static function getTrainingsInfoJSON(){
        $user = new User();
        if ($user->isLogin()) {
        	$data = $user->getActiveUser();
        	return json_encode($data['trainings']);
        }
        return json_encode(Array());
    }     
    
    public static function isMasterTraining($training_id = 0){
        $user = new User();
        if ($user->isLogin()) {
            $data = $user->getActiveUser();
            if ( isset($data['trainings']['master'][$training_id]) ) {
                return true;
            }else {
                return false;
            }
        }
        return fale;
    }
    
}

?>