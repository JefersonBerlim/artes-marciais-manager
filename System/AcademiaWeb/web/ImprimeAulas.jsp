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

            #professor{
                width: 550px;
            }

            #exercicio{
                width: 550px;
            }

            #palavrachave{
                width: 550px;
            }

        </style>

    </head>

    <body>

        <form name="formulario" action="ImprimeRelAulas.jsp"> 

            <div data-role="content" style="padding: 15px">

                <h1>Impressão de Aulas</h1>

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
                        <c:forEach items="${controlealuno.findTbAlunoAll()}" var="aluno">

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${aluno.aluCodigo}" ${selecionado}>${aluno.aluNome}</option>
                        </c:forEach>
                    </select>
                </div>

                <%--Criação do Objeto "controleprofessor" para listagem dos professores--%>
                <jsp:useBean id="controleprofessor" class="Controle.TbProfessorJpaController"/>

                <%--Seleção do Professor--%>
                <div data-role="fieldcontain" id="professor">
                    <label>
                        Professor
                    </label><br>
                    <select data-mini="true" name="professor">
                        <option>

                        </option>

                        <%-- Listagem dos professores através do método "findTbProfessorAll"--%>
                        <c:forEach items="${controleprofessor.findTbProfessorAll()}" var="professor">
                            <c:set var="selecionado" value="" />

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${professor.proCodigo}" ${selecionado}> ${professor.proNome}</option>
                        </c:forEach>
                    </select>
                </div>

                <%--Criação do Objeto "controleexercicio" para listagem dos exercicios--%>
                <jsp:useBean id="controleexercicio" class="Controle.TbExercicioJpaController"/>

                <%--Seleção do Exercício--%>
                <div data-role="fieldcontain" id="exercicio">
                    <label>
                        Exercício
                    </label><br>
                    <select data-mini="true" name="exercicio">
                        <option>
                                 
                        </option>

                        <%-- Listagem dos exercicios através do método "findTbProfessorAll"--%>
                        <c:forEach items="${controleexercicio.findTbExercicioAll( )}" var="exercicio">
                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${exercicio.exeCodigo}" ${selecionado} > ${exercicio.exeDescricao}</option>
                        </c:forEach>
                    </select>
                </div>

                <%--Palavra Chave--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Palavra Chave
                        </label><br>

                        <input type="text" id="palavrachave" name="palavrachave"/>

                    </fieldset>
                </div>

                <input type="submit" data-inline="true" data-mini="true" data-theme="a" data-icon="check" data-iconpos="left" 
                       name="BtnSalvar" value="Imprimir">
            </div>

        </form>   

    </body>

</html> 