<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>


    <script src="TabelaConsulta/JQuery/jquery.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.pager.js"></script>
    <link rel="stylesheet" href="TabelaConsulta/CSS/cursos.css" media="screen" />
    <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
    <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>


    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Consulta de Exerc�cios</title>

    <script>
    
        function Deleta(  ) { 
        
            if( confirm('Confirma a exclus�o do Exercicio')){
                return true;
                
            } 
            else{ 
                return false;
            }
        } 
        
    </script>

</head>

<body>

    <h1>Consulta de Exerc�cios</h1>

    <%-- Cria��o do Objeto "controleexercicio" para listar os Exercicios abaixo do cadastro--%>
    <jsp:useBean id="controleexercicio" class="Controle.TbExercicioJpaController"/>

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
                <th>Descri��o</th>
                <th>Gradua��o</th>
                <th>A��es</th>
            </tr>
        </thead>
        <tbody>

            <c:catch var="Erro" >

                <c:if test="${not empty param.CodExercicio and param.Acao == 'Excluir' }">

                    <%--Cria��o do Objeto Entidade para a exclus�o no banco de dados--%>
                    <jsp:useBean id="entidade" class="Entidade.TbExercicio" />
                    <jsp:setProperty name="entidade" property="exeCodigo" param="CodExercicio"/> 

                    <%
                        entidade = controleexercicio.findTbExercicio(entidade.getExeCodigo());
                        pageContext.setAttribute("entidade", entidade);
                        controleexercicio.destroy(entidade.getExeCodigo());
                    %>

                </c:if>

            </c:catch>

            <c:if test="${not empty Erro }">

            <script>
                jAlert('Problemas ao Excluir o Exerc�cio: ${entidade.exeDescricao}' ,'Aten��o');
            </script>

        </c:if>

        <%--Listagem dos exerc�cios  atrav�s do m�todo findTbExercicioAll--%>
        <c:forEach items="${controleexercicio.findTbExercicioAll()}" var="exercicios">

            <tr>
                <td><input type="checkbox" value="1" name="marcar[]" /></td>
                <td>${exercicios.exeDescricao}</td>
                <td>${exercicios.tbGraduacaoGraCodigo.graDescricao}</td>
                <td>
                    <c:if test="${SysUser == 'M' }">
                        <a href="CadExercicio.jsp?ExeCodigo=${exercicios.exeCodigo}"</a><img src="TabelaConsulta/Imagens/edit.png" width="16" height="16" /></a>
                        <a href="ConExercicios.jsp?Acao=Excluir&CodExercicio=${exercicios.exeCodigo}" onclick="javascript:return Deleta()"><img src="TabelaConsulta/Imagens/delete.png" width="16" height="16" /></a>
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
