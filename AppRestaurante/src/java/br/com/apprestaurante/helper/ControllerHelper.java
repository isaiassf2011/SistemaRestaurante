package br.com.apprestaurante.helper;

import br.com.apprestaurante.command.AddItemCarrinho;
import br.com.apprestaurante.command.AlterarRestaurante;
import br.com.apprestaurante.command.AutenticaRestaurante;
import br.com.apprestaurante.command.BuscarMesa;
import br.com.apprestaurante.command.BuscarPedido;
import br.com.apprestaurante.command.BuscarPedidoCaixa;
import br.com.apprestaurante.command.BuscarProduto;
import br.com.apprestaurante.command.BuscarRestaurante;
import br.com.apprestaurante.command.CadastraRestaurante;
import br.com.apprestaurante.command.CommandInterface;
import br.com.apprestaurante.command.ExcluirMesa;
import br.com.apprestaurante.command.ExcluirProduto;
import br.com.apprestaurante.command.FinalizarItemPedido;
import br.com.apprestaurante.command.FinalizarPedido;
import br.com.apprestaurante.command.SalvarProduto;
import br.com.apprestaurante.command.SalvarRestaurante;
import br.com.apprestaurante.command.ListarCardapio;
import br.com.apprestaurante.command.ListarCardapioUsuario;
import br.com.apprestaurante.command.ListarItensPendentes;
import br.com.apprestaurante.command.ListarItensProntos;
import br.com.apprestaurante.command.ListarPedidos;
import br.com.apprestaurante.command.ListarPedidosCaixa;
import br.com.apprestaurante.command.ListarProdutosNomeUsuario;
import br.com.apprestaurante.command.RealizarPedido;
import br.com.apprestaurante.command.RemoveItemCarrinho;
import br.com.apprestaurante.command.RemoverImagem;
import br.com.apprestaurante.command.SalvarMesa;
import br.com.apprestaurante.command.listarCategorias;
import br.com.apprestaurante.command.listarProdutos;
import br.com.apprestaurante.command.listarProdutosUsuario;
import br.com.apprestaurante.constante.AcaoConstante;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class ControllerHelper {

    private HashMap<String, CommandInterface> comandos;
    private HttpServletRequest request;

    public ControllerHelper() {

        comandos = new HashMap<String, CommandInterface>();
        comandos.put(AcaoConstante.ADD_ITEM_CARRINHO, new AddItemCarrinho());
        comandos.put(AcaoConstante.ALTERAR_RESTAURANTE, new AlterarRestaurante());
        comandos.put(AcaoConstante.AUTENTICA_RESTAURANTE, new AutenticaRestaurante());
        comandos.put(AcaoConstante.BUSCAR_PEDIDO_CAIXA, new BuscarPedidoCaixa());
        comandos.put(AcaoConstante.FINALIZAR_ITEM_PEDIDO, new FinalizarItemPedido());
        comandos.put(AcaoConstante.FINALIZAR_PEDIDO, new FinalizarPedido());
        comandos.put(AcaoConstante.SALVAR_RESTAURANTE, new SalvarRestaurante());
        comandos.put(AcaoConstante.SALVAR_MESA, new SalvarMesa());
        comandos.put(AcaoConstante.SALVAR_PRODUTO, new SalvarProduto());
        comandos.put(AcaoConstante.LISTAR_CARDAPIO, new ListarCardapio());
        comandos.put(AcaoConstante.LISTAR_CARDAPIO_USUARIO, new ListarCardapioUsuario());
        comandos.put(AcaoConstante.LISTAR_ITENS_PRONTOS, new ListarItensProntos());
        comandos.put(AcaoConstante.LISTAR_ITENS_PENDENTES, new ListarItensPendentes());
        comandos.put(AcaoConstante.LISTAR_PEDIDOS_CAIXA, new ListarPedidosCaixa());
        comandos.put(AcaoConstante.LISTAR_PRODUTOS, new listarProdutos());
        comandos.put(AcaoConstante.LISTAR_PRODUTOS_NOME_USUARIO, new ListarProdutosNomeUsuario());
        comandos.put(AcaoConstante.LISTAR_PRODUTOS_USUARIO, new listarProdutosUsuario());
        comandos.put(AcaoConstante.LISTAR_CATEGORIAS, new listarCategorias());
        comandos.put(AcaoConstante.LISTAR_PEDIDOS, new ListarPedidos());
        comandos.put(AcaoConstante.BUSCAR_PRODUTO, new BuscarProduto());
        comandos.put(AcaoConstante.BUSCAR_MESA, new BuscarMesa());
        comandos.put(AcaoConstante.BUSCAR_RESTAURANTE, new BuscarRestaurante());
        comandos.put(AcaoConstante.EXCLUIR_PRODUTO, new ExcluirProduto());
        comandos.put(AcaoConstante.EXCLUIR_MESA, new ExcluirMesa());
        comandos.put(AcaoConstante.REMOVER_IMAGEM, new RemoverImagem());
        comandos.put(AcaoConstante.REMOVE_ITEM_CARRINHO, new RemoveItemCarrinho());
        comandos.put(AcaoConstante.CADASTRAR_RESTAURANTE, new CadastraRestaurante());
        comandos.put(AcaoConstante.REALIZAR_PEDIDO, new RealizarPedido());
        comandos.put(AcaoConstante.BUSCAR_PEDIDO, new BuscarPedido());

    }

    public CommandInterface getComando() {
        String comando = getRequest().getParameter("acao");
        return comandos.get(comando);
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

}
