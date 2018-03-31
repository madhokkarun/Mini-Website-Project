<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.*, DAO.*, java.lang.String, java.util.Date, java.text.SimpleDateFormat" %>
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
			if(!userAccount.getIsManager())
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
			
			if(request.getSession().getAttribute("isItemAddSuccessful") != null)
			{
				if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isItemAddSuccessful"))))
				{%>
					<div class="alert alert-success alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Item Added successfully!</strong>
					</div>
				<%}
				
				request.getSession().removeAttribute("isItemAddSuccessful");
				
			}
			
			if(request.getSession().getAttribute("isItemDeleteSuccessful") != null)
			{
				if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isItemDeleteSuccessful"))))
				{%>
					<div class="alert alert-success alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Item Deleted successfully!</strong>
					</div>
				<%}
				
				request.getSession().removeAttribute("isItemDeleteSuccessful");
				
			}
			
			if(request.getSession().getAttribute("isItemUpdateSuccessful") != null)
			{
				if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isItemUpdateSuccessful"))))
				{%>
					<div class="alert alert-success alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Item Updated successfully!</strong>
					</div>
				<%}
				
				request.getSession().removeAttribute("isItemUpdateSuccessful");
				
			}
			userFullName = " " + userAccount.getFirstName() + " " + userAccount.getLastName();
			
			%><script type="text/javascript"> oldSessionPassword = "<%=userAccount.getPassword()%>"</script>
		<%}
		else
			response.sendRedirect("/inventory");
		
		%>
		<div class="container-fluid">
			<div class="row inventory-page-header" style="border-bottom: 1px solid grey">
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-title">
					<h3 class="display-sm-up-inline-block">Inventory - </h3><h4 class="display-sm-up-inline-block padding-left-sm-up-5"><%=userFullName %></h4>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-buttons padding-top-sm-up-15 text-align-sm-up-right">
					<button class="btn btn-primary" id="addItemButton" type="button" data-target="#addItemDialog" data-toggle="modal">Add Item</button>
					<div class="dropdown manager-dropdown display-sm-up-inline-block">
						<button class="btn btn-primary dropdown-toggle" id="managerDropdownButton" type="button" data-toggle="dropdown">Manager
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a id="myOrdersButton" class="pointerClickable" data-toggle="modal" data-target="#manageOrdersDialog">Manage Orders</a></li>
							<li><a id="changePasswordButton" class="pointerClickable" data-toggle="modal" data-target="#managerChangePasswordDialog">Change Password</a></li>
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
					<table id="managerItemTable" class="table item-table">
						<thead>
							<tr>
								<th>Item code</th>
								<th>Name</th>
								<th>Price</th>
								<th>Quantity</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						
							<%if(WebsiteDAO.getItems() != null)
							{for(Item item: WebsiteDAO.getItems())
								{ %>
									<tr>
										<%  String onlyNumericPrice = String.format("%.2f", item.getPrice());
											String formattedPrice = "$" + String.format("%,.2f", item.getPrice());
											String quantity = WebsiteDAO.getItemQuantity(item.getId());
										%>
										<td><%=item.getId() %></td>
										<td class="item-name"><%=item.getName() %></td>
										<td class="item-price"><%=formattedPrice %></td>
										<td class="item-quantity"><%=quantity %></td>
										<td class="text-align-sm-up-right"><a class="pointerClickable item-edit-button" id="itemEditButton" data-item-price="<%=onlyNumericPrice%>" data-item-id="<%=item.getId()%>" data-toggle="modal" data-target="#updateItemDialog"><span class="glyphicon glyphicon-pencil"></span></a></td>
										<td class="text-align-sm-up-right"><a class="pointerClickable item-delete-button" id="itemDeleteButton" data-item-id="<%=item.getId()%>" data-toggle="modal" data-target="#itemDeleteConfirmation"><span class="glyphicon glyphicon-trash"></span></button></td>
									</tr>
								<%}}%>
						</tbody>
					</table>
				</div>
			</div>
			<div id="addItemDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Add Item</h4>
						</div>
						<div class="modal-body">
							<form id="addItemForm" method="POST" action="ItemController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
									<input type="text" name="itemAddName" id="itemAddName" class="form-control" placeholder="Name" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
									<input type="number" name="itemAddPrice" id="itemAddPrice" class="form-control" placeholder="Price" step=".01" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-plus"></i></span>
									<input type="number" name="itemAddQuantity" id="itemAddQuantity" class="form-control" placeholder="Quantity" min="0" required>
								</div>
								<input type="hidden" name="isAddItem" value="true">
								<input type="submit" class="btn btn-info" value="Add">
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="updateItemDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Add Item</h4>
						</div>
						<div class="modal-body">
							<form id="updateItemForm" method="POST" action="ItemController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
									<input type="text" name="itemUpdateName" id="itemUpdateName" class="form-control" placeholder="Name" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
									<input type="number" name="itemUpdatePrice" id="itemUpdatePrice" class="form-control" placeholder="Price" step=".01" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-plus"></i></span>
									<input type="number" name="itemUpdateQuantity" id="itemUpdateQuantity" class="form-control" placeholder="Quantity" min="0" required>
								</div>
								<input type="hidden" name="isUpdateItem" value="true">
								<input type="hidden" name="itemUpdateId" id="itemUpdateId">
								<input type="submit" class="btn btn-info" value="Update">
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="itemDeleteConfirmation" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Delete Order</h4>
						</div>
						<div class="modal-body">
							<form id="itemDeleteForm" method="POST" action="ItemController">
								<div class="form-group">
									<span>Are you sure you want to delete this item?</label>
								</div>
								<div class="form-group display-sm-up-inline-block">
									<input type="submit" class="btn" value="Yes">
								</div>
								<div class="form-group display-sm-up-inline-block">
									<button class="btn btn-info" data-dismiss="modal">No</button>
								</div>
								<input type="hidden" name="isDeleteItem" value="true">
								<input type="hidden" id="itemDeleteId" name="itemDeleteId"> 
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="manageOrdersDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">My Orders</h4>
						</div>
						<div class="modal-body">
							<table id="manageOrdersTable" class="table manage-orders-table">
								<thead>
									<tr>
										<th>Order No</th>
										<th>Name</th>
										<th>Price</th>
										<th>Quantity</th>
										<th>Address</th>
										<th>Total</th>
										<th>Is Processed?</th>
									</tr>
								</thead>
								<tbody>
								
									<%if(userAccount != null)
										{
										for(ItemOrder itemOrder: WebsiteDAO.getItemOrders())
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
												<td><input type="checkbox" class="is-item-processed" data-order-id = "<%=itemOrder.getId()%>" <%if(itemOrder.getIsProcessed()){%> checked<%} %>></td>
											</tr>
										<%}}%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>