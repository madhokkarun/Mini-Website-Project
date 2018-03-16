package constants;

public class WebsiteConstants {

	public static final String SELECT_ITEM = "SELECT * FROM item";
	public static final String SELECT_USER_ACCOUNT = "SELECT * FROM userAccount";
	public static final String SELECT_ITEM_ORDER = "SELECT * FROM itemOrder";
	public static final String SELECT_INVENTORY = "SELECT * FROM inventory";
	
	public static final String SELECT_ITEM_QUANTITY = "SELECT quantity FROM inventory WHERE item = ?"; 
	
	
}
