package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Produto;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author isaias
 */
public class ProdutoDao {

    public List<Produto> getAll() {
        List<Produto> lista = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();

        Query query = session.createQuery("from entity.Produto");
        lista = query.list();

        session.getTransaction().commit();
        session.close();

        return lista;
    }

    public List<Produto> getAllByNome(String nome) {
        List<Produto> lista = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();

        Query query = session.createQuery("from entity.Produto as p where p.nome like :nome");
        query.setParameter("nome", "%" + nome + "%");
        lista = query.list();

        session.getTransaction().commit();
        session.close();

        return lista;
    }

    public void excluir(Produto produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        session.delete(produto);
        session.getTransaction().commit();
        session.close();
    }

    public Produto getById(Integer id) {
        Produto p = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        p = (Produto) session.get(Produto.class, id);
        session.getTransaction().commit();
        session.close();
        return p;
    }

    public void salvar(Produto produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        session.saveOrUpdate(produto);
        session.getTransaction().commit();
        session.close();
    }

}
