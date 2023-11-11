package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;

import util.DBUtil;
import vo.Manager;
import vo.Notice;

public class NoticeDao {
	// 공지사항 추가
	public int insertNotice(Notice insertNotice) throws Exception {
	    DBUtil dbUtil = new DBUtil();
	    Connection conn = dbUtil.getConnection();

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
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

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
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

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
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            // 조회 SQL (manager 테이블과 조인)
            String sql = "SELECT n.*, m.manager_name " +
                         "FROM notice n " +
                         "JOIN manager m ON n.manager_no = m.manager_no";
            PreparedStatement stmt = conn.prepareStatement(sql);
            System.out.println(stmt + "<--stmt");
            ResultSet rs = stmt.executeQuery();

            List<Notice> noticeList = new ArrayList<>();

            while (rs.next()) {
                Notice notice = new Notice();
                Manager manager = new Manager();
                notice.setManager(manager);
                notice.setNoticeNo(rs.getInt("notice_no"));
                notice.setManagerNo(rs.getInt("manager_no"));
                manager.setManagerName(rs.getString("manager_name"));
                notice.setNoticeTitle(rs.getString("notice_title"));
                notice.setNoticeContent(rs.getString("notice_content"));
                notice.setCreatedate(rs.getString("createdate"));
                notice.setUpdatedate(rs.getString("updatedate"));
                noticeList.add(notice);
            }

            return noticeList;
        } finally {
            conn.close(); // 연결 닫기
        }
    }
}