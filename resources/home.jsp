<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.*, DAO.*, java.lang.String" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Inventory</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		
		
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
		<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css" rel="stylesheet" >
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css">
		
		<link href="css/responsive-utilities.css" rel="stylesheet">
		<link href="css/home.css" rel="stylesheet">
		
		<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
		
		<script src="js/home.js"></script>
		
	</head>
	<body>
		<%
			UserAccount userAccount = (UserAccount) request.getSession().getAttribute("userAccount");
			
			if(request.getSession().getAttribute("isSignUpSuccessful") != null)
			{
				if(Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isSignUpSuccessful"))))
				{%>
					<div class="alert alert-success alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Sign up successful!</strong> Log In to use the website
					</div>
				<%
				}
				else
				{%>
					<div class="alert alert-danger alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Sign up unsuccessful!</strong> User already exists
					</div>
				<%}
				request.getSession().removeAttribute("isSignUpSuccessful");
			}
		
			if(userAccount != null)
			{
				if(userAccount.getIsManager())
					response.sendRedirect("/inventory/managerHome.jsp");
				else
					response.sendRedirect("/inventory/userHome.jsp");
			}
			else if(request.getSession().getAttribute("isCredentialsValid") != null)
			{
				if(!Boolean.valueOf(String.valueOf(request.getSession().getAttribute("isCredentialsValid"))))
				{
				%>
					<div class="alert alert-danger alert-dismissible">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Invalid Email or Password!</strong>
					</div>
				<%
				request.getSession().removeAttribute("isCredentialsValid");
				}
			}
		%>
		<div class="container-fluid">
			<div class="row inventory-page-header" style="border-bottom: 1px solid grey">
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-title">
					<h3>Inventory</h3>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 inventory-page-header-buttons padding-top-sm-up-15 text-align-sm-up-right">
					<div class="dropdown manager-dropdown display-sm-up-inline-block">
						<button class="btn btn-primary dropdown-toggle" id="managerDropdownButton" type="button" data-toggle="dropdown">Manager
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a id="managerLogInButton" class="pointerClickable" data-toggle="modal" data-target="#logInDialog">Log In</a></li>
							<li><a id="managerSignUpButton" class="pointerClickable" data-toggle="modal" data-target="#signUpDialog">Sign Up</a></li>
						</ul>
					</div>
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
							<form id="logInForm" method="POST" action="WebsiteController">
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input type="email" name="logInEmail" id="logInEmail" class="form-control" placeholder="Email" required>
								</div>
								<div class="form-group input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" name="logInPassword" id= "logInPassword" class="form-control" placeholder="Password" required>
								</div>
								<input type="hidden" id="isUser" name="isUser">
								<input type="hidden" name="isLogIn" value="true">
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
							<form id="signUpForm" method="POST" action="WebsiteController">
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
								<input type="hidden" id="isUser" name="isUser">
								<input type="hidden" name="isSignUp" value="true">
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