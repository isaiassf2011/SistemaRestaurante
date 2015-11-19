/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.CategoriaProduto;
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
public class CategoriaProdutoDao {

    public List<CategoriaProduto> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<CategoriaProduto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from CategoriaProduto");
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

    public List<CategoriaProduto> buscarPorRestaurante(Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<CategoriaProduto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("Select distinct p.categoriaProduto from Produto as p where p.restaurante.codigo = :codigoRestaurante ");
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
    
    public List<CategoriaProduto> buscarPorRestauranteUsuario(Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<CategoriaProduto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("Select distinct p.categoriaProduto from Produto as p where p.restaurante.codigo = :codigoRestaurante and p.cancelado = 0 ");
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
    
    public List<CategoriaProduto> buscarPorProdutoNome(String nome, Integer codigoRestaurante) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<CategoriaProduto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("Select distinct p.categoriaProduto from Produto as p where p.nome like :nome and p.restaurante.codigo = :codigoRestaurante ");
            query.setParameter("nome", "%" + nome + "%");
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

    public List<Produto> getAllByNome(String nome) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Produto> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Produto as r where r.nome like :nome");
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

    public void excluir(CategoriaProduto categoriaProduto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.delete(categoriaProduto);
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

    public CategoriaProduto getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        CategoriaProduto cp = null;

        try {
            transacao = session.beginTransaction();
            cp = (CategoriaProduto) session.get(CategoriaProduto.class, id);
            transacao.commit();
            return cp;
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

    public void salvar(CategoriaProduto categoriaProduto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;

        try {
            transacao = session.beginTransaction();
            session.saveOrUpdate(categoriaProduto);
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
