<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.*, DAO.*, java.lang.String" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Inventory</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		<link href="css/responsive-utilities.css" rel="stylesheet">
		<link href="css/home.css" rel="stylesheet">
		
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
		<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css" rel="stylesheet" >
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css">
		
		<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
		
		<script src="js/home.js"></script>
		
	</head>
	<body>
		<script type="text/javascript"> var oldSessionPassword = "";</script>
		
		<%
			UserAccount userAccount = (UserAccount) request.getSession().getAttribute("userAccount");
			String userFullName = "";			

			if(userAccount != null)
			{
				if(userAccount.getIsManager())
				{
					request.getSession().removeAttribute("userAccount");
					response.sendRedirect("/inventory");
				}
				
				if(request.getSession().getAttribute("isPasswordChangeSuccessful") != null)
				{
					if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isPasswordChangeSuccessful"))))
					{%>
						<div class="alert alert-success alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Password changed successfully!</strong>
						</div>
						
					<%}
					
					request.getSession().removeAttribute("isPasswordChangeSuccessful");
					
					%>
						<script>oldSessionPassword = "";</script>
					<%
					
				}
				
				if(request.getSession().getAttribute("isOrderSuccessful") != null)
				{
					if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isOrderSuccessful"))))
					{
						%>
						<div class="alert alert-success alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order Successful! </strong>Open My Orders to check your order status.
						</div>
						
					<%
					}
					else
					{
						%>
						<div class="alert alert-danger alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order Unsuccessful! </strong>Something went wrong, try again later.
						</div>
						
					<%
					}
					request.getSession().removeAttribute("isOrderSuccessful");
				}
				
				if(request.getSession().getAttribute("isOrderCancelSuccessful") != null)
				{
					if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isOrderCancelSuccessful"))))
					{
						%>
						<div class="alert alert-success alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order cancelled successfully! </strong>
						</div>
						
					<%
					}
					else
					{
						%>
						<div class="alert alert-danger alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order couldn't be canceled!</strong>Something went wrong, try again later.
						</div>
						
					<%
					}
					request.getSession().removeAttribute("isOrderCancelSuccessful");
				}
				
				if(request.getSession().getAttribute("isOrderUpdateSuccessful") != null)
				{
					if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isOrderUpdateSuccessful"))))
					{
						%>
						<div class="alert alert-success alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order Updated successfully! </strong>
						</div>
						
					<%
					}
					else
					{
						%>
						<div class="alert alert-danger alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Order couldn't be updated!</strong>Something went wrong, try again later.
						</div>
						
					<%
					}
					request.getSession().removeAttribute("isOrderUpdateSuccessful");
				}
				
				userFullName = " " + userAccount.getFirstName() + " " + userAccount.getLastName();%>
				
				<script type="text/javascript"> oldSessionPassword = "<%=userAccount.getPassword()%>"</script>
			<%}
			else
				response.sendRedirect("/inventory");
			
		%>
		<div class="container-fluid">
			<div class="row inventory-page-header" style="border-bottom: 1px solid grey">
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-title">
					<h3 class="display-sm-up-inline-block">Inventory -</h3> <h4 class="display-sm-up-inline-block padding-left-sm-up-5"><%=userFullName %></h4>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-buttons padding-top-sm-up-15 text-align-sm-up-right">
					<div class="dropdown manager-dropdown display-sm-up-inline-block">
						<button class="btn btn-primary dropdown-toggle" id="managerDropdownButton" type="button" data-toggle="dropdown">User
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a id="myOrdersButton" class="pointerClickable" data-toggle="modal" data-target="#userMyOrdersDialog">My Orders</a></li>
							<li><a id="changePasswordButton" class="pointerClickable" data-toggle="modal" data-target="#userChangePasswordDialog">Change Password</a></li>
						</ul>
					</div>
					<form class="display-sm-up-inline-block" action="WebsiteController" method="POST">
						<input type="hidden" name="isLogOut" value="true">
						<input type="submit" class="btn btn-danger" id="logOutButton" value="Log Out">
					</form>
				</div>
			</div>
			<div class="row inventory-page-content padding-top-sm-up-20">
				<div class="col-sm-10 col-md-8 col-lg-8 col-sm-offset-1 col-md-offset-2 col-lg-offset-2">
					<table id="userItemTable" class="table item-table">
						<thead>
							<tr>
								<th>Item code</th>
								<th>Name</th>
								<th>Price</th>
								<th>Quantity</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						
							<%if(WebsiteDAO.getItems() != null)
							{for(Item item: WebsiteDAO.getItems())
								{ %>
									<tr>
										<% String formattedPrice = "$" + String.format("%,.2f", item.getPrice());
											String quantity = WebsiteDAO.getItemQuantity(item.getId());
										%>
										<td><%=item.getId() %></td>
										<td><%=item.getName() %></td>
										<td><%=formattedPrice %></td>
										<td><%=quantity %></td>
										<td class="text-align-sm-up-right"><button id="orderButton<%=item.getId()%>" class="btn btn-primary item-order-button" data-item-id="<%=item.getId()%>" data-item-max-quantity="<%=quantity%>" <%if(Integer.valueOf(quantity) <= 0){%>disabled<%} %> data-toggle="modal" data-target="#itemOrderDialog">Order</button></td>
									</tr>
								<%}}%>
						</tbody>
					</table>
				</div>
			</div>
			<div id="userChangePasswordDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Change Password</h4>
						</div>
						<div class="modal-body">
							<form id="userChangePasswordForm" method="POST" action="WebsiteController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" name="userOldPassword" id="userOldPassword" class="form-control" placeholder="Old Password" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" name="userNewPassword" id="userNewPassword" class="form-control" placeholder="New Password" min="8" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" title="Min 8 characters, at least one letter and one number" required>
								</div>
								<input type="hidden" name="isChangePassword" value="true">
								<div class="form-group">
									<input type="submit" class="btn btn-info" value="Change">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="itemOrderDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Order Item</h4>
						</div>
						<div class="modal-body">
							<form id="itemOrderForm" method="POST" action="ItemController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-plus"></i></span>
									<input type="number" name="itemOrderQuantity" id="itemOrderQuantity" class="form-control" placeholder="Quantity" min="1" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
									<input type="text" name="itemOrderDeliveryAddress" id="itemOrderDeliveryAddress" class="form-control" placeholder="Delivery address" required>
								</div>
								<input type="hidden" name="isItemOrder" value="true">
								<input type="hidden" id="itemOrderId" name="itemOrderId"> 
								<input type="hidden" id="availableItemQuantity" name="availableItemQuantity">
								<div class="form-group">
									<input type="submit" class="btn btn-info" value="Order">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div id="userMyOrdersDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">My Orders</h4>
						</div>
						<div class="modal-body">
							<table id="userMyOrdersTable" class="table user-my-orders-table">
								<thead>
									<tr>
										<th>Order No</th>
										<th>Name</th>
										<th>Price</th>
										<th>Quantity</th>
										<th>Address</th>
										<th>Total</th>
										<th>Is Processed?</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								
									<%if(userAccount != null)
										{
										for(ItemOrder itemOrder: WebsiteDAO.getItemOrdersByUser(userAccount.getId()))
										{ %>
											<tr>
												<% Item item = WebsiteDAO.getItem(itemOrder.getItem());
												
													String formattedPrice = "$" + String.format("%,.2f", item.getPrice());
													Integer quantityOrdered = itemOrder.getQuantity();
													
													Double total = Double.valueOf(item.getPrice()) * quantityOrdered;
													String formattedTotal = "$" + String.format("%,.2f", total);
													
													Integer availableItemQuantity = Integer.valueOf(WebsiteDAO.getItemQuantity(item.getId()));
													
												%>
												<td><%=itemOrder.getId() %></td>
												<td><%=item.getName() %></td>
												<td><%=formattedPrice %></td>
												<td class="quantity-ordered"><%=quantityOrdered %></td>
												<td class="order-delivery-address"><%=itemOrder.getDeliveryAddress() %></td>
												<td><%= formattedTotal%></td>
												<td><%if(itemOrder.getIsProcessed()){%>Yes<%}else{%>No<%} %></td>
												<td class="text-align-sm-up-right"><button id="editOrderButton<%=itemOrder.getId()%>" class="btn btn-primary item-order-edit-button" data-item-id = "<%=item.getId()%>" data-item-order-id="<%=itemOrder.getId()%>" <%if(itemOrder.getIsProcessed()){%>disabled<%} %> data-toggle="modal" data-target="#orderUpdateDialog">Edit</button></td>
												<td class="text-align-sm-up-right"><button id="cancelOrderButton<%=itemOrder.getId()%>" class="btn btn-danger item-order-cancel-button" data-item-id = "<%=item.getId()%>" data-item-quantity-update = "<%=(availableItemQuantity + quantityOrdered)%>" data-item-order-id="<%=itemOrder.getId()%>" <%if(itemOrder.getIsProcessed()){%>disabled<%} %> data-toggle="modal" data-target="#orderCancelConfirmation">Cancel</button></td>
											</tr>
										<%}}%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div id="orderCancelConfirmation" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Cancel Order</h4>
						</div>
						<div class="modal-body">
							<form id="orderCancelForm" method="POST" action="ItemController">
								<div class="form-group">
									<span>Are you sure you want to cancel your order?</label>
								</div>
								<div class="form-group display-sm-up-inline-block">
									<input type="submit" class="btn" value="Yes">
								</div>
								<div class="form-group display-sm-up-inline-block">
									<button class="btn btn-info" data-dismiss="modal">No</button>
								</div>
								<input type="hidden" name="isCancelOrder" value="true">
								<input type="hidden" id="cancelOrderId" name="cancelOrderId"> 
								<input type="hidden" id="cancelItemId" name="cancelItemId">
								<input type="hidden" id="updatedItemQuantity" name="updatedItemQuantity">
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="orderUpdateDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Update Order</h4>
						</div>
						<div class="modal-body">
							<form id="orderUpdateForm" method="POST" action="ItemController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-plus"></i></span>
									<input type="number" name="itemUpdateOrderQuantity" id="itemUpdateOrderQuantity" class="form-control" placeholder="Quantity" min="1" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
									<input type="text" name="itemUpdateOrderDeliveryAddress" id="itemUpdateOrderDeliveryAddress" class="form-control" placeholder="Delivery address" required>
								</div>
								<input type="hidden" name="isUpdateOrder" value="true">
								<input type="hidden" id="itemUpdateOrderId" name="itemUpdateOrderId"> 
								<div class="form-group">
									<input type="submit" class="btn btn-info" value="Update">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>