package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PedidoDao {

    public List<Pedido> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Pedido> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Pedido");
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

    public void excluir(Pedido pedido) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(pedido);
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

    public Pedido getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Pedido p = null;

        try {
            transacao = session.beginTransaction();
            p = (Pedido) session.get(Pedido.class, id);
            transacao.commit();
            return p;
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
    
    public Pedido getByIdItens(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Pedido p = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Pedido as p join fetch p.itens where p.codigo = :codigoPedido ");
            query.setParameter("codigoPedido", id);
            p = (Pedido) query.uniqueResult();
            transacao.commit();
            return p;
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

    public Pedido buscarPedidoPorMesa(Integer codigoMesa) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Pedido p = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Pedido as p join fetch p.itens where p.mesa.codigo = :codigoMesa and p.finalizado = 0 ");
            query.setParameter("codigoMesa", codigoMesa);
            p = (Pedido) query.uniqueResult();
            transacao.commit();
            return p;
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
    
    public List<Pedido> listarPorPedido(Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Pedido> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Pedido as p where p.mesa.restaurante.codigo = :codigoRestaurante and p.finalizado = 0 ");
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

    public void salvar(Pedido pedido) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(pedido);
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
