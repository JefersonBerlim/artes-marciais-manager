
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
@Table(name = "TB_GRADUACAO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbGraduacao.findAll", query = "SELECT t FROM TbGraduacao t"),
    @NamedQuery(name = "TbGraduacao.findByGraCodigo", query = "SELECT t FROM TbGraduacao t WHERE t.graCodigo = :graCodigo"),
    @NamedQuery(name = "TbGraduacao.findByGraduacaoPorCurso", query = "SELECT t FROM TbGraduacao t WHERE t.tbCursoCurCodigo.curCodigo = :tbCursoCurCodigo"),
    @NamedQuery(name = "TbGraduacao.findByGraDescricao", query = "SELECT t FROM TbGraduacao t WHERE t.graDescricao = :graDescricao")})
public class TbGraduacao implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "GRA_CODIGO")
    private Integer graCodigo;
    @Column(name = "GRA_DESCRICAO")
    private String graDescricao;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbGraduacaoGraCodigo")
    private Collection<TbExercicio> tbExercicioCollection;
    @JoinColumn(name = "TB_CURSO_CUR_CODIGO", referencedColumnName = "CUR_CODIGO")
    @ManyToOne(optional = false)
    private TbCurso tbCursoCurCodigo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbGraduacaoGraCodigo")
    private Collection<TbExames> tbExamesCollection;
    @Transient
    private Integer tmpCursoCurCodigo;

    public TbGraduacao() {
    }

    public TbGraduacao(Integer graCodigo) {
        this.graCodigo = graCodigo;
    }
    
    public Integer getTmpCursoCurCodigo() {
        return tmpCursoCurCodigo;
    }

    public void setTmpCursoCurCodigo(Integer tmpCursoCurCodigo) {
        this.tmpCursoCurCodigo = tmpCursoCurCodigo;
    }

    public Integer getGraCodigo() {
        return graCodigo;
    }

    public void setGraCodigo(Integer graCodigo) {
        this.graCodigo = graCodigo;
    }

    public String getGraDescricao() {
        return graDescricao;
    }

    public void setGraDescricao(String graDescricao) {
        this.graDescricao = graDescricao;
    }

    @XmlTransient
    public Collection<TbExercicio> getTbExercicioCollection() {
        return tbExercicioCollection;
    }

    public void setTbExercicioCollection(Collection<TbExercicio> tbExercicioCollection) {
        this.tbExercicioCollection = tbExercicioCollection;
    }

    public TbCurso getTbCursoCurCodigo() {
        return tbCursoCurCodigo;
    }

    public void setTbCursoCurCodigo(TbCurso tbCursoCurCodigo) {
        this.tbCursoCurCodigo = tbCursoCurCodigo;
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
        hash += (graCodigo != null ? graCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbGraduacao)) {
            return false;
        }
        TbGraduacao other = (TbGraduacao) object;
        if ((this.graCodigo == null && other.graCodigo != null) || (this.graCodigo != null && !this.graCodigo.equals(other.graCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbGraduacao[ graCodigo=" + graCodigo + " ]";
    }
    
}
