package br.com.apprestaurante.command;

import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.HibernateUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.fill.JRAbstractLRUVirtualizer;
import net.sf.jasperreports.engine.fill.JRGzipVirtualizer;
import org.hibernate.Session;
import org.hibernate.engine.spi.SessionFactoryImplementor;

/**
 *
 * @author isaias
 */
public class RelatorioPedidoPeriodo implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HashMap<String, Object> parametros = new HashMap<String, Object>();

        HttpSession sessionRes = request.getSession(false);
        Restaurante restaurante = (Restaurante) sessionRes.getAttribute("restaurante");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatterAux = new SimpleDateFormat("dd/MM/yyyy");
        Date dataAuxI = null;
        Date dataAuxF = null;
        String dataI = null;
        String dataF = null;
        try {
            dataAuxI = (java.util.Date)formatter.parse(request.getParameter("dt_inicial"));
            dataI = formatterAux.format(dataAuxI);
            dataAuxF = (java.util.Date)formatter.parse(request.getParameter("dt_final"));
            dataF = formatterAux.format(dataAuxF);
        } catch (ParseException ex) {
            Logger.getLogger(RelatorioPedidoPeriodo.class.getName()).log(Level.SEVERE, null, ex);
        }

        System.out.println(dataI);
        parametros.put("dt_inicial", request.getParameter("dt_inicial"));
        parametros.put("dt_final", request.getParameter("dt_final"));
        parametros.put("dt_i", dataI);
        parametros.put("dt_f", dataF);
        parametros.put("restaurante_codigo", restaurante.getCodigo());

        ServletContext contexto = request.getSession(false).getServletContext();

        String nomeArquivoJasper = contexto.getRealPath("relatorio/pedidos_por_periodo.jasper");

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
                response.setHeader("Content-disposition", "attachment; filename=pedidos_por_periodo" + request.getParameter("codigoMesa") + ".pdf");

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
