package model;

public class ItemOrder {

	private int id;
	private int userAccount;
	private int item;
	private int quantity;
	private String orderDate;
	private String deliveryAddress;
	private Boolean isProcessed;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(int userAccount) {
		this.userAccount = userAccount;
	}
	
	public int getItem() {
		return item;
	}
	public void setItem(int item) {
		this.item = item;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	
	public Boolean getIsProcessed() {
		return isProcessed;
	}
	public void setIsProcessed(Boolean isProcessed) {
		this.isProcessed = isProcessed;
	}
	
}
