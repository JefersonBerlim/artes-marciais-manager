<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Relatório de Exames</title>
    </head>
    <body>

        <c:set var="query" >
            SELECT
            TB_PROFESSOR.PRO_CODIGO,
            TB_EXAMES."EXA_DATA" AS TB_EXAMES_EXA_DATA,
            TB_EXAMES."EXA_HORARIO" AS TB_EXAMES_EXA_HORARIO,
            TB_EXAMES."TB_PROFESSOR_PRO_CODIGO" AS TB_EXAMES_TB_PROFESSOR_PRO_CODI,
            TB_EXAMES."TB_CURSO_CUR_CODIGO" AS TB_EXAMES_TB_CURSO_CUR_CODIGO,
            TB_EXAMES."TB_GRADUACAO_GRA_CODIGO" AS TB_EXAMES_TB_GRADUACAO_GRA_CODI,
            TB_EXAMES."TB_ALUNO_ALU_CODIGO" AS TB_EXAMES_TB_ALUNO_ALU_CODIGO,
            TB_EXAMES."EXA_MEDIA" AS TB_EXAMES_EXA_MEDIA,
            CASE TB_EXAMES."EXA_RESULTADO" WHEN 'A' THEN 'Aprovado' ELSE 'Reprovado' END AS TB_EXAMES_EXA_RESULTADO,
            TB_ALUNO."ALU_NOME" AS TB_ALUNO_ALU_NOME,
            TB_GRADUACAO."GRA_CODIGO" AS TB_GRADUACAO_GRA_CODIGO,
            TB_GRADUACAO."TB_CURSO_CUR_CODIGO" AS TB_GRADUACAO_TB_CURSO_CUR_CODIG,
            TB_GRADUACAO."GRA_DESCRICAO" AS TB_GRADUACAO_GRA_DESCRICAO,
            TB_PROFESSOR."PRO_NOME" AS TB_PROFESSOR_PRO_NOME,
            TB_CURSO."CUR_DESCRICAO" AS TB_CURSO_CUR_DESCRICAO
            FROM
            "TB_EXAMES" TB_EXAMES 
            LEFT JOIN "TB_PROFESSOR" TB_PROFESSOR ON TB_PROFESSOR."PRO_CODIGO" = TB_EXAMES."TB_PROFESSOR_PRO_CODIGO"
            LEFT JOIN "TB_ALUNO" TB_ALUNO ON TB_EXAMES."TB_ALUNO_ALU_CODIGO" = TB_ALUNO."ALU_CODIGO"
            LEFT JOIN "TB_GRADUACAO" TB_GRADUACAO ON TB_EXAMES."TB_GRADUACAO_GRA_CODIGO" = TB_GRADUACAO."GRA_CODIGO"
            LEFT JOIN "TB_CURSO" TB_CURSO ON TB_EXAMES."TB_CURSO_CUR_CODIGO" = TB_CURSO."CUR_CODIGO"
            WHERE 1=1 
        </c:set>

        <c:if test="${not empty param.datainicial and empty param.datafinal}">
            <c:set var="data">
                AND TB_EXAMES.EXA_DATA >= '${param.datainicial}'
            </c:set>
        </c:if>

        <c:if test="${empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_EXAMES.EXA_DATA <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_EXAMES.EXA_DATA >= '${param.datainicial}' AND TB_EXAMES.EXA_DATA <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.curso}">
            <c:set var="curso">
                AND TB_CURSO."CUR_CODIGO" = '${param.curso}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.aluno}">
            <c:set var="aluno">
                AND TB_ALUNO."ALU_CODIGO" = '${param.aluno}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.graduacao}">
            <c:set var="graduacao">
                AND TB_GRADUACAO."GRA_CODIGO" = '${param.graduacao}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.professor}">
            <c:set var="professor">
                AND TB_PROFESSOR."PRO_CODIGO" = '${param.professor}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.resultado}">
            <c:set var="resultado">
                AND TB_EXAMES.EXA_RESULTADO = '${param.resultado}'
            </c:set>
        </c:if>

        <c:url value="GeraRelatoriosFiltro.jsp" var="relatorio">
            <c:param name="reportName" value="Relatorios/RelacaoDeExames.jasper"/>
            <c:param name="queryp" value="${query} ${data} ${curso} ${aluno} ${graduacao} ${professor} ${resultado}"/>
        </c:url>

        <script>
            window.open("${relatorio}");
        </script>

    </body>

</html>


