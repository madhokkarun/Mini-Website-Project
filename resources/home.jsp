<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.*, DAO.*, java.lang.String" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Inventory</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		<link href="css/responsive-utilities.css" rel="stylesheet">
		
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
		
		
		<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row inventory-page-header" style="border-bottom: 1px solid grey">
				<div class="col-sm-8 col-md-8 col-lg-8 inventory-page-header-title">
					<h3>Inventory</h3>
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4 inventory-page-header-buttons padding-top-sm-up-15 text-align-sm-up-right">
					<button class="btn">Log In</button>
					<button class="btn">Sign up</button>
				</div>
			</div>
			<div class="row inventory-page-content padding-top-sm-up-20">
				<div class="col-sm-8 col-md-6 col-lg-6 col-sm-offset-2 col-md-offset-3 col-lg-offset-3">
					<table class="table">
						<thead>
							<tr>
								<th>Item code</th>
								<th>Name</th>
								<th>Price</th>
								<th>Quantity</th>
							</tr>
						</thead>
						<tbody>
						
							<%for(Item item: WebsiteDAO.getItems())
								{ %>
									<tr>
										<% String formattedPrice = "$" + String.format("%,.2f", item.getPrice());
											String quantity = WebsiteDAO.getItemQuantity(item.getId());
										%>
										<td><%=item.getId() %></td>
										<td><%=item.getName() %></td>
										<td><%=formattedPrice %></td>
										<td><%=quantity %></td>
									</tr>
								<%}%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>