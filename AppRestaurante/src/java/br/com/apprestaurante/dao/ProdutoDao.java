package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Produto;
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
public class ProdutoDao {

    public List<Produto> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Produto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from entity.Produto");
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
    
    public List<Produto> buscarPorCategoria(Integer codigo) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Produto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from entity.Produto as p where p.categoriaProduto.codigo = :categoria ");
            query.setParameter("categoria", codigo);
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

    public List<Produto> getAllByNome(String nome) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Produto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from entity.Produto as r where r.nome like :nome");
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

    public void excluir(Produto produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(produto);
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

    public Produto getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Produto p = null;

        try {
            transacao = session.beginTransaction();
            p = (Produto) session.get(Produto.class, id);
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

    public void salvar(Produto produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(produto);
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
