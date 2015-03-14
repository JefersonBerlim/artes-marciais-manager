/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.IllegalOrphanException;
import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.TbAluno;
import Entidade.TbCurso;
import Entidade.TbExames;
import Entidade.TbGraduacao;
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
public class TbCursoJpaController implements Serializable {

    public TbCursoJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbCurso tbCurso) throws PreexistingEntityException, Exception {
        if (tbCurso.getTbGraduacaoCollection() == null) {
            tbCurso.setTbGraduacaoCollection(new ArrayList<TbGraduacao>());
        }
        if (tbCurso.getTbAlunoCollection() == null) {
            tbCurso.setTbAlunoCollection(new ArrayList<TbAluno>());
        }
        if (tbCurso.getTbExamesCollection() == null) {
            tbCurso.setTbExamesCollection(new ArrayList<TbExames>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Collection<TbGraduacao> attachedTbGraduacaoCollection = new ArrayList<TbGraduacao>();
            for (TbGraduacao tbGraduacaoCollectionTbGraduacaoToAttach : tbCurso.getTbGraduacaoCollection()) {
                tbGraduacaoCollectionTbGraduacaoToAttach = em.getReference(tbGraduacaoCollectionTbGraduacaoToAttach.getClass(), tbGraduacaoCollectionTbGraduacaoToAttach.getGraCodigo());
                attachedTbGraduacaoCollection.add(tbGraduacaoCollectionTbGraduacaoToAttach);
            }
            tbCurso.setTbGraduacaoCollection(attachedTbGraduacaoCollection);
            Collection<TbAluno> attachedTbAlunoCollection = new ArrayList<TbAluno>();
            for (TbAluno tbAlunoCollectionTbAlunoToAttach : tbCurso.getTbAlunoCollection()) {
                tbAlunoCollectionTbAlunoToAttach = em.getReference(tbAlunoCollectionTbAlunoToAttach.getClass(), tbAlunoCollectionTbAlunoToAttach.getAluCodigo());
                attachedTbAlunoCollection.add(tbAlunoCollectionTbAlunoToAttach);
            }
            tbCurso.setTbAlunoCollection(attachedTbAlunoCollection);
            Collection<TbExames> attachedTbExamesCollection = new ArrayList<TbExames>();
            for (TbExames tbExamesCollectionTbExamesToAttach : tbCurso.getTbExamesCollection()) {
                tbExamesCollectionTbExamesToAttach = em.getReference(tbExamesCollectionTbExamesToAttach.getClass(), tbExamesCollectionTbExamesToAttach.getSequencial());
                attachedTbExamesCollection.add(tbExamesCollectionTbExamesToAttach);
            }
            tbCurso.setTbExamesCollection(attachedTbExamesCollection);
            if (tbCurso.getCurCodigo() == null) {
                em.persist(tbCurso);
            } else {
                em.merge(tbCurso);
            }
            for (TbGraduacao tbGraduacaoCollectionTbGraduacao : tbCurso.getTbGraduacaoCollection()) {
                TbCurso oldTbCursoCurCodigoOfTbGraduacaoCollectionTbGraduacao = tbGraduacaoCollectionTbGraduacao.getTbCursoCurCodigo();
                tbGraduacaoCollectionTbGraduacao.setTbCursoCurCodigo(tbCurso);
                tbGraduacaoCollectionTbGraduacao = em.merge(tbGraduacaoCollectionTbGraduacao);
                if (oldTbCursoCurCodigoOfTbGraduacaoCollectionTbGraduacao != null) {
                    oldTbCursoCurCodigoOfTbGraduacaoCollectionTbGraduacao.getTbGraduacaoCollection().remove(tbGraduacaoCollectionTbGraduacao);
                    oldTbCursoCurCodigoOfTbGraduacaoCollectionTbGraduacao = em.merge(oldTbCursoCurCodigoOfTbGraduacaoCollectionTbGraduacao);
                }
            }
            for (TbAluno tbAlunoCollectionTbAluno : tbCurso.getTbAlunoCollection()) {
                TbCurso oldTbCursoCurCodigoOfTbAlunoCollectionTbAluno = tbAlunoCollectionTbAluno.getTbCursoCurCodigo();
                tbAlunoCollectionTbAluno.setTbCursoCurCodigo(tbCurso);
                tbAlunoCollectionTbAluno = em.merge(tbAlunoCollectionTbAluno);
                if (oldTbCursoCurCodigoOfTbAlunoCollectionTbAluno != null) {
                    oldTbCursoCurCodigoOfTbAlunoCollectionTbAluno.getTbAlunoCollection().remove(tbAlunoCollectionTbAluno);
                    oldTbCursoCurCodigoOfTbAlunoCollectionTbAluno = em.merge(oldTbCursoCurCodigoOfTbAlunoCollectionTbAluno);
                }
            }
            for (TbExames tbExamesCollectionTbExames : tbCurso.getTbExamesCollection()) {
                TbCurso oldTbCursoCurCodigoOfTbExamesCollectionTbExames = tbExamesCollectionTbExames.getTbCursoCurCodigo();
                tbExamesCollectionTbExames.setTbCursoCurCodigo(tbCurso);
                tbExamesCollectionTbExames = em.merge(tbExamesCollectionTbExames);
                if (oldTbCursoCurCodigoOfTbExamesCollectionTbExames != null) {
                    oldTbCursoCurCodigoOfTbExamesCollectionTbExames.getTbExamesCollection().remove(tbExamesCollectionTbExames);
                    oldTbCursoCurCodigoOfTbExamesCollectionTbExames = em.merge(oldTbCursoCurCodigoOfTbExamesCollectionTbExames);
                }
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

    public void edit(TbCurso tbCurso) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbCurso persistentTbCurso = em.find(TbCurso.class, tbCurso.getCurCodigo());
            Collection<TbGraduacao> tbGraduacaoCollectionOld = persistentTbCurso.getTbGraduacaoCollection();
            Collection<TbGraduacao> tbGraduacaoCollectionNew = tbCurso.getTbGraduacaoCollection();
            Collection<TbAluno> tbAlunoCollectionOld = persistentTbCurso.getTbAlunoCollection();
            Collection<TbAluno> tbAlunoCollectionNew = tbCurso.getTbAlunoCollection();
            Collection<TbExames> tbExamesCollectionOld = persistentTbCurso.getTbExamesCollection();
            Collection<TbExames> tbExamesCollectionNew = tbCurso.getTbExamesCollection();
            List<String> illegalOrphanMessages = null;
            for (TbGraduacao tbGraduacaoCollectionOldTbGraduacao : tbGraduacaoCollectionOld) {
                if (!tbGraduacaoCollectionNew.contains(tbGraduacaoCollectionOldTbGraduacao)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbGraduacao " + tbGraduacaoCollectionOldTbGraduacao + " since its tbCursoCurCodigo field is not nullable.");
                }
            }
            for (TbAluno tbAlunoCollectionOldTbAluno : tbAlunoCollectionOld) {
                if (!tbAlunoCollectionNew.contains(tbAlunoCollectionOldTbAluno)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbAluno " + tbAlunoCollectionOldTbAluno + " since its tbCursoCurCodigo field is not nullable.");
                }
            }
            for (TbExames tbExamesCollectionOldTbExames : tbExamesCollectionOld) {
                if (!tbExamesCollectionNew.contains(tbExamesCollectionOldTbExames)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbExames " + tbExamesCollectionOldTbExames + " since its tbCursoCurCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<TbGraduacao> attachedTbGraduacaoCollectionNew = new ArrayList<TbGraduacao>();
            for (TbGraduacao tbGraduacaoCollectionNewTbGraduacaoToAttach : tbGraduacaoCollectionNew) {
                tbGraduacaoCollectionNewTbGraduacaoToAttach = em.getReference(tbGraduacaoCollectionNewTbGraduacaoToAttach.getClass(), tbGraduacaoCollectionNewTbGraduacaoToAttach.getGraCodigo());
                attachedTbGraduacaoCollectionNew.add(tbGraduacaoCollectionNewTbGraduacaoToAttach);
            }
            tbGraduacaoCollectionNew = attachedTbGraduacaoCollectionNew;
            tbCurso.setTbGraduacaoCollection(tbGraduacaoCollectionNew);
            Collection<TbAluno> attachedTbAlunoCollectionNew = new ArrayList<TbAluno>();
            for (TbAluno tbAlunoCollectionNewTbAlunoToAttach : tbAlunoCollectionNew) {
                tbAlunoCollectionNewTbAlunoToAttach = em.getReference(tbAlunoCollectionNewTbAlunoToAttach.getClass(), tbAlunoCollectionNewTbAlunoToAttach.getAluCodigo());
                attachedTbAlunoCollectionNew.add(tbAlunoCollectionNewTbAlunoToAttach);
            }
            tbAlunoCollectionNew = attachedTbAlunoCollectionNew;
            tbCurso.setTbAlunoCollection(tbAlunoCollectionNew);
            Collection<TbExames> attachedTbExamesCollectionNew = new ArrayList<TbExames>();
            for (TbExames tbExamesCollectionNewTbExamesToAttach : tbExamesCollectionNew) {
                tbExamesCollectionNewTbExamesToAttach = em.getReference(tbExamesCollectionNewTbExamesToAttach.getClass(), tbExamesCollectionNewTbExamesToAttach.getSequencial());
                attachedTbExamesCollectionNew.add(tbExamesCollectionNewTbExamesToAttach);
            }
            tbExamesCollectionNew = attachedTbExamesCollectionNew;
            tbCurso.setTbExamesCollection(tbExamesCollectionNew);
            tbCurso = em.merge(tbCurso);
            for (TbGraduacao tbGraduacaoCollectionNewTbGraduacao : tbGraduacaoCollectionNew) {
                if (!tbGraduacaoCollectionOld.contains(tbGraduacaoCollectionNewTbGraduacao)) {
                    TbCurso oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao = tbGraduacaoCollectionNewTbGraduacao.getTbCursoCurCodigo();
                    tbGraduacaoCollectionNewTbGraduacao.setTbCursoCurCodigo(tbCurso);
                    tbGraduacaoCollectionNewTbGraduacao = em.merge(tbGraduacaoCollectionNewTbGraduacao);
                    if (oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao != null && !oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao.equals(tbCurso)) {
                        oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao.getTbGraduacaoCollection().remove(tbGraduacaoCollectionNewTbGraduacao);
                        oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao = em.merge(oldTbCursoCurCodigoOfTbGraduacaoCollectionNewTbGraduacao);
                    }
                }
            }
            for (TbAluno tbAlunoCollectionNewTbAluno : tbAlunoCollectionNew) {
                if (!tbAlunoCollectionOld.contains(tbAlunoCollectionNewTbAluno)) {
                    TbCurso oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno = tbAlunoCollectionNewTbAluno.getTbCursoCurCodigo();
                    tbAlunoCollectionNewTbAluno.setTbCursoCurCodigo(tbCurso);
                    tbAlunoCollectionNewTbAluno = em.merge(tbAlunoCollectionNewTbAluno);
                    if (oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno != null && !oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno.equals(tbCurso)) {
                        oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno.getTbAlunoCollection().remove(tbAlunoCollectionNewTbAluno);
                        oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno = em.merge(oldTbCursoCurCodigoOfTbAlunoCollectionNewTbAluno);
                    }
                }
            }
            for (TbExames tbExamesCollectionNewTbExames : tbExamesCollectionNew) {
                if (!tbExamesCollectionOld.contains(tbExamesCollectionNewTbExames)) {
                    TbCurso oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames = tbExamesCollectionNewTbExames.getTbCursoCurCodigo();
                    tbExamesCollectionNewTbExames.setTbCursoCurCodigo(tbCurso);
                    tbExamesCollectionNewTbExames = em.merge(tbExamesCollectionNewTbExames);
                    if (oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames != null && !oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames.equals(tbCurso)) {
                        oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames.getTbExamesCollection().remove(tbExamesCollectionNewTbExames);
                        oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames = em.merge(oldTbCursoCurCodigoOfTbExamesCollectionNewTbExames);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbCurso.getCurCodigo();
                if (findTbCurso(id) == null) {
                    throw new NonexistentEntityException("The tbCurso with id " + id + " no longer exists.");
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
            TbCurso tbCurso;
            try {
                tbCurso = em.getReference(TbCurso.class, id);
                tbCurso.getCurCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbCurso with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<TbGraduacao> tbGraduacaoCollectionOrphanCheck = tbCurso.getTbGraduacaoCollection();
            for (TbGraduacao tbGraduacaoCollectionOrphanCheckTbGraduacao : tbGraduacaoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbCurso (" + tbCurso + ") cannot be destroyed since the TbGraduacao " + tbGraduacaoCollectionOrphanCheckTbGraduacao + " in its tbGraduacaoCollection field has a non-nullable tbCursoCurCodigo field.");
            }
            Collection<TbAluno> tbAlunoCollectionOrphanCheck = tbCurso.getTbAlunoCollection();
            for (TbAluno tbAlunoCollectionOrphanCheckTbAluno : tbAlunoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbCurso (" + tbCurso + ") cannot be destroyed since the TbAluno " + tbAlunoCollectionOrphanCheckTbAluno + " in its tbAlunoCollection field has a non-nullable tbCursoCurCodigo field.");
            }
            Collection<TbExames> tbExamesCollectionOrphanCheck = tbCurso.getTbExamesCollection();
            for (TbExames tbExamesCollectionOrphanCheckTbExames : tbExamesCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbCurso (" + tbCurso + ") cannot be destroyed since the TbExames " + tbExamesCollectionOrphanCheckTbExames + " in its tbExamesCollection field has a non-nullable tbCursoCurCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tbCurso);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbCurso> findTbCursoAll() {
        EntityManager em = getEntityManager();
        Query curso = em.createNamedQuery("TbCurso.findAll");
        return curso.getResultList();
    }

    public TbCurso findTbCurso(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbCurso.class, id);
        } finally {
            em.close();
        }
    }

}
