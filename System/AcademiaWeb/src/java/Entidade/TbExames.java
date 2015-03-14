
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Administrador
 */
@Entity
@Table(name = "TB_EXAMES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbExames.findAll", query = "SELECT t FROM TbExames t"),
    @NamedQuery(name = "TbExames.findByExaData", query = "SELECT t FROM TbExames t WHERE t.exaData = :exaData"),
    @NamedQuery(name = "TbExames.findValidaExame", query = "SELECT t FROM TbExames t WHERE t.exaData = :exaData"
                                                                                 + " AND t.exaHorario = :exaHorario"
                                                                                 + " AND t.tbAlunoAluCodigo.aluCodigo = :aluCodigo "),
    @NamedQuery(name = "TbExames.findByExaHorario", query = "SELECT t FROM TbExames t WHERE t.exaHorario = :exaHorario"),
    @NamedQuery(name = "TbExames.findBySequencial", query = "SELECT t FROM TbExames t WHERE t.sequencial = :sequencial"),
    @NamedQuery(name = "TbExames.findByExaMedia", query = "SELECT t FROM TbExames t WHERE t.exaMedia = :exaMedia"),
    @NamedQuery(name = "TbExames.findByExaResultado", query = "SELECT t FROM TbExames t WHERE t.exaResultado = :exaResultado"),})
public class TbExames implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @Column(name = "EXA_DATA")
    @Temporal(TemporalType.DATE)
    private Date exaData;
    @Basic(optional = false)
    @Column(name = "EXA_HORARIO")
    @Temporal(TemporalType.TIME)
    private Date exaHorario;
    @Id
    @Basic(optional = false)
    @Column(name = "SEQUENCIAL")
    private Integer sequencial;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "EXA_MEDIA")
    private Double exaMedia;
    @Column(name = "EXA_RESULTADO")
    private String exaResultado;
    @JoinColumn(name = "TB_PROFESSOR_PRO_CODIGO", referencedColumnName = "PRO_CODIGO")
    @ManyToOne(optional = false)
    private TbProfessor tbProfessorProCodigo;
    @JoinColumn(name = "TB_GRADUACAO_GRA_CODIGO", referencedColumnName = "GRA_CODIGO")
    @ManyToOne(optional = false)
    private TbGraduacao tbGraduacaoGraCodigo;
    @JoinColumn(name = "TB_CURSO_CUR_CODIGO", referencedColumnName = "CUR_CODIGO")
    @ManyToOne(optional = false)
    private TbCurso tbCursoCurCodigo;
    @JoinColumn(name = "TB_ALUNO_ALU_CODIGO", referencedColumnName = "ALU_CODIGO")
    @ManyToOne(optional = false)
    private TbAluno tbAlunoAluCodigo;
    @Transient
    private Integer tmptbProfessorProCodigo;
    @Transient
    private Integer tmptbGraduacaoGraCodigo;
    @Transient
    private Integer tmptbAlunoAluCodigo;
    @Transient
    private Integer tmptbCursoCurCodigo;

    public void setTmptbCursoCurCodigo(Integer tmptbCursoCurCodigo) {
        this.tmptbCursoCurCodigo = tmptbCursoCurCodigo;
    }

    public Integer getTmptbCursoCurCodigo() {
        return tmptbCursoCurCodigo;
    }

    public TbExames() {
    }

    public TbExames(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public Integer getTmptbAlunoAluCodigo() {
        return tmptbAlunoAluCodigo;
    }

    public Integer getTmptbGraduacaoGraCodigo() {
        return tmptbGraduacaoGraCodigo;
    }

    public Integer getTmptbProfessorProCodigo() {
        return tmptbProfessorProCodigo;
    }

    public void setTmptbAlunoAluCodigo(Integer tmptbAlunoAluCodigo) {
        this.tmptbAlunoAluCodigo = tmptbAlunoAluCodigo;
    }

    public void setTmptbGraduacaoGraCodigo(Integer tmptbGraduacaoGraCodigo) {
        this.tmptbGraduacaoGraCodigo = tmptbGraduacaoGraCodigo;
    }

    public void setTmptbProfessorProCodigo(Integer tmptbProfessorProCodigo) {
        this.tmptbProfessorProCodigo = tmptbProfessorProCodigo;
    }

    public TbExames(Integer sequencial, Date exaData, Date exaHorario) {
        this.sequencial = sequencial;
        this.exaData = exaData;
        this.exaHorario = exaHorario;
    }

    public Date getExaData() {
        return exaData;
    }

    public void setExaData(Date exaData) {
        this.exaData = exaData;
    }

    public Date getExaHorario() {
        return exaHorario;
    }

    public void setExaHorario(Date exaHorario) {
        this.exaHorario = exaHorario;
    }

    public Integer getSequencial() {
        return sequencial;
    }

    public void setSequencial(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public Double getExaMedia() {
        return exaMedia;
    }

    public void setExaMedia(Double exaMedia) {
        this.exaMedia = exaMedia;
    }

    public String getExaResultado() {
        return exaResultado;
    }

    public void setExaResultado(String exaResultado) {
        this.exaResultado = exaResultado;
    }

    public TbProfessor getTbProfessorProCodigo() {
        return tbProfessorProCodigo;
    }

    public void setTbProfessorProCodigo(TbProfessor tbProfessorProCodigo) {
        this.tbProfessorProCodigo = tbProfessorProCodigo;
    }

    public TbGraduacao getTbGraduacaoGraCodigo() {
        return tbGraduacaoGraCodigo;
    }

    public void setTbGraduacaoGraCodigo(TbGraduacao tbGraduacaoGraCodigo) {
        this.tbGraduacaoGraCodigo = tbGraduacaoGraCodigo;
    }

    public TbCurso getTbCursoCurCodigo() {
        return tbCursoCurCodigo;
    }

    public void setTbCursoCurCodigo(TbCurso tbCursoCurCodigo) {
        this.tbCursoCurCodigo = tbCursoCurCodigo;
    }

    public TbAluno getTbAlunoAluCodigo() {
        return tbAlunoAluCodigo;
    }

    public void setTbAlunoAluCodigo(TbAluno tbAlunoAluCodigo) {
        this.tbAlunoAluCodigo = tbAlunoAluCodigo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (sequencial != null ? sequencial.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbExames)) {
            return false;
        }
        TbExames other = (TbExames) object;
        if ((this.sequencial == null && other.sequencial != null) || (this.sequencial != null && !this.sequencial.equals(other.sequencial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbExames[ sequencial=" + sequencial + " ]";
    }
}
