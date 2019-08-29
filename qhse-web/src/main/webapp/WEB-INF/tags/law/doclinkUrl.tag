<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="doclink" required="true" type="com.scannellsolutions.modules.doclink.domain.DocLink" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${param['cgen'] == 'true' and doclink.file}" >documents/${doclink.filename}</c:when> 
	<c:otherwise>${doclink.url}</c:otherwise>
</c:choose>
