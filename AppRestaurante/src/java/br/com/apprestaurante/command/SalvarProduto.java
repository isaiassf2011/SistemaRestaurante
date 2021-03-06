package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Produto;
import br.com.apprestaurante.entity.Restaurante;
import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class SalvarProduto implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        HttpSession session = request.getSession(false);

        if (session != null) {
            try {

                Produto produto;
                ProdutoDao dao = new ProdutoDao();
                if (!request.getParameter("codigoProduto").equals("") && request.getParameter("codigoProduto") != null) {
                    produto = dao.getById(Integer.parseInt(request.getParameter("codigoProduto")));
                    System.out.println("IMG PRODUTO: " + produto.getImagem());
                    if (!produto.getImagem().equals("") && !produto.getImagem().equals(request.getParameter("imagem"))) {
                        File f = new File(request.getSession().getServletContext().getRealPath("/imgs/imgsRestaurante/" + produto.getImagem()).replace("build", ""));
                        f.delete();
                    }
                } else {
                    produto = new Produto();
                }
                produto.setNome(request.getParameter("nomeProduto"));
                produto.setDescricao(request.getParameter("descricao"));
                // diretorio de origem
                File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("imagem"));
                // diretorio de destino
                File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/imgsRestaurante/").replace("build", ""));
                // move o arquivo para o novo diretorio
                boolean ok = arquivo.renameTo(new File(dir, arquivo.getName()));
                if (ok) {
                    System.out.println("Arquivo foi movido com sucesso");
                } else {
                    System.out.println("Nao foi possivel mover o arquivo");
                }

                System.out.println(request.getParameter("preco").replaceAll("\\.", "").replaceAll(",", "."));
                produto.setImagem(request.getParameter("imagem"));
                produto.setPreco(new BigDecimal(request.getParameter("preco").replaceAll("\\.", "").replaceAll(",", ".")));

                Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
                produto.setRestaurante(restaurante);
                CategoriaProduto categoriaProduto = new CategoriaProduto();
                categoriaProduto.setCodigo(Integer.parseInt(request.getParameter("cmbCategoria")));
                produto.setCategoriaProduto(categoriaProduto);
                produto.setCancelado(false);

                dao.salvar(produto);

                List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
                List<Produto> produtos = new ArrayList<Produto>();
                categorias = new CategoriaProdutoDao().buscarPorRestaurante(restaurante.getCodigo());
                produtos = new ProdutoDao().buscarPorRestaurante(restaurante.getCodigo());
                request.setAttribute("categorias", categorias);
                request.setAttribute("produtos", produtos);

            } catch (Exception e) {
                e.printStackTrace();
            }

            return "pages/categoria.jsp";

        } else {
            return null;
        }

    }

}
