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

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <title>Cadastro de Alunos</title>

        <script>
            
            //Valida se todos os campos do formulário estão prenchidos
            function validaformulario(){
                if (formulario.AluCurso.value == ''){
                    jAlert('Por favor, selecione um curso!', 'Atenção');
                    document.formulario.AluCurso.focus();
                    return false;                   
                }else{
                    if (formulario.AluGraduacao.value == ''){
                        jAlert('Por favor, selecione uma graduação!', 'Atenção');
                        document.formulario.AluGraduacao.focus();
                        return false;                   
                    }else{
                        if (formulario.AluMensalidade.value == ''){
                            jAlert('Por favor, selecione uma mensalidade!', 'Atenção');
                            document.formulario.AluMensalidade.focus();
                            return false;                   
                        }else{
                            if (formulario.AluNome.value == '') {
                                jAlert('Por favor, digite o nome do aluno!', 'Atenção');
                                document.formulario.AluNome.focus();
                                return false;
                            }else{
                                if (  eval( formulario.AluDesconto.value.replace(',','.') ) > 100 ) {  
                                    jAlert('Desconto máximo é de 100%!','Atenção');
                                    document.formulario.AluDesconto.focus();
                                    return false; 
                                }else{
                                    //se todos os campos do formulário foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                                    document.formulario.valida.value = "ok";
                                    return true;  
                                }
                            }                    
                        }
                    }
                    
                }
                
            }
            
            function FormataData(campo){
                if (campo.value.length == 2 || campo.value.length == 5 ){
                    campo.value = campo.value+"/";
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
            
            function atualizagraduacao(){
                document.formulario.submit();
            }
            
        </script>

        <style type="text/css">

            #nomecurso {
                width: 400px;
            }
            #nomegraduacao{
                width: 400px;
            }
            #mensalidade{
                width: 400px;
            }
            #nomealuno{
                width: 350px;
            }
            #quantidadeaulas{
                width: 150px;
            }
            #datanascimento{
                width: 150px;
            }
            #datamatricula{
                width: 150px;
            }
            #telefone{
                width: 150px;
            }
            #email{
                width: 350px;
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
            #vencmensalidade{
                width: 300px;
            }
            #desconto{
                width: 100px;
            }
            #sexo{
                width: 200px;
            }
            #estadocivil{
                width: 300px;
            }
            #tiposanguineo {
                width: 200px;
            }
            #observacoesmedicas{
                width: 900px;
            }

        </style>

    </head>

    <body>

        <%--Criação do Objeto "controlecurso" para listar os cursos--%>
        <jsp:useBean id="controlecurso" class="Controle.TbCursoJpaController"/> 

        <%--Criação do Objeto "controlemensalidade" para listagem das mensalidades--%>
        <jsp:useBean id="controlemensalidade" class="Controle.TbMensalidadeJpaController"/>

        <%--Criação do Objeto "controlegraduacao" para listagem das graduações--%>
        <jsp:useBean id="controlegraduacao" class="Controle.TbGraduacaoJpaController"/>

        <%--Criação do Objeto "controlealuno" para gravar no banco--%>
        <jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

        <%--Criação do Objeto Entidade para a gravação no banco de dados--%>
        <jsp:useBean id="entidade" class="Entidade.TbAluno"/>

        <%--Atribuição dos parâmetros da tela as propriedades da Entidade--%> 
        <jsp:setProperty name="entidade" property="aluCodigo" param="AluCodigo"/>
        <jsp:setProperty name="entidade" property="tmpCursoCurCodigo" param="AluCurso"/>
        <jsp:setProperty name="entidade" property="tmpMensalidadeMenCodigo" param="AluMensalidade"/>
        <jsp:setProperty name="entidade" property="aluNome" param="AluNome"/>
        <jsp:setProperty name="entidade" property="aluQtdaulas" param="AluQtdAulas"/>

        <fmt:parseDate var="DtNascimento" value="${param.AluDtNascimento}" pattern="dd/MM/yyyy"/><%--Conversão da Data --%>
        <jsp:setProperty name="entidade" property="aluDtnascimento" value="${DtNascimento}"/>

        <fmt:parseDate var="DtMatricula" value="${param.AluDtMatricula}" pattern="dd/MM/yyyy"/><%--Conversão da Data --%>
        <jsp:setProperty name="entidade" property="aluDtmatricula" value="${DtMatricula}"/>

        <jsp:setProperty name="entidade" property="aluTelefone" param="AluTelefone"/>
        <jsp:setProperty name="entidade" property="aluEmail" param="AluEMail"/>
        <jsp:setProperty name="entidade" property="aluLogradouro" param="AluLogradouro"/>
        <jsp:setProperty name="entidade" property="aluCidade" param="AluCidade"/>
        <jsp:setProperty name="entidade" property="aluEstado" param="AluEstado"/>
        <jsp:setProperty name="entidade" property="aluNumero" param="AluNumero"/>
        <jsp:setProperty name="entidade" property="aluComplemento" param="AluComplemento"/>
        <jsp:setProperty name="entidade" property="aluBairro" param="AluBairro"/>
        <jsp:setProperty name="entidade" property="aluDiavencmensalidae" param="AluDtVencimentoMens"/>
        <jsp:setProperty name="entidade" property="aluSexo" param="AluSexo"/>
        <jsp:setProperty name="entidade" property="aluTiposanguineo" param="tiposanguineo"/>
        <jsp:setProperty name="entidade" property="aluObsMedica" param="observacoesmedicas"/>
        <jsp:setProperty name="entidade" property="aluFoto" param="AluFoto"/>

        <fmt:parseNumber var="Desconto" value="${param.AluDesconto}" />
        <jsp:setProperty name="entidade" property="aluDesconto" value="${Desconto}"/>
        <jsp:setProperty name="entidade" property="aluEstadocivil" param="AluEstadoCivil"/>
        <jsp:setProperty name="entidade" property="tmptbGraduacaoGraCodigo" param="AluGraduacao"/>


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
        <c:if test="${ SysUser == 'P' }">
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
                controlealuno.create(entidade);
            %>
            <script>
                jAlert('Aluno salvo com sucesso!', 'Atenção');       
            </script>
        </c:if>

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.AluCodigo}">
            <%
                entidade = controlealuno.findTbAluno(entidade.getAluCodigo());
                pageContext.setAttribute("entidade", entidade);
            %>
        </c:if> 

        <H1 style="margin-left: 14px; margin-top: 35p">Cadastro de Alunos</H1>

        <div style="position: absolute; left: 250px; top: 120px;">
            <form method="post" name="form" enctype="multipart/form-data">
                Imagem: <input type="file" name="arquivo" /><br />
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
                    <input type="hidden" name="AluFoto" value="<%= downloadbean.getDownloadLink(imagem)%>">
                    <%} else {
                    %>
                    <c:if test="${not empty entidade.aluFoto}">                    
                        <img src="${entidade.aluFoto}" style="width: 100%; " />
                        <input type="hidden" name="AluFoto" value="${entidade.aluFoto}">
                    </c:if>
                    <%                            }
                    %>
                </div>
            </div>
                
                
            <div data-role="content" style="padding: 15px">

                <%--Campo oculto para validar o formulário--%>
                <input type="hidden" name="valida"/>

                <%--Código do Aluno--%>
                <input type="hidden" name="AluCodigo" value="${param.AluCodigo}"/>

                <%--Nome do Curso--%>
                <div data-role="fieldcontain" id="nomecurso" >		
                    <label>
                        Curso
                    </label><br>
                    <select data-mini="true" name="AluCurso" onchange="atualizagraduacao()">
                        <option>

                        </option>

                        <%--Listagem dos cursos através do método "findTbCursoAll"--%>
                        <c:forEach items="${controlecurso.findTbCursoAll()}" var="curso">
                            <c:set var="selecionado" value="" />
                            <c:if test="${curso.curCodigo eq param.AluCurso}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <c:if test="${empty param.AluCurso and curso.curCodigo eq entidade.tbCursoCurCodigo.curCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>  

                            <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                            <option value="${curso.curCodigo}" ${selecionado}> ${curso.curDescricao} </option>
                        </c:forEach>

                    </select>
                </div>

                <%--Nome da graduação--%>
                <div data-role="fieldcontain" id="nomegraduacao">		
                    <label>
                        Graduação
                    </label><br>
                    <select data-mini="true" name="AluGraduacao">
                        <option>

                        </option>

                        <c:set var="SelCurso" value="${entidade.tbCursoCurCodigo.curCodigo}" />
                        <c:if test="${not empty param.AluCurso}" >
                            <c:set var="SelCurso" value="${param.AluCurso}" />
                        </c:if>

                        <%--Listagem dos cursos através do método "findTbCursoAll"--%>
                        <c:forEach items="${controlegraduacao.findByGraduacaoPorCurso( SelCurso )}" var="graduacao">
                            <c:set var="selecionado" value="" />
                            <c:if test="${graduacao.graCodigo eq entidade.tbGraduacaoGraCodigo.graCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>
                            <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                            <option value="${graduacao.graCodigo}" ${selecionado}> ${graduacao.graDescricao} </option>
                        </c:forEach>

                    </select>
                </div>


                <%--Nome da Mensalidade--%>
                <div data-role="fieldcontain" id="mensalidade">
                    <label>
                        Mensalidade
                    </label><br>
                    <select data-mini="true" name="AluMensalidade" >
                        <option>

                        </option>

                        <%--Listagem das mensalidades através do método "findTbMensalidadeAll"--%>
                        <c:forEach items="${controlemensalidade.findTbMensalidadeAll()}" var="mensalidade">
                            <c:set var="selecionado" value="" />
                            <c:if test="${mensalidade.menCodigo eq entidade.tbMensalidadeMenCodigo.menCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>
                            <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                            <option value="${mensalidade.menCodigo}" ${selecionado}> ${mensalidade.menNome} - <fmt:formatNumber value="${mensalidade.menValor}" type="currency"/></option>
                        </c:forEach>

                    </select>
                </div>


                <%--Nome do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Nome
                        </label><br>
                        <input type="text" id="nomealuno" name="AluNome" value="${entidade.aluNome}">
                    </fieldset>
                </div>


                <%--Quantidade de Aulas--%>
                <div data-role="fieldcontain" id="quantidadeaulas">
                    <label>
                        Quantidade Aulas
                    </label><br>
                    <select data-mini="true" name="AluQtdAulas">

                        <option>
                        </option>

                        <c:forEach begin="1" end="7" var="dia">              

                            <c:if test="${entidade.aluQtdaulas == dia }" >
                                <option selected="true" >${entidade.aluQtdaulas}</option>
                            </c:if>

                            <c:if test="${ entidade.aluQtdaulas != dia }" >
                                <option>${dia}</option>
                            </c:if>

                        </c:forEach>
                    </select>
                </div>


                <%--Data de Nascimento--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data de Nascimento
                        </label><br>
                        <input type="text" id="datanascimento" name="AluDtNascimento" onKeyUp="FormataData(this)" maxlength="10" 
                               value="<fmt:formatDate value="${entidade.aluDtnascimento}" pattern="dd/MM/yyyy"/>">
                    </fieldset>
                </div>


                <%--Data da Matricula--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data da Matrícula
                        </label><br>
                        <input type="text" id="datamatricula" name="AluDtMatricula" onKeyUp="FormataData(this)" maxlength="10" 
                               value="<fmt:formatDate value="${entidade.aluDtmatricula}" pattern="dd/MM/yyyy"/>">
                    </fieldset>
                </div>


                <%--Telefone--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Telefone
                        </label><br>
                        <input type="text" id="telefone" name="AluTelefone" value="${entidade.aluTelefone}"
                               size="13" maxlength="13" onKeyPress="mascaratelefone(this);">
                    </fieldset>
                </div>


                <%--E-Mail--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            E-Mail
                        </label><br>
                        <input type="text" id="email" name="AluEMail" maxlength="30" value="${entidade.aluEmail}">
                    </fieldset>
                </div>


                <%--Logradouro--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Logradouro
                        </label><br>
                        <input type="text" id="logradouro" name="AluLogradouro" maxlength="50" value="${entidade.aluLogradouro}">
                    </fieldset>
                </div>


                <%--Cidade do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Cidade
                        </label><br>
                        <input type="text" id="cidade" name="AluCidade" maxlength="30" value="${entidade.aluCidade}">
                    </fieldset>
                </div>


                <%--Estado do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Estado
                        </label><br>
                        <input type="text" id="estado" name="AluEstado" maxlength="2" value="${entidade.aluEstado}">
                    </fieldset>
                </div>


                <%--Número de Endereço--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Número
                        </label><br>
                        <input type="text" id="numero" name="AluNumero" maxlength="5" value="${entidade.aluNumero}">
                    </fieldset>
                </div>


                <%--Complemento do Endereço--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Complemento
                        </label><br>
                        <input type="text" id="complemento" name="AluComplemento" maxlength="30" value="${entidade.aluComplemento}">
                    </fieldset>
                </div>

                <%--Bairro do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Bairro
                        </label><br>
                        <input type="text" id="bairro" name="AluBairro" maxlength="30" value="${entidade.aluBairro}"
                    </fieldset>
                </div>

                <%--Dia do Vencimento da Mensalidade--%>
                <div data-role="fieldcontain" id="vencmensalidade">
                    <label>
                        Dia Vencimento Mensalidade
                    </label>
                    <select data-mini="true" name="AluDtVencimentoMens" >

                        <option>
                        </option>

                        <c:forEach begin="1" end="31" var="dia">              

                            <c:if test="${entidade.aluDiavencmensalidae == dia }" >
                                <option selected="true" >${entidade.aluDiavencmensalidae}</option>
                            </c:if>

                            <c:if test="${ entidade.aluDiavencmensalidae != dia }" >
                                <option>${dia}</option>
                            </c:if>

                        </c:forEach>
                    </select>
                </div>

                <%--Tipo Sanguineo--%>
                <div data-role="fieldcontain" id="tiposanguineo">
                    <label>
                        Tipo Sanguíneo
                    </label>
                    <select data-mini="true" name="tiposanguineo" >

                        <option>
                        </option>
                        <option <c:if test="${entidade.aluTiposanguineo == 'A+' }"> selected="true" </c:if>>
                            A+
                        </option>
                        <option <c:if test="${entidade.aluTiposanguineo == 'A-' }"> selected="true" </c:if>>
                            A-
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'B+' }"> selected="true" </c:if>>
                            B+
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'B-' }"> selected="true" </c:if>>
                            B-
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'AB+' }"> selected="true" </c:if>>
                            AB+
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'AB-' }"> selected="true" </c:if>>
                            AB-
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'O+' }"> selected="true" </c:if>>
                            O+
                        </option>                        
                        <option <c:if test="${entidade.aluTiposanguineo == 'O-' }"> selected="true" </c:if>>
                            O-
                        </option>                        
                    </select>
                </div>


                <%--Observações Médicas--%>
                <div data-role="fieldcontain" id="observacoesmedicas">
                    <fieldset data-role="controlgroup">
                        <label>
                            Observações Médicas
                        </label><br>
                        <textarea data-mini="true" name="observacoesmedicas" cols="45" 
                                  rows="7">${entidade.aluObsMedica}</textarea>
                    </fieldset>
                </div>


                <%--Sexo do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-type="vertical" data-mini="true" id="sexo">
                        <legend>
                            Sexo
                        </legend><br>
                        <input name="AluSexo" id="radio1" value="M" type="radio"
                               <c:if test="${entidade.aluSexo == 'M' }"> checked="true" </c:if>>
                        <label for="radio1">
                            Masculino
                        </label>
                        <input name="AluSexo" id="radio2" value="F" type="radio"
                               <c:if test="${entidade.aluSexo == 'F' }"> checked="true" </c:if>>
                        <label for="radio2">
                            Feminino
                        </label>
                    </fieldset>
                </div>


                <%--Desconto da Mensalidade do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            % Desconto
                        </label><br>
                        <input type="text" id="desconto" name="AluDesconto" onkeyup="moeda(this)" maxlength="6"
                               value="<fmt:formatNumber value="${entidade.aluDesconto}" minFractionDigits="2"/>">
                    </fieldset>
                </div>


                <%--Estado Cívil do Aluno--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-type="vertical" data-mini="true" id="estadocivil">
                        <legend>
                            Estado Cívil
                        </legend><br>
                        <input name="AluEstadoCivil" id="radio3" value="C" type="radio"
                               <c:if test="${entidade.aluEstadocivil == 'C' }"> checked="true" </c:if>>
                        <label for="radio3">
                            Casado(a)
                        </label>
                        <input name="AluEstadoCivil" id="radio4" value="S" type="radio"
                               <c:if test="${entidade.aluEstadocivil == 'S' }"> checked="true" </c:if>>
                        <label for="radio4">
                            Solteiro(a)
                        </label>
                    </fieldset>
                </div>

                <input type="submit" data-inline="true" data-theme="a" data-icon="check"
                       data-iconpos="left" value="Salvar" data-mini="true" onClick="return validaformulario()">

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='CadAluno.jsp';" value="Novo" />


            </div>

        </form>   

    </body>

</html> 