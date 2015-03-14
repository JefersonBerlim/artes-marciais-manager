<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>

    <%--Criação do Objeto "controlealuno" para listagem dos alunos--%>
    <jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

    <title>Pagamentos</title>

    <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
    <script src="CorpoPagina/jquery.js"></script>
    <script src="CorpoPagina/jquery.mobile.js"></script>
    <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
    <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>


    <script>
        
        //Valida se todos os campos to formulário foram preenchidos
        function validaformulario()
            
        {
            if (formulario.NomeAluno.value == '') {
                jAlert('Por favor, selecione o nome do aluno!','Atenção');
                document.formulario.NomeAluno.focus();
                return false; 
            }else{
                if (formulario.DtPagamento.value == '') {
                    jAlert('Por favor, digite a data do pagamento!','Atenção');
                    document.formulario.DtPagamento.focus();
                    return false; 
                }else{
                    if ( formulario.VlrPago.value == '' || eval( formulario.VlrPago.value.replace(',','.') ) <= 0 ) {  
                        jAlert('Por favor, um valor válido para o pagamento!','Atenção');
                        document.formulario.VlrPago.focus();
                        return false; 
                    }else{
                     //se todos os campos do formulário foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                     document.formulario.valida.value = "ok";
                     return true;  
                    }                    
                }
            }
        }
        
        function FormataData(){
            if (formulario.DtPagamento.value.length == 2 || formulario.DtPagamento.value.length == 5 ){
                formulario.DtPagamento.value = formulario.DtPagamento.value+"/";
            }
        }
        
        var pagamentos = new Array();
        var mensalidades = new Array();
            
        <c:forEach items="${controlealuno.findTbAlunoAll()}" var="aluno">
            pagamentos["${aluno.aluCodigo}"] = value="<fmt:formatNumber value="${( ( aluno.tbMensalidadeMenCodigo.menValor ) - ( ( aluno.tbMensalidadeMenCodigo.menValor / 100 ) * aluno.aluDesconto ) )}" type="number" minFractionDigits="2"/>";
            mensalidades["${aluno.aluCodigo}"] = value="${aluno.tbMensalidadeMenCodigo.menCodigo}";
        </c:forEach>
                                            
            function atualizaMensalidade(aluno) {
                var index = aluno.selectedIndex; 

                document.formulario.VlrAPagar.value = pagamentos[aluno.options[index].value];
                document.formulario.Mensalidade.value = mensalidades[aluno.options[index].value];
            }
           
            $(document).ready(function(){

                $( ".data" ).datepicker({ changeMonth: true, changeYear: true });

            });
            
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

        #nomealuno {
            width: 450px;
        }

        #datapagamento{
            width: 150px;
        } 
        #valorpago{
            width: 300px;
        }

        #valorapagar{
            width: 300px;
        }

    </style>

</head>

<body>

    <%--Criação do Objeto "controlepagamentos" para a listagem das mensalidades --%>
    <jsp:useBean id="controlepagamentos" class="Controle.TbPagamentosJpaController"/>

    <%--Criação do Objeto de Entidade para fazer a persistência--%>
    <jsp:useBean id="entidade" class="Entidade.TbPagamentos"/>

    <jsp:setProperty name="entidade" property="sequencial" param="PagCod"/>

    <fmt:parseDate var="DtPagamento" value="${param.DtPagamento}" pattern="dd/MM/yyyy"/><%--Conversão da Data --%>
    <jsp:setProperty name="entidade" property="pagDtpagamento" value="${DtPagamento}"/> 

    <fmt:parseNumber var="VlrAPagar" value="${param.VlrAPagar}" />
    <jsp:setProperty name="entidade" property="pagValorapagar" value="${VlrAPagar}"/>

    <fmt:parseNumber var="VlrPago" value="${param.VlrPago}" type="number" />    
    <jsp:setProperty name="entidade" property="pagValorpago" value="${VlrPago}"/>    

    <%--Atributo @Transient da Entidade para efetuar a persistência dentro do Controle--%>
    <jsp:setProperty name="entidade" property="tmptbMensalidadeMenCodigo" param="Mensalidade"/>

    <%--Atributo @Transient da Entidade para efetuar a persistência dentro do Controle--%>
    <jsp:setProperty name="entidade" property="tmptbAlunoAluCodigo" param="NomeAluno"/>

    <%--Validação do Usuário no acesso á tela--%>
    <c:if test="${( SysUser == 'P' )}">
        <c:redirect url="TelaLogin.jsp">
            <c:param name="alerta">
                Somente usuários do tipo "Mestre" ou "Gestor" tem acesso a esta tela
            </c:param>                
        </c:redirect>

    </c:if>

    <%--Verifica se o campo 'valida'esta com o valor ok, caso esteja
   todos os campos obrigatórios foram preenchidos, ai faz-se a persistência--%>
    <c:if test="${param.valida eq 'ok'}">
        <%
            controlepagamentos.create(entidade);
        %>
        <script>
            jAlert('Pagamento efetuado com sucesso!','Atenção');
        </script>
    </c:if>

    <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
    <c:if test="${not empty param.PagCod}">
        <%
            entidade = controlepagamentos.findTbPagamentos(entidade.getSequencial());
            pageContext.setAttribute("entidade", entidade);
        %>
    </c:if>  

    <form name="formulario">

        <div data-role="content" style="padding: 15px">

            <h1> Pagamento de Mensalidades</h1>

            <%--Campo oculto para validar o formulário--%>
            <input type="hidden" name="valida" />


            <%--Código do Pagamento--%>
            <input type="hidden" name="PagCod" value="${param.PagCod}"/>


            <%--Código da Mensalidade--%>
            <input type="hidden" name="Mensalidade" value="${entidade.tbMensalidadeMenCodigo.menCodigo}"  />


            <%--Seleção do Aluno--%>
            <div data-role="fieldcontain" id="nomealuno">
                <label>
                    Aluno
                </label><br>
                <select name="NomeAluno" onchange="atualizaMensalidade(this)" data-mini="true">
                    <option <c:if test="${ not empty param.PagCod }"> disabled="true" </c:if>>

                    </option>

                    <%--Listagem dos alunos--%>
                    <c:forEach items="${controlealuno.findAlunoPagamentos()}" var="aluno">
                        <c:set var="selecionado" value="" />
                        <c:if test="${aluno.aluCodigo eq entidade.tbAlunoAluCodigo.aluCodigo}" >
                            <c:set var="selecionado" value="selected" />
                        </c:if>

                        <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                        <option value="${aluno.aluCodigo}" ${selecionado}
                                <c:if test="${ not empty param.PagCod }"> disabled="true" </c:if>> ${aluno.aluNome} </option>            
                    </c:forEach> 

                </select>
            </div>


            <%--Data do Pagamento--%>
            <div data-role="fieldcontain">
                <fieldset data-role="controlgroup" data-mini="true">
                    <label>
                        Data do Pagamento
                    </label><br>
                    <input type="text" id="datapagamento" name="DtPagamento" onKeyUp="FormataData(this)" maxlength="10" 
                           value="<fmt:formatDate value="${entidade.pagDtpagamento}" pattern="dd/MM/yyyy"/>"
                           <c:if test="${ not empty param.PagCod }"> readonly="true" </c:if>>
            </div>


            <%--Valor Pago--%>
            <div data-role="fieldcontain" id="valorpago">
                <fieldset data-role="controlgroup" data-mini="true">
                    <label>
                        Valor Pago
                    </label><br>
                    <input type="text" name="VlrPago" onkeyup="moeda(this)"
                           value="<fmt:formatNumber value="${entidade.pagValorpago}" type="number" minFractionDigits="2"/>">
                </fieldset>
            </div>


            <%--Valor à Pagar--%>
            <div data-role="fieldcontain" id="valorapagar">
                <fieldset data-role="controlgroup" data-mini="true">
                    <label>
                        Valor à Pagar
                    </label><br>
                    <input type="text" name="VlrAPagar" onkeyup="moeda(this)"
                           readonly="true" value="<fmt:formatNumber value="${entidade.pagValorapagar}" type="number" minFractionDigits="2"/>">
                </fieldset>
            </div>

            <input type="submit" data-theme="a" data-icon="check" data-iconpos="left" data-inline="true" 
                   data-mini="true" value="Salvar" onClick="return validaformulario()">

            <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                   data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='Pagamentos.jsp';" value="Novo" />

        </div>

    </form>

</body>

</html>
