

Map<String, dynamic> fetchPlayerDoc(String username, String device, String authType){
  return {
    'username'          : username,
    'cash'              : 1000,
    'account_lvl'       : 1,
    'xp'                : 0,
    'device_id'         : device,
    'auth_type'         : authType
  };
}

Map<String, dynamic> fetchStorageDoc(){
  return {
    'items' : [],
  };
}