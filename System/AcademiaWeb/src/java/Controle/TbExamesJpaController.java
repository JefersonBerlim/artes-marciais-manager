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
public class TbExamesJpaController implements Serializable {

    public TbExamesJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbExames tbExames) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        Collection<TbExames> exame;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            TbProfessor tbProfessorProCodigo = tbExames.getTbProfessorProCodigo();

            if (tbProfessorProCodigo != null) {
                tbProfessorProCodigo = em.getReference(tbProfessorProCodigo.getClass(), tbProfessorProCodigo.getProCodigo());
                tbExames.setTbProfessorProCodigo(tbProfessorProCodigo);
            } else {
                tbProfessorProCodigo = em.getReference(TbProfessor.class, tbExames.getTmptbProfessorProCodigo());
                tbExames.setTbProfessorProCodigo(tbProfessorProCodigo);
            }

            TbGraduacao tbGraduacaoGraCodigo = tbExames.getTbGraduacaoGraCodigo();
            if (tbGraduacaoGraCodigo != null) {
                tbGraduacaoGraCodigo = em.getReference(tbGraduacaoGraCodigo.getClass(), tbGraduacaoGraCodigo.getGraCodigo());
                tbExames.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            } else {
                tbGraduacaoGraCodigo = em.getReference(TbGraduacao.class, tbExames.getTmptbGraduacaoGraCodigo());
                tbExames.setTbGraduacaoGraCodigo(tbGraduacaoGraCodigo);
            }

            TbCurso tbCursoCurCodigo = tbExames.getTbCursoCurCodigo();
            if (tbCursoCurCodigo != null) {
                tbCursoCurCodigo = em.getReference(tbCursoCurCodigo.getClass(), tbCursoCurCodigo.getCurCodigo());
                tbExames.setTbCursoCurCodigo(tbCursoCurCodigo);
            } else {
                tbCursoCurCodigo = em.getReference(TbCurso.class, tbExames.getTmptbCursoCurCodigo());
                tbExames.setTbCursoCurCodigo(tbCursoCurCodigo);
            }

            TbAluno tbAlunoAluCodigo = tbExames.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo = em.getReference(tbAlunoAluCodigo.getClass(), tbAlunoAluCodigo.getAluCodigo());
                tbExames.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            } else {
                tbAlunoAluCodigo = em.getReference(TbAluno.class, tbExames.getTmptbAlunoAluCodigo());
                tbExames.setTbAlunoAluCodigo(tbAlunoAluCodigo);
            }

            if (tbExames.getExaResultado().equals("A")) {
                tbExames.getTbAlunoAluCodigo().setTbGraduacaoGraCodigo(tbExames.getTbGraduacaoGraCodigo());
            }

            if (tbExames.getSequencial() == null) {
                //valida se o exame já foi lançado no sistema
                exame = validaExame(tbExames.getExaData(), tbExames.getExaHorario(), tbExames.getTmptbAlunoAluCodigo());

                if (exame != null && exame.size() > 0) {
                    throw new Exception("Este exame já se encontra lançado no sistema. Por favor verifique.");
                }
                em.persist(tbExames);
            } else {
                em.merge(tbExames);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TbExames tbExames) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbExames persistentTbExames = em.find(TbExames.class, tbExames.getSequencial());
            TbProfessor tbProfessorProCodigoOld = persistentTbExames.getTbProfessorProCodigo();
            TbProfessor tbProfessorProCodigoNew = tbExames.getTbProfessorProCodigo();
            TbGraduacao tbGraduacaoGraCodigoOld = persistentTbExames.getTbGraduacaoGraCodigo();
            TbGraduacao tbGraduacaoGraCodigoNew = tbExames.getTbGraduacaoGraCodigo();
            TbCurso tbCursoCurCodigoOld = persistentTbExames.getTbCursoCurCodigo();
            TbCurso tbCursoCurCodigoNew = tbExames.getTbCursoCurCodigo();
            TbAluno tbAlunoAluCodigoOld = persistentTbExames.getTbAlunoAluCodigo();
            TbAluno tbAlunoAluCodigoNew = tbExames.getTbAlunoAluCodigo();

            tbExames = em.merge(tbExames);

            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbExames.getSequencial();
                if (findTbExames(id) == null) {
                    throw new NonexistentEntityException("The tbExames with id " + id + " no longer exists.");
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
            TbExames tbExames;
            try {
                tbExames = em.getReference(TbExames.class, id);
                tbExames.getSequencial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbExames with id " + id + " no longer exists.", enfe);
            }
            TbProfessor tbProfessorProCodigo = tbExames.getTbProfessorProCodigo();
            if (tbProfessorProCodigo != null) {
                tbProfessorProCodigo.getTbExamesCollection().remove(tbExames);
                tbProfessorProCodigo = em.merge(tbProfessorProCodigo);
            }
            TbGraduacao tbGraduacaoGraCodigo = tbExames.getTbGraduacaoGraCodigo();
            if (tbGraduacaoGraCodigo != null) {
                tbGraduacaoGraCodigo.getTbExamesCollection().remove(tbExames);
                tbGraduacaoGraCodigo = em.merge(tbGraduacaoGraCodigo);
            }
            TbCurso tbCursoCurCodigo = tbExames.getTbCursoCurCodigo();
            if (tbCursoCurCodigo != null) {
                tbCursoCurCodigo.getTbExamesCollection().remove(tbExames);
                tbCursoCurCodigo = em.merge(tbCursoCurCodigo);
            }
            TbAluno tbAlunoAluCodigo = tbExames.getTbAlunoAluCodigo();
            if (tbAlunoAluCodigo != null) {
                tbAlunoAluCodigo.getTbExamesCollection().remove(tbExames);
                tbAlunoAluCodigo = em.merge(tbAlunoAluCodigo);
            }
            em.remove(tbExames);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbExames> findTbExamesAll() {
        EntityManager em = getEntityManager();
        Query exame = em.createNamedQuery("TbExames.findAll");
        return exame.getResultList();
    }

    public List<TbAluno> findByAlunoPorCurso(Integer curso) {
        EntityManager em = getEntityManager();
        Query aluno = em.createNamedQuery("TbAluno.findByAlunoPorCurso").setParameter("tbCursoCurCodigo", curso);
        return aluno.getResultList();
    }

    public List<TbGraduacao> findByGraduacaoPorCurso(TbGraduacao graduacao) {
        EntityManager em = getEntityManager();
        Query graduacoes = em.createNamedQuery("Tbgraduacao.findByGraduacaoPorCurso").setParameter("tbCursoCurCodigo", graduacao);
        return graduacoes.getResultList();
    }

    public List<TbCurso> findTbCursoAll() {
        EntityManager em = getEntityManager();
        Query curso = em.createNamedQuery("TbCurso.findAll");
        return curso.getResultList();
    }

    public TbExames findTbExames(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbExames.class, id);
        } finally {
            em.close();
        }
    }

    public List<TbExames> validaExame(Date data, Date horario, Integer aluno) {
        EntityManager em = getEntityManager();
        Query exame = em.createNamedQuery("TbExames.findValidaExame")
                .setParameter("exaData", data)
                .setParameter("exaHorario", horario)
                .setParameter("aluCodigo", aluno);
        return exame.getResultList();
    }
}
