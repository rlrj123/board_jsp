<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Timestamp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 목록</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">
    <h2>게시물 목록</h2>
    <table border="1">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // 데이터베이스 연결
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

                // 게시물 목록 조회 쿼리
                String query = "SELECT p.post_id, p.title, p.user_id, p.created_at FROM posts p ORDER BY p.created_at DESC";
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                // 결과 출력
                while (rs.next()) {
                    int postId = rs.getInt("post_id");
                    String title = rs.getString("title");
                    String userId = rs.getString("user_id");
                    Timestamp createdAt = rs.getTimestamp("created_at");
        %>
                    <tr>
                        <td><%= postId %></td>
                        <td><a href="view_register.jsp?postId=<%= postId %>"><%= title %></a></td>
                        <td><%= userId %></td>
                        <td><%= createdAt %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
</div>

</body>
</html>
