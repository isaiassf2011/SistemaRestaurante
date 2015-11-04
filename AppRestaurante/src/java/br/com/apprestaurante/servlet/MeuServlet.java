/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.servlet;

import br.com.apprestaurante.dao.RestauranteDao;
import com.google.gson.JsonObject;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author isaias_sergio
 */
@MultipartConfig
public class MeuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        JsonObject json = new JsonObject();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (isMultipart) {

            FileItemFactory factory = new DiskFileItemFactory();

            ServletFileUpload upload = new ServletFileUpload(factory);
            try {

                List<FileItem> multiparts = upload.parseRequest(request);

                String caminho = request.getRequestURL().toString().replace(request.getRequestURI().toString(), "") + request.getContextPath() + "/imgs/";
                System.out.println(System.getProperty("java.io.tmpdir"));
                for (FileItem item : multiparts) {
                    if (item.getFieldName().equals("file")) {
                        String nomeArquivo = new Date().getTime() + item.getName();
                        //File file = new File(getServletConfig().getServletContext().getRealPath("/imgs/").replace("build", ""), nomeArquivo);
                        File file = new File(System.getProperty("java.io.tmpdir"), nomeArquivo);
                        item.write(file);

                        System.out.println(nomeArquivo);
                        System.out.println(caminho + file.getName());
                        json.addProperty("caminho", file.getName());
                    }
                    /*if (!item.isFormField()) {
                     String name = new File(item.getName()).getName();
                     item.write(new File(name));
                     }*/
                }

                out.print(json);
                out.flush();
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("File upload failed");
            }
        }

    }

}
