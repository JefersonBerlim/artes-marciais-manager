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

        <title>Impressão Anual de Mensalidades</title>

        <script>
            
            function FormataData(campo){
                if (campo.value.length == 2 || campo.value.length == 5 ){
                    campo.value = campo.value+"/";
                }
            }
            

            function validaformulario() {
                if ( formulario.anobase.value == '' ){
                    jAlert('Por favor, digite o um ano base válido!', 'Atenção');
                    document.formulario.anobase.focus();
                    return false;
                }else{ 
                    if ( formulario.anobase.value > 2020 ||  formulario.anobase.value < 1900 ){
                        jAlert('Por favor, digite o um ano entre 1900 e 2020!', 'Atenção');
                        document.formulario.anobase.focus();
                        return false;
                    }else{ 
                        return true;                                        
                    }            
                }
            }
          
                    
        </script>

        <style type="text/css">

            #anobase {
                width: 200px;
            }
            
            #aluno{
                width: 550px;
            }

        </style>

    </head>

    <body>

        <form name="formulario" action="ImprimeRelMensalidadeEmAtraso.jsp"> 

            <div data-role="content" style="padding: 15px">

                <h1>Impressão Anual de Mensalidades</h1>

                <%--Ano Base--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Ano Base
                        </label><br>
                        <input data-mini="true" id="anobase" name="anobase" type="text"
                               maxlength="4" />
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
                       name="BtnSalvar" value="Imprimir" onClick="return validaformulario()">
            </div>

        </form>   

    </body>

</html> 