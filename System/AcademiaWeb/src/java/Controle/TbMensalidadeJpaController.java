/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.IllegalOrphanException;
import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.TbAluno;
import Entidade.TbMensalidade;
import Entidade.TbPagamentos;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author Administrador
 */
public class TbMensalidadeJpaController implements Serializable {

    public TbMensalidadeJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbMensalidade tbMensalidade) throws PreexistingEntityException, Exception {
        if (tbMensalidade.getTbAlunoCollection() == null) {
            tbMensalidade.setTbAlunoCollection(new ArrayList<TbAluno>());
        }
        if (tbMensalidade.getTbPagamentosCollection() == null) {
            tbMensalidade.setTbPagamentosCollection(new ArrayList<TbPagamentos>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Collection<TbAluno> attachedTbAlunoCollection = new ArrayList<TbAluno>();
            for (TbAluno tbAlunoCollectionTbAlunoToAttach : tbMensalidade.getTbAlunoCollection()) {
                tbAlunoCollectionTbAlunoToAttach = em.getReference(tbAlunoCollectionTbAlunoToAttach.getClass(), tbAlunoCollectionTbAlunoToAttach.getAluCodigo());
                attachedTbAlunoCollection.add(tbAlunoCollectionTbAlunoToAttach);
            }
            tbMensalidade.setTbAlunoCollection(attachedTbAlunoCollection);
            Collection<TbPagamentos> attachedTbPagamentosCollection = new ArrayList<TbPagamentos>();
            for (TbPagamentos tbPagamentosCollectionTbPagamentosToAttach : tbMensalidade.getTbPagamentosCollection()) {
                tbPagamentosCollectionTbPagamentosToAttach = em.getReference(tbPagamentosCollectionTbPagamentosToAttach.getClass(), tbPagamentosCollectionTbPagamentosToAttach.getSequencial());
                attachedTbPagamentosCollection.add(tbPagamentosCollectionTbPagamentosToAttach);
            }
            tbMensalidade.setTbPagamentosCollection(attachedTbPagamentosCollection);
            if (tbMensalidade.getMenCodigo() == null) {
                em.persist(tbMensalidade);
            } else {
                em.merge(tbMensalidade);
            }
            for (TbAluno tbAlunoCollectionTbAluno : tbMensalidade.getTbAlunoCollection()) {
                TbMensalidade oldTbMensalidadeMenCodigoOfTbAlunoCollectionTbAluno = tbAlunoCollectionTbAluno.getTbMensalidadeMenCodigo();
                tbAlunoCollectionTbAluno.setTbMensalidadeMenCodigo(tbMensalidade);
                tbAlunoCollectionTbAluno = em.merge(tbAlunoCollectionTbAluno);
                if (oldTbMensalidadeMenCodigoOfTbAlunoCollectionTbAluno != null) {
                    oldTbMensalidadeMenCodigoOfTbAlunoCollectionTbAluno.getTbAlunoCollection().remove(tbAlunoCollectionTbAluno);
                    oldTbMensalidadeMenCodigoOfTbAlunoCollectionTbAluno = em.merge(oldTbMensalidadeMenCodigoOfTbAlunoCollectionTbAluno);
                }
            }
            for (TbPagamentos tbPagamentosCollectionTbPagamentos : tbMensalidade.getTbPagamentosCollection()) {
                TbMensalidade oldTbMensalidadeMenCodigoOfTbPagamentosCollectionTbPagamentos = tbPagamentosCollectionTbPagamentos.getTbMensalidadeMenCodigo();
                tbPagamentosCollectionTbPagamentos.setTbMensalidadeMenCodigo(tbMensalidade);
                tbPagamentosCollectionTbPagamentos = em.merge(tbPagamentosCollectionTbPagamentos);
                if (oldTbMensalidadeMenCodigoOfTbPagamentosCollectionTbPagamentos != null) {
                    oldTbMensalidadeMenCodigoOfTbPagamentosCollectionTbPagamentos.getTbPagamentosCollection().remove(tbPagamentosCollectionTbPagamentos);
                    oldTbMensalidadeMenCodigoOfTbPagamentosCollectionTbPagamentos = em.merge(oldTbMensalidadeMenCodigoOfTbPagamentosCollectionTbPagamentos);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findTbMensalidade(tbMensalidade.getMenCodigo()) != null) {
                throw new PreexistingEntityException("TbMensalidade " + tbMensalidade + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TbMensalidade tbMensalidade) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbMensalidade persistentTbMensalidade = em.find(TbMensalidade.class, tbMensalidade.getMenCodigo());
            Collection<TbAluno> tbAlunoCollectionOld = persistentTbMensalidade.getTbAlunoCollection();
            Collection<TbAluno> tbAlunoCollectionNew = tbMensalidade.getTbAlunoCollection();
            Collection<TbPagamentos> tbPagamentosCollectionOld = persistentTbMensalidade.getTbPagamentosCollection();
            Collection<TbPagamentos> tbPagamentosCollectionNew = tbMensalidade.getTbPagamentosCollection();
            List<String> illegalOrphanMessages = null;
            for (TbAluno tbAlunoCollectionOldTbAluno : tbAlunoCollectionOld) {
                if (!tbAlunoCollectionNew.contains(tbAlunoCollectionOldTbAluno)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbAluno " + tbAlunoCollectionOldTbAluno + " since its tbMensalidadeMenCodigo field is not nullable.");
                }
            }
            for (TbPagamentos tbPagamentosCollectionOldTbPagamentos : tbPagamentosCollectionOld) {
                if (!tbPagamentosCollectionNew.contains(tbPagamentosCollectionOldTbPagamentos)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbPagamentos " + tbPagamentosCollectionOldTbPagamentos + " since its tbMensalidadeMenCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<TbAluno> attachedTbAlunoCollectionNew = new ArrayList<TbAluno>();
            for (TbAluno tbAlunoCollectionNewTbAlunoToAttach : tbAlunoCollectionNew) {
                tbAlunoCollectionNewTbAlunoToAttach = em.getReference(tbAlunoCollectionNewTbAlunoToAttach.getClass(), tbAlunoCollectionNewTbAlunoToAttach.getAluCodigo());
                attachedTbAlunoCollectionNew.add(tbAlunoCollectionNewTbAlunoToAttach);
            }
            tbAlunoCollectionNew = attachedTbAlunoCollectionNew;
            tbMensalidade.setTbAlunoCollection(tbAlunoCollectionNew);
            Collection<TbPagamentos> attachedTbPagamentosCollectionNew = new ArrayList<TbPagamentos>();
            for (TbPagamentos tbPagamentosCollectionNewTbPagamentosToAttach : tbPagamentosCollectionNew) {
                tbPagamentosCollectionNewTbPagamentosToAttach = em.getReference(tbPagamentosCollectionNewTbPagamentosToAttach.getClass(), tbPagamentosCollectionNewTbPagamentosToAttach.getSequencial());
                attachedTbPagamentosCollectionNew.add(tbPagamentosCollectionNewTbPagamentosToAttach);
            }
            tbPagamentosCollectionNew = attachedTbPagamentosCollectionNew;
            tbMensalidade.setTbPagamentosCollection(tbPagamentosCollectionNew);
            tbMensalidade = em.merge(tbMensalidade);
            for (TbAluno tbAlunoCollectionNewTbAluno : tbAlunoCollectionNew) {
                if (!tbAlunoCollectionOld.contains(tbAlunoCollectionNewTbAluno)) {
                    TbMensalidade oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno = tbAlunoCollectionNewTbAluno.getTbMensalidadeMenCodigo();
                    tbAlunoCollectionNewTbAluno.setTbMensalidadeMenCodigo(tbMensalidade);
                    tbAlunoCollectionNewTbAluno = em.merge(tbAlunoCollectionNewTbAluno);
                    if (oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno != null && !oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno.equals(tbMensalidade)) {
                        oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno.getTbAlunoCollection().remove(tbAlunoCollectionNewTbAluno);
                        oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno = em.merge(oldTbMensalidadeMenCodigoOfTbAlunoCollectionNewTbAluno);
                    }
                }
            }
            for (TbPagamentos tbPagamentosCollectionNewTbPagamentos : tbPagamentosCollectionNew) {
                if (!tbPagamentosCollectionOld.contains(tbPagamentosCollectionNewTbPagamentos)) {
                    TbMensalidade oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos = tbPagamentosCollectionNewTbPagamentos.getTbMensalidadeMenCodigo();
                    tbPagamentosCollectionNewTbPagamentos.setTbMensalidadeMenCodigo(tbMensalidade);
                    tbPagamentosCollectionNewTbPagamentos = em.merge(tbPagamentosCollectionNewTbPagamentos);
                    if (oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos != null && !oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos.equals(tbMensalidade)) {
                        oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos.getTbPagamentosCollection().remove(tbPagamentosCollectionNewTbPagamentos);
                        oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos = em.merge(oldTbMensalidadeMenCodigoOfTbPagamentosCollectionNewTbPagamentos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbMensalidade.getMenCodigo();
                if (findTbMensalidade(id) == null) {
                    throw new NonexistentEntityException("The tbMensalidade with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbMensalidade tbMensalidade;
            try {
                tbMensalidade = em.getReference(TbMensalidade.class, id);
                tbMensalidade.getMenCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbMensalidade with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<TbAluno> tbAlunoCollectionOrphanCheck = tbMensalidade.getTbAlunoCollection();
            for (TbAluno tbAlunoCollectionOrphanCheckTbAluno : tbAlunoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbMensalidade (" + tbMensalidade + ") cannot be destroyed since the TbAluno " + tbAlunoCollectionOrphanCheckTbAluno + " in its tbAlunoCollection field has a non-nullable tbMensalidadeMenCodigo field.");
            }
            Collection<TbPagamentos> tbPagamentosCollectionOrphanCheck = tbMensalidade.getTbPagamentosCollection();
            for (TbPagamentos tbPagamentosCollectionOrphanCheckTbPagamentos : tbPagamentosCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbMensalidade (" + tbMensalidade + ") cannot be destroyed since the TbPagamentos " + tbPagamentosCollectionOrphanCheckTbPagamentos + " in its tbPagamentosCollection field has a non-nullable tbMensalidadeMenCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tbMensalidade);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbMensalidade> findTbMensalidadeAll() {
        EntityManager em = getEntityManager();
        Query mensalidade = em.createNamedQuery("TbMensalidade.findAll");
        return mensalidade.getResultList();
    }

    public TbMensalidade findTbMensalidade(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbMensalidade.class, id);
        } finally {
            em.close();
        }
    }

}
