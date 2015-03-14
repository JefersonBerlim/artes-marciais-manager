<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>

    <head>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <title>Exames de Faixas</title>

        <script>
            
            
            //Valida se todos os campos to formulário foram preenchidos
            function validaformulario(){

                if (formulario.DtExame.value == '') {
                    jAlert('Por favor, digite a data do exame!','Atenção');
                    document.formulario.DtExame.focus();
                    return false; 
                }else{
                    if (formulario.HrExame.value == '') {
                        jAlert('Por favor, digite a hora do exame!','Atenção');
                        document.formulario.HrExame.focus();
                        return false; 
                    }else{
                        if (formulario.ExaCurso.value == '') {
                            jAlert('Por favor, selecione o curso do exame!','Atenção');
                            document.formulario.ExaCurso.focus();
                            return false;
                        }else{
                            if (formulario.ExaAluno.value == '') {
                                jAlert('Por favor, selecione o aluno do exame!','Atenção');
                                document.formulario.ExaAluno.focus();
                                return false;
                            }else{
                                if (formulario.ExaGraduacao.value == '') {
                                    jAlert('Por favor, selecione a graduação do exame!','Atenção');
                                    document.formulario.ExaGraduacao.focus();
                                    return false;
                                }else{
                                    if (formulario.ExaProfessor.value == '') {
                                        jAlert('Por favor, selecione o professor do exame!','Atenção');
                                        document.formulario.ExaProfessor.focus();
                                        return false;
                                    }else{
                                        if (formulario.ExaMedia.value == '' || eval( formulario.ExaMedia.value.replace(',','.') ) <= 0  
                                            || eval( formulario.ExaMedia.value.replace(',','.') ) > 10 ) {
                                            jAlert('Por favor, digite uma média válida!','Atenção');
                                            document.formulario.ExaMedia.focus();
                                            return false;
                                        }else{
                                            if (formulario.ExaResultado.value == '') {
                                                jAlert('Por favor, selecione o resultado do exame!','Atenção');
                                                document.formulario.ExaResultado.focus();
                                                return false;
                                            }else{
                                                //se todos os campos do formulário foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                                                document.formulario.valida.value = 'ok';
                                                return true;          
                                            }
                                        }
                                    }
                                }                                 
                            }                                
                        }                          
                    }
                }
            }
            
            function FormataData(){
                if (formulario.DtExame.value.length == 2 || formulario.DtExame.value.length == 5 ){
                    formulario.DtExame.value = formulario.DtExame.value+"/";
                }
            }
            
            function validahora(edit){
                if(event.keyCode<48 || event.keyCode>57){
                    event.returnValue=false;
                }
                if(edit.value.length==2){
                    edit.value+=":";}
            }
            
            function atualizacurso(){
                
                
                document.formulario.submit();
                
            }
            
            function atualiza(){
                document.formulario.submit();
            }
            function nota(z){ 
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

            #dtexame {
                width: 150px;
            }
            #hrexame{
                width: 100px;
            } 
            #nomeprofessor{
                width: 450px;
            }
            #aluno{
                width: 450px;
            }
            #curso{
                width: 450px;
            }
            #graduacao{
                width: 450px;
            }
            #media{
                width: 120px;
            }
            #resultado{
                width: 350px;
            }

        </style>

    </head>

    <body>       

        <%--Criação do Objeto "controleexames" para a listagem dos exames --%>
        <jsp:useBean id="controleexames" class="Controle.TbExamesJpaController"/>

        <%--Criação do Objeto "controlealuno" para a listagem dos alunos --%>
        <jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

        <%--Criação do Objeto "controlecurso" para listagem dos cursos--%>
        <jsp:useBean id="controlecurso" class="Controle.TbCursoJpaController"/>

        <%--Criação do Objeto "controlegraduacao" para a listagem das graduacoes--%>
        <jsp:useBean id="controlegraduacao" class="Controle.TbGraduacaoJpaController"/>

        <%--Criação do Objeto "controleprofessor" para a listagem dos professores--%>
        <jsp:useBean id="controleprofessor" class="Controle.TbProfessorJpaController"/>

        <%--Criação do Objeto de Entidade para fazer a persistência--%>
        <jsp:useBean id="entidade" class="Entidade.TbExames"/>

        <%--Atribuição dos parâmetros da tela as propriedades da Entidade--%> 
        <jsp:setProperty name="entidade" property="sequencial" param="ExaCodigo"/>

        <%--Conversão da Data --%>
        <fmt:parseDate var="dtexame" value="${param.DtExame}" pattern="dd/MM/yyyy"/>
        <jsp:setProperty name="entidade" property="exaData" value="${dtexame}"/>

        <%--Conversão da Hora --%>
        <fmt:parseDate var="hrexame" value="${param.HrExame}" pattern="HH:mm"/>         
        <jsp:setProperty name="entidade" property="exaHorario" value="${hrexame}"/>

        <jsp:setProperty name="entidade" property="tmptbAlunoAluCodigo" param="ExaAluno"/>
        <jsp:setProperty name="entidade" property="tmptbCursoCurCodigo" param="ExaCurso"/>
        <jsp:setProperty name="entidade" property="tmptbGraduacaoGraCodigo" param="ExaGraduacao"/>
        <jsp:setProperty name="entidade" property="tmptbProfessorProCodigo" param="ExaProfessor"/>

        <fmt:parseNumber var="media" value="${param.ExaMedia}" type="number"/>
        <jsp:setProperty name="entidade" property="exaMedia" value="${media}"/>

        <jsp:setProperty name="entidade" property="exaResultado" param="ExaResultado"/>

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
            <c:catch var="erro" >
                <%
                    controleexames.create(entidade);
                %>
                <script>
                    jAlert('Exame salvo com sucesso!','Atenção');
                </script>
            </c:catch>
        </c:if>

        <c:if test="${not empty erro}">                    
            <script>
                jAlert('${erro.message}', 'Atenção');
            </script>
        </c:if>

        <%--Troca o objeto criado na página pelo objeto retornado pelo find que já está gerenciado pelo entity manager--%>
        <c:if test="${not empty param.ExaCodigo}">
            <%
                entidade = controleexames.findTbExames(entidade.getSequencial());
                pageContext.setAttribute("entidade", entidade);
            %>
        </c:if> 

        <form name="formulario">

            <div data-role="content" style="padding: 15px">

                <h1>Lançamento de Exames de Faixas</h1>


                <%--Criação do campo oculto usado para a validação formulário--%>
                <input type="hidden" name="valida" />


                <%--Código sequencial do cadastro de mensalidades--%>
                <input type="hidden" name="ExaCodigo" value="${param.ExaCodigo}"/>


                <%--Data do Exame--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data do Exame
                        </label><br>
                        <input type="text" id="dtexame" name="DtExame" onKeyUp="FormataData(this)" maxlength="10" 
                               value="<fmt:formatDate value="${entidade.exaData}" pattern="dd/MM/yyyy"/>" 
                               <c:if test="${not empty param.ExaCodigo }"> readonly="true" </c:if>>
                    </fieldset>
                </div>


                <%--Horário do Exame--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Horário do Exame
                        </label><br>
                        <input type="text" id="hrexame" name="HrExame" maxlength="5" onkeypress="validahora(this)" 
                               value="<fmt:formatDate value="${entidade.exaHorario}" pattern="hh:mm" />" 
                               <c:if test="${not empty param.ExaCodigo }"> readonly="true" </c:if>>
                    </fieldset>
                </div>


                <%--Curso--%>
                <div data-role="fieldcontain" id="curso">
                    <label>
                        Curso
                    </label><br>
                    <select name="ExaCurso" data-mini="true" onchange="atualiza()">
                        <option <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>
                        </option>

                        <%--Listagem dos cursos através do método "findTbCursoAll"--%>
                        <c:forEach items="${controleexames.findTbCursoAll()}" var="curso">

                            <c:set var="selecionado" value="" />
                            <c:if test="${curso.curCodigo eq param.ExaCurso}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <c:if test="${empty param.ExaCurso and curso.curCodigo eq entidade.tbCursoCurCodigo.curCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>  

                            <%--Mostra o atributo da Descrição mas guarda o valor do Código do objeto selecionado--%>
                            <option value="${curso.curCodigo}" ${selecionado}
                                    <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> ${curso.curDescricao} </option>
                        </c:forEach>
                    </select>
                </div>


                <%--Nome do Aluno--%>
                <div data-role="fieldcontain" id="aluno">
                    <label>
                        Aluno
                    </label><br>
                    <select name="ExaAluno" data-mini="true" onchange="atualiza()">
                        <option <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>
                        </option>

                        <c:set var="SelCurso" value="${entidade.tbCursoCurCodigo.curCodigo}" />
                        <c:if test="${not empty param.ExaCurso}" >
                            <c:set var="SelCurso" value="${param.ExaCurso}"/>
                        </c:if>

                        <%-- Listagem dos alunos através do método "findTbAlunoAll"--%>
                        <c:forEach items="${controleexames.findByAlunoPorCurso( SelCurso )}" var="aluno">
                            <c:set var="selecionado" value="" />
                            <c:if test="${aluno.aluCodigo eq entidade.tbAlunoAluCodigo.aluCodigo or param.ExaAluno eq aluno.aluCodigo}" >
                                <c:set var="selecionado" value="selected" />
                                <c:set var="SelGraduacao" value="${aluno.tbGraduacaoGraCodigo.graCodigo}"/>
                            </c:if>

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${aluno.aluCodigo}" ${selecionado}
                                    <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> ${aluno.aluNome}</option>
                        </c:forEach>
                    </select>
                </div>


                <%--Graduação--%>
                <div data-role="fieldcontain" id="graduacao">
                    <label>
                        Graduação
                    </label><br>
                    <select name="ExaGraduacao" data-mini="true">
                        <option <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>
                        </option>

                        <c:set var="SelCurso" value="${entidade.tbCursoCurCodigo.curCodigo}" />
                        <c:if test="${not empty param.ExaCurso}" >
                            <c:set var="SelCurso" value="${param.ExaCurso}" />
                        </c:if>

                        <%-- Listagem das graduações através do método "findTbGraduacaoAll" do Objeto "controlegraduacao"--%>
                        <c:forEach items="${controlegraduacao.findByGraduacaoPorCurso( SelCurso )}" var="graduacao">
                            <c:set var="selecionado" value="" />
                            <c:if test="${graduacao.graCodigo eq entidade.tbGraduacaoGraCodigo.graCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${graduacao.graCodigo}" ${selecionado}
                                    <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> ${graduacao.graDescricao} </option>
                        </c:forEach>
                    </select>
                </div>


                <%--Nome do Professor--%>
                <div data-role="fieldcontain" id="nomeprofessor">
                    <label>
                        Professor Responsável
                    </label><br>
                    <select name="ExaProfessor" data-mini="true">
                        <option <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>
                        </option>

                        <%-- Listagem dos professores através do método "findTbProfessorAll"--%>
                        <c:forEach items="${controleprofessor.findTbProfessorAll()}" var="professor">
                            <c:set var="selecionado" value="" />
                            <c:if test="${professor.proCodigo eq entidade.tbProfessorProCodigo.proCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--guarda o valor do código mas mostra a descrição da listagem--%>
                            <option value="${professor.proCodigo}" ${selecionado}
                                    <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> ${professor.proNome}</option>
                        </c:forEach>
                    </select>
                </div>


                <%--Média do Exame--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Média
                        </label><br>
                        <input type="text" id="media" name="ExaMedia" maxlength="5" onkeyup="nota(this)"
                               value="<fmt:formatNumber value="${entidade.exaMedia}" minFractionDigits="2"/>" 
                               <c:if test="${not empty param.ExaCodigo}"> readonly="true" </c:if>>
                    </fieldset>
                </div>


                <%--Resultado do Exame--%>
                <div data-role="fieldcontain" id="resultado">
                    <label>
                        Resultado
                    </label><br>
                    <select name="ExaResultado" data-mini="true">
                        <option <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>

                        </option>

                        <option value="A" <c:if test="${entidade.exaResultado == 'A' }"> selected="true" </c:if>
                                <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> Aprovado</option>

                        <option value="R" <c:if test="${entidade.exaResultado == 'R' }"> selected="true" </c:if> 
                                <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>> Reprovado</option>
                    </select>
                </div>

                <input type="submit" data-inline="true" data-theme="a" data-icon="check"
                       data-iconpos="left" value="Salvar" data-mini="true" onClick="return validaformulario()"
                       <c:if test="${not empty param.ExaCodigo }"> disabled="true" </c:if>>

                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='Exames.jsp';" value="Novo" />
            </div>
        </form>
    </body>
</html>