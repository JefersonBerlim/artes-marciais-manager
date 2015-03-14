<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="javazoom.upload.*,java.util.*" %>
<%@ page language="java" import="javazoom.download.*,javazoom.download.util.*, java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="downloadbean" class="javazoom.download.DownloadBean" scope="page" />
<%
    Repository repository = Repository.getInstance();
    Config conf = repository.get("uniqueid");
    downloadbean.setConfig(conf);
    downloadbean.setVirtualPath(request.getContextPath() + "/download");
%>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
    <jsp:setProperty name="upBean" property="folderstore" value="C:/AcademiaWeb/System/AcademiaWeb/web/Imagens/Upload" />
</jsp:useBean>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; UTF-8">
        <title>Cadastro de Professores</title>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <script>
            
            //Valida se todos os campos to formulário foram preenchidos
            function validaformulario()
            
            {
                if (formulario.ProNome.value == '') {
                    jAlert('Por favor, digite o nome do professor!','Atenção');
                    document.formulario.ProNome.focus();
                    return false; 
                }else{
                    if (formulario.ProUsuario.value == '') {
                        jAlert('Por favor, digite o usuário!','Atenção');
                        document.formulario.ProUsuario.focus();
                        return false;  
            
                    }else{
                        if (formulario.ProSenha.value == '') {
                            jAlert('Por favor, digite a senha!','Atenção');
                            document.formulario.ProSenha.focus();
                            return false; 
                        }else{
                            //se todos os campos do formulário foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                            document.formulario.valida.value = 'ok';
                            return true;
                        }
                    }
                }
            }
            
            function FormataData(campo){
                if (campo.value.length == 2 || campo.value.length == 5 ){
                    campo.value = campo.value+"/";
                }
            }
            
            function ValidaValor(campo, valor)
            {
                alert(valor);
                campo.checked = true;
            }
            
            function mascaratelefone(nm_campo)
            {
                tam_campo = (nm_campo.value).length;
                if(tam_campo == '')
                    nm_campo.value = nm_campo.value + "(";

                if(tam_campo == 3)
                    nm_campo.value = nm_campo.value + ")";

                if(tam_campo == 8)
                    nm_campo.value = nm_campo.value + "-";
            } 
            
            function atualiza(){
                jalert( document.formulario.ulrfoto );
                document.formulario.submit();
            }
            
        </script>

        <style type="text/css">


            #nomeprofessor{
                width: 380px;
            }
            #datanascimento {
                width: 150px;
            }
            #logradouro{
                width: 300px;
            }
            #cidade{
                width: 230px;
            }
            #estado{
                width: 100px;
            }
            #numero{
                width: 100px;
            }
            #complemento{
                width: 300px;
            }
            #bairro{
                width: 250px;
            }
            #telefone{
                width: 150px;
            }
            #email{
                width: 350px;
            }
            #datamatricula {
                width: 150px;
            }
            #sexo{
                width: 200px;
            }
            #estadocivil{
                width: 230px;
            }
            #pessoa{
                width: 200px;
            }
            #usuario{
                width: 200px;
            }
            #senha{
                width: 200px;
            }

        </style>

    </head>

    <body>

        <%--Criação do Objeto "controleprofessor" para gravar os professores --%>
        <jsp:useBean id="controleprofessor" class="Controle.TbProfessorJpaController"/>

        <%--Criação do Objeto de Entidade para a persistência no Professor--%>
        <jsp:useBean id="entidade" class="Entidade.TbProfessor"/>

        <fmt:parseDate var="DtNascimento" value="${param.ProDtNascimento}" pattern="dd/MM/yyyy"/><%--Conversão da Data --%>
        <jsp:setProperty name="entidade" property="proNome" param="ProNome"/> 
        <jsp:setProperty name="entidade" property="proDtnascimento" value="${DtNascimento}"/> 
        <jsp:setProperty name="entidade" property="proLogradouro" param="ProLogradouro"/> 
        <jsp:setProperty name="entidade" property="proCidade" param="ProCidade"/> 
        <jsp:setProperty name="entidade" property="proEstado" param="ProEstado"/> 
        <jsp:setProperty name="entidade" property="proNumero" param="ProNumero"/> 
        <jsp:setProperty name="entidade" property="proComplemento" param="ProComplemento"/> 
        <jsp:setProperty name="entidade" property="proBairro" param="ProBairro"/>
        <jsp:setProperty name="entidade" property="proTelefone" param="ProTelefone"/>
        <jsp:setProperty name="entidade" property="proEmail" param="ProEmail"/>
        <jsp:setProperty name="entidade" property="proUsuario" param="ProUsuario"/>
        <jsp:setProperty name="entidade" property="proSenha" param="ProSenha"/>
        <jsp:setProperty name="entidade" property="proFoto" param="ProFoto"/>


        <fmt:parseDate var="DtMatricula" value="${param.ProDtMatricula}" pattern="dd/MM/yyyy"/><%--Conversão da Data --%>
        <jsp:setProperty name="entidade" property="proDtmatricula" value="${DtMatricula}"/>
        <jsp:setProperty name="entidade" property="proSexo" param="ProSexo"/>
        <jsp:setProperty name="entidade" property="proEstadocivil" param="ProEstadoCivil"/>
        <jsp:setProperty name="entidade" property="proEhgestor" param="ProEhGestor"/>
        <jsp:setProperty name="entidade" property="proEhmestre" param="ProEhMestre"/>
        <jsp:setProperty name="entidade" property="proCodigo" param="ProCodigo"/>



        <%
//****************UPLOAD DAS IMAGENS************************************************************************
            if (MultipartFormDataRequest.isMultipartFormData(request)) {
                // Uses MultipartFormDataRequest to parse the HTTP request.
                MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                String todo = null;
                if (mrequest != null) {
                    todo = mrequest.getParameter("todo");
                }
                if ((todo != null) && (todo.equalsIgnoreCase("upload"))) {
                    Hashtable files = mrequest.getFiles();
                    if ((files != null) && (!files.isEmpty())) {
                        UploadFile file = (UploadFile) files.get("arquivo");
                        if (file != null) {
                            request.setAttribute("filename", file.getFileName());
                        }
                        // Uses the bean now to store specified by jsp:setProperty at the top.
                        upBean.store(mrequest, "arquivo");
                    } else {
                        out.println("<li>No uploaded files");
                    }
                } else {
                    out.println("<BR> todo=" + todo);
                }
            }
        %>

        <%--Validação do Usuário no acesso á tela--%>
        <c:if test="${SysUser == 'P'}">
            <c:redirect url="TelaLogin.jsp">
                <c:param name="alerta">
                    Somente usuários do tipo "Mestre" ou "Gestor" tem acesso a esta tela
                </c:param>                
            </c:redirect>

        </c:if>

        <%--Verifica se o campo 'valida'esta com o valor ok, caso esteja
                todos os campos obrigatórios foram preenchidos, ai faz-se a persistência--%>
        <c:if test="${param.valida eq 'ok'}">  
            <c:catch var="erro" >
                <%
                    controleprofessor.create(entidade);
                %>
                <script>
                    jAlert('Professor salvo com sucesso!','Atenção');
                </script>
            </c:catch>
        </c:if>


        <c:if test="${not empty erro}">                    
            <script>
                jAlert('${erro.message}', 'Atenção');
            </script>
        </c:if>

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.ProCodigo}">
            <%
                entidade = controleprofessor.findTbProfessor(entidade.getProCodigo());
                pageContext.setAttribute("entidade", entidade);
            %>
        </c:if>

        <H1 style="margin-left: 14px; margin-top: 35px">Cadastro de Professor</h1>

        <div style="position: absolute; left: 250px; top: 120px;">
            <form method="post" name="form" enctype="multipart/form-data">
                Imagem: <input type="file" name="arquivo" /><br>
                <input type="hidden" name="todo" value="upload">
                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" onclick="submit()" value="Carregar" />                
            </form>
        </div>


        <form name="formulario">

            <div data-role="content">
                <div style="width: 200px; min-height:100px; max-height: 200px; overflow: hidden; position: relative; background-color: #fbfbfb; border: 1px solid #b8b8b8;">
                    <% String imagem = (String) request.getAttribute("filename");
                        if (imagem != null) {
                    %>
                    <img src="<%= downloadbean.getDownloadLink(imagem)%>" style="width: 100%; " />
                    <input type="hidden" name="ProFoto" value="<%= downloadbean.getDownloadLink(imagem)%>">
                    <%} else {
                    %>
                    <c:if test="${not empty entidade.proFoto}">                    
                        <img src="${entidade.proFoto}" style="width: 100%; " />
                        <input type="hidden" name="ProFoto" value="${entidade.proFoto}">
                    </c:if>
                    <%                            }
                    %>
                </div>
            </div>

            <div data-role="content" style="padding: 15px">

                <%--Campo oculto para validar o formulário--%>
                <input type="hidden" name="valida" />

                <%--Código do Professor--%>
                <input type="hidden" name="ProCodigo" value="${param.ProCodigo}"/>

                <%--Nome do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Nome
                        </label><br>
                        <input type="text" id="nomeprofessor" name="ProNome" maxlength="50" value="${entidade.proNome}">
                    </fieldset>
                </div>


                <%--Data de Nascimento--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data de Nascimento
                        </label><br>
                        <input type="text" id="datanascimento" name="ProDtNascimento" onKeyUp="FormataData(this)" maxlength="10" 
                               value="<fmt:formatDate value="${entidade.proDtnascimento}" pattern="dd/MM/yyyy"/>">
                    </fieldset>
                </div>

                <%--Data de Matrícula do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true" >
                        <label for="textinput11">
                            Data de Matrícula
                        </label><br>
                        <input type="text" id="datamatricula" name="ProDtMatricula" onKeyUp="FormataData(this)" maxlength="10" value="<fmt:formatDate value="${entidade.proDtmatricula}" pattern="dd/MM/yyyy"/>" >
                    </fieldset>
                </div>


                <%--Logradouro--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label for="textinput3">
                            Logradouro
                        </label><br>
                        <input type="text" id="logradouro" name="ProLogradouro" value="${entidade.proLogradouro}">
                    </fieldset>
                </div>


                <%--Cidade do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Cidade
                        </label><br>
                        <input type="text" id="cidade"name="ProCidade" maxlength="30" value="${entidade.proCidade}">
                    </fieldset>
                </div>


                <%--Estado do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Estado
                        </label><br>
                        <input type="text" id="estado" name="ProEstado" type="text" maxlength="2" value="${entidade.proEstado}">
                    </fieldset>
                </div>


                <%--Número do Logradouro--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Número
                        </label><br>
                        <input type="text" id="numero" name="ProNumero" maxlength="5" value="${entidade.proNumero}">
                    </fieldset>
                </div>


                <%--Complemento do Endereço--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Complemento
                        </label><br>
                        <input type="text" id="complemento" name="ProComplemento" maxlength="30" value="${entidade.proComplemento}">
                    </fieldset>
                </div>


                <%--Bairro do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Bairro
                        </label><br>
                        <input type="text" id="bairro" name="ProBairro" maxlength="30" value="${entidade.proBairro}">
                    </fieldset>
                </div>


                <%--Telefone do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label for="textinput9">
                            Telefone
                        </label><br>
                        <input type="text" id="telefone" name="ProTelefone" value="${entidade.proTelefone}" 
                               size="13" maxlength="13" onKeyPress="mascaratelefone(this);">
                    </fieldset>
                </div>


                <%--E-Mail do Professor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label for="textinput10">
                            E-Mail
                        </label><br>
                        <input type="text" id="email" name="ProEmail" maxlength="30" value="${entidade.proEmail}">
                    </fieldset>
                </div>             


                <%--Sexo do Professor--%>
                <div data-role="fieldcontain" id="sexo">
                    <fieldset data-role="controlgroup" data-type="vertical" data-mini="true">
                        <legend>
                            Sexo
                        </legend><br>
                        <input id="radio1" type="radio" name="ProSexo" value="M"
                               <c:if test="${entidade.proSexo == 'M' }"> checked="true" </c:if>>
                               <label for="radio1">
                                   Masculino
                               </label>
                               <input type="radio" id="radio2"name="ProSexo" value="F"
                               <c:if test="${entidade.proSexo == 'F' }"> checked="true" </c:if>>
                               <label for="radio2">
                                   Feminino
                               </label>
                        </fieldset>
                    </div>


                <%--Estado Cívil--%>
                <div data-role="fieldcontain" id="estadocivil">
                    <fieldset data-role="controlgroup" data-type="vertical" data-mini="true">
                        <legend>
                            Estado Cívil
                        </legend><br>
                        <input type="radio" id="radio1" name="ProEstadoCivil" value="C"
                               <c:if test="${entidade.proEstadocivil == 'C' }"> checked="true" </c:if>>
                               <label for="radio1">
                                   Casado(a)
                               </label>
                               <input type="radio" id="radio2"name="ProEstadoCivil" value="S" 
                               <c:if test="${entidade.proEstadocivil == 'S' }"> checked="true" </c:if>>
                               <label for="radio2">
                                   Solteiro(a)
                               </label>
                        </fieldset>
                    </div>


                <%--Identificador se é Mestre ou Gestor--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-type="vertical" data-mini="true" id="pessoa">
                        <legend>
                        </legend>
                        <input type="checkbox" id="checkbox1" name="ProEhMestre" value="S"
                               <c:if test="${entidade.proEhmestre == 'S' }"> checked="checked" </c:if>>
                               <label for=checkbox1>
                                   Mestre
                               </label>
                               <input type="checkbox" id="checkbox2" name="ProEhGestor" value="S"
                               <c:if test="${entidade.proEhgestor == 'S' }"> checked="checked" </c:if>>
                               <label for="checkbox2">
                                   Gestor
                               </label>
                        </fieldset>
                    </div>

                <%--Usuário--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label for="textinput9">
                            Usuário
                        </label><br>
                        <input type="text" id="usuario" name="ProUsuario" value="${entidade.proUsuario}" 
                               size="13" maxlength="50" >
                    </fieldset>
                </div> 

                <%--Senha--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label for="textinput9">
                            Senha
                        </label><br>
                        <input type="password" id="senha" name="ProSenha" value="${entidade.proSenha}" 
                               size="13" maxlength="6" >
                    </fieldset>
                </div>  


                <input type="submit" data-inline="true" data-theme="a" data-icon="check" 
                       data-iconpos="left" value="Salvar" data-mini="true" onClick="return validaformulario()">

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadProfessor.jsp';" value="Novo" />                

            </div>

        </form>

    </body>

</html>
