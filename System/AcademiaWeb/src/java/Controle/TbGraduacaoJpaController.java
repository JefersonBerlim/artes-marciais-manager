/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.IllegalOrphanException;
import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.TbCurso;
import Entidade.TbGraduacao;
import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author Administrador
 */
public class TbGraduacaoJpaController implements Serializable {

    public TbGraduacaoJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbGraduacao tbGraduacao) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbCurso tbCursoCurCodigo = tbGraduacao.getTbCursoCurCodigo();

            if (tbCursoCurCodigo != null) {
                tbCursoCurCodigo = em.getReference(tbCursoCurCodigo.getClass(), tbCursoCurCodigo.getCurCodigo());
                tbGraduacao.setTbCursoCurCodigo(tbCursoCurCodigo);
            } else {
                tbCursoCurCodigo = em.getReference(TbCurso.class, tbGraduacao.getTmpCursoCurCodigo());
                tbGraduacao.setTbCursoCurCodigo(tbCursoCurCodigo);
            }
            if (tbGraduacao.getGraCodigo() == null) {
                em.persist(tbGraduacao);
            } else {
                em.merge(tbGraduacao);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            if (findTbGraduacao(tbGraduacao.getGraCodigo()) != null) {
                throw new PreexistingEntityException("TbGraduacao " + tbGraduacao + " already exists.", ex);
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
            TbGraduacao tbGraduacao;
            try {
                tbGraduacao = em.getReference(TbGraduacao.class, id);
                tbGraduacao.getGraCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbGraduacao with id " + id + " no longer exists.", enfe);
            }
            em.remove(tbGraduacao);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public TbGraduacao findTbGraduacao(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbGraduacao.class, id);
        } finally {
            em.close();
        }
    }

    public List<TbGraduacao> findTbGraduacaoAll() {
        EntityManager em = getEntityManager();
        Query graduacao = em.createNamedQuery("TbGraduacao.findAll");
        return graduacao.getResultList();
    }

    public List<TbGraduacao> findByGraduacaoPorCurso(Integer graduacao) {
        EntityManager em = getEntityManager();
        Query graduacoes = em.createNamedQuery("TbGraduacao.findByGraduacaoPorCurso").setParameter("tbCursoCurCodigo", graduacao);
        return graduacoes.getResultList();
    }

}
