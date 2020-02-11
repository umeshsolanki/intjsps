<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col s4 m2 blue lighten-3 hide-on-small-only via-p0 via-m0" id="nav-container">
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