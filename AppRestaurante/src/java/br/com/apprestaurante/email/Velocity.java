package br.com.apprestaurante.email;

import java.io.StringWriter;
import java.util.Properties;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

/**
 *
 * @author isaias
 */
public class Velocity {

    private Properties p;
    private VelocityEngine ve;
    private VelocityContext context = new VelocityContext(); // Criando Contexto
    private String fs = System.getProperty("file.separator");

    public Velocity() throws Exception {

        Properties p = new Properties();

        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");

        p.put("input.encoding", "utf-8");

        this.p = p;

        // Inicializando o velocity
        VelocityEngine ve = new VelocityEngine();

        ve.init(this.p);

        this.ve = ve;

        // criando o contexto que liga o java ao template
        VelocityContext context = new VelocityContext();

        this.context = context;

    }

    public StringWriter formataEmailSenha(String cnpj, String senha) throws Exception {

        Template t = ve.getTemplate("br" + fs + "com" + fs + "apprestaurante"  + fs + "email" + fs + "html" + fs + "template.htm");

        // Parametros
        context.put("cnpj", cnpj);
        context.put("senha", senha);
        context.put("paginaConteudo", "br/com/apprestaurante/email/html/senha.htm");

        StringWriter writer = new StringWriter();

        // mistura o contexto com o template. Renderiza o template.
        t.merge(context, writer);

        return writer;

    }

}
