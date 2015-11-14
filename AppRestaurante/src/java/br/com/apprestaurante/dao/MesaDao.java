package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author isaias
 */
public class MesaDao {

    public List<Mesa> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Mesa> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Mesa");
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
    
     public List<Mesa> listarPorRestaurante(Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Mesa> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Mesa as m where m.restaurante.codigo = :codigoRestaurante ");
            query.setParameter("codigoRestaurante", codigoRestaurante);
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
     
     /*public List<Mesa> listarPorPedido(Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Mesa> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("Select p.mesa from Pedido as p where p.mesa.restaurante.codigo = :codigoRestaurante and p.finalizado = 0 ");
            query.setParameter("codigoRestaurante", codigoRestaurante);
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
    }*/

    public void excluir(Mesa mesa) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(mesa);
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

    public Mesa getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Mesa m = null;

        try {
            transacao = session.beginTransaction();
            m = (Mesa) session.get(Mesa.class, id);
            transacao.commit();
            return m;
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

    public void salvar(Mesa mesa) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(mesa);
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
