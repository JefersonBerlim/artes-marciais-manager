<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Cadastro de Exercicios</title>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <script>
            // validação do formulário de cadastro
            function validaformulario(){ 
			
                //Verifica se a Descrição do Exercicio foi preenchida
                if (formulario.ExeDescricao.value == "") {
                    jAlert('Por favor, digite a descrição!', 'Atenção');
                    document.formulario.ExeDescricao.focus();
                    return false; 
                }else{
                    if (formulario.ExeGraduacao.value == "") {
                        jAlert('Por favor, selecione a graduação!', 'Atenção');
                        document.formulario.ExeGraduacao.focus();
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

            #nomeexercicio {
                width: 300px;
            }

            #nomegraduacao{
                width:400px;
            }

        </style>

    </head>

    <body>

        <%-- Criação do Objeto "controlegraduacao" para fazer a persistência no banco de dados--%>
        <jsp:useBean id="controlegraduacao" class="Controle.TbGraduacaoJpaController"/>

        <%-- Criação do Objeto "controleexercicio" para listar os Exercicios abaixo do cadastro--%>
        <jsp:useBean id="controleexercicio" class="Controle.TbExercicioJpaController"/>

        <%-- Criação do Objeto "entidade" para inserir os atributos da entidade--%>
        <jsp:useBean id="entidade" class="Entidade.TbExercicio"/>
        <jsp:setProperty name="entidade" property="exeDescricao" param="ExeDescricao"/> 
        <jsp:setProperty name="entidade" property="exeCodigo" param="ExeCodigo"/>

        <%--Atributo @Transient da Entidade para efetuar a persistência dentro do Controle--%>
        <jsp:setProperty name="entidade" property="tmptbGraduacaoGraCodigo" param="ExeGraduacao"/>

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
                controleexercicio.create(entidade);
            %>
            <script>
                jAlert('Exercício salvo com sucesso!', 'Atenção');
            </script>
        </c:if>

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.ExeCodigo}">
            <%
                entidade = controleexercicio.findTbExercicio(entidade.getExeCodigo());
                pageContext.setAttribute("entidade", entidade);
            %>

        </c:if>  

        <form name="formulario">

            <div data-role="content" style="padding: 15px">

                <h1>Cadastro de Exercícios</h1>

                <%--Criação do campo oculto para a validação do formulário--%>
                <input type="hidden" name="valida" />


                <%--Código do exercício--%>
                <input type="hidden" name="ExeCodigo" value="${param.ExeCodigo}"/>


                <%--Descrição do exercício--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label >
                            Descrição
                        </label><br>
                        <input type="text" data-mini="true" id="nomeexercicio" name="ExeDescricao" maxlength="50" value="${entidade.exeDescricao}">
                    </fieldset>
                </div>


                <%--Seleção da Graduação--%>
                <div data-role="fieldcontain" id="nomegraduacao">
                    <label>
                        Graduação
                    </label><br>
                    <select name="ExeGraduacao" data-mini="true" >
                        <option>

                        </option>

                        <%-- Listagem das graduações através do método "findTbGraduacaoAll" do Objeto "controlegraduacao"--%>
                        <c:forEach items="${controlegraduacao.findTbGraduacaoAll()}" var="graduacao">
                            <c:set var="selecionado" value="" />
                            <c:if test="${graduacao.graCodigo eq entidade.tbGraduacaoGraCodigo.graCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${graduacao.graCodigo}" ${selecionado}> ${graduacao.graDescricao} </option>
                        </c:forEach>				  

                    </select>

                </div>

                <input type="submit" data-theme="a" data-icon="check" data-iconpos="left" data-inline="true"  
                       data-mini="true" name="BtnSalvar" value="Salvar" onClick="return validaformulario()">

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadExercicio.jsp';" value="Novo" />

            </div>

        </form>

    </body>

</html>