package product;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import database.SqlVO;

@WebServlet(value= {"/product/list", "/product/id", "/product/insert", "/product/read", "/product/update", "/product/delete"})
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		JSONObject jObject=new JSONObject();
		SqlVO svo=new SqlVO();
		String key=request.getParameter("key")==null?"mall_id":request.getParameter("key");
		String word=request.getParameter("word")==null?"":request.getParameter("word");
		String order=request.getParameter("order")==null?"mall_id":request.getParameter("order");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
		String page=request.getParameter("page")==null?"1":request.getParameter("page");
		String perPage=request.getParameter("perPage")==null?"2":request.getParameter("perPage");
		svo.setKey(key);
		svo.setWord(word);
		svo.setOrder(order);
		svo.setDesc(desc);
		svo.setPage(Integer.parseInt(page));
		svo.setPerPage(Integer.parseInt(perPage));
		
		ProductDAO dao=new ProductDAO();
		switch(request.getServletPath()) {
		case "/product/list":
			out.println(dao.list(svo));
			break;
			
		case "/product/id":	
			jObject.put("id", dao.getID());
			out.println(jObject);
			break;
			
		case "/product/read":
			request.setAttribute("vo", dao.read(request.getParameter("prod_id")));
			RequestDispatcher dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
			
		case "/product/delete":
			ProductVO vo=dao.read(request.getParameter("prod_id")); // 삭제하기 전 data
			int count=dao.delete(request.getParameter("prod_id")); // 삭제
			if(count==0 && vo.getImage()!=null) {
				System.gc();
				String uploadPath="c:"+File.separator+"shop"+File.separator+"product"+File.separator;
				File file=new File(uploadPath + vo.getImage());
				file.delete();	
			}
			jObject.put("count", count);
			out.println(jObject);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ProductDAO dao=new ProductDAO();
		//이미지파일 업로드 
		String uploadPath="c:"+File.separator+"shop"+File.separator+"product"+File.separator;
		File mdPath=new File(uploadPath);
		if(!mdPath.exists()) mdPath.mkdir();
		MultipartRequest multi=new MultipartRequest(request, uploadPath, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
		String image=multi.getFilesystemName("image");
		String prod_id=multi.getParameter("prod_id");
		
		ProductVO vo=new ProductVO();
		vo.setProd_id(prod_id);
		vo.setProd_name(multi.getParameter("prod_name"));
		vo.setCompany(multi.getParameter("company"));
		vo.setMall_id(multi.getParameter("mall_id"));
		vo.setPrice1(Integer.parseInt(multi.getParameter("price1")));
		vo.setPrice2(Integer.parseInt(multi.getParameter("price2")));
		vo.setDetail(multi.getParameter("detail"));
		String prod_del=multi.getParameter("prod_del");
		if(prod_del==null) {
			vo.setProd_del("0");
		}else {
			vo.setProd_del(multi.getParameter("prod_del"));
		}
		
		switch(request.getServletPath()) {
		case "/product/insert":
			vo.setImage(image);
			dao.insert(vo);
			response.sendRedirect("list.jsp");
			break;
			
		case "/product/update":
			ProductVO oldVO=dao.read(prod_id);
			if(image!=null) {
				if(oldVO.getImage()!=null) {
					System.gc();
					File oldImage=new File(uploadPath + oldVO.getImage());
					oldImage.delete();
				}
				vo.setImage(image);
			}else {
				vo.setImage(oldVO.getImage());
			}
			dao.update(vo);
			response.sendRedirect("list.jsp");
			break;
		}
	}
}
