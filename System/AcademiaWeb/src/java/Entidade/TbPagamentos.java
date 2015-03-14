
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
@Table(name = "TB_PAGAMENTOS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbPagamentos.findAll", query = "SELECT t FROM TbPagamentos t"), 
    @NamedQuery(name = "TbPagamentos.findBySequencial", query = "SELECT t FROM TbPagamentos t WHERE t.sequencial = :sequencial"),
    @NamedQuery(name = "TbPagamentos.findByPagDtpagamento", query = "SELECT t FROM TbPagamentos t WHERE t.pagDtpagamento = :pagDtpagamento"),
    @NamedQuery(name = "TbPagamentos.findByPagValorpago", query = "SELECT t FROM TbPagamentos t WHERE t.pagValorpago = :pagValorpago"),
    @NamedQuery(name = "TbPagamentos.findByPagValorapagar", query = "SELECT t FROM TbPagamentos t WHERE t.pagValorapagar = :pagValorapagar")})
public class TbPagamentos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "SEQUENCIAL")
    private Integer sequencial;
    @Column(name = "PAG_DTPAGAMENTO")
    @Temporal(TemporalType.DATE)
    private Date pagDtpagamento;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "PAG_VALORPAGO")
    private Double pagValorpago;
    @Column(name = "PAG_VALORAPAGAR")
    private Double pagValorapagar;
    @JoinColumn(name = "TB_MENSALIDADE_MEN_CODIGO", referencedColumnName = "MEN_CODIGO")
    @ManyToOne(optional = false)
    private TbMensalidade tbMensalidadeMenCodigo;
    @JoinColumn(name = "TB_ALUNO_ALU_CODIGO", referencedColumnName = "ALU_CODIGO")
    @ManyToOne(optional = false)
    private TbAluno tbAlunoAluCodigo;
    @Transient
    private Integer tmptbAlunoAluCodigo;
    @Transient
    private Integer tmptbMensalidadeMenCodigo;

    public Integer getTmptbAlunoAluCodigo() {
        return tmptbAlunoAluCodigo;
    }

    public void setTmptbMensalidadeMenCodigo(Integer tmptbMensalidadeMenCodigo) {
        this.tmptbMensalidadeMenCodigo = tmptbMensalidadeMenCodigo;
    }

    public Integer getTmptbMensalidadeMenCodigo() {
        return tmptbMensalidadeMenCodigo;
    }

    public TbPagamentos() {
    }

    public void setTmptbAlunoAluCodigo(Integer tmptbAlunoAluCodigo) {
        this.tmptbAlunoAluCodigo = tmptbAlunoAluCodigo;
    }

    public TbPagamentos(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public Integer getSequencial() {
        return sequencial;
    }

    public void setSequencial(Integer sequencial) {
        this.sequencial = sequencial;
    }

    public Date getPagDtpagamento() {
        return pagDtpagamento;
    }

    public void setPagDtpagamento(Date pagDtpagamento) {
        this.pagDtpagamento = pagDtpagamento;
    }

    public Double getPagValorpago() {
        return pagValorpago;
    }

    public void setPagValorpago(Double pagValorpago) {
        this.pagValorpago = pagValorpago;
    }

    public Double getPagValorapagar() {
        return pagValorapagar;
    }

    public void setPagValorapagar(Double pagValorapagar) {
        this.pagValorapagar = pagValorapagar;
    }

    public TbMensalidade getTbMensalidadeMenCodigo() {
        return tbMensalidadeMenCodigo;
    }

    public void setTbMensalidadeMenCodigo(TbMensalidade tbMensalidadeMenCodigo) {
        this.tbMensalidadeMenCodigo = tbMensalidadeMenCodigo;
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
        if (!(object instanceof TbPagamentos)) {
            return false;
        }
        TbPagamentos other = (TbPagamentos) object;
        if ((this.sequencial == null && other.sequencial != null) || (this.sequencial != null && !this.sequencial.equals(other.sequencial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbPagamentos[ sequencial=" + sequencial + " ]";
    }
}
