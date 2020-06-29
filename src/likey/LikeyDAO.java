package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeyDAO{
	
	public int like(String userID, String evaluationID, String userIP) {
		String SQL =  "INSERT INTO LIKEY VALUES (?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, evaluationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate(); // insert,delete,update는 전부 Update함수를 사용하여 처리
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return -1; // 추천 중복시 오류
	}

}
