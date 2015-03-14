
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Administrador
 */
@Entity
@Table(name = "TB_ALUNO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbAluno.findAll", query = "SELECT t FROM TbAluno t"),
    @NamedQuery(name = "TbAluno.findPagamentos", query = "SELECT t FROM TbAluno t WHERE t.aluDesconto < 100 AND t.aluDiavencmensalidae IS NOT NULL"),
    @NamedQuery(name = "TbAluno.findByAluCodigo", query = "SELECT t FROM TbAluno t WHERE t.aluCodigo = :aluCodigo"),
    @NamedQuery(name = "TbAluno.findByAlunoPorCurso", query = "SELECT t FROM TbAluno t WHERE t.tbCursoCurCodigo.curCodigo = :tbCursoCurCodigo"),
    @NamedQuery(name = "TbAluno.findByAluNome", query = "SELECT t FROM TbAluno t WHERE t.aluNome = :aluNome"),
    @NamedQuery(name = "TbAluno.findByAluQtdaulas", query = "SELECT t FROM TbAluno t WHERE t.aluQtdaulas = :aluQtdaulas"),
    @NamedQuery(name = "TbAluno.findByAluDtnascimento", query = "SELECT t FROM TbAluno t WHERE t.aluDtnascimento = :aluDtnascimento"),
    @NamedQuery(name = "TbAluno.findByAluDtmatricula", query = "SELECT t FROM TbAluno t WHERE t.aluDtmatricula = :aluDtmatricula"),
    @NamedQuery(name = "TbAluno.findByAluTelefone", query = "SELECT t FROM TbAluno t WHERE t.aluTelefone = :aluTelefone"),
    @NamedQuery(name = "TbAluno.findByAluEmail", query = "SELECT t FROM TbAluno t WHERE t.aluEmail = :aluEmail"),
    @NamedQuery(name = "TbAluno.findByAluLogradouro", query = "SELECT t FROM TbAluno t WHERE t.aluLogradouro = :aluLogradouro"),
    @NamedQuery(name = "TbAluno.findByAluCidade", query = "SELECT t FROM TbAluno t WHERE t.aluCidade = :aluCidade"),
    @NamedQuery(name = "TbAluno.findByAluEstado", query = "SELECT t FROM TbAluno t WHERE t.aluEstado = :aluEstado"),
    @NamedQuery(name = "TbAluno.findByAluNumero", query = "SELECT t FROM TbAluno t WHERE t.aluNumero = :aluNumero"),
    @NamedQuery(name = "TbAluno.findByAluComplemento", query = "SELECT t FROM TbAluno t WHERE t.aluComplemento = :aluComplemento"),
    @NamedQuery(name = "TbAluno.findByAluBairro", query = "SELECT t FROM TbAluno t WHERE t.aluBairro = :aluBairro"),
    @NamedQuery(name = "TbAluno.findByAluSexo", query = "SELECT t FROM TbAluno t WHERE t.aluSexo = :aluSexo"),
    @NamedQuery(name = "TbAluno.findByAluDesconto", query = "SELECT t FROM TbAluno t WHERE t.aluDesconto = :aluDesconto"),
    @NamedQuery(name = "TbAluno.findByAluEstadocivil", query = "SELECT t FROM TbAluno t WHERE t.aluEstadocivil = :aluEstadocivil")})
public class TbAluno implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ALU_CODIGO")
    private Integer aluCodigo;
    @Column(name = "ALU_NOME")
    private String aluNome;
    @Column(name = "ALU_QTDAULAS")
    private Integer aluQtdaulas;
    @Column(name = "ALU_DTNASCIMENTO")
    @Temporal(TemporalType.DATE)
    private Date aluDtnascimento;
    @Column(name = "ALU_DTMATRICULA")
    @Temporal(TemporalType.DATE)
    private Date aluDtmatricula;
    @Column(name = "ALU_TELEFONE")
    private String aluTelefone;
    @Column(name = "ALU_EMAIL")
    private String aluEmail;
    @Column(name = "ALU_LOGRADOURO")
    private String aluLogradouro;
    @Column(name = "ALU_CIDADE")
    private String aluCidade;
    @Column(name = "ALU_ESTADO")
    private String aluEstado;
    @Column(name = "ALU_NUMERO")
    private String aluNumero;
    @Column(name = "ALU_COMPLEMENTO")
    private String aluComplemento;
    @Column(name = "ALU_BAIRRO")
    private String aluBairro;
    @Column(name = "ALU_DIAVENCMENSALIDAE")
    private Integer aluDiavencmensalidae;
    @Column(name = "ALU_SEXO")
    private String aluSexo;
    @Column(name = "ALU_TIPOSANGUINEO")
    private String aluTiposanguineo;
    @Column(name = "ALU_OBSMEDICAL")
    private String aluObsMedica;
    @Column(name = "ALU_FOTO")
    private String aluFoto;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "ALU_DESCONTO")
    private Double aluDesconto;
    @Column(name = "ALU_ESTADOCIVIL")
    private String aluEstadocivil;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbAlunoAluCodigo")
    private Collection<TbAula> tbAulaCollection;
    @JoinColumn(name = "TB_MENSALIDADE_MEN_CODIGO", referencedColumnName = "MEN_CODIGO")
    @ManyToOne(optional = false)
    private TbMensalidade tbMensalidadeMenCodigo;
    @JoinColumn(name = "TB_CURSO_CUR_CODIGO", referencedColumnName = "CUR_CODIGO")
    @ManyToOne(optional = false)
    private TbCurso tbCursoCurCodigo;
    @JoinColumn(name = "TB_GRADUACAO_GRA_CODIGO", referencedColumnName = "GRA_CODIGO")
    @ManyToOne(optional = false)
    private TbGraduacao tbGraduacaoGraCodigo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbAlunoAluCodigo")
    private Collection<TbPagamentos> tbPagamentosCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbAlunoAluCodigo")
    private Collection<TbExames> tbExamesCollection;
    @Transient
    private Integer tmpMensalidadeMenCodigo;
    @Transient
    private Integer tmpCursoCurCodigo;
    @Transient
    private Integer tmptbGraduacaoGraCodigo;

    public TbAluno() {
    }

    public TbAluno(Integer aluCodigo) {
        this.aluCodigo = aluCodigo;
    }

    /**
     * @return the tmpMensalidadeMenCodigo
     */
    public Integer getTmpMensalidadeMenCodigo() {
        return tmpMensalidadeMenCodigo;
    }

    public void setTmptbGraduacaoGraCodigo(Integer tmptbGraduacaoGraCodigo) {
        this.tmptbGraduacaoGraCodigo = tmptbGraduacaoGraCodigo;
    }

    public Integer getTmptbGraduacaoGraCodigo() {
        return tmptbGraduacaoGraCodigo;
    }

    /**
     * @param tmpMensalidadeMenCodigo the tmpMensalidadeMenCodigo to set
     */
    public void setTmpMensalidadeMenCodigo(Integer tmpMensalidadeMenCodigo) {
        this.tmpMensalidadeMenCodigo = tmpMensalidadeMenCodigo;
    }

    public void setTbGraduacaoGraCodigo(TbGraduacao tbGraduacaoGraCodigo) {
        this.tbGraduacaoGraCodigo = tbGraduacaoGraCodigo;
    }

    public TbGraduacao getTbGraduacaoGraCodigo() {
        return tbGraduacaoGraCodigo;
    }

    public void setAluFoto(String aluFoto) {
        this.aluFoto = aluFoto;
    }

    public String getAluFoto() {
        return aluFoto;
    }

    /**
     * @return the tmpCursoCurCodigo
     */
    public Integer getTmpCursoCurCodigo() {
        return tmpCursoCurCodigo;
    }

    /**
     * @param tmpCursoCurCodigo the tmpCursoCurCodigo to set
     */
    public void setTmpCursoCurCodigo(Integer tmpCursoCurCodigo) {
        this.tmpCursoCurCodigo = tmpCursoCurCodigo;
    }

    public Integer getAluCodigo() {
        return aluCodigo;
    }

    public void setAluCodigo(Integer aluCodigo) {
        this.aluCodigo = aluCodigo;
    }

    public String getAluNome() {
        return aluNome;
    }

    public void setAluTiposanguineo(String aluTiposanguineo) {
        this.aluTiposanguineo = aluTiposanguineo;
    }

    public void setAluObsMedica(String aluObsMedica) {
        this.aluObsMedica = aluObsMedica;
    }

    public String getAluTiposanguineo() {
        return aluTiposanguineo;
    }

    public String getAluObsMedica() {
        return aluObsMedica;
    }

    public void setAluNome(String aluNome) {
        this.aluNome = aluNome;
    }

    public Integer getAluQtdaulas() {
        return aluQtdaulas;
    }

    public void setAluQtdaulas(Integer aluQtdaulas) {
        this.aluQtdaulas = aluQtdaulas;
    }

    public Date getAluDtnascimento() {
        return aluDtnascimento;
    }

    public void setAluDtnascimento(Date aluDtnascimento) {
        this.aluDtnascimento = aluDtnascimento;
    }

    public Date getAluDtmatricula() {
        return aluDtmatricula;
    }

    public void setAluDtmatricula(Date aluDtmatricula) {
        this.aluDtmatricula = aluDtmatricula;
    }

    public String getAluTelefone() {
        return aluTelefone;
    }

    public void setAluTelefone(String aluTelefone) {
        this.aluTelefone = aluTelefone;
    }

    public String getAluEmail() {
        return aluEmail;
    }

    public void setAluEmail(String aluEmail) {
        this.aluEmail = aluEmail;
    }

    public String getAluLogradouro() {
        return aluLogradouro;
    }

    public void setAluLogradouro(String aluLogradouro) {
        this.aluLogradouro = aluLogradouro;
    }

    public String getAluCidade() {
        return aluCidade;
    }

    public void setAluCidade(String aluCidade) {
        this.aluCidade = aluCidade;
    }

    public String getAluEstado() {
        return aluEstado;
    }

    public void setAluEstado(String aluEstado) {
        this.aluEstado = aluEstado;
    }

    public String getAluNumero() {
        return aluNumero;
    }

    public void setAluNumero(String aluNumero) {
        this.aluNumero = aluNumero;
    }

    public String getAluComplemento() {
        return aluComplemento;
    }

    public void setAluComplemento(String aluComplemento) {
        this.aluComplemento = aluComplemento;
    }

    public String getAluBairro() {
        return aluBairro;
    }

    public void setAluBairro(String aluBairro) {
        this.aluBairro = aluBairro;
    }

    public Integer getAluDiavencmensalidae() {
        return aluDiavencmensalidae;
    }

    public void setAluDiavencmensalidae(Integer aluDiavencmensalidae) {
        this.aluDiavencmensalidae = aluDiavencmensalidae;
    }

    public String getAluSexo() {
        return aluSexo;
    }

    public void setAluSexo(String aluSexo) {
        this.aluSexo = aluSexo;
    }

    public Double getAluDesconto() {
        return aluDesconto;
    }

    public void setAluDesconto(Double aluDesconto) {
        this.aluDesconto = aluDesconto;
    }

    public String getAluEstadocivil() {
        return aluEstadocivil;
    }

    public void setAluEstadocivil(String aluEstadocivil) {
        this.aluEstadocivil = aluEstadocivil;
    }

    @XmlTransient
    public Collection<TbAula> getTbAulaCollection() {
        return tbAulaCollection;
    }

    public void setTbAulaCollection(Collection<TbAula> tbAulaCollection) {
        this.tbAulaCollection = tbAulaCollection;
    }

    public TbMensalidade getTbMensalidadeMenCodigo() {
        return tbMensalidadeMenCodigo;
    }

    public void setTbMensalidadeMenCodigo(TbMensalidade tbMensalidadeMenCodigo) {
        this.tbMensalidadeMenCodigo = tbMensalidadeMenCodigo;
    }

    public TbCurso getTbCursoCurCodigo() {
        return tbCursoCurCodigo;
    }

    public void setTbCursoCurCodigo(TbCurso tbCursoCurCodigo) {
        this.tbCursoCurCodigo = tbCursoCurCodigo;
    }

    @XmlTransient
    public Collection<TbPagamentos> getTbPagamentosCollection() {
        return tbPagamentosCollection;
    }

    public void setTbPagamentosCollection(Collection<TbPagamentos> tbPagamentosCollection) {
        this.tbPagamentosCollection = tbPagamentosCollection;
    }

    @XmlTransient
    public Collection<TbExames> getTbExamesCollection() {
        return tbExamesCollection;
    }

    public void setTbExamesCollection(Collection<TbExames> tbExamesCollection) {
        this.tbExamesCollection = tbExamesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (aluCodigo != null ? aluCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbAluno)) {
            return false;
        }
        TbAluno other = (TbAluno) object;
        if ((this.aluCodigo == null && other.aluCodigo != null) || (this.aluCodigo != null && !this.aluCodigo.equals(other.aluCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbAluno[ aluCodigo=" + aluCodigo + " ]";
    }
}
