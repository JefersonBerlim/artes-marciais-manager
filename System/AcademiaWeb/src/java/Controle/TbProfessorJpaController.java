/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import Controle.exceptions.IllegalOrphanException;
import Controle.exceptions.NonexistentEntityException;
import Controle.exceptions.PreexistingEntityException;
import Entidade.TbAula;
import Entidade.TbExames;
import Entidade.TbProfessor;
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
public class TbProfessorJpaController implements Serializable {

    public TbProfessorJpaController() {
        emf = Persistence.createEntityManagerFactory("AcademiaWebPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TbProfessor tbProfessor) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        Collection<TbProfessor> professor;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            if (tbProfessor.getProCodigo() == null) {
                //valida se o usuário já foi cadastrado no sistema
                professor = validaProfessor(tbProfessor.getProUsuario());

                if (professor != null && professor.size() > 0) {
                    throw new Exception("Este usuário já se encontra cadastrado no sistema. Por favor verifique.");
                }
                em.persist(tbProfessor);
            } else {
                em.merge(tbProfessor);
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

    public void edit(TbProfessor tbProfessor) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TbProfessor persistentTbProfessor = em.find(TbProfessor.class, tbProfessor.getProCodigo());
            Collection<TbAula> tbAulaCollectionOld = persistentTbProfessor.getTbAulaCollection();
            Collection<TbAula> tbAulaCollectionNew = tbProfessor.getTbAulaCollection();
            Collection<TbExames> tbExamesCollectionOld = persistentTbProfessor.getTbExamesCollection();
            Collection<TbExames> tbExamesCollectionNew = tbProfessor.getTbExamesCollection();
            List<String> illegalOrphanMessages = null;
            for (TbAula tbAulaCollectionOldTbAula : tbAulaCollectionOld) {
                if (!tbAulaCollectionNew.contains(tbAulaCollectionOldTbAula)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbAula " + tbAulaCollectionOldTbAula + " since its tbProfessorProCodigo field is not nullable.");
                }
            }
            for (TbExames tbExamesCollectionOldTbExames : tbExamesCollectionOld) {
                if (!tbExamesCollectionNew.contains(tbExamesCollectionOldTbExames)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain TbExames " + tbExamesCollectionOldTbExames + " since its tbProfessorProCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<TbAula> attachedTbAulaCollectionNew = new ArrayList<TbAula>();
            for (TbAula tbAulaCollectionNewTbAulaToAttach : tbAulaCollectionNew) {
                tbAulaCollectionNewTbAulaToAttach = em.getReference(tbAulaCollectionNewTbAulaToAttach.getClass(), tbAulaCollectionNewTbAulaToAttach.getSequencial());
                attachedTbAulaCollectionNew.add(tbAulaCollectionNewTbAulaToAttach);
            }
            tbAulaCollectionNew = attachedTbAulaCollectionNew;
            tbProfessor.setTbAulaCollection(tbAulaCollectionNew);
            Collection<TbExames> attachedTbExamesCollectionNew = new ArrayList<TbExames>();
            for (TbExames tbExamesCollectionNewTbExamesToAttach : tbExamesCollectionNew) {
                tbExamesCollectionNewTbExamesToAttach = em.getReference(tbExamesCollectionNewTbExamesToAttach.getClass(), tbExamesCollectionNewTbExamesToAttach.getSequencial());
                attachedTbExamesCollectionNew.add(tbExamesCollectionNewTbExamesToAttach);
            }
            tbExamesCollectionNew = attachedTbExamesCollectionNew;
            tbProfessor.setTbExamesCollection(tbExamesCollectionNew);
            tbProfessor = em.merge(tbProfessor);
            for (TbAula tbAulaCollectionNewTbAula : tbAulaCollectionNew) {
                if (!tbAulaCollectionOld.contains(tbAulaCollectionNewTbAula)) {
                    TbProfessor oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula = tbAulaCollectionNewTbAula.getTbProfessorProCodigo();
                    tbAulaCollectionNewTbAula.setTbProfessorProCodigo(tbProfessor);
                    tbAulaCollectionNewTbAula = em.merge(tbAulaCollectionNewTbAula);
                    if (oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula != null && !oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula.equals(tbProfessor)) {
                        oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula.getTbAulaCollection().remove(tbAulaCollectionNewTbAula);
                        oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula = em.merge(oldTbProfessorProCodigoOfTbAulaCollectionNewTbAula);
                    }
                }
            }
            for (TbExames tbExamesCollectionNewTbExames : tbExamesCollectionNew) {
                if (!tbExamesCollectionOld.contains(tbExamesCollectionNewTbExames)) {
                    TbProfessor oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames = tbExamesCollectionNewTbExames.getTbProfessorProCodigo();
                    tbExamesCollectionNewTbExames.setTbProfessorProCodigo(tbProfessor);
                    tbExamesCollectionNewTbExames = em.merge(tbExamesCollectionNewTbExames);
                    if (oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames != null && !oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames.equals(tbProfessor)) {
                        oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames.getTbExamesCollection().remove(tbExamesCollectionNewTbExames);
                        oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames = em.merge(oldTbProfessorProCodigoOfTbExamesCollectionNewTbExames);
                    }
                }
            }

        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tbProfessor.getProCodigo();
                if (findTbProfessor(id) == null) {
                    throw new NonexistentEntityException("The tbProfessor with id " + id + " no longer exists.");
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
            TbProfessor tbProfessor;
            try {
                tbProfessor = em.getReference(TbProfessor.class, id);
                tbProfessor.getProCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tbProfessor with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<TbAula> tbAulaCollectionOrphanCheck = tbProfessor.getTbAulaCollection();
            for (TbAula tbAulaCollectionOrphanCheckTbAula : tbAulaCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbProfessor (" + tbProfessor + ") cannot be destroyed since the TbAula " + tbAulaCollectionOrphanCheckTbAula + " in its tbAulaCollection field has a non-nullable tbProfessorProCodigo field.");
            }
            Collection<TbExames> tbExamesCollectionOrphanCheck = tbProfessor.getTbExamesCollection();
            for (TbExames tbExamesCollectionOrphanCheckTbExames : tbExamesCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TbProfessor (" + tbProfessor + ") cannot be destroyed since the TbExames " + tbExamesCollectionOrphanCheckTbExames + " in its tbExamesCollection field has a non-nullable tbProfessorProCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tbProfessor);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TbProfessor> findTbProfessorAll() {
        EntityManager em = getEntityManager();
        Query professor = em.createNamedQuery("TbProfessor.findAll");
        return professor.getResultList();
    }

    public List<TbProfessor> findUsuario(String usuario, String senha) {
        EntityManager em = getEntityManager();
        Query professor = em.createNamedQuery("TbProfessor.findUsuario").setParameter("usuario", usuario).setParameter("senha", senha);
        return professor.getResultList();
    }

    public TbProfessor findTbProfessor(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TbProfessor.class, id);
        } finally {
            em.close();
        }
    }

    public List<TbProfessor> validaProfessor(String usuario) {
        EntityManager em = getEntityManager();
        Query professor = em.createNamedQuery("TbProfessor.findValidaProfessor")
                .setParameter("proUsuario", usuario);
        return professor.getResultList();
    }
}
