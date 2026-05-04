package com.ecosprout.util;

import java.sql.*;

/**
 * DBUtil - Utility class for obtaining database connections.
 * Update URL, USER, and PASSWORD to match your local MySQL setup.
 */
public class DBUtil {

    private static final String URL      = "jdbc:mysql://localhost:3306/ecosprout";
    private static final String USER     = "root";
    private static final String PASSWORD = "";

    /**
     * Returns a new MySQL connection. Caller is responsible for closing it.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
