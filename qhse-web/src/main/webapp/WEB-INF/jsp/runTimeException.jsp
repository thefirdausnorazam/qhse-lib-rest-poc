<%@ page language="java" isErrorPage="true"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title></title>
    <style type="text/css">
    p {
  font-size: 20px;
}
    .modal-header {    
    background-color: #000000 !important;
    color:#ffffff !important;
   
 }
 .modal.large {
     width: 80%;
}
    .centered
{
    text-align:center;
}
    </style>
    <script language="javascript" type="text/javascript">
    var exceptionNotification;
    exceptionNotification = void 0;
    jQuery(document).ready(function() {
      jQuery('#block').removeClass('block-flat');
      jQuery('#mod').click();
      jQuery('#myModalHorizontal').appendTo('body');
      jQuery('#myModalHorizontalSuccess').appendTo('body');
      jQuery('#back').click(function() {
        window.history.go(-1);
      });
      jQuery('#backSuccess').click(function() {
        window.history.go(-1);
      });
      jQuery('#retry').click(function() {
        window.location.reload(true);
      });
      jQuery('#retrySuccess').click(function() {
        window.location.reload(true);
      });
      jQuery('#mailto').click(function() {
        exceptionNotification();
      });
      exceptionNotification = function() {
        var desc, url;
        desc = void 0;
        url = void 0;
        desc = jQuery('#desc').val();
        if (desc.length > 300) {
          desc = desc.substring(0, 300);
        }
        url = contextPath + '/enviro/exceptionNotification.json?' + 'desc=' + desc;
        jQuery.getJSON(url, function(json) {
          if (json === 'success') {
            jQuery('#myModalHorizontal').modal('hide');
            jQuery('#modSuccess').click();
          }
        });
      };
    });    
</script>
  </head>
  
  <body>
 <button style="display: none;" class="btn btn-primary btn-lg" id="mod" data-toggle="modal" data-target="#myModalHorizontal">   
</button>
<button style="display: none;" class="btn btn-primary btn-lg" id="modSuccess" data-toggle="modal" data-target="#myModalHorizontalSuccess">   
</button>

<div class="modal fade" id="myModalHorizontalSuccess" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width:100%">
            <!-- Modal Header -->
            <div class="modal-header">
                <button type="button" class="close" 
                   data-dismiss="modal">
                       <span aria-hidden="true">&times;</span>
                       <span class="sr-only">Close</span>
                </button>
                <h1 class="modal-title" id="myModalLabel" align="center">
                   Q-Pulse
                </h1>
            </div>            
            <!-- Modal Body -->
            <div class="modal-body">
              <h1 align="center" style="padding-top: 5%;"> Report  </h1>
              <p align="center" style="padding-top: 2%;">sent successfully  </p>  
              
             
               <p align="center" style="padding-top: 4%;padding-left:20%; padding-right:20%;"> <button type="button" id="backSuccess" class="btn btn-primary btn-lg btn-block">Back</button></p> 
              
               <p align="center" style="padding-top: 2%;padding-left:20%; padding-right:20%;"> <button type="button" id="retrySuccess" class="btn btn-primary btn-lg btn-block">Retry</button></p>               
                               
                
            </div>            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">
                            Close
                </button>
                
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModalHorizontal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width:100%">
            <!-- Modal Header -->
            <div class="modal-header">
                <button type="button" class="close" 
                   data-dismiss="modal">
                       <span aria-hidden="true">&times;</span>
                       <span class="sr-only">Close</span>
                </button>
                <h1 class="modal-title" id="myModalLabel" align="center">
                   Q-Pulse
                </h1>
            </div>            
            <!-- Modal Body -->
            <div class="modal-body">
              <h1 align="center" style="padding-top: 5%;"> Sorry </h1>
              <p align="center" style="padding-top: 2%;">Something is wrong  </p>  
              <p align="center" style="padding-top: 2%;">and we can't display what you are looking for</p> 
             
               <p align="center" style="padding-top: 4%;padding-left:20%; padding-right:20%;"> <button type="button" id="back" class="btn btn-primary btn-lg btn-block">Back</button></p> 
              
               <p align="center" style="padding-top: 2%;padding-left:20%; padding-right:20%;"> <button type="button" id="retry" class="btn btn-primary btn-lg btn-block">Retry</button></p> 
               
               <p align="center" style="padding-top: 2%;padding-left:20%; padding-right:20%;"> <button type="button" id="mailto" class="btn btn-primary btn-lg btn-block">Report this Problem</button></p>                
                
            </div>            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">
                            Close
                </button>
                
            </div>
        </div>
    </div>
</div>

 <% Exception ex = (Exception) request.getAttribute("exception"); %>  
<input type="hidden" id="desc" value="<%ex.printStackTrace(new java.io.PrintWriter(out));%>">
  </body>
</html>
