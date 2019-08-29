<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<%@page import="com.scannellsolutions.enviromanager.util.RegisterTypeHelper"%>

<html>



<head>
<title>Scannell ENVIRO Manager - Legal Profile Manager</title>

<c:if test="${param['jsDebug'] == 'true'}" >
    <c:set var="jsSuffix" value="-debug" />
</c:if>

<link type="text/css" href="<c:url value="/ext-3.1.0/resources/css/ext-all.css" />" rel="stylesheet" />
<link type="text/css" href="<c:url value="/ext-ux/css/Ext.ux.form.LovCombo.css" />" rel="stylesheet" />

<script type="text/javascript" src="<c:url value="/ext-3.1.0/adapter/ext/ext-base${jsSuffix}.js" />"></script>
<script type="text/javascript" src="<c:url value="/ext-3.1.0/ext-all${jsSuffix}.js" />"></script>
<script type="text/javascript" src="<c:url value="/ext-ux/js/Ext.ux.util.js" />"></script>
<script type="text/javascript" src="<c:url value="/ext-ux/js/Ext.ux.form.LovCombo.js" />"></script>



<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '<c:url value="/ext-3.1.0/resources/images/default/s.gif" />';
var autoEditProfileId = ${autoEditProfileId};
</script>
<script language="javascript" type="text/javascript">
  var contextPath = '<%=request.getContextPath()%>';
  var profileCreateAllowed = <%=LegacyProfile.isCreateAllowed()%>;
  var ss_cgen = ${isContentGenerator}; 
</script>
  <script type="text/javascript">
 /* var openAttachDocumentWindow = function(id) {
		var url = contextPath + "/doclink/holderEdit.htm?holderName=" + id;
		jQuery('#dialogFrameDocs').attr('src', url);
		jQuery('#dialogLinkDocs').dialog('open');
	}; */
        function OnChangeCheckbox (checkbox) {
        	alert();
        	
            if (checkbox.checked) {
                alert ("The check box is checked.");
            }
            else {
                alert ("The check box is not checked.");
            }
            
        }
    </script>
  
  <%@include file="../decorators/javascript.translations.jsp" %> 
<script type="text/javascript" src="<scannell:resource value="/js/profileManager.js" />"></script>

<style type="text/css">
.x-form-item-label {
  font-weight: bold;
  font-size: 11px;
}
.x-form-item  {
  font:verdana,arial,helvetica,sans-serif;
}
.ss-pmgr-checkbox {
  padding:0;
  font-family:tahoma,arial,helvetica,sans-serif;
  font-size:12px;
  font-size-adjust:none;
  font-style:normal;
  font-variant:normal;
  font-weight:normal;
  line-height:normal;
}
.ss-pmgr-checkbox label{
    display: block;
    float: left;
    clear: both;
    padding-left: 30px;
    text-indent: -30px;
}

td.tr2-content-modifiable div {
  margin-left: 10px;
}

.tr2-content-modified {
  background-image: url("<c:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />") !important; 
  background-repeat: no-repeat; 
}

.ss-checkbox-on { padding-left: 20px; background-image: url("<c:url value="/images/cb-on.gif" />"); background-repeat: no-repeat; }
.ss-checkbox-off { padding-left: 20px; background-image: url("<c:url value="/images/cb-off.gif" />"); background-repeat: no-repeat; }
.ss-form-border {
}

.ss-leg {
    background-image: url("<c:url value="/legal/images/scannelApp_BackgroundTile2.gif" />");
    padding: 10px 20px;
}

.ss-leg a,a:visited {
  color: #666699
}

.ss-leg ul{ margin-left: 40px; }
.ss-leg-text ul li { list-style-type: disc; }



.checklist-title {
  background-color: #d8e0f0;
  font-weight: bold;
  font-size: 12px;
  border-top: 5px;
  padding: 10px 5px;
}

.law-changeindicator-true {
  background-image: url("<c:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />");
  background-repeat: no-repeat;
  background-position: 5px center;
  padding-left: 25px !important;  
}

.checklist-id {
  font-size: 10px;
  font-weight: normal;
}

.checklist-description {
    background-color :#EEEEEE;
    color:#666699;
    font-family:Arial,Helvetica,sans-serif;
    font-size: 10pt;
    padding:8px;
    margin-top: 5px;
}

.checklist-description-title {
  font-weight: bold;
}


.checklist-legislation {
  margin-top: 10px;
  margin-bottom: 20px;
  padding-top: 10px;
  color: #666699;
}

.checklist-legislation-title {
  font-size: 12px;
  font-weight:  bold;
  padding: 10px;
  background-color: #eeeeee;
}

.checklist-legislation-item {
  background-color: #eeeeee;
  border-bottom: 1px solid #BDBDBD;
  border-top: 1px solid #BDBDBD;
  padding: 10px;
  margin: 5px;
  color: #666666;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 10px;
  font-weight: bold;
  color: #666666;
}

.relevance-title {
  background-color:#006699;
  color:#FFFFFF;
  font-family:Arial,Helvetica,sans-serif;
  font-weight:bold;
  padding:2px;
  font-size: 13px;
}

.relevance-detail {
  border: 2px solid #006699;
  padding: 2px;
  font-size: 13px;
  font-family: Arial,Helvetica,sans-serif;
}

.ss-profile-version-out-of-date {
  background-color: #F6CACF;
}

</style>

</head>


<body>
</body>
</html>