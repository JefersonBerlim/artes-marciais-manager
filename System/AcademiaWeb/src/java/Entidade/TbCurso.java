
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
@Table(name = "TB_CURSO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbCurso.findAll", query = "SELECT t FROM TbCurso t"),
    @NamedQuery(name = "TbCurso.findByCurCodigo", query = "SELECT t FROM TbCurso t WHERE t.curCodigo = :curCodigo"),
    @NamedQuery(name = "TbCurso.findByCurDescricao", query = "SELECT t FROM TbCurso t WHERE t.curDescricao = :curDescricao")})
public class TbCurso implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "CUR_CODIGO")
    private Integer curCodigo;
    @Column(name = "CUR_DESCRICAO")
    private String curDescricao;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbCursoCurCodigo")
    private Collection<TbGraduacao> tbGraduacaoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbCursoCurCodigo")
    private Collection<TbAluno> tbAlunoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbCursoCurCodigo")
    private Collection<TbExames> tbExamesCollection;

    public TbCurso() {
    }

    public TbCurso(Integer curCodigo) {
        this.curCodigo = curCodigo;
    }

    public Integer getCurCodigo() {
        return curCodigo;
    }

    public void setCurCodigo(Integer curCodigo) {
        this.curCodigo = curCodigo;
    }

    public String getCurDescricao() {
        return curDescricao;
    }

    public void setCurDescricao(String curDescricao) {
        this.curDescricao = curDescricao;
    }

    @XmlTransient
    public Collection<TbGraduacao> getTbGraduacaoCollection() {
        return tbGraduacaoCollection;
    }

    public void setTbGraduacaoCollection(Collection<TbGraduacao> tbGraduacaoCollection) {
        this.tbGraduacaoCollection = tbGraduacaoCollection;
    }

    @XmlTransient
    public Collection<TbAluno> getTbAlunoCollection() {
        return tbAlunoCollection;
    }

    public void setTbAlunoCollection(Collection<TbAluno> tbAlunoCollection) {
        this.tbAlunoCollection = tbAlunoCollection;
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
        hash += (curCodigo != null ? curCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbCurso)) {
            return false;
        }
        TbCurso other = (TbCurso) object;
        if ((this.curCodigo == null && other.curCodigo != null) || (this.curCodigo != null && !this.curCodigo.equals(other.curCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbCurso[ curCodigo=" + curCodigo + " ]";
    }
    
}
