package database;

import org.json.simple.JSONObject;
import mall.MallDAO;

public class Main {

	public static void main(String[] args) {
		System.out.println(Database.CON);
		SqlVO vo=new SqlVO();
		vo.setKey("mall_name");
		vo.setWord("");
		vo.setOrder("mall_id");
		vo.setDesc("desc");
		vo.setPage(1);
		vo.setPerPage(2);
		
		MallDAO dao=new MallDAO();
		JSONObject jObject=dao.list(vo);
		System.out.println(jObject);
	}
}
