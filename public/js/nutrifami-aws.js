/**********************************************************
*
* Requiere incluir el API https://sdk.amazonaws.com/js/aws-sdk-2.3.15.min.js
* antes de incluir este archivo en su sitio WEB.
*
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/

/*
 * Objeto con los datos de configuración inicial
 */
AWS_credentials = {
      userName: 'developer'
    , accessKeyId: 'AKIAIFBZYG6G44KXUE4A'
    , secretAccessKey: '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'
    , region: 'us-east-1' 
    , defaultBucket: 'nutrifami'    /* Nombre por defecto del bucket en S3 AWS */
};

/*
 * Ejecución automatica inicial. Una vez cargue el sitio.
 */
$(function(){
  // AWS.config.credentials = ...;
  //AWS.config.update({accessKeyId: AWS_credentials.accessKeyId, secretAccessKey: AWS_credentials.secretAccessKey});
 // Configure your region
  //AWS.config.region = AWS_credentials.region;
});

/*
 * Bucket en S3
 */
var nutrifamiS3;

/*
 * Objeto para manejar funcionalidades de AWS
 * Directo al API
 */
nutrifami_aws = {
    
    /*
     * nutrifami_aws.s3.xxxxxxxxxx
     * Objeto que maneja las funcionalidades de S3
     */
    s3: {
        
        /*
         * nutrifami_aws.s3.load();
         * Carga la información inicial para gestionar S3
         * Parametros opcionales bucket, callback
         */
        load: function(bucket, callback){
            bucket = bucket || AWS_credentials.defaultBucket;
            bucket = 'default' || AWS_credentials.defaultBucket;
            callback = callback || function(){};
            AWS.config.update({accessKeyId: AWS_credentials.accessKeyId, secretAccessKey: AWS_credentials.secretAccessKey});
            // Configure your region
            AWS.config.region = AWS_credentials.region;
            nutrifamiS3 = new AWS.S3({params: {Bucket: bucket}});   /* Inicializa el bucket */
            callback();
        },
        
        /*
         * nutrifami_aws.s3.uploadFile(file);
         * Carga de archivo en s3
         * @param {file} file
         * @returns {String}
         */
        uploadFile: function(file, newName){
            var msj = 'error_1'; /* No se ejecuto la carga */
            if (file) {
              msj = 'success';
              var fileName = newName || file.name; 
              var params = {Key: fileName, ContentType: file.type, Body: file};
              nutrifamiS3.upload(params, function (err, data) {
                  msj = 'error_2'; /* Excepcion en la carga a AWS */
                  alert(msj);
                  alert(err);
              });
            } else {
                msj = 'error_3';  /* No hay archivo que cargar*/
                alert(msj);
            }
        }
        
    }
    
};
