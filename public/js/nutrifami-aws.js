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
 * Bucket en S3
 */
var nutrifamiS3;

/*
 * Objeto para manejar funcionalidades de AWS
 * Directo al API
 * Necesita la libreria https://sdk.amazonaws.com/js/aws-sdk-2.3.15.min.js en la misma aplicación
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
        load: function(callback){
            callback = callback || function(){};
            AWS.config.update({accessKeyId: AWS_credentials.accessKeyId, secretAccessKey: AWS_credentials.secretAccessKey});
            // Configure your region
            AWS.config.region = AWS_credentials.region;
            nutrifamiS3 = new AWS.S3({params: {Bucket: AWS_credentials.defaultBucket}});   /* Inicializa el bucket */
            callback();
        },
        
        /*
         * nutrifami_aws.s3.uploadFile(file);
         * Carga de archivo en s3
         * @param {file} file   // Objeto de archivo cargado con archivo
         * @param {string} folder   // Ubicacion en el bucket
         * @param {string} newName   
         * @param {function} callback   
         * @returns {String}
         */
        uploadFile: function(file, folder, newName, callback){
            callback = callback || function(){};
            folder = folder || '';
            var msj = 'error_1'; /* No se ejecuto la carga */
            if (file) {
              msj = 'success';
              var fileName = newName || file.name; 
              var params = {Key: folder+fileName, ContentType: file.type, Body: file, Bucket:AWS_credentials.defaultBucket, ACL:'public-read'};
              nutrifamiS3.upload(params, function (err, data) {
                  msj = 'error_2'; /* Excepcion en la carga a AWS */
                  if ( err == null ){
                      callback();
                  }else {
                      alert(err);  
                  }           
              });
            } else {
                msj = 'error_3';  /* No hay archivo que cargar*/
                alert(msj);
            }
        },
        
        /*
         * nutrifami_aws.s3.saveImage(file);
         * Carga de archivo en s3
         * @param {file} file   // Objeto de archivo cargado con archivo
         * @param {string} folder   // Ubicacion en el bucket
         * @param {string} newName   
         * @param {function} callback   
         * @returns {String}
         */
        saveImage: function (req, folder, newName, res) {
            
            var fileName = newName || req.body.imageName; 
            // bucketName var below crates a "folder" for each user
            var bucketName = AWS_credentials.defaultBucket;
            var params = {
                Bucket: bucketName
              , Key: folder+fileName
              , Body: req
              , ContentType: 'image/png'
              , ACL: 'public-read'
            };
            nutrifamiS3.upload(params, function (err, data) {
              if (err) return res.status(500).send(err);

              // TODO: save data to mongo
              res.json(data);
            });
        },
        
        /*
         * nutrifami_aws.s3.changeBucket(bucket);
         * Cambia el bucket
         */
        changeBucket: function(bucket, callback) {
            bucket = bucket || AWS_credentials.defaultBucket;
            callback = callback || function(){};
            AWS_credentials.defaultBucket = bucket;
        }
        
    }
    
};




function getExt (fileName){
    var s  = fileName,
    lw = s.replace(/^.+[\W]/, '');
    return lw;
}

function getFileName(fileName){
    var d = new Date();
    var sName = d.getFullYear()+''+d.getMonth()+''+d.getDay()+''+d.getHours()+''+d.getMinutes()+''+d.getSeconds()+''+d.getMilliseconds();
    return sName+'.'+getExt(fileName);
}



var wrap = $(window);

wrap.scroll(function (e) {
    
  if (wrap.scrollTop() > 100) {
    $(".navbar-inner").addClass("navbartop");
    $(".seccion_titulo").addClass("tituloseccion");
    $(".container.main").addClass("form_custom");
  } else {
    $(".navbar-inner").removeClass("navbartop");
    $(".seccion_titulo").removeClass("tituloseccion");
    $(".container.main").removeClass("form_custom");
  }
  
});



 function loadFileAsURL(file, idpreview, callback)
{
    callback = callback || function(){};
    var reader  = new FileReader();

    reader.addEventListener("load", function () {
      $('#'+idpreview).cropper('reset', true).cropper('replace', reader.result);
      callback();
    }, false);

    if (file) {
      reader.readAsDataURL(file);
    }
}

function dataURLtoFile(dataurl, filename) {
    var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while(n--){
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new File([u8arr], filename, {type:mime});
}