<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.apache.taglibs.standard.tag.common.sql.DataSourceWrapper"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>  
<%@page import="java.util.Map"%>  
<%@page import="java.util.HashMap"%>  
<%@page import="java.io.File"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 


<!DOCTYPE html>  

<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <title>${param.reportTitle}</title>  
    </head>  
    <body>  
        <sql:setDataSource driver="org.firebirdsql.jdbc.FBDriver" 
                           url="jdbc:firebirdsql:localhost/3050:C:/AcademiaWeb/System/Banco de Dados Academia Web/academia.fdb?encoding=UTF8"
                           user="sysdba" password="masterkey"
                           var="conexao" />

        <c:if test="${not empty param.reportName}" >

            <%
                DataSourceWrapper datasource = (DataSourceWrapper) pageContext.getAttribute("conexao");
                File reportFile = new File(application.getRealPath(request.getParameter("reportName")));
                Map parameters = new HashMap();
                java.util.Enumeration<String> paramNames = request.getParameterNames();
                while (paramNames.hasMoreElements()) {
                    String paramName = paramNames.nextElement();
                    parameters.put(paramName, request.getParameter(paramName));
                }
                byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, datasource.getConnection());
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream ouputStream = response.getOutputStream();
                ouputStream.write(bytes, 0, bytes.length);
                ouputStream.flush();
                ouputStream.close();
            %>                

        </c:if>
    </body>  
</html>  