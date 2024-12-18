package com.aadhar_management_system.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionHelper {
	
	private static final String dbUrl = "jdbc:mysql://localhost:3306/ams?useSSL=false";
	private static final String dbUname = "root";
	private static final String dbPassword = "root";
	static Connection connection = null;
	
	public static void loadDriver() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		try {
			connection = DriverManager.getConnection(dbUrl, dbUname, dbPassword);
		} catch (SQLException e) {
			e.printStackTrace();                 
		}
		return connection;
	}
	
	public static void CloseConnection(Connection connection) {
			try {
				connection.close();
			}catch( Exception e) {
				e.printStackTrace();
			}
	}
}
