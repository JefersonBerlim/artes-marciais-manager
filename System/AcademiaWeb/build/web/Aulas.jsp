<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>

    <head>

        <%--Cria��o do Objeto "controleexercicio" para listagem dos exercicios--%>
        <jsp:useBean id="controleexercicio" class="Controle.TbExercicioJpaController"/>

        <title>Aulas</title>

        <link rel="stylesheet" href="CorpoPagina/jquery.mobile-1.1.1.css" />
        <script src="CorpoPagina/jquery.js"></script>
        <script src="CorpoPagina/jquery.mobile.js"></script>
        <script src="jquery.alerts-1.1/jquery.alerts.js"></script>
        <link  rel="stylesheet" href="jquery.alerts-1.1/jquery.alerts.css"/>

        <script>
        
            
            //Valida se todos os campos to formul�rio foram preenchidos
            function validaformulario(){
			
                if (formulario.DtAula.value == '') {
                    jAlert('Por favor, digite a data da aula!', 'Aten��o');
                    document.formulario.DtAula.focus();
                    return false; 
                }else{
                    if(formulario.HrAula.value == ''){
                        jAlert('Por favor, digite a hora da aula!', 'Aten��o');
                        document.formulario.HrAula.focus();
                        return false;
                    }else{
                        if(formulario.HrAula.value == ''){
                            jAlert('Por favor, digite a hora da aula!', 'Aten��o');
                            document.formulario.HrAula.focus();
                            return false;
                        }else{
                            if(formulario.NmAluno.value == ''){
                                jAlert('Por favor, selecione o aluno!', 'Aten��o');
                                document.formulario.NmAluno.focus();
                                return false;
                            }else{
                                if(formulario.NmExercicio.value == ''){
                                    jAlert('Por favor,selecione o exerc�cio!', 'Aten��o');
                                    document.formulario.NmExercicio.focus();
                                    return false;
                                }else{
                                    if(formulario.NmProfessor.value == ''){
                                        jAlert('Por favor, selecione o professor!', 'Aten��o');
                                        document.formulario.NmProfessor.focus();
                                        return false;
                                    }else{
                                        //se todos os campos do formul�rio foram preenchidos, coloca o valor "ok" no campo oculto 'valida'
                                        document.formulario.valida.value = 'ok';
                                        return true;
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            function FormataData(){
                if (formulario.DtAula.value.length == 2 || formulario.DtAula.value.length == 5 ){
                    formulario.DtAula.value = formulario.DtAula.value+"/";
                }
            }
			
            function validahora(edit){
                if(event.keyCode<48 || event.keyCode>57){
                    event.returnValue=false;
                }
                if(edit.value.length==2){
                    edit.value+=":";}
            }
	            
            $(document).ready(function(){

                $( ".data" ).datepicker({ changeMonth: true, changeYear: true });

            });
            
            function atualiza(){
                document.formulario.submit();
            }
            
        </script>

        <style type="text/css">

            #dataaula {
                width: 150px;
            }

            #horaaula{
                width: 100px;
            } 
            #professor{
                width: 450px;
            }

            #exercicio{
                width:450px;
            }

            #aluno{
                width: 450px;
            }

            #assunto{
                width: 810px;
            }

            #observacoes{
                width: 810px;
            }

        </style>

    </head>

    <body>

        <%--Cria��o do Objeto "controleprofessor" para listagem dos professores--%>
        <jsp:useBean id="controleprofessor" class="Controle.TbProfessorJpaController"/>

        <%--Cria��o do Objeto "controlealuno" para listagem dos alunos--%>
        <jsp:useBean id="controlealuno" class="Controle.TbAlunoJpaController"/>

        <%--Cria��o do Objeto "controleaulas" para gravar no banco--%>
        <jsp:useBean id="controleaulas" class="Controle.TbAulaJpaController"/>

        <%--Cria��o do Objeto Entidade para a grava��o no banco de dados--%>
        <jsp:useBean id="entidade" class="Entidade.TbAula"/>

        <%--Atribui��o dos par�metros da tela as propriedades da Entidade--%> 
        <jsp:setProperty name="entidade" property="sequencial" param="AulCod"/>

        <%--Convers�o da Data --%>
        <fmt:parseDate var="DtAula" value="${param.DtAula}" pattern="dd/MM/yyyy"/>
        <jsp:setProperty name="entidade" property="aulData" value="${DtAula}"/>

        <%--Convers�o da Hora --%>
        <fmt:parseDate var="HrAula" value="${param.HrAula}" pattern="HH:mm"/>         
        <jsp:setProperty name="entidade" property="aulHorario" value="${HrAula}"/>

        <jsp:setProperty name="entidade" property="aulObservacoes" param="DesObservacoes"/>
        <jsp:setProperty name="entidade" property="aulAssunto" param="DesAssunto"/>
        <jsp:setProperty name="entidade" property="tmptbProfessorProCodigo" param="NmProfessor"/>
        <jsp:setProperty name="entidade" property="tmptbExercicioExeCodigo" param="NmExercicio"/>
        <jsp:setProperty name="entidade" property="tmptbAlunoAluCodigo" param="NmAluno"/>

        <%--Valida��o do Usu�rio no acesso � tela--%>
        <c:if test="${( SysUser == 'P' ) }">
            <c:redirect url="TelaLogin.jsp">
                <c:param name="alerta">
                    Somente usu�rios do tipo "Mestre" ou "Professor" tem acesso a esta tela
                </c:param>                
            </c:redirect>
        </c:if>


        <%--Verifica se o campo 'valida'esta com o valor ok, caso esteja 
                todos os campos obrigat�rios foram preenchidos, ai faz-se a persist�ncia--%>
        <c:if test="${param.valida eq 'ok'}">
            <c:catch var="erro" >
                <%
                    controleaulas.create(entidade);
                %>
                <script>
                    jAlert('Aula salva com sucesso!', 'Aten��o');
                </script>
            </c:catch>
        </c:if>

        <c:if test="${not empty erro}">                    
            <script>
                jAlert('${erro.message}', 'Aten��o');
            </script>
        </c:if>

        <%--Troca o objeto criado na p�gina pelo objeto retornado pelo find que j� est� gerenciado pelo entity manager--%>
        <c:if test="${not empty param.AulCod}">
            <%
                entidade = controleaulas.findTbAula(entidade.getSequencial());
                pageContext.setAttribute("entidade", entidade);
            %>
        </c:if>

        <form name="formulario">

            <div data-role="content" style="padding: 15px">

                <h1> Lan�amento de Aulas</h1>

                <%--Campo oculto para validar o formul�rio--%>
                <input type="hidden" name="valida" />


                <%--C�digo da Aula--%>
                <input type="hidden" name="AulCod" value="${param.AulCod}"/>


                <%--Data da Aula--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Data Aula
                        </label><br>

                        <input type="text" id="dataaula" name="DtAula" onKeyUp="FormataData(this)" maxlength="10" 
                               value="<fmt:formatDate value="${entidade.aulData}" pattern="dd/MM/yyyy"/>"
                               <c:if test="${not empty param.AulCod }"> readonly="true" </c:if>>

                        </fieldset>
                    </div>


                <%--Hor�rio da Aula--%>
                <div data-role="fieldcontain">
                    <fieldset data-role="controlgroup" data-mini="true">
                        <label>
                            Hor�rio
                        </label><br>
                        <input type="text" id="horaaula" name="HrAula" maxlength="5" onkeypress="validahora(this)" 
                               value="<fmt:formatDate value="${entidade.aulHorario}" pattern="HH:mm" />"
                               <c:if test="${not empty param.AulCod }"> readonly="true" </c:if>>
                        </fieldset>
                    </div>


                <%--Sele��o do Aluno--%>
                <div data-role="fieldcontain" id="aluno">
                    <label>
                        Aluno
                    </label><br>
                    <select data-mini="true" name="NmAluno" onchange="atualiza()" >
                        <option  <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>>
                            </option>

                        <%-- Listagem dos alunos atrav�s do m�todo "findTbAlunoAll"--%>
                        <c:forEach items="${controlealuno.findTbAlunoAll()}" var="aluno">

                            <c:set var="selecionado" value="" />
                            <c:if test="${aluno.aluCodigo eq param.NmAluno}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <c:if test="${empty param.NmAluno and aluno.aluCodigo eq entidade.tbAlunoAluCodigo.aluCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--guarda o valor do c�digo mas mostra a descri��o da listagem--%>
                            <option value="${aluno.aluCodigo}" ${selecionado}                                    
                                    <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>>${aluno.aluNome}</option>
                        </c:forEach>
                    </select>
                </div>


                <%--Sele��o do Exerc�cio--%>
                <div data-role="fieldcontain" id="exercicio">
                    <label>
                        Exerc�cio
                    </label><br>
                    <select data-mini="true" name="NmExercicio">
                        <option <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>>
                            </option>

                        <c:set var="SelGraduacao" value="${entidade.tbAlunoAluCodigo.aluCodigo}" />
                        <c:if test="${not empty param.NmAluno}" >
                            <c:set var="SelGraduacao" value="${param.NmAluno}" />
                        </c:if>

                        <%-- Listagem dos exercicios atrav�s do m�todo "findTbProfessorAll"--%>
                        <c:if test="${not empty SelGraduacao }">
                            <c:forEach items="${controleexercicio.findExercicioPorAluno( SelGraduacao, entidade.sequencial )}" var="exercicio">
                                <c:set var="selecionado" value="" />
                                <c:if test="${exercicio.exeCodigo eq entidade.tbExercicioExeCodigo.exeCodigo}" >
                                    <c:set var="selecionado" value="selected" />
                                </c:if>

                                <%--guarda o valor do c�digo mas mostra a descri��o da listagem--%>
                                <option value="${exercicio.exeCodigo}" ${selecionado}
                                        <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>> ${exercicio.exeDescricao}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>


                <%--Sele��o do Professor--%>
                <div data-role="fieldcontain" id="professor">
                    <label>
                        Professor
                    </label><br>
                    <select data-mini="true" name="NmProfessor">
                        <option <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>>
                            </option>

                        <%-- Listagem dos professores atrav�s do m�todo "findTbProfessorAll"--%>
                        <c:forEach items="${controleprofessor.findTbProfessorAll()}" var="professor">
                            <c:set var="selecionado" value="" />
                            <c:if test="${professor.proCodigo eq entidade.tbProfessorProCodigo.proCodigo}" >
                                <c:set var="selecionado" value="selected" />
                            </c:if>

                            <%--guarda o valor do c�digo mas mostra a descri��o da listagem--%>
                            <option value="${professor.proCodigo}" ${selecionado}
                                    <c:if test="${not empty param.AulCod }"> disabled="true" </c:if>> ${professor.proNome}</option>
                        </c:forEach>
                    </select>
                </div>


                <%--Assunto da Aula--%>
                <div data-role="fieldcontain" id="assunto">
                    <fieldset data-role="controlgroup">
                        <label>
                            Assunto
                        </label><br>
                        <textarea data-mini="true" name="DesAssunto" cols="45" rows="5" >${entidade.aulAssunto}</textarea>
                    </fieldset>
                </div>


                <%--Observa��es da Aula--%>
                <div data-role="fieldcontain" id="observacoes">
                    <fieldset data-role="controlgroup">
                        <label>
                            Observa��es
                        </label><br>
                        <textarea data-mini="true" name="DesObservacoes" cols="45" rows="5">${entidade.aulObservacoes}</textarea>
                    </fieldset>
                </div>


                <input type="submit" data-theme="a" data-icon="check" data-iconpos="left" data-inline="true" 
                       data-mini="true" name="BtnSalvar" value="Salvar" onClick="return validaformulario()" >


                <input type="button" data-inline="true" data-mini="true" data-theme="a" data-icon="plus" 
                       data-iconpos="left" name="BtnSalvar" onclick="javascript: location.href='Aulas.jsp';" value="Novo" />


            </div>
        </form>
    </body>
</html>