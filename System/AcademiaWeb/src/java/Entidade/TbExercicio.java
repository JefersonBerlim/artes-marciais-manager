
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Administrador
 */
@Entity
@Table(name = "TB_EXERCICIO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbExercicio.findAll", query = "SELECT t FROM TbExercicio t"),
    @NamedQuery(name = "TbExercicio.findByExeCodigo", query = "SELECT t FROM TbExercicio t WHERE t.exeCodigo = :exeCodigo"),
    @NamedQuery(name = "TbExercicio.findByExeTbGraduacao", query = "SELECT t FROM TbExercicio t WHERE t.tbGraduacaoGraCodigo = :graCodigo"),
    @NamedQuery(name = "TbExercicio.findByExeDescricao", query = "SELECT t FROM TbExercicio t WHERE t.exeDescricao = :exeDescricao")})
public class TbExercicio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "EXE_CODIGO")
    private Integer exeCodigo;
    @Column(name = "EXE_DESCRICAO")
    private String exeDescricao;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbExercicioExeCodigo")
    private Collection<TbAula> tbAulaCollection;
    @JoinColumn(name = "TB_GRADUACAO_GRA_CODIGO", referencedColumnName = "GRA_CODIGO")
    @ManyToOne(optional = false)
    private TbGraduacao tbGraduacaoGraCodigo;
    @Transient
    private Integer tmptbGraduacaoGraCodigo;

    public TbExercicio() {
    }

    public Integer getTmptbGraduacaoGraCodigo() {
        return tmptbGraduacaoGraCodigo;
    }

    public void setTmptbGraduacaoGraCodigo(Integer tmptbGraduacaoGraCodigo) {
        this.tmptbGraduacaoGraCodigo = tmptbGraduacaoGraCodigo;
    }

    public TbExercicio(Integer exeCodigo) {
        this.exeCodigo = exeCodigo;
    }

    public Integer getExeCodigo() {
        return exeCodigo;
    }

    public void setExeCodigo(Integer exeCodigo) {
        this.exeCodigo = exeCodigo;
    }

    public String getExeDescricao() {
        return exeDescricao;
    }

    public void setExeDescricao(String exeDescricao) {
        this.exeDescricao = exeDescricao;
    }

    @XmlTransient
    public Collection<TbAula> getTbAulaCollection() {
        return tbAulaCollection;
    }

    public void setTbAulaCollection(Collection<TbAula> tbAulaCollection) {
        this.tbAulaCollection = tbAulaCollection;
    }

    public TbGraduacao getTbGraduacaoGraCodigo() {
        return tbGraduacaoGraCodigo;
    }

    public void setTbGraduacaoGraCodigo(TbGraduacao tbGraduacaoGraCodigo) {
        this.tbGraduacaoGraCodigo = tbGraduacaoGraCodigo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (exeCodigo != null ? exeCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbExercicio)) {
            return false;
        }
        TbExercicio other = (TbExercicio) object;
        if ((this.exeCodigo == null && other.exeCodigo != null) || (this.exeCodigo != null && !this.exeCodigo.equals(other.exeCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbExercicio[ exeCodigo=" + exeCodigo + " ]";
    }
}
