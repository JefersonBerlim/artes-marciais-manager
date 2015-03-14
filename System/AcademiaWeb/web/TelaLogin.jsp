<%@page import="Entidade.TbProfessor"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta charset="utf-8">

        <!-- Le styles -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap-responsive.css"/>
        <link rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>
        
        <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>       
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>    
        <script type="text/javascript" src="CorpoPagina/jquery.js"></script>
        <script type="text/javascript" src="jquery.alerts-1.1/jquery.alerts.js"></script> 
        
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tela de Login</title>

        <script>
            ;
            //Valida se todos os campos do formulário estão prenchidos
            function validalogin( ) {

                if (formulario.UsuNome.value === "") {
                    jAlert('Digite o Nome do Usuário', 'Atenção');
                    document.formulario.UsuNome.focus();
                    return false;
                } else {
                    if (formulario.UsuSenha.value === "") {
                        jAlert('Digite a Senha', 'Atenção');
                        document.formulario.UsuSenha.focus();
                        return false;
                    } else {
                        document.formulario.submit();
                    }
                }
            }

        </script>

        <style type="text/css">
            body {
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin {
                max-width: 300px;
                padding: 19px 29px 29px;
                margin: 0 auto 20px;
                background-color: #fff;
                border: 1px solid #e5e5e5;
                -webkit-border-radius: 5px;
                -moz-border-radius: 5px;
                border-radius: 5px;
                -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
            }
            .form-signin .form-signin-heading,
            .form-signin .checkbox {
                margin-bottom: 10px;
            }
            .form-signin input[type="text"],
            .form-signin input[type="password"] {
                font-size: 16px;
                height: auto;
                margin-bottom: 15px;
                padding: 7px 9px;
            }

        </style>
    </head>
    <body>
        <%--Criação do Objeto "controlecurso" para a listagem dos cursos--%>
        <jsp:useBean id="controleusuario" class="Controle.TbProfessorJpaController"/>

        <%--Criação do Objeto Entidade para a gravação no banco de dados--%>
        <jsp:useBean id="entidade" class="Entidade.TbProfessor" />
        <jsp:setProperty name="entidade" property="proUsuario" param="UsuNome"/> 
        <jsp:setProperty name="entidade" property="proSenha" param="UsuSenha"/>         

        <c:if test="${not empty entidade.proUsuario and not empty entidade.proSenha}">
            <%
                java.util.List<TbProfessor> professores = controleusuario.findUsuario(entidade.getProUsuario(), entidade.getProSenha());

                if (professores.size() == 1) {
                    session.setAttribute("SysUser", "P");

                    if (professores.get(0).getProEhgestor() != null) {
                        session.setAttribute("SysUser", "G");
                    }
                    if (professores.get(0).getProEhmestre() != null) {
                        session.setAttribute("SysUser", "M");
                    }

                    pageContext.setAttribute("Login", "OK");

                } else {
                    
                    pageContext.setAttribute("Login", "Erro");
                    
                }
            %>
        </c:if>

        <c:if test="${ Login == 'Erro' }">
            <script>
                jAlert('Usuário ou Senha Incorretos', 'Atenção');
            </script>
        </c:if>

        <c:if test="${ not empty param.alerta }">
            <script>
                jAlert('${param.alerta}', 'Atenção');
            </script>
        </c:if>

        <c:if test="${Login == 'OK' }" >
            <c:redirect url="PaginaInicial.jsp"/>
        </c:if>

        <div class="container">
            <form name="formulario" class="form-signin">
                <h2 class="form-signin-heading">Bem Vindo</h2>
                <input type="text" class="input-block-level" placeholder="Usuário" 
                       name="UsuNome" value="${entidade.proUsuario}">
                <input type="password" class="input-block-level" placeholder="Senha" 
                       name="UsuSenha" value="${entidade.proSenha}">
                <label class="checkbox">
                    <input type="checkbox" value="remember-me"> Lembrar
                </label>
                <button class="btn btn-large btn-primary" type="submit" 
                        name="BtnSalvar" onClick="return validalogin()">Acessar</button>
            </form>
        </div> <!-- /container -->
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="bootstrap/js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap-transition.js"></script>
        <script src="bootstrap/js/bootstrap-alert.js"></script>
        <script src="bootstrap/js/bootstrap-modal.js"></script>
        <script src="bootstrap/js/bootstrap-dropdown.js"></script>
        <script src="bootstrap/js/bootstrap-scrollspy.js"></script>
        <script src="bootstrap/js/bootstrap-tab.js"></script>
        <script src="bootstrap/js/bootstrap-tooltip.js"></script>
        <script src="bootstrap/js/bootstrap-popover.js"></script>
        <script src="bootstrap/js/bootstrap-button.js"></script>
        <script src="bootstrap/js/bootstrap-collapse.js"></script>
        <script src="bootstrap/js/bootstrap-carousel.js"></script>
        <script src="bootstrap/js/bootstrap-typeahead.js"></script>
    </body>
</html>
