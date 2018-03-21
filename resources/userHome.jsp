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
				
				userFullName = " " + userAccount.getFirstName() + " " + userAccount.getLastName();
			}
			else
				response.sendRedirect("/inventory");
			
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
			}
		%>
		<script> var oldSessionPassword = "<%=userAccount.getPassword()%>"</script>
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
							<li><a id="myOrdersButton">My Orders</a></li>
							<li><a id="changePasswordButton" data-toggle="modal" data-target="#userChangePasswordDialog">Change Password</a></li>
						</ul>
					</div>
					<form class="display-sm-up-inline-block" action="WebsiteController" method="POST">
						<input type="hidden" name="isLogOut" value="true">
						<input type="submit" class="btn btn-danger" id="logOutButton" value="Log Out">
					</form>
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
								<th></th>
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
										<td><button class="btn btn-primary" data-item-id="<%=item.getId()%>" id="orderButton<%=item.getId()%>">Order</button></td>
									</tr>
								<%}%>
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
		</div>
	</body>
</html>