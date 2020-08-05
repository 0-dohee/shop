package mall;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.SqlVO;

@WebServlet(value= {"/mall/list"})
public class MallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();

		SqlVO svo=new SqlVO();
		String key=request.getParameter("key")==null?"mall_id":request.getParameter("key");
		String word=request.getParameter("word")==null?"":request.getParameter("word");
		String order=request.getParameter("order")==null?"mall_id":request.getParameter("order");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
		String page=request.getParameter("page")==null?"1":request.getParameter("page");
		String perPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
		svo.setKey(key);
		svo.setWord(word);
		svo.setOrder(order);
		svo.setDesc(desc);
		svo.setPage(Integer.parseInt(page));
		svo.setPerPage(Integer.parseInt(perPage));
		
		MallDAO dao=new MallDAO();
		switch(request.getServletPath()) {
		case "/mall/list":
			out.println(dao.list(svo));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
