/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.*;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author Administrador
 */
public class TbAulaJpaController implements Serializable {

    public TbAulaJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbAula tbAula) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        Collection<TbAula> aulas;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbProfessor tbProfessorProCodigo = tbAula.getTbProfessorProCodigo();
            if (tbProfessorProCodigo != null) {
                tbProfessorProCodigo = em.getReference(tbProfessorProCodigo.getClass(), tbProfessorProCodigo.getProCodigo());
                tbAula.setTbProfessorProCodigo(tbProfessorProCodigo);
            } else {
                tbProfessorProCodigo = em.getReference(TbProfessor.class, tbAula.getTmptbProfessorProCodigo());
                tbAula.setTbProfessorProCodigo(tbProfessorProCodigo);
            }
            TbExercicio tbExercicioExeCodigo = tbAula.getTbExercicioExeCodigo();
            if (tbExercicioExeCodigo != null) {
                tbExercicioExeCodigo = em.getReference(tbExercicioExeCodigo.getClass(), tbExercicioExeCodigo.getExeCodigo());
                tbAula.setTbExercicioExeCodigo(tbExercicioExeCodigo);
            } else {
                tbExercicioExeCodigo = em.getReference(TbExercicio.class, tbAula.getTmptbExercicioExeCodigo());
                tbAula.setTbExercicioExeCodigo(tbExercicioExeCodigo);
            }
            TbAluno tbAlunoAluCodigo = tbAula.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo = em.getReference(tbAlunoAluCodigo.getClass(), tbAlunoAluCodigo.getAluCodigo());
                tbAula.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            } else {
                tbAlunoAluCodigo = em.getReference(TbAluno.class, tbAula.getTmptbAlunoAluCodigo());
                tbAula.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            }
            if (tbAula.getSequencial() == null) {
                //valida se a aula já foi lançada no sistema
                aulas = validaAula(tbAula.getAulData(), tbAula.getAulHorario(), tbAula.getTmptbAlunoAluCodigo());

                if (aulas != null && aulas.size() > 0) {
                    throw new Exception("Esta aula já se encontra lançada no sistema. Por favor verifique.");
                }
                em.persist(tbAula);
            } else {
                em.merge(tbAula);
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

    public void edit(TbAula tbAula) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbAula persistentTbAula = em.find(TbAula.class, tbAula.getSequencial());

            TbProfessor tbProfessorProCodigo = tbAula.getTbProfessorProCodigo();

            TbExercicio tbExercicioExeCodigo = persistentTbAula.getTbExercicioExeCodigo();

            TbAluno tbAlunoAluCodigo = tbAula.getTbAlunoAluCodigo();

            if (tbProfessorProCodigo != null) {
                tbProfessorProCodigo = em.getReference(tbProfessorProCodigo.getClass(), tbProfessorProCodigo.getProCodigo());
                tbAula.setTbProfessorProCodigo(tbProfessorProCodigo);
            } else {
                tbProfessorProCodigo = em.getReference(TbProfessor.class, tbAula.getTbProfessorProCodigo());
                tbAula.setTbProfessorProCodigo(tbProfessorProCodigo);
            }
            if (tbExercicioExeCodigo != null) {
                tbExercicioExeCodigo = em.getReference(tbExercicioExeCodigo.getClass(), tbExercicioExeCodigo.getExeCodigo());
                tbAula.setTbExercicioExeCodigo(tbExercicioExeCodigo);
            } else {
                tbExercicioExeCodigo = em.getReference(TbExercicio.class, tbAula.getTmptbExercicioExeCodigo());
                tbAula.setTbExercicioExeCodigo(tbExercicioExeCodigo);
            }
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo = em.getReference(tbAlunoAluCodigo.getClass(), tbAlunoAluCodigo.getAluCodigo());
                tbAula.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            } else {
                tbAlunoAluCodigo = em.getReference(TbAluno.class, tbAula.getTmptbAlunoAluCodigo());
                tbAula.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            }
            em.persist(tbAula);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbAula.getSequencial();
                if (findTbAula(id) == null) {
                    throw new NonexistentEntityException("The tbAula with id " + id + " no longer exists.");
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
            TbAula tbAula;
            try {
                tbAula = em.getReference(TbAula.class, id);
                tbAula.getSequencial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbAula with id " + id + " no longer exists.", enfe);
            }
            TbProfessor tbProfessorProCodigo = tbAula.getTbProfessorProCodigo();
            if (tbProfessorProCodigo != null) {
                tbProfessorProCodigo.getTbAulaCollection().remove(tbAula);
                tbProfessorProCodigo = em.merge(tbProfessorProCodigo);
            }
            TbExercicio tbExercicioExeCodigo = tbAula.getTbExercicioExeCodigo();
            if (tbExercicioExeCodigo != null) {
                tbExercicioExeCodigo.getTbAulaCollection().remove(tbAula);
                tbExercicioExeCodigo = em.merge(tbExercicioExeCodigo);
            }
            TbAluno tbAlunoAluCodigo = tbAula.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo.getTbAulaCollection().remove(tbAula);
                tbAlunoAluCodigo = em.merge(tbAlunoAluCodigo);
            }
            em.remove(tbAula);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbAula> findTbAulaAll() {
        EntityManager em = getEntityManager();
        Query aula = em.createNamedQuery("TbAula.findAll");
        return aula.getResultList();
    }

    public TbAula findTbAula(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbAula.class, id);
        } finally {
            em.close();
        }
    }

    public List<TbAula> validaAula(Date data, Date horario, Integer aluno) {
        EntityManager em = getEntityManager();
        Query aula = em.createNamedQuery("TbAula.findValidaAula")
                .setParameter("aulData", data)
                .setParameter("aulHorario", horario)
                .setParameter("aluCodigo", aluno);
        return aula.getResultList();
    }
}
