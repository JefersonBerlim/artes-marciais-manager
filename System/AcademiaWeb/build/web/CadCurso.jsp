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
        <title>Cadastro de Cursos</title>

        <script>
            
            //Valida se todos os campos do formulário estão prenchidos
            function validaformulario(){
                if (formulario.CurDescricao.value == "") {
                    jAlert('Por favor, digite a descrição!', 'Atenção');
                    document.formulario.CurDescricao.focus();
                    return false;
                }
            } 
            
        </script>

        <style type="text/css">

            #nomecurso {
                width: 300px;
            }

        </style>

    </head>

    <body>

        <%--Criação do Objeto "controlecurso" para a listagem dos cursos--%>
        <jsp:useBean id="controlecurso" class="Controle.TbCursoJpaController"/>

        <%--Criação do Objeto Entidade para a gravação no banco de dados--%>
        <jsp:useBean id="entidade" class="Entidade.TbCurso" />
        <jsp:setProperty name="entidade" property="curDescricao" param="CurDescricao"/> 
        <jsp:setProperty name="entidade" property="curCodigo" param="codigo"/> 

        <%--Validação do Usuário no acesso á tela--%>
        <c:if test="${SysUser != 'M' }">
            <c:redirect url="TelaLogin.jsp">
                <c:param name="alerta">
                    Somente usuários do tipo "Mestre" tem acesso a esta tela
                </c:param>                
            </c:redirect>
            
        </c:if>


        <%--Verifica se o campo 'valida'esta com o valor ok, caso esteja 
                todos os campos obrigatórios foram preenchidos, ai faz-se a persistência--%>          
        <c:if test="${not empty param.CurDescricao}">
            <%
                controlecurso.create(entidade);
            %>

            <script>
                jAlert('Curso salvo com sucesso!', 'Atenção');
            </script>
        </c:if>  

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.codigo}">
            <%
                entidade = controlecurso.findTbCurso(entidade.getCurCodigo());
                pageContext.setAttribute("entidade", entidade);
            %>
        </c:if>  

        <form name="formulario"> 

            <div data-role="content" style="padding: 15px">

                <h1>Cadastro de Cursos</h1>

                <%--Código do Curso--%>
                <input type="hidden" name="codigo" value="${param.codigo}" /> 


                <%--Nome do Curso--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Descrição
                        </label><br>
                        <input data-mini="true" id="nomecurso" type="text" name="CurDescricao" maxlength="50" value="${entidade.curDescricao}" />
                    </fieldset>
                </div>	

                <input type="submit" data-inline="true" data-mini="true" data-theme="a" data-icon="check" data-iconpos="left" 
                       name="BtnSalvar" value="Salvar" onClick="return validaformulario()" >

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadCurso.jsp';" value="Novo" />

            </div>

        </form>   

    </body>

</html> 