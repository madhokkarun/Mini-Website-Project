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
		<div class="container-fluid">
			<div class="row inventory-page-header" style="border-bottom: 1px solid grey">
				<div class="col-sm-8 col-md-8 col-lg-8 inventory-page-header-title">
					<h3>Inventory</h3>
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4 inventory-page-header-buttons padding-top-sm-up-15 text-align-sm-up-right">
					<button class="btn" id="logInButton" data-toggle="modal" data-target="#logInDialog">Log In</button>
					<button class="btn" id="signUpButton" data-toggle="modal" data-target="#signUpDialog">Sign up</button>
				</div>
			</div>
			<div class="row inventory-page-content padding-top-sm-up-20">
				<div class="col-sm-8 col-md-6 col-lg-6 col-sm-offset-2 col-md-offset-3 col-lg-offset-3">
					<table id="itemTable" class="table item-table">
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
			<!-- Bootstrap Modal Dialog for Log In -->
			<div id="logInDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Log In</h4>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input type="email" name="email" id= "logInEmail" class="form-control" placeholder="Email" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" name="password" id= "logInPassword" class="form-control" placeholder="Password" min="8" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" title="Min 8 characters, at least one letter and one number" required>
								</div>
								<div class="form-group">
									<input type="submit" class="btn btn-info" value="Log In">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Bootstrap Modal Dialog for Sign Up -->
			<div id="signUpDialog" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Sign Up</h4>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
									<input type="text" name="signUpFirstName" id= "signUpfirstName" class="form-control" placeholder="First name" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
									<input type="text" name="signUpLastName" id= "signUpLastName" class="form-control" placeholder="Last name">
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input type="email" name="signUpEmail" id= "signUpEmail" class="form-control" placeholder="Email" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" name="signUpPassword" id= "signUpPassword" class="form-control" placeholder="Password" min="8" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" title="Min 8 characters, at least one letter and one number" required>
								</div>
								<div class="form-group">
									<input type="submit" class="btn btn-info" value="Sign Up">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>