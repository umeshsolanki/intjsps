<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="blue lighten-3 via-p0 via-m0 hiddendiv col s6 m4 l3 xl2" id="nav-container"   
     style="position: absolute;height: calc(100%-56);min-height: 93vh;overflow-y: auto;z-index: 996">
    <ul class="collapsible via-m0 via-p0">
        <c:forEach items="${modules}" var="m">
        <li>
          <div class="collapsible-header">${m.module}</div>
          <div class="collapsible-body via-p0">
              <c:forEach items="${m.links}" var="l">
              <a href="${l.value}"><p class="via-p2 via-m2 via-arrowCursor black-text">${l.name}</p></a>
              </c:forEach>
          </div>
        </li>
        </c:forEach>
        <li>
          <div class="collapsible-header">Maven Project</div>
          <div class="collapsible-body via-p0">
              <a href="/api/admin/project/new" ><p class="via-p2 via-m2 via-arrowCursor black-text">New Project</p></a>
              <a href="/api/admin/project/open" ><p class="via-p2 via-m2 via-arrowCursor black-text">Open Project</p></a>
          </div>
        </li>
    </ul>
</div>