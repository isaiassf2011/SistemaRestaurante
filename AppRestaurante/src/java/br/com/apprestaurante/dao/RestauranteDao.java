package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author isaias_sergio
 */
public class RestauranteDao {

    public List<Restaurante> getAll() {
        List<Restaurante> lista = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();

        Query query = session.createQuery("from entity.Restaurante");
        lista = query.list();

        session.getTransaction().commit();
        session.close();

        return lista;
    }

    public List<Restaurante> getAllByNome(String nome) {
        List<Restaurante> lista = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();

        Query query = session.createQuery("from entity.Restaurante as r where r.nome like :nome");
        query.setParameter("nome", "%" + nome + "%");
        lista = query.list();

        session.getTransaction().commit();
        session.close();

        return lista;
    }

    public void excluir(Restaurante produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        session.delete(produto);
        session.getTransaction().commit();
        session.close();
    }

    public Restaurante getById(Integer id) {
        Restaurante p = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        p = (Restaurante) session.get(Restaurante.class, id);
        session.getTransaction().commit();
        session.close();
        return p;
    }

    public void salvar(Restaurante produto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        session.saveOrUpdate(produto);
        session.getTransaction().commit();
        session.close();
    }

}
