package purchase;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import database.Database;
import database.SqlVO;

public class PurchaseDAO {
	// 구매 목록 출력
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, "purchase");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.NUMBER);
			cs.execute();
			
			ResultSet rs=(ResultSet)cs.getObject(8);
			int count=cs.getInt(9);
			
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("order_id", rs.getString("order_id"));
				obj.put("name", rs.getString("name"));
				obj.put("address", rs.getString("address"));
				obj.put("tel", rs.getString("tel"));
				obj.put("email", rs.getString("email"));
				jArray.add(obj);
			}
			jObject.put("array", jArray);
			jObject.put("count", count);
			jObject.put("page", vo.getPage());
			jObject.put("perPage", vo.getPerPage());
			
			int totPage=count%vo.getPerPage()==0?count/vo.getPerPage():count/vo.getPerPage()+1;
			jObject.put("totPage", totPage);
		}catch(Exception e) {
			System.out.println("구매 목록 출력 error: " + e.toString());
		}
		return jObject;
	}
	
	// 구매 정보 읽기
	public PurchaseVO read(String order_id) {
		PurchaseVO vo=new PurchaseVO();
		try {
			String sql="select * from purchase where order_id=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, order_id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setOrder_id("order_id");
				vo.setName(rs.getString("name"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setPayType(rs.getString("payType"));
				vo.setStatus(rs.getString("status"));
				vo.setTel(rs.getString("tel"));
				vo.setPdate(rs.getString("pdate"));
			}
		}catch(Exception e) {
			System.out.println("구매 정보 읽기 error: " + e.toString());
		}
		return vo;
	}
	
	// 구매자 정보 입력
	public String insert(PurchaseVO vo) {
		String order_id="";
		try {
			String sql="insert into purchase(order_id, name, address, email, tel, pdate, payType, status) values('R'||seq_purchase.nextval,?,?,?,?,sysdate,?,0)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getAddress());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getTel());
			ps.setString(5, vo.getPayType());
			ps.execute();
			
			sql="select 'R'||seq_purchase.currval order_id from dual"; // 현재 value값 확인
			ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				order_id=rs.getString("order_id");
			}
		}catch(Exception e) {
			System.out.println("구매자 정보 입력 error: " + e.toString());
		}
		return order_id;
	}
}
