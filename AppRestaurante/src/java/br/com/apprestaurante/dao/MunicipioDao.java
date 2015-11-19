package br.com.apprestaurante.dao;

import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Municipio;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.util.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author brd03-pc
 */
public class MunicipioDao {
    
    public List<Municipio> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Municipio> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Municipio");
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
    
    public List<Municipio> listarPorEstado(Integer codigoEstado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        List<Municipio> lista = null;

        try {
            transacao = session.beginTransaction();
            Query query = session.createQuery("from Municipio as m where m.estado.codigo = :codigoEstado ");
            query.setParameter("codigoEstado", codigoEstado);
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

    public Municipio getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transacao = null;
        Municipio municipio = null;

        try {
            transacao = session.beginTransaction();
            municipio = (Municipio) session.get(Municipio.class, id);
            transacao.commit();
            return municipio;
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
