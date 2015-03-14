
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidade;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "TB_PROFESSOR")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TbProfessor.findAll", query = "SELECT t FROM TbProfessor t WHERE t.proCodigo <> '1' "),
    @NamedQuery(name = "TbProfessor.findValidaProfessor", query = "SELECT t FROM TbProfessor t WHERE t.proUsuario = :proUsuario"),
    @NamedQuery(name = "TbProfessor.findUsuario", query = "SELECT t FROM TbProfessor t where Upper(t.proUsuario ) = Upper( :usuario ) and t.proSenha = :senha"),
    @NamedQuery(name = "TbProfessor.findByProCodigo", query = "SELECT t FROM TbProfessor t WHERE t.proCodigo = :proCodigo"),
    @NamedQuery(name = "TbProfessor.findByProNome", query = "SELECT t FROM TbProfessor t WHERE t.proNome = :proNome"),
    @NamedQuery(name = "TbProfessor.findByProDtnascimento", query = "SELECT t FROM TbProfessor t WHERE t.proDtnascimento = :proDtnascimento"),
    @NamedQuery(name = "TbProfessor.findByProLogradouro", query = "SELECT t FROM TbProfessor t WHERE t.proLogradouro = :proLogradouro"),
    @NamedQuery(name = "TbProfessor.findByProCidade", query = "SELECT t FROM TbProfessor t WHERE t.proCidade = :proCidade"),
    @NamedQuery(name = "TbProfessor.findByProEstado", query = "SELECT t FROM TbProfessor t WHERE t.proEstado = :proEstado"),
    @NamedQuery(name = "TbProfessor.findByProNumero", query = "SELECT t FROM TbProfessor t WHERE t.proNumero = :proNumero"),
    @NamedQuery(name = "TbProfessor.findByProComplemento", query = "SELECT t FROM TbProfessor t WHERE t.proComplemento = :proComplemento"),
    @NamedQuery(name = "TbProfessor.findByProBairro", query = "SELECT t FROM TbProfessor t WHERE t.proBairro = :proBairro"),
    @NamedQuery(name = "TbProfessor.findByProTelefone", query = "SELECT t FROM TbProfessor t WHERE t.proTelefone = :proTelefone"),
    @NamedQuery(name = "TbProfessor.findByProEmail", query = "SELECT t FROM TbProfessor t WHERE t.proEmail = :proEmail"),
    @NamedQuery(name = "TbProfessor.findByProDtmatricula", query = "SELECT t FROM TbProfessor t WHERE t.proDtmatricula = :proDtmatricula"),
    @NamedQuery(name = "TbProfessor.findByProSexo", query = "SELECT t FROM TbProfessor t WHERE t.proSexo = :proSexo"),
    @NamedQuery(name = "TbProfessor.findByProEstadocivil", query = "SELECT t FROM TbProfessor t WHERE t.proEstadocivil = :proEstadocivil"),
    @NamedQuery(name = "TbProfessor.findByProEhgestor", query = "SELECT t FROM TbProfessor t WHERE t.proEhgestor = :proEhgestor"),
    @NamedQuery(name = "TbProfessor.findByProEhmestre", query = "SELECT t FROM TbProfessor t WHERE t.proEhmestre = :proEhmestre")})
public class TbProfessor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "PRO_CODIGO")
    private Integer proCodigo;
    @Column(name = "PRO_NOME")
    private String proNome;
    @Column(name = "PRO_DTNASCIMENTO")
    @Temporal(TemporalType.DATE)
    private Date proDtnascimento;
    @Column(name = "PRO_LOGRADOURO")
    private String proLogradouro;
    @Column(name = "PRO_CIDADE")
    private String proCidade;
    @Column(name = "PRO_ESTADO")
    private String proEstado;
    @Column(name = "PRO_NUMERO")
    private String proNumero;
    @Column(name = "PRO_COMPLEMENTO")
    private String proComplemento;
    @Column(name = "PRO_BAIRRO")
    private String proBairro;
    @Column(name = "PRO_TELEFONE")
    private String proTelefone;
    @Column(name = "PRO_EMAIL")
    private String proEmail;
    @Column(name = "PRO_DTMATRICULA")
    @Temporal(TemporalType.DATE)
    private Date proDtmatricula;
    @Column(name = "PRO_SEXO")
    private String proSexo;
    @Column(name = "PRO_ESTADOCIVIL")
    private String proEstadocivil;
    @Column(name = "PRO_EHGESTOR")
    private String proEhgestor;
    @Column(name = "PRO_FOTO")
    private String proFoto;
    @Column(name = "PRO_USUARIO")
    private String proUsuario;
    @Column(name = "PRO_SENHA")
    private String proSenha;
    @Column(name = "PRO_EHMESTRE")
    private String proEhmestre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbProfessorProCodigo")
    private Collection<TbAula> tbAulaCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tbProfessorProCodigo")
    private Collection<TbExames> tbExamesCollection;

    public TbProfessor() {
    }

    public TbProfessor(Integer proCodigo) {
        this.proCodigo = proCodigo;
    }

    public Integer getProCodigo() {
        return proCodigo;
    }

    public void setProFoto(String proFoto) {
        this.proFoto = proFoto;
    }

    public String getProFoto() {
        return proFoto;
    }

    public void setProCodigo(Integer proCodigo) {
        this.proCodigo = proCodigo;
    }

    public String getProNome() {
        return proNome;
    }

    public void setProNome(String proNome) {
        this.proNome = proNome;
    }

    public Date getProDtnascimento() {
        return proDtnascimento;
    }

    public String getProUsuario() {
        return proUsuario;
    }

    public void setProSenha(String proSenha) {
        this.proSenha = proSenha;
    }

    public String getProSenha() {
        return proSenha;
    }

    public void setProUsuario(String proUsuario) {
        this.proUsuario = proUsuario;
    }

    public void setProDtnascimento(Date proDtnascimento) {
        this.proDtnascimento = proDtnascimento;
    }

    public String getProLogradouro() {
        return proLogradouro;
    }

    public void setProLogradouro(String proLogradouro) {
        this.proLogradouro = proLogradouro;
    }

    public String getProCidade() {
        return proCidade;
    }

    public void setProCidade(String proCidade) {
        this.proCidade = proCidade;
    }

    public String getProEstado() {
        return proEstado;
    }

    public void setProEstado(String proEstado) {
        this.proEstado = proEstado;
    }

    public String getProNumero() {
        return proNumero;
    }

    public void setProNumero(String proNumero) {
        this.proNumero = proNumero;
    }

    public String getProComplemento() {
        return proComplemento;
    }

    public void setProComplemento(String proComplemento) {
        this.proComplemento = proComplemento;
    }

    public String getProBairro() {
        return proBairro;
    }

    public void setProBairro(String proBairro) {
        this.proBairro = proBairro;
    }

    public String getProTelefone() {
        return proTelefone;
    }

    public void setProTelefone(String proTelefone) {
        this.proTelefone = proTelefone;
    }

    public String getProEmail() {
        return proEmail;
    }

    public void setProEmail(String proEmail) {
        this.proEmail = proEmail;
    }

    public Date getProDtmatricula() {
        return proDtmatricula;
    }

    public void setProDtmatricula(Date proDtmatricula) {
        this.proDtmatricula = proDtmatricula;
    }

    public String getProSexo() {
        return proSexo;
    }

    public void setProSexo(String proSexo) {
        this.proSexo = proSexo;
    }

    public String getProEstadocivil() {
        return proEstadocivil;
    }

    public void setProEstadocivil(String proEstadocivil) {
        this.proEstadocivil = proEstadocivil;
    }

    public String getProEhgestor() {
        return proEhgestor;
    }

    public void setProEhgestor(String proEhgestor) {
        this.proEhgestor = proEhgestor;
    }

    public String getProEhmestre() {
        return proEhmestre;
    }

    public void setProEhmestre(String proEhmestre) {
        this.proEhmestre = proEhmestre;
    }

    @XmlTransient
    public Collection<TbAula> getTbAulaCollection() {
        return tbAulaCollection;
    }

    public void setTbAulaCollection(Collection<TbAula> tbAulaCollection) {
        this.tbAulaCollection = tbAulaCollection;
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
        hash += (proCodigo != null ? proCodigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TbProfessor)) {
            return false;
        }
        TbProfessor other = (TbProfessor) object;
        if ((this.proCodigo == null && other.proCodigo != null) || (this.proCodigo != null && !this.proCodigo.equals(other.proCodigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidade.TbProfessor[ proCodigo=" + proCodigo + " ]";
    }
}
