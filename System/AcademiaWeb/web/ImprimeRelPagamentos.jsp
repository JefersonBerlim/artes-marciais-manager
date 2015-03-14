<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Relatório de Pagamentos</title>
    </head>
    <body>

        <c:set var="query" >
            SELECT
            TB_ALUNO."ALU_NOME" AS TB_ALUNO_ALU_NOME,
            TB_PAGAMENTOS."SEQUENCIAL" AS TB_PAGAMENTOS_SEQUENCIAL,
            TB_PAGAMENTOS."TB_ALUNO_ALU_CODIGO" AS TB_PAGAMENTOS_TB_ALUNO_ALU_CODI,
            TB_PAGAMENTOS."TB_MENSALIDADE_MEN_CODIGO" AS TB_PAGAMENTOS_TB_MENSALIDADE_ME,
            TB_PAGAMENTOS."PAG_DTPAGAMENTO" AS TB_PAGAMENTOS_PAG_DTPAGAMENTO,
            TB_PAGAMENTOS."PAG_VALORPAGO" AS TB_PAGAMENTOS_PAG_VALORPAGO,
            TB_PAGAMENTOS."PAG_VALORAPAGAR" AS TB_PAGAMENTOS_PAG_VALORAPAGAR
            FROM
            "TB_PAGAMENTOS" TB_PAGAMENTOS 
            LEFT JOIN "TB_ALUNO" TB_ALUNO ON TB_ALUNO."ALU_CODIGO" = TB_PAGAMENTOS."TB_ALUNO_ALU_CODIGO"
            WHERE 1=1 
        </c:set>

        <c:if test="${not empty param.datainicial and empty param.datafinal}">
            <c:set var="data">
                AND TB_PAGAMENTOS.PAG_DTPAGAMENTO >= '${param.datainicial}'
            </c:set>
        </c:if>

        <c:if test="${empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_PAGAMENTOS.PAG_DTPAGAMENTO <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.datainicial and not empty param.datafinal}">
            <c:set var="data">
                AND TB_PAGAMENTOS.PAG_DTPAGAMENTO >= '${param.datainicial}' AND TB_PAGAMENTOS.PAG_DTPAGAMENTO <= '${param.datafinal}'
            </c:set>
        </c:if>

        <c:if test="${not empty param.aluno }">
            <c:set var="aluno">
                AND TB_ALUNO."ALU_CODIGO" = '${param.aluno}'
            </c:set>
        </c:if>

        <c:url value="GeraRelatoriosFiltro.jsp" var="relatorio">
            <c:param name="reportName" value="Relatorios/RelacaoDePagamentos.jasper"/>
            <c:param name="queryp" value="${query} ${data} ${aluno}"/>
        </c:url>

        <script>
            window.open("${relatorio}");
        </script>

    </body>

</html>


