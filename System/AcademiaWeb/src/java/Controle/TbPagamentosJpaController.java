/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.TbAluno;
import Entidade.TbMensalidade;
import Entidade.TbPagamentos;
import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author Administrador
 */
public class TbPagamentosJpaController implements Serializable {

    public TbPagamentosJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbPagamentos tbPagamentos) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbMensalidade tbMensalidadeMenCodigo = tbPagamentos.getTbMensalidadeMenCodigo();
            if (tbMensalidadeMenCodigo != null) {
                tbMensalidadeMenCodigo = em.getReference(tbMensalidadeMenCodigo.getClass(), tbMensalidadeMenCodigo.getMenCodigo());
                tbPagamentos.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigo);
            } else {
                tbMensalidadeMenCodigo = em.getReference(TbMensalidade.class, tbPagamentos.getTmptbMensalidadeMenCodigo());
                tbPagamentos.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigo);
            }
            TbAluno tbAlunoAluCodigo = tbPagamentos.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo = em.getReference(tbAlunoAluCodigo.getClass(), tbAlunoAluCodigo.getAluCodigo());
                tbPagamentos.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            } else {
                tbAlunoAluCodigo = em.getReference(TbAluno.class, tbPagamentos.getTmptbAlunoAluCodigo());
                tbPagamentos.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            }
            if (tbPagamentos.getSequencial() == null) {
                em.persist(tbPagamentos);
            } else {
                em.merge(tbPagamentos);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {

            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TbPagamentos tbPagamentos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbPagamentos persistentTbPagamentos = em.find(TbPagamentos.class, tbPagamentos.getSequencial());
            TbMensalidade tbMensalidadeMenCodigoOld = persistentTbPagamentos.getTbMensalidadeMenCodigo();
            TbMensalidade tbMensalidadeMenCodigoNew = tbPagamentos.getTbMensalidadeMenCodigo();
            TbAluno tbAlunoAluCodigoOld = persistentTbPagamentos.getTbAlunoAluCodigo();
            TbAluno tbAlunoAluCodigoNew = tbPagamentos.getTbAlunoAluCodigo();
            if (tbMensalidadeMenCodigoNew != null) {
                tbMensalidadeMenCodigoNew = em.getReference(tbMensalidadeMenCodigoNew.getClass(), tbMensalidadeMenCodigoNew.getMenCodigo());
                tbPagamentos.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigoNew);
            }
            if (tbAlunoAluCodigoNew != null) {
                tbAlunoAluCodigoNew = em.getReference(tbAlunoAluCodigoNew.getClass(), tbAlunoAluCodigoNew.getAluCodigo());
                tbPagamentos.setTbAlunoAluCodigo(tbAlunoAluCodigoNew);
            }
            tbPagamentos = em.merge(tbPagamentos);
            if (tbMensalidadeMenCodigoOld != null && !tbMensalidadeMenCodigoOld.equals(tbMensalidadeMenCodigoNew)) {
                tbMensalidadeMenCodigoOld.getTbPagamentosCollection().remove(tbPagamentos);
                tbMensalidadeMenCodigoOld = em.merge(tbMensalidadeMenCodigoOld);
            }
            if (tbMensalidadeMenCodigoNew != null && !tbMensalidadeMenCodigoNew.equals(tbMensalidadeMenCodigoOld)) {
                tbMensalidadeMenCodigoNew.getTbPagamentosCollection().add(tbPagamentos);
                tbMensalidadeMenCodigoNew = em.merge(tbMensalidadeMenCodigoNew);
            }
            if (tbAlunoAluCodigoOld != null && !tbAlunoAluCodigoOld.equals(tbAlunoAluCodigoNew)) {
                tbAlunoAluCodigoOld.getTbPagamentosCollection().remove(tbPagamentos);
                tbAlunoAluCodigoOld = em.merge(tbAlunoAluCodigoOld);
            }
            if (tbAlunoAluCodigoNew != null && !tbAlunoAluCodigoNew.equals(tbAlunoAluCodigoOld)) {
                tbAlunoAluCodigoNew.getTbPagamentosCollection().add(tbPagamentos);
                tbAlunoAluCodigoNew = em.merge(tbAlunoAluCodigoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbPagamentos.getSequencial();
                if (findTbPagamentos(id) == null) {
                    throw new NonexistentEntityException("The tbPagamentos with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbPagamentos tbPagamentos;
            try {
                tbPagamentos = em.getReference(TbPagamentos.class, id);
                tbPagamentos.getSequencial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbPagamentos with id " + id + " no longer exists.", enfe);
            }
            TbMensalidade tbMensalidadeMenCodigo = tbPagamentos.getTbMensalidadeMenCodigo();
            if (tbMensalidadeMenCodigo != null) {
                tbMensalidadeMenCodigo.getTbPagamentosCollection().remove(tbPagamentos);
                tbMensalidadeMenCodigo = em.merge(tbMensalidadeMenCodigo);
            }
            TbAluno tbAlunoAluCodigo = tbPagamentos.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo.getTbPagamentosCollection().remove(tbPagamentos);
                tbAlunoAluCodigo = em.merge(tbAlunoAluCodigo);
            }
            em.remove(tbPagamentos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbPagamentos> findTbExercicioAll() {
        EntityManager em = getEntityManager();
        Query pagamentos = em.createNamedQuery("TbPagamentos.findAll");
        return pagamentos.getResultList();
    }

    public TbPagamentos findTbPagamentos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbPagamentos.class, id);
        } finally {
            em.close();
        }
    }

}
