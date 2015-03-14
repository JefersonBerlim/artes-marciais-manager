<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Criação do Objeto "controlecurso" para a listagem dos cursos --%>
<jsp:useBean id="controlecurso" class="Controle.TbCursoJpaController"/>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script src="TabelaConsulta/JQuery/jquery.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.min.js"></script>
    <script src="TabelaConsulta/JQuery/jquery.tablesorter.pager.js"></script>
    <link rel="stylesheet" href="TabelaConsulta/CSS/cursos.css" media="screen" />
    <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
    <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

    <title>Consulta de Cursos</title>

    <script>
    
        function DeletaCurso(  ) { 
        
            if( confirm('Confirma a exclusão do curso')){
                return true;
                
            } 
            else{ 
                return false;
            }
        } 
    </script>

</head>
<body>
    <h1>Consulta de Cursos</h1> <br> 

    <form method="post" action="exemplo.html" id="frm-filtro">
        <p>
            <label for="pesquisar">Pesquisar</label>
            <input type="text" id="pesquisar" name="pesquisar" size="30" />
        </p>
    </form>

    <table cellspacing="0" summary="Tabela de dados fictï¿½cios">'
        <thead>
            <tr>
                <th><input type="checkbox" value="1" id="marcar-todos" name="marcar-todos" /></th>
                <th>Descrição</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>

            <c:catch var="Erro" >

                <c:if test="${not empty param.CodCurso and param.Acao == 'Excluir' }">

                    <%--Criação do Objeto Entidade para a exclusão no banco de dados--%>
                    <jsp:useBean id="entidade" class="Entidade.TbCurso" />
                    <jsp:setProperty name="entidade" property="curCodigo" param="CodCurso"/> 

                    <%
                        entidade = controlecurso.findTbCurso(entidade.getCurCodigo());
                        pageContext.setAttribute("entidade", entidade);
                        controlecurso.destroy(entidade.getCurCodigo());
                    %>

                </c:if>

            </c:catch>

            <c:if test="${not empty Erro }">

            <script>
                jAlert('Problemas ao Excluir o Curso: ${entidade.curDescricao}' ,'Atenção');
            </script>

        </c:if>


        <%--Listagem dos cursos através do método controlecurso--%>
        <c:forEach items="${controlecurso.findTbCursoAll()}" var="curso">

            <tr>
                <td><input type="checkbox" value="1" name="marcar[]" /></td>
                <td>${curso.curDescricao}</td>
                <td>
                    <c:if test="${SysUser == 'M' }">
                        <a href="CadCurso.jsp?codigo=${curso.curCodigo}"</a> <img src="TabelaConsulta/Imagens/edit.png" width="16" height="16" /></a>
                        <a href="ConCursos.jsp?Acao=Excluir&CodCurso=${curso.curCodigo}" onclick="javascript:return DeletaCurso()"><img src="TabelaConsulta/Imagens/delete.png" width="16" height="16" /></a>
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
