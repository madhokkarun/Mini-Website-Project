package DAO;

import java.nio.file.attribute.UserPrincipalNotFoundException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SqlServerConnection;
import constants.WebsiteConstants;
import model.Inventory;
import model.Item;
import model.ItemOrder;
import model.UserAccount;

public class WebsiteDAO {
	
	/**
	 * Get all the Item records from database
	 * @return: returns list of all the records in form of Item object
	 * @throws SQLException
	 */
	
	public static List<Item> getItems() throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		List<Item> itemList = new ArrayList();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			Item item = new Item();
			
			item.setId(rs.getInt(index++));
			item.setName(rs.getString(index++));
			item.setPrice(rs.getDouble(index++));
			item.setDateAdded(rs.getString(index++));
			
			itemList.add(item);
		}
		
		conn.close();
		
		return itemList;
		
	}
	
	/**
	 * Get all the User account records from database
	 * @return: returns list of all the records in form of UserAccount object
	 * @throws SQLException
	 */
	
	public static List<UserAccount> getUserAccounts() throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		List<UserAccount> userAccountList = new ArrayList();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_USER_ACCOUNT);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			UserAccount userAccount =  new UserAccount();
			
			userAccount.setId(rs.getInt(index++));
			userAccount.setFirstName(rs.getString(index++));
			userAccount.setLastName(rs.getString(index++));
			userAccount.setEmail(rs.getString(index++));
			userAccount.setPassword(rs.getString(index++));
			userAccount.setIsManager(rs.getBoolean(index++));
			
			userAccountList.add(userAccount);
		}
		
		conn.close();
		
		return userAccountList;
	}
	
	/**
	 * Get all the Item order records from database
	 * @return: returns list of all the records in form of ItemOrder object
	 * @throws SQLException
	 */
	public static List<ItemOrder> getItemOrders() throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		List<ItemOrder> itemOrderList = new ArrayList();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM_ORDER);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			ItemOrder itemOrder = new ItemOrder();
			
			itemOrder.setId(rs.getInt(index++));
			itemOrder.setUserAccount(rs.getInt(index++));
			itemOrder.setItem(rs.getInt(index++));
			itemOrder.setQuantity(rs.getInt(index++));
			itemOrder.setOrderDate(rs.getString(index++));
			itemOrder.setDeliveryAddress(rs.getString(index++));
			itemOrder.setIsProcessed(rs.getBoolean(index++));
			
			itemOrderList.add(itemOrder);
		}
		
		conn.close();
		
		return itemOrderList;
	}
	
	/**
	 * Get all the Item order records for a particular user from database
	 * @return: returns list of all the records in form of ItemOrder object
	 * @throws SQLException
	 */
	public static List<ItemOrder> getItemOrdersByUser(Integer userId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		List<ItemOrder> itemOrderList = new ArrayList();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM_ORDER_BY_USER);
		
		int i = 1;
		
		ps.setInt(i++, userId);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			ItemOrder itemOrder = new ItemOrder();
			
			itemOrder.setId(rs.getInt(index++));
			itemOrder.setUserAccount(rs.getInt(index++));
			itemOrder.setItem(rs.getInt(index++));
			itemOrder.setQuantity(rs.getInt(index++));
			itemOrder.setOrderDate(rs.getString(index++));
			itemOrder.setDeliveryAddress(rs.getString(index++));
			itemOrder.setIsProcessed(rs.getBoolean(index++));
			
			itemOrderList.add(itemOrder);
		}
		
		conn.close();
		
		return itemOrderList;
	}
	
	/**
	 * Get all the Inventory records from database
	 * @return: returns list of all the records in form of inventory object
	 * @throws SQLException
	 */
	public static List<Inventory> getInventory() throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		List<Inventory> inventoryList = new ArrayList();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_INVENTORY);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			Inventory inventory = new Inventory();
			
			inventory.setId(rs.getInt(index++));
			inventory.setItem(rs.getInt(index++));
			inventory.setQuantity(rs.getInt(index++));
			
			inventoryList.add(inventory);
			
		}
		
		conn.close();
		
		return inventoryList;
	}
	
	/**
	 * 
	 * @param item : item id for which quantity is required from inventory
	 * @return: returns the quantity of that item, if no record found in inventory then returns 0
	 * @throws SQLException
	 */
	public static String getItemQuantity(int item) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM_QUANTITY);
		
		int index = 1;
		int quantity = 0;
		
		ps.setInt(index++, item);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int i = 1;
			
			quantity = rs.getInt(i++);
		}
		
		conn.close();
		
		return String.valueOf(quantity);
	}
	
	public static Boolean getUser(String email) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_USER);
		
		int index = 1;
		boolean isUserExists = false;
		
		ps.setString(index++, email);
		
		ResultSet rs = ps.executeQuery();
		
		if(rs.next())
			isUserExists = true;
		
		conn.close();
		
		return isUserExists;
	}
	
	public static UserAccount getUser(int id) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_USER_ACCOUNT_ID);
		
		UserAccount userAccount = new UserAccount();
		
		int i = 1;
		
		ps.setInt(i++, id);
		
		ResultSet rs = ps.executeQuery();
		
		if(rs.next())
		{
			int index = 1;
			userAccount.setId(rs.getInt(index++));
			userAccount.setFirstName(rs.getString(index++));
			userAccount.setLastName(rs.getString(index++));
			userAccount.setEmail(rs.getString(index++));
			userAccount.setPassword(rs.getString(index++));
			userAccount.setIsManager(rs.getBoolean(index++));
		}
		
		conn.close();
		
		return userAccount;
	}
	
	public static Boolean insertUser(UserAccount userAccount) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.INSERT_USER_ACCOUNT);
		
		int index = 1;
		
		ps.setString(index++, userAccount.getFirstName());
		ps.setString(index++, userAccount.getLastName());
		ps.setString(index++, userAccount.getEmail());
		ps.setString(index++, userAccount.getPassword());
		ps.setBoolean(index++, userAccount.getIsManager());
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected > 0)
			return true;
		else
			return false;
	}
	
	public static UserAccount getUser(String email, String password, boolean isManager) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_USER_EMAIL_PASSWORD);
		
		int index = 1;
		
		ps.setString(index++, email);
		ps.setString(index++, password);
		ps.setBoolean(index++, isManager);
		
		ResultSet rs = ps.executeQuery();
		
		UserAccount userAccount = new UserAccount();
		
		while(rs.next())
		{
			int i = 1;
			
			userAccount.setId(rs.getInt(i++));
			userAccount.setFirstName(rs.getString(i++));
			userAccount.setLastName(rs.getString(i++));
			userAccount.setEmail(rs.getString(i++));
			userAccount.setPassword(rs.getString(i++));
			userAccount.setIsManager(rs.getBoolean(i++));
		}
		
		conn.close();
		
		return userAccount;
		
	}
	
	public static Boolean updateUserPassword( Integer id, String newPassword, String oldPassword) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.UPDATE_PASSWORD);
		
		int index = 1;
		
		ps.setString(index++, newPassword);
		ps.setInt(index++, id);
		ps.setString(index++, oldPassword);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
		
	}
	
	public static Boolean insertItemOrder(Integer userId, Integer itemId, Integer quantity, String deliveryAddress) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.INSERT_ITEM_ORDER);
		
		int index = 1;
		
		ps.setInt(index++, userId);
		ps.setInt(index++, itemId);
		ps.setInt(index++, quantity);
		ps.setString(index++, deliveryAddress);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
	}
	
	public static Boolean updateInventoryItemQuantity(Integer quantity, Integer itemId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.UPDATE_INVENTORY_ITEM_QUANTITY);
		
		int index = 1;
		
		ps.setInt(index++, quantity);
		ps.setInt(index++, itemId);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
	}
	
	public static Item getItem(Integer itemId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		Item item  = new Item();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM_ID);
		
		int i = 1;
		
		ps.setInt(i++, itemId);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			item.setId(rs.getInt(index++));
			item.setName(rs.getString(index++));
			item.setPrice(rs.getDouble(index++));
			item.setDateAdded(rs.getString(index++));
			
		}
		
		conn.close();
		
		return item;
		
	}
	
	public static Boolean deleteItemOrder(Integer orderId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.DELETE_ITEM_ORDER);
		
		int index = 1;
		
		ps.setInt(index++, orderId);
		
		int rowAffected = ps.executeUpdate();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
		
	}
	
	public static Boolean updateItemOrder(Integer id, Integer quantity, String deliveryAddress) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.UPDATE_ITEM_ORDER);
		
		int index = 1;
		
		ps.setInt(index++, quantity);
		ps.setString(index++, deliveryAddress);
		ps.setInt(index++, id);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
		
	}
	
	public static ItemOrder getItemOrder(Integer orderId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		ItemOrder itemOrder  = new ItemOrder();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.SELECT_ITEM_ORDER_ID);
		
		int i = 1;
		
		ps.setInt(i++, orderId);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			int index = 1;
			
			itemOrder.setId(rs.getInt(index++));
			itemOrder.setUserAccount(rs.getInt(index++));
			itemOrder.setItem(rs.getInt(index++));
			itemOrder.setQuantity(rs.getInt(index++));
			itemOrder.setOrderDate(rs.getString(index++));
			itemOrder.setDeliveryAddress(rs.getString(index++));
			itemOrder.setIsProcessed(rs.getBoolean(index++));
			
		}
		
		conn.close();
		
		return itemOrder;
		
	}
	
	public static Boolean insertItem(Item item, Integer quantity) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.ADD_ITEM);
		
		int index = 1;
		
		ps.setString(index++, item.getName());
		ps.setDouble(index++, item.getPrice());
		
		ResultSet rs = ps.executeQuery();
		
		int itemId = 0;
		
		while(rs.next())
			itemId = rs.getInt(1);
		
		ps = conn.prepareStatement(WebsiteConstants.ADD_QUANTITY_INVENTORY);
		
		index = 1;
		
		ps.setInt(index++, itemId);
		ps.setInt(index++, quantity);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected > 0 && itemId > 0)
			return true;
		else
			return false;
	} 
	
	public static Boolean deleteItem(Integer itemId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.DELETE_ITEM_INVENTORY);
		
		int index = 1;
		ps.setInt(index, itemId);
		int inventoryRowAffected = ps.executeUpdate();
		
		
		ps = conn.prepareStatement(WebsiteConstants.DELETE_ITEM_ORDER_ITEM);
		
		index = 1;
		ps.setInt(index, itemId);
		int itemOrderRowAffected = ps.executeUpdate();
		
		ps = conn.prepareStatement(WebsiteConstants.DELETE_ITEM);
		
		index = 1;
		
		ps.setInt(index++, itemId);
		
		int itemRowAffected = ps.executeUpdate();
		
		if(itemRowAffected == 1 && inventoryRowAffected == 1 || itemOrderRowAffected > 0)
			return true;
		else
			return false;
		
	}
	
	public static Boolean updateItem(Item item, Integer quantity) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.UPDATE_ITEM);
		
		int index = 1;
		
		ps.setString(index++, item.getName());
		ps.setDouble(index++, item.getPrice());
		ps.setInt(index++, item.getId());
		
		int rowAffected = ps.executeUpdate();
		
		Boolean isInventoryUpdated = updateInventoryItemQuantity(quantity, item.getId());
		
		if(rowAffected == 1 && isInventoryUpdated)
			return true;
		else
			return false;
	}
	
	public static Boolean updateItemOrderProcessing(Boolean isProcessed, Integer orderId) throws SQLException
	{
		Connection conn = SqlServerConnection.getConnection();
		
		PreparedStatement ps = conn.prepareStatement(WebsiteConstants.UPDATE_ORDER_PROCESSING);
		
		int index = 1;
		
		ps.setBoolean(index++, isProcessed);
		ps.setInt(index++, orderId);
		
		int rowAffected = ps.executeUpdate();
		
		conn.close();
		
		if(rowAffected == 1)
			return true;
		else
			return false;
	}
	

}
