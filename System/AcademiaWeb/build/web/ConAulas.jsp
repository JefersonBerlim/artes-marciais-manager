<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Cria��o do Objeto "controleaulas" para listagem das aulas--%>
<jsp:useBean id="controleaulas" class="Controle.TbAulaJpaController"/>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script src="TabelaConsulta/JQuery/jquery.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.pager.js"></script>
    <link rel="stylesheet" href="TabelaConsulta/CSS/aulas.css" media="screen" />
    <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
    <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

    <title>Consulta de Aulas</title>

    <script>
    
        function Deleta(  ) { 
        
            if( confirm('Confirma a exclus�o da Aula?')){
                return true;
                
            } 
            else{ 
                return false;
            }
        } 
    </script>

</head>
<body>

    <%--Valida��o do Usu�rio no acesso � tela--%>
    <c:if test="${( SysUser == 'P' ) }">
        <c:redirect url="TelaLogin.jsp">
            <c:param name="alerta">
                Somente usu�rios do tipo "Mestre" ou "Professor" tem acesso a esta tela
            </c:param>                
        </c:redirect>

    </c:if>

    <h1>Consulta de Aulas</h1>

    <form method="post" action="exemplo.html" id="frm-filtro">
        <p>
            <label for="pesquisar">Pesquisar</label>
            <input type="text" id="pesquisar" name="pesquisar" size="30" />
        </p>
    </form>
    <table cellspacing="0" summary="Tabela de dados fict�cios">'
        <thead>
            <tr>
                <th><input type="checkbox" value="1" id="marcar-todos" name="marcar-todos" /></th>
                <th>Data</th>
                <th>Hor�rio</th>
                <th>Professor</th>
                <th>Aluno</th>
                <th>Exerc�cio</th>
                <th>A��es</th>
            </tr>
        </thead>
        <tbody>

            <c:catch var="Erro" >

                <c:if test="${not empty param.CodAula and param.Acao == 'Excluir' }">

                    <%--Cria��o do Objeto Entidade para a exclus�o no banco de dados--%>
                    <jsp:useBean id="entidade" class="Entidade.TbAula" />
                    <jsp:setProperty name="entidade" property="sequencial" param="CodAula"/> 

                    <%
                        entidade = controleaulas.findTbAula(entidade.getSequencial());
                        pageContext.setAttribute("entidade", entidade);
                        controleaulas.destroy(entidade.getSequencial());
                    %>

                </c:if>

            </c:catch>

            <c:if test="${not empty Erro }">

            <script>
                jAlert('Erro ao Excluir a Aula!' ,'Aten��o');
            </script>

        </c:if>

        <%--Listagem das aulas atrav�s do m�todo findTbAulaAll --%>
        <c:forEach items="${controleaulas.findTbAulaAll()}" var="aulas">

            <tr>
                <td><input type="checkbox" value="1" name="marcar[]" /></td>
                <td><fmt:formatDate value="${aulas.aulData}" pattern="dd/MM/yyyy"/></td>
                <td><fmt:formatDate value="${aulas.aulHorario}" pattern="HH:mm" /></td>
                <td>${aulas.tbProfessorProCodigo.proNome}</td>
                <td>${aulas.tbAlunoAluCodigo.aluNome}</td>
                <td>${aulas.tbExercicioExeCodigo.exeDescricao}</td>
                <td>
                    <c:if test="${SysUser == 'M' }">
                        <a href="Aulas.jsp?AulCod=${aulas.sequencial}"</a> <img src="TabelaConsulta/Imagens/edit.png" width="16" height="16" /></a>
                        <a href="ConAulas.jsp?Acao=Excluir&CodAula=${aulas.sequencial}" onclick="javascript:return Deleta()"><img src="TabelaConsulta/Imagens/delete.png" width="16" height="16" /></a>
                        </c:if>
                </td>
            </tr>


        </c:forEach>

    </tbody>
</table>

<div id="pager" class="pager">
    <form>
        <span>
            Exibir <select class="pagesize">
                <option selected="selected"  value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
                <option value="40">40</option>
            </select> registros
        </span>

        <img src="TabelaConsulta/Imagens/first.png" class="first"/>
        <img src="TabelaConsulta/Imagens/prev.png" class="prev"/>
        <input type="text" class="pagedisplay"/>
        <img src="TabelaConsulta/Imagens/next.png" class="next"/>
        <img src="TabelaConsulta/Imagens/last.png" class="last"/>
    </form>
</div>




<script>
    $(function(){
      
        $('table > tbody > tr:odd').addClass('odd');
      
        $('table > tbody > tr').hover(function(){
            $(this).toggleClass('hover');
        });
      
        $('#marcar-todos').click(function(){
            $('table > tbody > tr > td > :checkbox')
            .attr('checked', $(this).is(':checked'))
            .trigger('change');
        });
      
        $('table > tbody > tr > td > :checkbox').bind('click change', function(){
            var tr = $(this).parent().parent();
            if($(this).is(':checked')) $(tr).addClass('selected');
            else $(tr).removeClass('selected');
        });
      
        $('form').submit(function(e){ e.preventDefault(); });
      
        $('#pesquisar').keydown(function(){
            var encontrou = false;
            var termo = $(this).val().toLowerCase();
            $('table > tbody > tr').each(function(){
                $(this).find('td').each(function(){
                    if($(this).text().toLowerCase().indexOf(termo) > -1) encontrou = true;
                });
                if(!encontrou) $(this).hide();
                else $(this).show();
                encontrou = false;
            });
        });
      
        $("table") 
        .tablesorter({
            dateFormat: 'uk',
            headers: {
                0: {
                    sorter: false
                },
                5: {
                    sorter: false
                }
            }
        }) 
        .tablesorterPager({container: $("#pager")})
        .bind('sortEnd', function(){
            $('table > tbody > tr').removeClass('odd');
            $('table > tbody > tr:odd').addClass('odd');
        });
      
    });
</script>

</body>
</html>
