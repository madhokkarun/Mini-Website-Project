package constants;

public class WebsiteConstants {

	public static final String SELECT_ITEM = "SELECT * FROM item";
	public static final String SELECT_USER_ACCOUNT = "SELECT * FROM userAccount";
	public static final String SELECT_ITEM_ORDER = "SELECT * FROM itemOrder";
	public static final String SELECT_INVENTORY = "SELECT * FROM inventory";
	
	public static final String SELECT_ITEM_QUANTITY = "SELECT quantity FROM inventory WHERE item = ?"; 
	public static final String SELECT_USER = "SELECT id FROM userAccount WHERE email = ?";
	public static final String SELECT_USER_EMAIL_PASSWORD = "SELECT * FROM userAccount WHERE email = ? and password = ? COLLATE SQL_Latin1_General_CP1_CS_AS and isManager = ?";
	public static final String SELECT_USER_ACCOUNT_ID = "SELECT * FROM userAccount WHERE id = ?";
	
	public static final String INSERT_USER_ACCOUNT = "INSERT INTO userAccount(first_name, last_name, email, password, isManager) VALUES (?,?,?,?,?)";
	
	public static final String UPDATE_PASSWORD = "UPDATE userAccount SET password = ? WHERE id= ? AND password = ? COLLATE SQL_Latin1_General_CP1_CS_AS";
	
}
