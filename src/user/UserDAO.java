package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // executeQuery는 데이터 검색할때 사용
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else {
					return 0; //비밀번호 틀림
				}
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return -2; //DB 오류
	}
	
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,false)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); // insert,delete,update는 전부 Update함수를 사용하여 처리
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return -1; //회원가입 실패
	}
	
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return null; // DB 오류
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return false; // DB 오류
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace();}
			try { if(rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace();}
		}
		return false; // DB 오류
	}
	
	

}
