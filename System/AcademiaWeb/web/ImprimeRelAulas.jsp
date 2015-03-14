<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>        

        <c:set var="query" >
            SELECT
            TB_ALUNO."ALU_NOME" AS TB_ALUNO_ALU_NOME,
            TB_AULA."AUL_DATA" AS TB_AULA_AUL_DATA,
            TB_AULA."AUL_HORARIO" AS TB_AULA_AUL_HORARIO,
            TB_AULA."AUL_ASSUNTO" AS TB_AULA_AUL_ASSUNTO,
            TB_AULA."AUL_OBSERVACOES" AS TB_AULA_AUL_OBSERVACOES,
            TB_EXERCICIO."EXE_DESCRICAO" AS TB_EXERCICIO_EXE_DESCRICAO,
            TB_PROFESSOR."PRO_NOME" AS TB_PROFESSOR_PRO_NOME
            FROM
            "TB_AULA" TB_AULA 
            LEFT JOIN "TB_ALUNO" TB_ALUNO ON TB_ALUNO."ALU_CODIGO" = TB_AULA."TB_ALUNO_ALU_CODIGO"
            LEFT JOIN "TB_EXERCICIO" TB_EXERCICIO ON TB_AULA."TB_EXERCICIO_EXE_CODIGO" = TB_EXERCICIO."EXE_CODIGO"
            LEFT JOIN "TB_PROFESSOR" TB_PROFESSOR ON TB_AULA."TB_PROFESSOR_PRO_CODIGO" = TB_PROFESSOR."PRO_CODIGO"
            WHERE 1=1
        </c:set>                    

        <c:if test="${not empty param.datainicial and empty param.datafinal}">
            <c:set var="data">
                AND TB_AULA.AUL_DATA >= '${param.datainicial}'
            </c:set>
        </c:if>

        <c:if test="${empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_AULA.AUL_DATA <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_AULA.AUL_DATA >= '${param.datainicial}' AND TB_AULA.AUL_DATA <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.aluno}" >
            <c:set var="aluno">
                AND TB_ALUNO."ALU_CODIGO" = '${param.aluno}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.professor}" >
            <c:set var="professor">
                AND TB_PROFESSOR."PRO_CODIGO" = '${param.professor}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.exercicio}" >
            <c:set var="exercicio">
                AND TB_EXERCICIO."EXE_CODIGO" = '${param.exercicio}'
            </c:set>
        </c:if>   

        <c:if test="${not empty param.palavrachave}" >
            <c:set var="palavrachave">
                AND ( TB_AULA."AUL_OBSERVACOES" LIKE '%${param.palavrachave}%' OR TB_AULA.AUL_ASSUNTO LIKE '%${param.palavrachave}%' )
            </c:set>
        </c:if>    

        <c:url value="GeraRelatoriosFiltro.jsp" var="relatorio">
            <c:param name="reportName" value="Relatorios/RelacaoDeAulas.jasper"/>
            <c:param name="queryp" value="${query} ${data} ${aluno} ${professor} ${exercicio} ${palavrachave}"/>
        </c:url>

        <script>
            window.open("${relatorio}");
        </script>

    </body>

</html>


