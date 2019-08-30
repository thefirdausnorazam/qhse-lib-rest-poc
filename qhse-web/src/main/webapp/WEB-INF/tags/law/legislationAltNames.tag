<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="legislation" required="true" type="com.scannellsolutions.modules.law.domain.Legislation" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:forEach items="${legislation.alternateLanguageNames}" var="altName">
<br/> <span class="legislation-alt-lang-name">
&#9675; <c:out value="${altName.value}" escapeXml="false" />
</span>
</c:forEach>

