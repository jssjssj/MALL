package dao;

import java.sql.*;
import vo.*;

public class DashboardInfoDao extends ClassDao {
	
	// 대시보드 정보 가져오기
    public DashboardInfo getDashboardInfo() throws Exception {
        DashboardInfo dashboardInfo = new DashboardInfo();

        try (Connection conn = db.getConnection();
             PreparedStatement stmtOrder = conn.prepareStatement("SELECT COUNT(*) AS order_count FROM orders");
             PreparedStatement stmtNewCustomers = conn.prepareStatement("SELECT COUNT(*) AS new_customers FROM customer WHERE createdate >= CURDATE()")) {

            try (ResultSet rsOrder = stmtOrder.executeQuery();
                 ResultSet rsNewCustomers = stmtNewCustomers.executeQuery()) {

                if (rsOrder.next()) {
                    dashboardInfo.setOrderCount(rsOrder.getInt("order_count"));
                }

                if (rsNewCustomers.next()) {
                    dashboardInfo.setNewCustomers(rsNewCustomers.getInt("new_customers"));
                }
            }
        }

        return dashboardInfo;
    }

}
