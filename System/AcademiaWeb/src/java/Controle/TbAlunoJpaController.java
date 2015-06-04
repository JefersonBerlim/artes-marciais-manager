/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.IllegalOrphanException;
import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Administrador
 */
public class TbAlunoJpaController implements Serializable {

    public TbAlunoJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbAluno tbAluno) throws PreexistingEntityException, Exception {
        if (tbAluno.getTbAulaCollection() == null) {
            tbAluno.setTbAulaCollection(new ArrayList<TbAula>());
        }
        if (tbAluno.getTbPagamentosCollection() == null) {
            tbAluno.setTbPagamentosCollection(new ArrayList<TbPagamentos>());
        }
        if (tbAluno.getTbExamesCollection() == null) {
            tbAluno.setTbExamesCollection(new ArrayList<TbExames>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbMensalidade tbMensalidadeMenCodigo = tbAluno.getTbMensalidadeMenCodigo();
            if (tbMensalidadeMenCodigo != null) {
                tbMensalidadeMenCodigo = em.getReference(tbMensalidadeMenCodigo.getClass(), tbMensalidadeMenCodigo.getMenCodigo());
                tbAluno.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigo);
            } else {
                tbMensalidadeMenCodigo = em.getReference(TbMensalidade.class, tbAluno.getTmpMensalidadeMenCodigo());
                tbAluno.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigo);
            }

            TbCurso tbCursoCurCodigo = tbAluno.getTbCursoCurCodigo();
            if (tbCursoCurCodigo != null) {
                tbCursoCurCodigo = em.getReference(tbCursoCurCodigo.getClass(), tbCursoCurCodigo.getCurCodigo());
                tbAluno.setTbCursoCurCodigo(tbCursoCurCodigo);
            } else {
                tbCursoCurCodigo = em.getReference(TbCurso.class, tbAluno.getTmpCursoCurCodigo());
                tbAluno.setTbCursoCurCodigo(tbCursoCurCodigo);
            }

            TbGraduacao tbGraduacaoGraCodigo = tbAluno.getTbGraduacaoGraCodigo();
            if (tbGraduacaoGraCodigo != null) {
                tbGraduacaoGraCodigo = em.getReference(tbGraduacaoGraCodigo.getClass(), tbGraduacaoGraCodigo.getGraCodigo());
                tbAluno.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            } else {
                tbGraduacaoGraCodigo = em.getReference(TbGraduacao.class, tbAluno.getTmptbGraduacaoGraCodigo());
                tbAluno.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            }

            if (tbAluno.getAluCodigo() == null) {
                em.persist(tbAluno);
            } else {
                em.merge(tbAluno);
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

    public void edit(TbAluno tbAluno) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbAluno persistentTbAluno = em.find(TbAluno.class, tbAluno.getAluCodigo());
            TbMensalidade tbMensalidadeMenCodigoOld = persistentTbAluno.getTbMensalidadeMenCodigo();
            TbMensalidade tbMensalidadeMenCodigoNew = tbAluno.getTbMensalidadeMenCodigo();
            TbCurso tbCursoCurCodigoOld = persistentTbAluno.getTbCursoCurCodigo();
            TbCurso tbCursoCurCodigoNew = tbAluno.getTbCursoCurCodigo();
            Collection<TbAula> tbAulaCollectionOld = persistentTbAluno.getTbAulaCollection();
            Collection<TbAula> tbAulaCollectionNew = tbAluno.getTbAulaCollection();
            Collection<TbPagamentos> tbPagamentosCollectionOld = persistentTbAluno.getTbPagamentosCollection();
            Collection<TbPagamentos> tbPagamentosCollectionNew = tbAluno.getTbPagamentosCollection();
            Collection<TbExames> tbExamesCollectionOld = persistentTbAluno.getTbExamesCollection();
            Collection<TbExames> tbExamesCollectionNew = tbAluno.getTbExamesCollection();
            List<String> illegalOrphanMessages = null;
            for (TbAula tbAulaCollectionOldTbAula : tbAulaCollectionOld) {
                if (!tbAulaCollectionNew.contains(tbAulaCollectionOldTbAula)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbAula " + tbAulaCollectionOldTbAula + " since its tbAlunoAluCodigo field is not nullable.");
                }
            }
            for (TbPagamentos tbPagamentosCollectionOldTbPagamentos : tbPagamentosCollectionOld) {
                if (!tbPagamentosCollectionNew.contains(tbPagamentosCollectionOldTbPagamentos)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbPagamentos " + tbPagamentosCollectionOldTbPagamentos + " since its tbAlunoAluCodigo field is not nullable.");
                }
            }
            for (TbExames tbExamesCollectionOldTbExames : tbExamesCollectionOld) {
                if (!tbExamesCollectionNew.contains(tbExamesCollectionOldTbExames)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbExames " + tbExamesCollectionOldTbExames + " since its tbAlunoAluCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (tbMensalidadeMenCodigoNew != null) {
                tbMensalidadeMenCodigoNew = em.getReference(tbMensalidadeMenCodigoNew.getClass(), tbMensalidadeMenCodigoNew.getMenCodigo());
                tbAluno.setTbMensalidadeMenCodigo(tbMensalidadeMenCodigoNew);
            }
            if (tbCursoCurCodigoNew != null) {
                tbCursoCurCodigoNew = em.getReference(tbCursoCurCodigoNew.getClass(), tbCursoCurCodigoNew.getCurCodigo());
                tbAluno.setTbCursoCurCodigo(tbCursoCurCodigoNew);
            }
            Collection<TbAula> attachedTbAulaCollectionNew = new ArrayList<TbAula>();
            for (TbAula tbAulaCollectionNewTbAulaToAttach : tbAulaCollectionNew) {
                tbAulaCollectionNewTbAulaToAttach = em.getReference(tbAulaCollectionNewTbAulaToAttach.getClass(), tbAulaCollectionNewTbAulaToAttach.getSequencial());
                attachedTbAulaCollectionNew.add(tbAulaCollectionNewTbAulaToAttach);
            }
            tbAulaCollectionNew = attachedTbAulaCollectionNew;
            tbAluno.setTbAulaCollection(tbAulaCollectionNew);
            Collection<TbPagamentos> attachedTbPagamentosCollectionNew = new ArrayList<TbPagamentos>();
            for (TbPagamentos tbPagamentosCollectionNewTbPagamentosToAttach : tbPagamentosCollectionNew) {
                tbPagamentosCollectionNewTbPagamentosToAttach = em.getReference(tbPagamentosCollectionNewTbPagamentosToAttach.getClass(), tbPagamentosCollectionNewTbPagamentosToAttach.getSequencial());
                attachedTbPagamentosCollectionNew.add(tbPagamentosCollectionNewTbPagamentosToAttach);
            }
            tbPagamentosCollectionNew = attachedTbPagamentosCollectionNew;
            tbAluno.setTbPagamentosCollection(tbPagamentosCollectionNew);
            Collection<TbExames> attachedTbExamesCollectionNew = new ArrayList<TbExames>();
            for (TbExames tbExamesCollectionNewTbExamesToAttach : tbExamesCollectionNew) {
                tbExamesCollectionNewTbExamesToAttach = em.getReference(tbExamesCollectionNewTbExamesToAttach.getClass(), tbExamesCollectionNewTbExamesToAttach.getSequencial());
                attachedTbExamesCollectionNew.add(tbExamesCollectionNewTbExamesToAttach);
            }
            tbExamesCollectionNew = attachedTbExamesCollectionNew;
            tbAluno.setTbExamesCollection(tbExamesCollectionNew);
            tbAluno = em.merge(tbAluno);
            if (tbMensalidadeMenCodigoOld != null && !tbMensalidadeMenCodigoOld.equals(tbMensalidadeMenCodigoNew)) {
                tbMensalidadeMenCodigoOld.getTbAlunoCollection().remove(tbAluno);
                tbMensalidadeMenCodigoOld = em.merge(tbMensalidadeMenCodigoOld);
            }
            if (tbMensalidadeMenCodigoNew != null && !tbMensalidadeMenCodigoNew.equals(tbMensalidadeMenCodigoOld)) {
                tbMensalidadeMenCodigoNew.getTbAlunoCollection().add(tbAluno);
                tbMensalidadeMenCodigoNew = em.merge(tbMensalidadeMenCodigoNew);
            }
            if (tbCursoCurCodigoOld != null && !tbCursoCurCodigoOld.equals(tbCursoCurCodigoNew)) {
                tbCursoCurCodigoOld.getTbAlunoCollection().remove(tbAluno);
                tbCursoCurCodigoOld = em.merge(tbCursoCurCodigoOld);
            }
            if (tbCursoCurCodigoNew != null && !tbCursoCurCodigoNew.equals(tbCursoCurCodigoOld)) {
                tbCursoCurCodigoNew.getTbAlunoCollection().add(tbAluno);
                tbCursoCurCodigoNew = em.merge(tbCursoCurCodigoNew);
            }
            for (TbAula tbAulaCollectionNewTbAula : tbAulaCollectionNew) {
                if (!tbAulaCollectionOld.contains(tbAulaCollectionNewTbAula)) {
                    TbAluno oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula = tbAulaCollectionNewTbAula.getTbAlunoAluCodigo();
                    tbAulaCollectionNewTbAula.setTbAlunoAluCodigo(tbAluno);
                    tbAulaCollectionNewTbAula = em.merge(tbAulaCollectionNewTbAula);
                    if (oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula != null && !oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula.equals(tbAluno)) {
                        oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula.getTbAulaCollection().remove(tbAulaCollectionNewTbAula);
                        oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula = em.merge(oldTbAlunoAluCodigoOfTbAulaCollectionNewTbAula);
                    }
                }
            }
            for (TbPagamentos tbPagamentosCollectionNewTbPagamentos : tbPagamentosCollectionNew) {
                if (!tbPagamentosCollectionOld.contains(tbPagamentosCollectionNewTbPagamentos)) {
                    TbAluno oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos = tbPagamentosCollectionNewTbPagamentos.getTbAlunoAluCodigo();
                    tbPagamentosCollectionNewTbPagamentos.setTbAlunoAluCodigo(tbAluno);
                    tbPagamentosCollectionNewTbPagamentos = em.merge(tbPagamentosCollectionNewTbPagamentos);
                    if (oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos != null && !oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos.equals(tbAluno)) {
                        oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos.getTbPagamentosCollection().remove(tbPagamentosCollectionNewTbPagamentos);
                        oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos = em.merge(oldTbAlunoAluCodigoOfTbPagamentosCollectionNewTbPagamentos);
                    }
                }
            }
            for (TbExames tbExamesCollectionNewTbExames : tbExamesCollectionNew) {
                if (!tbExamesCollectionOld.contains(tbExamesCollectionNewTbExames)) {
                    TbAluno oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames = tbExamesCollectionNewTbExames.getTbAlunoAluCodigo();
                    tbExamesCollectionNewTbExames.setTbAlunoAluCodigo(tbAluno);
                    tbExamesCollectionNewTbExames = em.merge(tbExamesCollectionNewTbExames);
                    if (oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames != null && !oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames.equals(tbAluno)) {
                        oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames.getTbExamesCollection().remove(tbExamesCollectionNewTbExames);
                        oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames = em.merge(oldTbAlunoAluCodigoOfTbExamesCollectionNewTbExames);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbAluno.getAluCodigo();
                if (findTbAluno(id) == null) {
                    throw new NonexistentEntityException("The tbAluno with id " + id + " no longer exists.");
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
            TbAluno tbAluno;
            try {
                tbAluno = em.getReference(TbAluno.class, id);
                tbAluno.getAluCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbAluno with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<TbAula> tbAulaCollectionOrphanCheck = tbAluno.getTbAulaCollection();
            for (TbAula tbAulaCollectionOrphanCheckTbAula : tbAulaCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbAluno (" + tbAluno + ") cannot be destroyed since the TbAula " + tbAulaCollectionOrphanCheckTbAula + " in its tbAulaCollection field has a non-nullable tbAlunoAluCodigo field.");
            }
            Collection<TbPagamentos> tbPagamentosCollectionOrphanCheck = tbAluno.getTbPagamentosCollection();
            for (TbPagamentos tbPagamentosCollectionOrphanCheckTbPagamentos : tbPagamentosCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbAluno (" + tbAluno + ") cannot be destroyed since the TbPagamentos " + tbPagamentosCollectionOrphanCheckTbPagamentos + " in its tbPagamentosCollection field has a non-nullable tbAlunoAluCodigo field.");
            }
            Collection<TbExames> tbExamesCollectionOrphanCheck = tbAluno.getTbExamesCollection();
            for (TbExames tbExamesCollectionOrphanCheckTbExames : tbExamesCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbAluno (" + tbAluno + ") cannot be destroyed since the TbExames " + tbExamesCollectionOrphanCheckTbExames + " in its tbExamesCollection field has a non-nullable tbAlunoAluCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            TbMensalidade tbMensalidadeMenCodigo = tbAluno.getTbMensalidadeMenCodigo();
            if (tbMensalidadeMenCodigo != null) {
                tbMensalidadeMenCodigo.getTbAlunoCollection().remove(tbAluno);
                tbMensalidadeMenCodigo = em.merge(tbMensalidadeMenCodigo);
            }
            TbCurso tbCursoCurCodigo = tbAluno.getTbCursoCurCodigo();
            if (tbCursoCurCodigo != null) {
                tbCursoCurCodigo.getTbAlunoCollection().remove(tbAluno);
                tbCursoCurCodigo = em.merge(tbCursoCurCodigo);
            }
            em.remove(tbAluno);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbAluno> findTbAlunoAll() {
        EntityManager em = getEntityManager();
        Query aluno = em.createNamedQuery("TbAluno.findAll");
        return aluno.getResultList();
    }

    public List<TbAluno> findAlunoPagamentos() {
        EntityManager em = getEntityManager();
        Query aluno = em.createNamedQuery("TbAluno.findPagamentos");
        return aluno.getResultList();
    }

    public List<TbAluno> findByAlunoPorCurso(Integer curso) {
        EntityManager em = getEntityManager();
        Query aluno = em.createNamedQuery("TbAluno.findByAlunoPorCurso").setParameter("tbCursoCurCodigo", curso);
        return aluno.getResultList();
    }

    public TbAluno findTbAluno(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbAluno.class, id);
        } finally {
            em.close();
        }
    }

}
