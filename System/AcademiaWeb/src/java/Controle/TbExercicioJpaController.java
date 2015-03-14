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
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author Administrador
 */
public class TbExercicioJpaController implements Serializable {

    public TbExercicioJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbExercicio tbExercicio) throws PreexistingEntityException, Exception {

        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbGraduacao tbGraduacaoGraCodigo = tbExercicio.getTbGraduacaoGraCodigo();

            if (tbGraduacaoGraCodigo != null) {
                tbGraduacaoGraCodigo = em.getReference(tbGraduacaoGraCodigo.getClass(), tbGraduacaoGraCodigo.getGraCodigo());
                tbExercicio.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            } else {
                tbGraduacaoGraCodigo = em.getReference(TbGraduacao.class, tbExercicio.getTmptbGraduacaoGraCodigo());
                tbExercicio.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            }
            if (tbExercicio.getExeCodigo() == null) {
                em.persist(tbExercicio);
            } else {
                em.merge(tbExercicio);
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

    public void edit(TbExercicio tbExercicio) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbExercicio persistentTbExercicio = em.find(TbExercicio.class, tbExercicio.getExeCodigo());
            TbGraduacao tbGraduacaoGraCodigoOld = persistentTbExercicio.getTbGraduacaoGraCodigo();
            TbGraduacao tbGraduacaoGraCodigoNew = tbExercicio.getTbGraduacaoGraCodigo();
            Collection<TbAula> tbAulaCollectionOld = persistentTbExercicio.getTbAulaCollection();
            Collection<TbAula> tbAulaCollectionNew = tbExercicio.getTbAulaCollection();
            List<String> illegalOrphanMessages = null;
            for (TbAula tbAulaCollectionOldTbAula : tbAulaCollectionOld) {
                if (!tbAulaCollectionNew.contains(tbAulaCollectionOldTbAula)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbAula " + tbAulaCollectionOldTbAula + " since its tbExercicioExeCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (tbGraduacaoGraCodigoNew != null) {
                tbGraduacaoGraCodigoNew = em.getReference(tbGraduacaoGraCodigoNew.getClass(), tbGraduacaoGraCodigoNew.getGraCodigo());
                tbExercicio.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigoNew);
            }
            Collection<TbAula> attachedTbAulaCollectionNew = new ArrayList<TbAula>();
            for (TbAula tbAulaCollectionNewTbAulaToAttach : tbAulaCollectionNew) {
                tbAulaCollectionNewTbAulaToAttach = em.getReference(tbAulaCollectionNewTbAulaToAttach.getClass(), tbAulaCollectionNewTbAulaToAttach.getSequencial());
                attachedTbAulaCollectionNew.add(tbAulaCollectionNewTbAulaToAttach);
            }
            tbAulaCollectionNew = attachedTbAulaCollectionNew;
            tbExercicio.setTbAulaCollection(tbAulaCollectionNew);
            tbExercicio = em.merge(tbExercicio);
            if (tbGraduacaoGraCodigoOld != null && !tbGraduacaoGraCodigoOld.equals(tbGraduacaoGraCodigoNew)) {
                tbGraduacaoGraCodigoOld.getTbExercicioCollection().remove(tbExercicio);
                tbGraduacaoGraCodigoOld = em.merge(tbGraduacaoGraCodigoOld);
            }
            if (tbGraduacaoGraCodigoNew != null && !tbGraduacaoGraCodigoNew.equals(tbGraduacaoGraCodigoOld)) {
                tbGraduacaoGraCodigoNew.getTbExercicioCollection().add(tbExercicio);
                tbGraduacaoGraCodigoNew = em.merge(tbGraduacaoGraCodigoNew);
            }
            for (TbAula tbAulaCollectionNewTbAula : tbAulaCollectionNew) {
                if (!tbAulaCollectionOld.contains(tbAulaCollectionNewTbAula)) {
                    TbExercicio oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula = tbAulaCollectionNewTbAula.getTbExercicioExeCodigo();
                    tbAulaCollectionNewTbAula.setTbExercicioExeCodigo(tbExercicio);
                    tbAulaCollectionNewTbAula = em.merge(tbAulaCollectionNewTbAula);
                    if (oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula != null && !oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula.equals(tbExercicio)) {
                        oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula.getTbAulaCollection().remove(tbAulaCollectionNewTbAula);
                        oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula = em.merge(oldTbExercicioExeCodigoOfTbAulaCollectionNewTbAula);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbExercicio.getExeCodigo();
                if (findTbExercicio(id) == null) {
                    throw new NonexistentEntityException("The tbExercicio with id " + id + " no longer exists.");
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
            TbExercicio tbExercicio;
            try {
                tbExercicio = em.getReference(TbExercicio.class, id);
                tbExercicio.getExeCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbExercicio with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<TbAula> tbAulaCollectionOrphanCheck = tbExercicio.getTbAulaCollection();
            for (TbAula tbAulaCollectionOrphanCheckTbAula : tbAulaCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbExercicio (" + tbExercicio + ") cannot be destroyed since the TbAula " + tbAulaCollectionOrphanCheckTbAula + " in its tbAulaCollection field has a non-nullable tbExercicioExeCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            TbGraduacao tbGraduacaoGraCodigo = tbExercicio.getTbGraduacaoGraCodigo();
            if (tbGraduacaoGraCodigo != null) {
                tbGraduacaoGraCodigo.getTbExercicioCollection().remove(tbExercicio);
                tbGraduacaoGraCodigo = em.merge(tbGraduacaoGraCodigo);
            }
            em.remove(tbExercicio);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbExercicio> findTbExercicioAll() {
        EntityManager em = getEntityManager();
        Query exercicio = em.createNamedQuery("TbExercicio.findAll");
        return exercicio.getResultList();
    }

    public Collection<TbExercicio> findExercicioPorAluno(Integer alunoCodigo, Integer sequencial) {
        EntityManager em = getEntityManager();
        if (sequencial == null || sequencial == 0) {
            Query alunoQr = em.createNamedQuery("TbAluno.findByAluCodigo").setParameter("aluCodigo", alunoCodigo);
            TbAluno aluno = (TbAluno) alunoQr.getSingleResult();
            return em.createNamedQuery("TbExercicio.findByExeTbGraduacao")
                    .setParameter("graCodigo", aluno.getTbGraduacaoGraCodigo()).getResultList();
        } else {
            TbAula aula = (TbAula) em.createNamedQuery("TbAula.findBySequencial")
                    .setParameter("sequencial", sequencial).getSingleResult();
            List<TbExercicio> colecao = new ArrayList<TbExercicio>();
            colecao.add(aula.getTbExercicioExeCodigo());
            return colecao;
        }
    }

    public TbExercicio findTbExercicio(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbExercicio.class, id);
        } finally {
            em.close();
        }
    }

}
