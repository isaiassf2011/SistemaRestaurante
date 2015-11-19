package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author isaias_sergio
 */
public class RestauranteDao {

    public List<Restaurante> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Restaurante> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from entity.Restaurante");
            lista = query.list();
            transacao.commit();
            return lista;
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }
    }

    public List<Restaurante> getAllByNome(String nome) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Restaurante> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Restaurante as r where r.nome like :nome");
            query.setParameter("nome", "%" + nome + "%");
            lista = query.list();
            transacao.commit();
            return lista;
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }

    }

    public Restaurante buscaPorCnpj(String cnpj) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Restaurante r = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Restaurante as r where r.cnpj = :cnpj ");
            query.setParameter("cnpj", cnpj);
            r = (Restaurante) query.uniqueResult();
            transacao.commit();
            return r;
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }

    }
    
    public Restaurante buscaPorCnpjSenha(String cnpj, String senha) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Restaurante r = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Restaurante as r where r.cnpj = :cnpj and r.senha = :senha ");
            query.setParameter("cnpj", cnpj);
            query.setParameter("senha", senha);
            r = (Restaurante) query.uniqueResult();
            transacao.commit();
            return r;
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }

    }

    public void excluir(Restaurante restaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(restaurante);
            transacao.commit();
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }
    }

    public Restaurante getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Restaurante r = null;

        try {
            transacao = session.beginTransaction();
            r = (Restaurante) session.get(Restaurante.class, id);
            transacao.commit();
            return r;
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }
    }

    public void salvar(Restaurante restaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(restaurante);
            transacao.commit();
        } catch (HibernateException e) {
            if (transacao != null) {
                transacao.rollback();
            }
            e.printStackTrace();
            throw new HibernateException(e.getMessage());
        } finally {
            session.close();
        }
    }

}
