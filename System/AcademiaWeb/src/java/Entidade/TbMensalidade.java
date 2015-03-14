
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Administrador
 */
@Entity
@Table(name = "TB_MENSALIDADE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbMensalidade.findAll", query = "SELECT t FROM TbMensalidade t"),
    @NamedQuery(name = "TbMensalidade.findByMenCodigo", query = "SELECT t FROM TbMensalidade t WHERE t.menCodigo = :menCodigo"),
    @NamedQuery(name = "TbMensalidade.findByMenNome", query = "SELECT t FROM TbMensalidade t WHERE t.menNome = :menNome"),
    @NamedQuery(name = "TbMensalidade.findByMenValor", query = "SELECT t FROM TbMensalidade t WHERE t.menValor = :menValor")})
public class TbMensalidade implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "MEN_CODIGO")
    private Integer menCodigo;
    @Column(name = "MEN_NOME")
    private String menNome;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "MEN_VALOR")
    private Double menValor;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbMensalidadeMenCodigo")
    private Collection<TbAluno> tbAlunoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbMensalidadeMenCodigo")
    private Collection<TbPagamentos> tbPagamentosCollection;

    public TbMensalidade() {
    }

    public TbMensalidade(Integer menCodigo) {
        this.menCodigo = menCodigo;
    }

    public Integer getMenCodigo() {
        return menCodigo;
    }

    public void setMenCodigo(Integer menCodigo) {
        this.menCodigo = menCodigo;
    }

    public String getMenNome() {
        return menNome;
    }

    public void setMenNome(String menNome) {
        this.menNome = menNome;
    }

    public Double getMenValor() {
        return menValor;
    }

    public void setMenValor(Double menValor) {
        this.menValor = menValor;
    }

   
    
    
    @XmlTransient
    public Collection<TbAluno> getTbAlunoCollection() {
        return tbAlunoCollection;
    }

    public void setTbAlunoCollection(Collection<TbAluno> tbAlunoCollection) {
        this.tbAlunoCollection = tbAlunoCollection;
    }

    @XmlTransient
    public Collection<TbPagamentos> getTbPagamentosCollection() {
        return tbPagamentosCollection;
    }

    public void setTbPagamentosCollection(Collection<TbPagamentos> tbPagamentosCollection) {
        this.tbPagamentosCollection = tbPagamentosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (menCodigo != null ? menCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbMensalidade)) {
            return false;
        }
        TbMensalidade other = (TbMensalidade) object;
        if ((this.menCodigo == null && other.menCodigo != null) || (this.menCodigo != null && !this.menCodigo.equals(other.menCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbMensalidade[ menCodigo=" + menCodigo + " ]";
    }
    
}
