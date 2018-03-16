package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.WebsiteDAO;
import model.Item;

public class SqlServerConnection {

		public static String connectionUrl = "jdbc:sqlserver://localhost:1433;" +  
	         "databaseName=miniWebsite;user=sa;password=km201294";
		
		public static Connection getConnection() throws SQLException
		{
			try {
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return DriverManager.getConnection(connectionUrl);
		}
		
}