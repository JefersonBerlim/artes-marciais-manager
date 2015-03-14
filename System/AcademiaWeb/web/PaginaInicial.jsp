<%@page import="Entidade.TbProfessor"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta charset="utf-8">

        <title>Início</title>

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <script src="bootstrap/js/jquery.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="CorpoPagina/jquery.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>


        <script>
            (function($) {
                $(document).ready(function() {
                    $('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
                        event.preventDefault();
                        event.stopPropagation();
                        $(this).parent().siblings().removeClass('open');
                        $(this).parent().toggleClass('open');
                    });
                });
            })(jQuery);

            function encerrasessao() {

                return(confirm('Confirma encerramento da sessão?'));
            }

        </script>

        <style>
            .marginBottom-0 {margin-bottom:0;}
            .dropdown-submenu{position:relative;}
            .dropdown-submenu>.dropdown-menu{top:0;left:100%;margin-top:-6px;margin-left:-1px;-webkit-border-radius:0 6px 6px 6px;-moz-border-radius:0 6px 6px 6px;border-radius:0 6px 6px 6px;}
            .dropdown-submenu>a:after{display:block;content:" ";float:right;width:0;height:0;border-color:transparent;border-style:solid;border-width:5px 0 5px 5px;border-left-color:#cccccc;margin-top:5px;margin-right:-10px;}
            .dropdown-submenu:hover>a:after{border-left-color:#555;}
            .dropdown-submenu.pull-left{float:none;}.dropdown-submenu.pull-left>.dropdown-menu{left:-100%;margin-left:10px;-webkit-border-radius:6px 0 6px 6px;-moz-border-radius:6px 0 6px 6px;border-radius:6px 0 6px 6px;}

        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-static-top marginBottom-0" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="PaginaInicial.jsp">Academia Web</a>
            </div>

            <div class="collapse navbar-collapse" id="navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Cadastros<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Cadastros</a>
                                <ul class="dropdown-menu">
                                    <c:if test="${SysUser == 'M' or SysUser == 'G' }">
                                        <li><a href="CadAluno.jsp" target="corpo">Alunos</a></li>
                                        </c:if>
                                        <c:if test="${SysUser == 'M' }">
                                        <li><a href="CadCurso.jsp" target="corpo">Cursos</a></li>
                                        </c:if>
                                        <c:if test="${SysUser == 'M' }">
                                        <li><a href="CadGraduacao.jsp" target="corpo">Graduações</a></li>
                                        </c:if>
                                        <c:if test="${SysUser == 'M' }">
                                        <li><a href="CadExercicio.jsp" target="corpo">Exercícios</a></li>
                                        </c:if>
                                        <c:if test="${SysUser == 'M' }">
                                        <li><a href="CadMensalidade.jsp" target="corpo">Mensalidades</a></li>
                                        </c:if>
                                        <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                        <li><a href="CadProfessor.jsp" target="corpo">Professores</a></li>
                                        </c:if>
                                </ul>
                            </li>
                            <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Consulta</a>
                                <ul class="dropdown-menu">
                                    <li><a href="ConAlunos.jsp" target="corpo">Alunos</a></li>
                                    <li><a href="ConCursos.jsp" target="corpo">Cursos</a></li>
                                    <li><a href="ConGraduacoes.jsp" target="corpo">Graduações</a></li>
                                    <li><a href="ConExercicios.jsp" target="corpo">Exercícios</a></li>
                                    <li><a href="ConMensalidades.jsp" target="corpo">Mensalidades</a></li>
                                    <li><a href="ConProfessores.jsp" target="corpo">Professores</a></li>
                                    <li class="divider"></li>
                                    <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Relatórios</a>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemAlunos.jasper')">Alunos</a></li>
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemCursos.jasper')">Cursos</a></li>
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemGraduacoes.jasper')">Graduações</a></li>
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemExercicios.jasper')">Exercícios</a></li>
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemMensalidades.jasper')">Mensalidades</a></li>
                                            <li><a href="#" onClick="window.open('GeraRelatorios.jsp?reportName=Relatorios/ListagemProfessores.jasper')">Professores</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <c:if test="${SysUser == 'M' or SysUser == 'P'}">
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Aulas<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <c:if test="${SysUser == 'M' or SysUser == 'P'}">
                                    <li><a href="Aulas.jsp" target="corpo">Lançamento</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'P'}">
                                    <li><a href="ConAulas.jsp" target="corpo">Consulta</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'P'}">
                                    <li><a href="ImprimeAulas.jsp" target="corpo">Impressão de Aulas</a></li>
                                    </c:if>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${SysUser == 'M'}">
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Exame de Faixas<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <c:if test="${SysUser == 'M'}">
                                    <li><a href="Exames.jsp" target="corpo">Lançamento</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M'}">
                                    <li><a href="ConExames.jsp" target="corpo">Consulta</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M'}">
                                    <li><a href="ImprimeExames.jsp" target="corpo">Impressão de Exames de Faixa</a></li>
                                    </c:if>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Pagamentos<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="Pagamentos.jsp" target="corpo">Lançamento</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="ConPagamentos.jsp" target="corpo">Consulta</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="ImprimePagamentos.jsp" target="corpo">Impressão de Pagamentos</a></li>                            
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="ImprimeMensalidadeEmAtraso.jsp" target="corpo">Impressão Anual de Mensalidades</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="ImprimeExtMensalidade.jsp" target="corpo">Impressão de Extrato de Mensalidades</a></li>
                                    </c:if>
                                    <c:if test="${SysUser == 'M' or SysUser == 'G'}">
                                    <li><a href="ImprimeMenAberta.jsp" target="corpo">Relatório de Mensalidades em Aberto</a></li>
                                    </c:if>
                            </ul>
                        </li>
                    </c:if>
                    <li><a href="SessionLogout.jsp" onclick="return encerrasessao()">Sair</a></li>
                </ul>
            </div>
        </nav>   
        <iframe name="corpo" src="" style="left:0px; position:absolute; top:7,9%; width:100%; height:92%" frameborder="0">
        </iframe>               
    </body>
</html>
