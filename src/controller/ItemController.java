package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.WebsiteDAO;
import model.UserAccount;

/**
 * Servlet implementation class ItemController
 */
@WebServlet("/ItemController")
public class ItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Boolean isItemOrder = Boolean.valueOf(request.getParameter("isItemOrder"));
		Boolean isCancelOrder = Boolean.valueOf(request.getParameter("isCancelOrder"));
		
		UserAccount userAccount =  (UserAccount) request.getSession().getAttribute("userAccount");
		
		if(isItemOrder)
		{
			try {
				handleItemOrder(request, response, userAccount);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(isCancelOrder)
		{
			int orderId = Integer.valueOf(request.getParameter("cancelOrderId"));
			
			try {
				handleOrderCancel(request, response, orderId);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
			
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void handleItemOrder(HttpServletRequest request, HttpServletResponse response, UserAccount userAccount) throws SQLException, IOException
	{
		Integer userId = userAccount.getId();
		Integer itemId = Integer.valueOf(request.getParameter("itemOrderId"));
		Integer quantity = Integer.valueOf(request.getParameter("itemOrderQuantity"));
		String deliveryAddress = request.getParameter("itemOrderDeliveryAddress");
		Integer availableQuantity = Integer.valueOf(request.getParameter("availableItemQuantity"));
		
		Boolean isOrderSuccessful = WebsiteDAO.insertItemOrder(userId, itemId, quantity, deliveryAddress);
		Boolean isItemInventoryQuantityUpdateSuccessful = WebsiteDAO.updateInventoryItemQuantity((availableQuantity-quantity), itemId);
		
		if(!isItemInventoryQuantityUpdateSuccessful)
			isOrderSuccessful = false;
		
		request.getSession().setAttribute("isOrderSuccessful", isOrderSuccessful);
		response.sendRedirect("/inventory/userHome.jsp");
		
		
	}
	
	protected void handleOrderCancel(HttpServletRequest request, HttpServletResponse response, int orderId) throws SQLException, IOException
	{
		Integer updatedItemQuantity = Integer.valueOf(request.getParameter("updatedItemQuantity"));
		Integer cancelItemId = Integer.valueOf(request.getParameter("cancelItemId"));
		
		Boolean isOrderCancelSuccessful = WebsiteDAO.deleteItemOrder(orderId);
		Boolean isItemInventoryQuantityUpdateSuccessful = WebsiteDAO.updateInventoryItemQuantity((updatedItemQuantity), cancelItemId);
		
		if(!isItemInventoryQuantityUpdateSuccessful)
			isOrderCancelSuccessful = false;
		
		
		request.getSession().setAttribute("isOrderCancelSuccessful", isOrderCancelSuccessful);
		
		response.sendRedirect("/inventory/userHome.jsp");
		
		
		
	}

}
