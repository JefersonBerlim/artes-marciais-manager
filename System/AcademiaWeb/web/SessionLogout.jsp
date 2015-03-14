<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Session Logout</title>

    </head>

    <body>

        <%
            session.invalidate();
        %>

        <c:redirect url="TelaLogin.jsp">

        </c:redirect>

    </body>

</html>
