package cart;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import orders.OrdersVO;
import product.ProductDAO;
import product.ProductVO;

@WebServlet(value= {"/cart/insert", "/cart/update", "/cart/delete"})
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		ArrayList<OrdersVO> listCart=(ArrayList<OrdersVO>)session.getAttribute("listCart");
		OrdersVO cartVO=new OrdersVO();
		String id=request.getParameter("id");
		
		switch(request.getServletPath()) {
		case "/cart/insert":
			ProductDAO pdao=new ProductDAO();
			ProductVO productVO=pdao.read(request.getParameter("prod_id"));
			
			cartVO.setProd_id(productVO.getProd_id());
			cartVO.setProd_name(productVO.getProd_name());
			cartVO.setPrice(productVO.getPrice1());
			cartVO.setQuantity(1);
			cartVO.setSum(cartVO.getPrice()*cartVO.getQuantity());
			boolean isFind=false;
			if(listCart==null) {
				listCart =new ArrayList<OrdersVO>();
			}else {
				for(OrdersVO oldVO:listCart) {
					if(oldVO.getProd_id().equals(cartVO.getProd_id())) {
						oldVO.setQuantity(oldVO.getQuantity()+1);
						oldVO.setSum(oldVO.getPrice() * oldVO.getQuantity());
						isFind=true;
					}
				}
			}
			if(!isFind) listCart.add(cartVO);
			session.setAttribute("listCart", listCart);
			break;
			
		case "/cart/update":
			String strQuantity=request.getParameter("quantity");
			int quantity=Integer.parseInt(strQuantity);
			for(OrdersVO oldVO:listCart) {
				if(oldVO.getProd_id().equals(id)) {
					oldVO.setQuantity(quantity);
					oldVO.setSum(oldVO.getPrice()*oldVO.getQuantity());
				}
				session.setAttribute("listCart", listCart);
			}
			break;
			
		case "/cart/delete":
			for(int i=0; i<listCart.size(); i++) {
				OrdersVO oldVO=listCart.get(i);
				if(oldVO.getProd_id().equals(id)) {
					listCart.remove(i);
					break;
				}
			}
			break;
		}
	}
}
