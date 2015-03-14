<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>

    <title>Cadastro de Mensalidade</title>

    <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
    <script src="CorpoPagina/jquery.js"></script>
    <script src="CorpoPagina/jquery.mobile.js"></script>
    <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
    <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

    <script>
        
        //Valida se todos os campos to formulário foram preenchidos
        function validaformulario()
        {
            if (formulario.MenDescricao.value == "") {
                jAlert('Por favor, digite a descrição!','Atenção');
                document.formulario.MenDescricao.focus();
                return false; 
            }else{
                if(formulario.MenVlrMensalidade.value == "" || formulario.MenVlrMensalidade.value <= 0 ) {
                    jAlert('Valor de mensalidade inválido!', 'Atenção');
                    document.formulario.MenVlrMensalidade.focus();
                    return false; 
                }
                else{
                    document.formulario.valida.value = "ok";
                    return true;
                }
            } 
        }
        
        function moeda(z){ 
            v = z.value; 
            v=v.replace(/\D/g,"") // permite digitar apenas numero 
            v=v.replace(/(\d{1})(\d{14})$/,"$1.$2") // coloca ponto antes dos ultimos digitos 
            v=v.replace(/(\d{1})(\d{11})$/,"$1.$2") // coloca ponto antes dos ultimos 11 digitos 
            v=v.replace(/(\d{1})(\d{8})$/,"$1.$2") // coloca ponto antes dos ultimos 8 digitos 
            v=v.replace(/(\d{1})(\d{5})$/,"$1.$2") // coloca ponto antes dos ultimos 5 digitos 
            v=v.replace(/(\d{1})(\d{1,2})$/,"$1,$2") // coloca virgula antes dos ultimos 2 digitos 
            z.value = v; 
        }
                      
    </script>

    <style type="text/css">

        #nomemensalidade {
            width: 300px;
        }

        #valormensalidade{
            width: 350px;
        }

    </style>

</head>

<body>

    <%--Criação do Objeto "controlemensalidade" para a listagem das mensalidades --%>
    <jsp:useBean id="controlemensalidade" class="Controle.TbMensalidadeJpaController"/>

    <%--Criação do Objeto de Entidade para fazer a persistência--%>
    <jsp:useBean id="entidade" class="Entidade.TbMensalidade"/>

    <jsp:setProperty name="entidade" property="menNome" param="MenDescricao"/> 
    <jsp:setProperty name="entidade" property="menCodigo" param="MenCodigo"/> 

    <fmt:parseNumber var="menValor" value="${param.MenVlrMensalidade}" type="number" /><%--formatação do valor para gravar no banco--%>
    <jsp:setProperty name="entidade" property="menValor" value="${menValor}"/>

    <%--Validação do Usuário no acesso á tela--%>
    <c:if test="${SysUser != 'M' }">
        <c:redirect url="TelaLogin.jsp">
            <c:param name="alerta">
                Somente usuários do tipo "Mestre" tem acesso a esta tela
            </c:param>                
        </c:redirect>

    </c:if>

    <%--Verifica se o campo oculto está com o valor 'ok', caso esteja efetua a persistência--%>
    <c:if test="${param.valida eq 'ok'}">  
        <%
            controlemensalidade.create(entidade);
        %>
        <script>
            jAlert('Mensalidade salva com sucesso!', 'Atenção');
        </script>
    </c:if>

    <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
    <c:if test="${not empty param.MenCodigo}">
        <%
            entidade = controlemensalidade.findTbMensalidade(entidade.getMenCodigo());
            pageContext.setAttribute("entidade", entidade);
        %>

    </c:if>

    <form name="formulario">

        <div data-role="content" style="padding: 15px">

            <h1>Cadastro de Mensalidades</h1>


            <%--Criação do campo oculto usado para a validação formulário--%>
            <input type="hidden" name="valida" />


            <%--Código sequencial do cadastro de mensalidades--%>
            <input type="hidden" name="MenCodigo" value="${param.MenCodigo}"/>


            <%--Nome da Mensalidade--%>
            <div data-role="fieldcontain">
                <fieldset data-role="controlgroup" data-mini="true">
                    <label>
                        Descrição
                    </label><BR>
                    <input type="text" id="nomemensalidade" name="MenDescricao" maxlength="50" value="${entidade.menNome}" >
                </fieldset>
            </div>


            <%--Valor da Mensalidade--%>
            <div data-role="fieldcontain" id="valormensalidade">
                <fieldset data-role="controlgroup" data-mini="true">
                    <label>
                        Valor
                    </label><BR>
                    <input type="text" name="MenVlrMensalidade" maxlength="13" onkeyup="moeda(this)"
                           value="<fmt:formatNumber value="${entidade.menValor}" type="number" minFractionDigits="2"/>">
                </fieldset>
            </div>

            <input type="submit" data-inline="true" data-mini="true" data-theme="a" data-icon="check" 
                   data-iconpos="left" name="BtnSalvar" value="Salvar" onClick="return validaformulario()">

            <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                   data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadMensalidade.jsp';" value="Novo" />

        </div>

    </form>

</body>

</html>