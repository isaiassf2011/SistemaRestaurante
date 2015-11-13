package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PedidoItemDao {

    public List<PedidoItem> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<PedidoItem> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from PedidoItem");
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

    public void excluir(PedidoItem pedidoItem) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(pedidoItem);
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

    public PedidoItem getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        PedidoItem p = null;

        try {
            transacao = session.beginTransaction();
            p = (PedidoItem) session.get(PedidoItem.class, id);
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

    public List<PedidoItem> listarPedidosPendentes(Restaurante restaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<PedidoItem> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from PedidoItem as p where p.pedido.finalizado = 0 "
                    + "and p.produto.restaurante.codigo = :codigoRestaurante and p.feito = 0 ");
            query.setParameter("codigoRestaurante", restaurante.getCodigo());
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
    
    public List<PedidoItem> listarPedidosProntos(Restaurante restaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<PedidoItem> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from PedidoItem as p where p.pedido.finalizado = 0 "
                    + "and p.produto.restaurante.codigo = :codigoRestaurante and p.feito = 1 ");
            query.setParameter("codigoRestaurante", restaurante.getCodigo());
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

    public void salvar(PedidoItem pedidoItem) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(pedidoItem);
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
