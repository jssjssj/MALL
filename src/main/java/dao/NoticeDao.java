package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;

import util.DBUtil;
import vo.Goods;
import vo.GoodsImg;
import vo.Manager;
import vo.Notice;

public class NoticeDao extends ClassDao {
	// 공지사항 추가
	public int insertNotice(Notice insertNotice) throws Exception {
	    Connection conn = db.getConnection();

	    try {
	        // 입력(insert) SQL
	        String sql = "INSERT INTO notice"
	                     + "(manager_no, notice_title, notice_content, createdate, updatedate) "
	                     + "VALUES(?, ?, ?, now(), now())";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, insertNotice.getManagerNo()); // 매니저의 manager_no 설정
	        stmt.setString(2, insertNotice.getNoticeTitle());
	        stmt.setString(3, insertNotice.getNoticeContent());

	        int row = stmt.executeUpdate();

	        if (row == 1) {
	            System.out.println("공지사항 생성 성공");
	        } else {
	            System.out.println("공지사항 생성 실패");
	        }

	        return row;
	    } finally {
	        conn.close(); // 연결 닫기
	    }
	}



    // 공지사항 정보 업데이트
    public int updateNotice(Notice updateNotice) throws Exception {
        Connection conn = db.getConnection();

        try {
            // 업데이트 SQL
            String sql = "UPDATE notice SET "
	            		+ "notice_title=?, notice_content=?, updatedate=now() "
	            		+ "WHERE noticeNo=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, updateNotice.getNoticeTitle());
            stmt.setString(2, updateNotice.getNoticeContent());
            stmt.setInt(3, updateNotice.getNoticeNo());

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("공지사항 업데이트 성공");
            } else {
                System.out.println("공지사항 업데이트 실패");
            }

            return row;
        } finally {
            conn.close(); // 연결 닫기
        }
    }

    // 공지사항 정보 삭제
    public int deleteNotice(int noticeNo) throws Exception {
        Connection conn = db.getConnection();

        try {
            // 삭제 SQL
            String sql = "DELETE FROM notice WHERE noticeNo=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, noticeNo);

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("공지사항 삭제 성공");
            } else {
                System.out.println("공지사항 삭제 실패");
            }

            return row;
        } finally {
            conn.close(); // 연결 닫기
        }
     }

	 // 공지사항 정보 조회
	    public List<Notice> selectNotice() throws Exception {
	        Connection conn = db.getConnection();
	        List<Notice> result = new ArrayList<>();
	        // 조회 SQL (manager 테이블과 조인)
	        String sql = """
	        			SELECT n.*, m.manager_name 
	        			FROM notice n 
	        			JOIN manager m ON n.manager_no = m.manager_no
	        		""";
	        try {
	        	ResultSet rs =  db.executeQuery(sql);
	        	
	        	List<Notice> noticeList = new ArrayList<>();
	            while (rs.next()) {
	                Notice notice = converter.getNotice(rs);
	                Manager manager = converter.getManager(rs);
	                notice.setManager(manager);  
	                noticeList.add(notice);
	            }
	
	            result = noticeList;
	        } finally {
	            conn.close(); // 연결 닫기
	        }
	        
	        return result;
	    }
	    
	    public List<Notice> selectNotice(int page, int perPage) throws Exception {
			List<Notice> result = new ArrayList<>();
			String sql = """
	        			SELECT n.*, m.manager_name 
	        			FROM notice n 
	        			JOIN manager m ON n.manager_no = m.manager_no
	        			LIMIT ? , ?
        		""";

			try {
				// 조회 SQL
				ResultSet rs = db.executeQuery(sql, (page - 1) * perPage, perPage);

				List<Notice> noticeList = new ArrayList<>();
				while (rs.next()) {
					Notice notice = converter.getNotice(rs);
	                noticeList.add(notice);
				}

				result = noticeList;
			} catch (Exception e) {}

			return result;
		}

		/**
		 * 페이징을 위한 게시글 총 개수를 카운팅하는 함수
		 * @param page
		 * @param perPage
		 * @return
		 * @throws Exception
		 */
		public int getAllNoticeCount() throws Exception {
			int cnt = 0;
			String sql = "SELECT COUNT(*) as cnt FROM notice";
			ResultSet rs = db.executeQuery(sql);
			if (rs.next()) cnt = rs.getInt(1);
			return cnt;
		}
		
		 public Notice getNoticeOne(int notice_no) throws Exception {
		    	ResultSet rs = db.executeQuery("SELECT * FROM notice WHERE notice_no = ?", notice_no);
		    	Notice notice = null;
		    	if (rs.next()) {
		    		notice = converter.getNotice(rs);
		    	}
		    	return notice;
		    }
}