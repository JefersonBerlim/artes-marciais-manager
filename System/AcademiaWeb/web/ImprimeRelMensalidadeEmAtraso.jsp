<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Impressão Anual de Mensalidades</title>
    </head>
    <body>

        <c:set var="aluno" value=""/>
        
        <c:if test="${not empty param.aluno}" >
            <c:set var="aluno">
                AND A.ALU_CODIGO = '${param.aluno}'
            </c:set>
        </c:if>                              

        <c:set var="query" >
            SELECT 
            A.ALU_NOME AS ALUNO,
            A.ALU_DESCONTO,
            A.ALU_DIAVENCMENSALIDAE,
            CASE M.MES WHEN 1 THEN 'JANEIRO' WHEN 2 THEN 'FEVEREIRO' WHEN 3 THEN 'MARÇO' WHEN 4 THEN 'ABRIL' 
            WHEN 5 THEN 'MAIO' WHEN 6 THEN 'JUNHO' WHEN 7 THEN 'JULHO' WHEN 8 THEN 'AGOSTO' WHEN 9 THEN 'SETEMBRO' 
            WHEN 10 THEN 'OUTUBRO' WHEN 11 THEN 'NOVEMBRO' ELSE 'DEZEMBRO' END AS MES, 
            ( (N.MEN_VALOR) -( ( N.MEN_VALOR/100 )* A.ALU_DESCONTO)) AS MENSALIDADE,  
            N.MEN_VALOR AS VALORAPAGAR,
            COALESCE( SUM( P.PAG_VALORPAGO ), 0 ) AS VALORPAGO  
            FROM TB_ALUNO A 
            LEFT JOIN MESES M ON 1=1
            LEFT JOIN TB_PAGAMENTOS P ON A.ALU_CODIGO = P.TB_ALUNO_ALU_CODIGO AND M.MES = extract( MONTH FROM P.PAG_DTPAGAMENTO) 
            AND EXTRACT( YEAR FROM P.PAG_DTPAGAMENTO) = ${param.anobase}
            LEFT JOIN TB_MENSALIDADE N ON A.TB_MENSALIDADE_MEN_CODIGO = N.MEN_CODIGO
            WHERE
            1=1
            AND A.ALU_DIAVENCMENSALIDAE IS NOT NULL
            ${aluno}
            GROUP BY M.MES, A.ALU_NOME, N.MEN_VALOR, extract( MONTH FROM P.PAG_DTPAGAMENTO ), A.ALU_DESCONTO, A.ALU_DIAVENCMENSALIDAE
            ORDER BY A.ALU_NOME, M.MES
        </c:set>      

        <c:url value="GeraRelatoriosFiltro.jsp" var="relatorio">            
            <c:param name="reportName" value="Relatorios/ImprimeMensalidadesAtrasadas.jasper"/>
            <c:param name="queryp" value="${query}"/>
        </c:url>

        <script>
            window.open("${relatorio}");
        </script>

    </body>

</html>


