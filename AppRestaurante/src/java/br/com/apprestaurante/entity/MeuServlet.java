/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.entity;

import java.io.File;
import java.io.IOException;
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

        if (isMultipart) {

            FileItemFactory factory = new DiskFileItemFactory();

            ServletFileUpload upload = new ServletFileUpload(factory);
            try {

                List<FileItem> multiparts = upload.parseRequest(request);

                String caminho = getServletContext().getRealPath("imgs");
                System.out.println(caminho);
                for (FileItem item : multiparts) {
                    File file = new File(caminho, item.getName());
                    item.write(file);
                    if (!item.isFormField()) {
                        String name = new File(item.getName()).getName();
                        item.write(new File(name));
                    }
                }
            } catch (Exception e) {
                System.out.println("File upload failed");
            }
        }

    }

}
