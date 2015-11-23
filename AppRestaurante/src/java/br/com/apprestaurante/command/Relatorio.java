package br.com.apprestaurante.command;

import br.com.apprestaurante.util.HibernateUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.fill.JRAbstractLRUVirtualizer;
import net.sf.jasperreports.engine.fill.JRGzipVirtualizer;
import org.hibernate.Session;
import org.hibernate.engine.spi.SessionFactoryImplementor;


public class Relatorio implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HashMap<String, Object> parametros = new HashMap<String, Object>();

        System.out.println(request.getParameter("codigoMesa"));
        parametros.put("mesa_codigo", Integer.parseInt(request.getParameter("codigoMesa")));

        ServletContext contexto = request.getSession(false).getServletContext();

        String nomeArquivoJasper = contexto.getRealPath("relatorio/qrcode_mesa.jasper");

        JRAbstractLRUVirtualizer virtualizer = new JRGzipVirtualizer(100);
        parametros.put(JRParameter.REPORT_VIRTUALIZER, virtualizer);

        byte[] bytes = null;
        JasperPrint arquivoPrint = null;

        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            arquivoPrint = JasperFillManager.fillReport(nomeArquivoJasper, parametros, ((SessionFactoryImplementor) HibernateUtil.getSessionFactory()).getConnectionProvider().getConnection());
            bytes = JasperRunManager.runReportToPdf(nomeArquivoJasper, parametros, ((SessionFactoryImplementor) HibernateUtil.getSessionFactory()).getConnectionProvider().getConnection());

        } catch (JRException ex) {
            Logger.getLogger(Relatorio.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Relatorio.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }

        if (bytes != null && bytes.length > 0 && arquivoPrint != null && arquivoPrint.getPages().size() > 0) {
            try {
                ServletOutputStream outputStream;
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                response.setHeader("Content-disposition", "attachment; filename=qrcode_mesa_"+request.getParameter("numeroMesa")+".pdf");

                outputStream = response.getOutputStream();
                outputStream.write(bytes, 0, bytes.length);
                outputStream.flush();
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return null;

    }

}
