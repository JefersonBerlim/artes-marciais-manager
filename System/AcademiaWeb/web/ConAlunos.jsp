<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Criação do Objeto "controlealuno" para gravar no banco--%>
<jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

<html>
    <head>

        <script src="TabelaConsulta/JQuery/jquery.min.js"></script>
        <script src="TabelaConsulta/JQuery/jquery.tablesorter.min.js"></script>
        <script src="TabelaConsulta/JQuery/jquery.tablesorter.pager.js"></script>
        <link rel="stylesheet" href="TabelaConsulta/CSS/professores.css" media="screen" />
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <title>Consulta de Alunos</title>


        <script>
    
            function Deleta(  ) { 
        
                if( confirm('Confirma a exclusão do Aluno')){
                    return true;
                
                } 
                else{ 
                    return false;
                }
            } 
        </script>

    </head>
    <body>

        <h1>Consulta de Alunos</h1>

        <form method="post" action="exemplo.html" id="frm-filtro">
            <p>
                <label for="pesquisar">Pesquisar</label>
                <input type="text" id="pesquisar" name="pesquisar" size="30" />
            </p>
        </form>

        <table cellspacing="0" summary="Tabela de dados fictícios">'
            <thead>
                <tr>
                    <th><input type="checkbox" value="1" id="marcar-todos" name="marcar-todos" /></th>
                    <th>Nome</th>
                    <th>Curso - Qtd Aulas</th>
                    <th>Cidade - UF</th>                
                    <th>Data Matrícula</th>
                    <th style="text-align:right;">% Desconto</th>
                    <th>Dia Venc. Mensalidade</th>
                    <th>Ações</th>

                </tr>
            </thead>
            <tbody>


                <c:catch var="Erro" >

                    <c:if test="${not empty param.CodAluno and param.Acao == 'Excluir' }">

                        <%--Criação do Objeto Entidade para a exclusão no banco de dados--%>
                        <jsp:useBean id="entidade" class="Entidade.TbAluno" />
                        <jsp:setProperty name="entidade" property="aluCodigo" param="CodAluno"/> 

                        <%
                            entidade = controlealuno.findTbAluno(entidade.getAluCodigo());
                            pageContext.setAttribute("entidade", entidade);
                            controlealuno.destroy(entidade.getAluCodigo());
                        %>

                    </c:if>

                </c:catch>

                <c:if test="${not empty Erro }">

                <script>
                    jAlert('Problemas ao Excluir o Aluno ${entidade.aluNome}' ,'Atenção');
                </script>

            </c:if>


            <%--Listagem das graduações através do método findTbGraduacaoAll --%>
            <c:forEach items="${controlealuno.findTbAlunoAll()}" var="alunos">
                <tr>
                    <td><input type="checkbox" value="1" name="marcar[]" /></td>
                    <td>${alunos.aluNome}</td>
                    <td>${alunos.tbCursoCurCodigo.curDescricao} - ${alunos.aluQtdaulas}</td>
                    <td>${alunos.aluCidade} - ${alunos.aluEstado}</td>
                    <td><fmt:formatDate value="${alunos.aluDtmatricula}" pattern="dd/MM/yyyy"/></td>
                    <td style="text-align:right;"><fmt:formatNumber value="${alunos.aluDesconto}" minFractionDigits="2"/></td>
                    <td>${alunos.aluDiavencmensalidae}</td>

                    <td>
                        <c:if test="${SysUser == 'M' or SysUser == 'G' }">
                            <a href="CadAluno.jsp?AluCodigo=${alunos.aluCodigo}"</a> <img src="TabelaConsulta/Imagens/edit.png" width="16" height="16" /></a>
                            <a href="ConAlunos.jsp?Acao=Excluir&CodAluno=${alunos.aluCodigo}" onclick="javascript:return Deleta()"><img src="TabelaConsulta/Imagens/delete.png" width="16" height="16" /></a>
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
