<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

    <head>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Relatório de Aulas</title>

        <script>
            
            function FormataData(campo){
                if (campo.value.length == 2 || campo.value.length == 5 ){
                    campo.value = campo.value+"/";
                }
            }
            
        </script>


        <style type="text/css">

            #datainicial {
                width: 200px;
            }
            #datafinal {
                width: 200px;
            }
            
            #aluno{
                width: 550px;
            }

        </style>

    </head>

    <body>

        <form name="formulario" action="ImprimeRelPagamentos.jsp"> 

            <div data-role="content" style="padding: 15px">

                <h1>Impressão de Pagamentos</h1>

                <%--Data Inicial--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data Inicial
                        </label><br>
                        <input data-mini="true" id="datainicial" name="datainicial" type="text"
                               onKeyUp="FormataData(this)" maxlength="10"/>
                    </fieldset>
                </div>

                <%--Data Final--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data Final
                        </label><br>
                        <input data-mini="true" id="datafinal" name="datafinal" type="text" 
                               onKeyUp="FormataData(this)" maxlength="10"/>
                    </fieldset>
                </div>

                <%--Criação do Objeto "controlealuno" para listagem dos alunos--%>
                <jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

                <%--Seleção do Aluno--%>
                <div data-role="fieldcontain" id="aluno">
                    <label>
                        Aluno
                    </label><br>
                    <select data-mini="true" name="aluno">
                        <option>

                        </option>

                        <%-- Listagem dos alunos através do método "findTbAlunoAll"--%>
                        <c:forEach items="${controlealuno.findAlunoPagamentos()}" var="aluno">

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${aluno.aluCodigo}" ${selecionado}>${aluno.aluNome}</option>
                        </c:forEach>
                    </select>
                </div>

                <input type="submit" data-inline="true" data-mini="true" data-theme="a" data-icon="check" data-iconpos="left" 
                       name="BtnSalvar" value="Imprimir">
            </div>

        </form>   

    </body>

</html> 