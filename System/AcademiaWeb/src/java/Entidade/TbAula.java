/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author BERLIM
 */
@Entity
@Table(name = "TB_AULA")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbAula.findAll", query = "SELECT t FROM TbAula t"), 
    @NamedQuery(name = "TbAula.findValidaAula", query = "SELECT t FROM TbAula t WHERE t.aulData = :aulData "
                                                                            + "AND t.aulHorario = :aulHorario "
                                                                            + "AND t.tbAlunoAluCodigo.aluCodigo = :aluCodigo"), 
    @NamedQuery(name = "TbAula.findByAulData", query = "SELECT t FROM TbAula t WHERE t.aulData = :aulData"),
    @NamedQuery(name = "TbAula.findByAulHorario", query = "SELECT t FROM TbAula t WHERE t.aulHorario = :aulHorario"),
    @NamedQuery(name = "TbAula.findBySequencial", query = "SELECT t FROM TbAula t WHERE t.sequencial = :sequencial"),
    @NamedQuery(name = "TbAula.findByAulAssunto", query = "SELECT t FROM TbAula t WHERE t.aulAssunto = :aulAssunto")})

public class TbAula implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @Column(name = "AUL_DATA")
    @Temporal(TemporalType.DATE)
    private Date aulData;
    @Basic(optional = false)
    @Column(name = "AUL_HORARIO")
    @Temporal(TemporalType.TIME)
    private Date aulHorario;
    @Id
    @Basic(optional = false)
    @Column(name = "SEQUENCIAL")
    private Integer sequencial;
    @Column(name = "AUL_ASSUNTO")
    private String aulAssunto;
    @Column(name = "AUL_OBSERVACOES")
    private String aulObservacoes;
    @JoinColumn(name = "TB_PROFESSOR_PRO_CODIGO", referencedColumnName = "PRO_CODIGO")
    @ManyToOne(optional = false)
    private TbProfessor tbProfessorProCodigo;
    @JoinColumn(name = "TB_EXERCICIO_EXE_CODIGO", referencedColumnName = "EXE_CODIGO")
    @ManyToOne(optional = false)
    private TbExercicio tbExercicioExeCodigo;
    @JoinColumn(name = "TB_ALUNO_ALU_CODIGO", referencedColumnName = "ALU_CODIGO")
    @ManyToOne(optional = false)
    private TbAluno tbAlunoAluCodigo;
    @Transient
    private Integer tmptbProfessorProCodigo;
    @Transient
    private Integer tmptbExercicioExeCodigo;
    @Transient
    private Integer tmptbAlunoAluCodigo;

    public Integer getTmptbAlunoAluCodigo() {
        return tmptbAlunoAluCodigo;
    }

    public Integer getTmptbExercicioExeCodigo() {
        return tmptbExercicioExeCodigo;
    }

    public Integer getTmptbProfessorProCodigo() {
        return tmptbProfessorProCodigo;
    }

    public void setTmptbAlunoAluCodigo(Integer tmptbAlunoAluCodigo) {
        this.tmptbAlunoAluCodigo = tmptbAlunoAluCodigo;
    }

    public void setTmptbExercicioExeCodigo(Integer tmptbExercicioExeCodigo) {
        this.tmptbExercicioExeCodigo = tmptbExercicioExeCodigo;
    }

    public void setTmptbProfessorProCodigo(Integer tmptbProfessorProCodigo) {
        this.tmptbProfessorProCodigo = tmptbProfessorProCodigo;
    }

    public TbAula() {
    }

    public TbAula(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public TbAula(Integer sequencial, Date aulData, Date aulHorario) {
        this.sequencial = sequencial;
        this.aulData = aulData;
        this.aulHorario = aulHorario;
    }

    public Date getAulData() {
        return aulData;
    }

    public void setAulData(Date aulData) {
        this.aulData = aulData;
    }

    public Date getAulHorario() {
        return aulHorario;
    }

    public void setAulHorario(Date aulHorario) {
        this.aulHorario = aulHorario;
    }

    public Integer getSequencial() {
        return sequencial;
    }

    public void setSequencial(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public String getAulAssunto() {
        return aulAssunto;
    }

    public void setAulAssunto(String aulAssunto) {
        this.aulAssunto = aulAssunto;
    }

    public String getAulObservacoes() {
        return aulObservacoes;
    }

    public void setAulObservacoes(String aulObservacoes) {
        this.aulObservacoes = aulObservacoes;
    }

    public TbProfessor getTbProfessorProCodigo() {
        return tbProfessorProCodigo;
    }

    public void setTbProfessorProCodigo(TbProfessor tbProfessorProCodigo) {
        this.tbProfessorProCodigo = tbProfessorProCodigo;
    }

    public TbExercicio getTbExercicioExeCodigo() {
        return tbExercicioExeCodigo;
    }

    public void setTbExercicioExeCodigo(TbExercicio tbExercicioExeCodigo) {
        this.tbExercicioExeCodigo = tbExercicioExeCodigo;
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
        if (!(object instanceof TbAula)) {
            return false;
        }
        TbAula other = (TbAula) object;
        if ((this.sequencial == null && other.sequencial != null) || (this.sequencial != null && !this.sequencial.equals(other.sequencial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbAula[ sequencial=" + sequencial + " ]";
    }
}
