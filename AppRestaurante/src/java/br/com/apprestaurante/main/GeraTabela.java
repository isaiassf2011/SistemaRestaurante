package br.com.apprestaurante.main;

import br.com.apprestaurante.util.HibernateUtil;

public class GeraTabela {

    public static void main(String[] args) {

        HibernateUtil.getSessionFactory();
        HibernateUtil.getSessionFactory().close();

    }

}
