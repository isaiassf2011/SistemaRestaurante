package br.com.apprestaurante.email;

import com.sun.mail.smtp.SMTPAddressFailedException;
import java.io.File;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author isaias
 */
public class Email {

    private static final String FROM = "izaiazferreira@gmail.com";
    private static final String USER = "izaiazferreira@gmail.com";
    private static final String SENHA = "comidadojaco";
    private static final String MAIL_SMTP_HOST = "smtp.gmail.com";
    private static final String PROTOCOL = "smtp";
    private static final String PORTA = "465";

    private Properties props = new Properties();
    private ArrayList<String> destinatario;
    private ArrayList<String> destinatarioCopiado;
    private String tituloEmail;
    private String textoEmail;
    private Session session;

    public void enviaEmail(ArrayList<String> destinatario, ArrayList<String> destinatarioCopiado, String tituloEmail, String textoEmail) throws Exception {

        try {
            // Seta valores
            this.setDestinatario(destinatario);
            this.setDestinatarioCopiado(destinatarioCopiado);
            this.setTituloEmail(tituloEmail);
            this.setTextoEmail(textoEmail);

            // Configura
            MimeMessage messageEmail = this.configuraEmail();

            // Envia email
            this.envia(messageEmail);

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Problema no Envio de Email. Email inválido. " + e.getMessage());
        }
    }

    public void enviaEmailComAnexo(ArrayList<String> destinatario, ArrayList<String> destinatarioCopiado, String tituloEmail, String textoEmail, ArrayList<File> arquivos) throws Exception {
        try {

            // Seta valores
            this.setDestinatario(destinatario);
            this.setDestinatarioCopiado(destinatarioCopiado);
            this.setTituloEmail(tituloEmail);
            this.setTextoEmail(textoEmail);

            // Anexa arquivo
            MimeMessage messageEmail = anexaArquivo(arquivos);

            // Configura a data: cabecalho
            messageEmail.setSentDate(new Date());

            // Envia email
            envia(messageEmail);

        } catch (AddressException e) {
            e.printStackTrace();

        } catch (NoSuchProviderException e) {
            e.printStackTrace();

        } catch (SMTPAddressFailedException e) {
            e.printStackTrace();

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new Exception("Problema no Envio de Email. Email inválido. " + e.getMessage());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Envia o email
     *
     * @param messageEmail
     * @throws NoSuchProviderException
     * @throws MessagingException
     */
    private void envia(MimeMessage messageEmail) throws NoSuchProviderException, MessagingException, Exception {
        //enviar mensagem
        Transport t = this.getSession().getTransport("smtp"); // protocolo de envio
        t.connect(USER, SENHA);
        System.out.println("enviando email...");
        t.sendMessage(messageEmail, messageEmail.getAllRecipients()); // envia o email
        System.out.println("Enviado com sucesso!");
    }

    /**
     * Metodo responsavel por anexar arquivos.
     *
     * @param arquivoAnexo
     * @return
     * @throws Exception
     * @throws MessagingException
     */
    private MimeMessage anexaArquivo(ArrayList<File> arquivosAnexo) throws Exception, MessagingException {
        // Configura email
        MimeMessage messageEmail = this.configuraEmail();

        // cria a primeira parte da mensagem
        MimeBodyPart mbp = new MimeBodyPart();
        mbp.setContent(this.getTextoEmail(), "text/html");

        Multipart mp = new MimeMultipart();
        mp.addBodyPart(mbp);

        FileDataSource fds;
        for (File arquivo : arquivosAnexo) {
            fds = new FileDataSource(arquivo);
            mbp = new MimeBodyPart();
            mbp.setDataHandler(new DataHandler(fds));
            mbp.setFileName(fds.getName());
            mp.addBodyPart(mbp);
        }

        // adiciona a Multipart na mensagem
        messageEmail.setContent(mp);
        return messageEmail;
    }

    /**
     * Configura a mensagem e para quem o email sera enviado
     *
     * @return
     * @throws Exception
     */
    public MimeMessage configuraEmail() throws Exception {
        MimeMessage messageEmail = new MimeMessage(this.getSession());

        try {
            messageEmail.setContent(this.getTextoEmail(), "text/html; charset=iso-8859-1"); // seta mensagem do email.		

            messageEmail.setFrom(new InternetAddress(FROM)); // email que vai enviar a mensagem

            messageEmail.setSubject(this.getTituloEmail()); // seta o titulo do email 

            //Use o metodo setReplyTo() para definir um endereco para o campo "responder".
            // Destinatario principal
            for (String to : this.getDestinatario()) {
                System.out.println("enviando para: " + to.toString());
                messageEmail.addRecipient(Message.RecipientType.TO, new InternetAddress(to.toString()));
            }

            // Copia Oculta
            if (this.getDestinatarioCopiado() != null) {
                for (String bcc : this.getDestinatarioCopiado()) {
                    System.out.println("com cópia para: " + bcc.toString());
                    messageEmail.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc.toString()));
                }
            }

        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return messageEmail;

    }

    public static void main(String[] args) throws Exception {
        //File arquivoAnexo = new File("c://449.pdf");

        ArrayList<String> a = new ArrayList<String>();
        a.add("izaiazferreira@gmail.com");

        ArrayList<String> b = new ArrayList<String>();
        b.add("isaiassf2011@hotmail.com");

        //new Email().enviaEmail(a, null, "Assunto", "texto do email");
        //new Email().enviaEmail(a, null, "email teste", "teste no corpo do email");  //EmailComAnexo(a, b, "tituloEmail", "textoEmail", arquivoAnexo);
        StringWriter texto = new Velocity().formataEmailSenha("111111111", "123");
        new Email().enviaEmail(a, null, "Senha - Sistema Chegou Pediu!", texto.toString());  //EmailComAnexo(a, b, "tituloEmail", "textoEmail", arquivoAnexo);
    }

    /**
     * Getters e Setters
     *
     * @return
     */
    public Properties getProps() {
        return props;
    }

    public void setProps(Properties props) {
        this.props = props;
    }

    public ArrayList<String> getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(ArrayList<String> destinatario) {
        this.destinatario = destinatario;
    }

    public ArrayList<String> getDestinatarioCopiado() {
        return destinatarioCopiado;
    }

    public void setDestinatarioCopiado(ArrayList<String> destinatarioCopiado) {
        this.destinatarioCopiado = destinatarioCopiado;
    }

    public String getTituloEmail() {
        return tituloEmail;
    }

    public void setTituloEmail(String tituloEmail) {
        this.tituloEmail = tituloEmail;
    }

    public String getTextoEmail() {
        return textoEmail;
    }

    public void setTextoEmail(String textoEmail) {
        this.textoEmail = textoEmail;
    }

    public Session getSession() {
        Properties props = new Properties();
        props.setProperty("mail.smtp.host", MAIL_SMTP_HOST);
        //props.setProperty("mail.smtp.localhost", MAIL_SMTP_LOCALHOST);
        props.setProperty("mail.user", USER);
        props.setProperty("mail.password", SENHA);
        props.setProperty("mail.transport.protocol", PROTOCOL);
        props.setProperty("mail.smtp.port", PORTA);
        props.setProperty("mail.smtp.auth", "true");
        //props.setProperty("mail.debug", "true");
        props.setProperty("mail.smtp.ssl.enable", "true");
        //props.put("mail.smtp.socketFactory.port", "587");

        this.setProps(props);
        // preparar sessao
        this.session = Session.getDefaultInstance(props);

        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

}
