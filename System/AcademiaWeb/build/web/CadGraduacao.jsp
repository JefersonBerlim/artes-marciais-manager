<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>

    <head>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <title>Cadastro de Graduações</title>

        <script>
            
            //Valida se todos os campos to formulário foram preenchidos
            function validaformulario() {
			
                if (formulario.GraDescricao.value == "") {
                    jAlert('Por favor, digite a descrição!', 'Atenção');
                    document.formulario.GraDescricao.focus();
                    return false; 
                }else{
                    if (formulario.GraCurso.value == "") {
                        jAlert('Por favor, selecione o curso!', 'Atenção');
                        document.formulario.GraCurso.focus();
                        return false; 
                    }else{
                        //se todos os campos do formulário foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                        document.formulario.valida.value = "ok";
                        return true;
                    }
                }
            }
        
        </script>

        <style type="text/css">

            #nomegraduacao {
                width: 300px;
            }

            #nomecurso{
                width: 400px;
            }

        </style>

    </head>

    <body>

        <%--Criação do Objeto "controlegraduacao" para usar o método de persistência da Entidade "TbGraduacao"--%>
        <jsp:useBean id="controlegraduacao" class="Controle.TbGraduacaoJpaController"/>    

        <%--Criação do Objeto "controlecurso" para listagem dos cursos--%>
        <jsp:useBean id="controlecurso" class="Controle.TbCursoJpaController"/>

        <%--Criação do Objeto de Entidade para a persistência no banco--%>
        <jsp:useBean id="entidade" class="Entidade.TbGraduacao"/>
        <jsp:setProperty name="entidade" property="graDescricao" param="GraDescricao"/> 
        <jsp:setProperty name="entidade" property="graCodigo" param="GraCodigo"/>

        <%--Atributo @Transient da Entidade para efetuar a persistência dentro do Controle--%>
        <jsp:setProperty name="entidade" property="tmpCursoCurCodigo" param="GraCurso"/>

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
        <c:if test="${param.valida eq 'ok'}">  
            <%
                controlegraduacao.create(entidade);
            %>
            <script>
                jAlert('Graduação salva com sucesso!', 'Atenção');
            </script>
        </c:if>

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.GraCodigo}">
            <%
                entidade = controlegraduacao.findTbGraduacao(entidade.getGraCodigo());
                pageContext.setAttribute("entidade", entidade);
            %>

        </c:if>  

        <form name="formulario">

            <div data-role="content" style="padding: 15px">

                <h1>Cadastro de Graduações</h1>

                <%--Campo oculto para validar o formulário--%>
                <input type="hidden" name="valida" />


                <%--Código da Graduação--%>
                <input type="hidden" name="GraCodigo" value="${param.GraCodigo}"/>


                <%--Nome da Graduação--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label >
                            Descrição
                        </label><br>
                        <input type="text" data-mini="true" id="nomegraduacao" name="GraDescricao" maxlength="50" value="${entidade.graDescricao}" >
                    </fieldset>
                </div>


                <%--Nome do Curso--%>
                <div data-role="fieldcontain" id="nomecurso">
                    <label>
                        Curso
                    </label><br>
                    <select name="GraCurso" data-mini="true" >
                        <option>

                        </option>

                        <%--Listagem dos cursos através do método "findTbCursoAll"--%>
                        <c:forEach items="${controlecurso.findTbCursoAll()}" var="curso">
                            <c:set var="selecionado" value="" />
                            <c:if test="${curso.curCodigo eq entidade.tbCursoCurCodigo.curCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                            <option value="${curso.curCodigo}" ${selecionado}> ${curso.curDescricao} </option>
                        </c:forEach>

                    </select>

                </div>         

                <input type="submit" data-inline="true" value="Salvar" data-mini="true" data-theme="a" 
                       data-icon="check" data-iconpos="left" name="BtnSalvar" onClick="return validaformulario()">

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadGraduacao.jsp';" value="Novo" />

            </div>

        </form>

    </body>

</html>