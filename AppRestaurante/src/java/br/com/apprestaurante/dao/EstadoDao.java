package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class EstadoDao {

    public List<Estado> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Estado> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Estado");
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

    public Estado getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Estado estado = null;

        try {
            transacao = session.beginTransaction();
            estado = (Estado) session.get(Estado.class, id);
            transacao.commit();
            return estado;
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
