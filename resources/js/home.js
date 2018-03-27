$(document).ready(function(){
	
	$('#itemTable').DataTable();
	
	$('#userItemTable').DataTable({
		"columnDefs": [
		    { "orderable": false, "targets": -1 }
		  ],
		"language": {
		    "emptyTable": "No items in inventory"}
	});
	
	$('#managerItemTable').DataTable({
		"columnDefs": [
		    { "orderable": false, "targets": [-1, -2] }
		  ],
		"language": {
		    "emptyTable": "No items in inventory"}
	});
	
	$('#userMyOrdersTable').DataTable({
		"columnDefs": [
		    { "orderable": false, "targets": [-1, -2] }
		  ],
		"language": {
		    "emptyTable": "Currently you don't have any orders"}
	});
	
	
	$('#managerLogInButton').click(function(){
		$('#logInForm').find('#isUser').val("false");
	});
	
	$('#managerSignUpButton').click(function(){
		$('#signUpForm').find('#isUser').val("false");
	});
	
	$('#logInButton').click(function(){
		$('#logInForm').find('#isUser').val("true");
	});
	
	$('#signUpButton').click(function(){
		$('#signUpForm').find('#isUser').val("true");
	});
	
	
	
	
	$('.item-order-button').click(function(){
		var itemId = $(this).attr('data-item-id');
		var maxQuantity = $(this).attr('data-item-max-quantity');
		
		$('#itemOrderQuantity').attr('max', maxQuantity);
		$('#itemOrderId').val(itemId);
		$('#availableItemQuantity').val(maxQuantity);
	});
	
	
	$('.item-order-cancel-button').click(function(){
		var orderId = $(this).attr('data-item-order-id');
		var itemId = $(this).attr('data-item-id');
		var itemQuantityUpdatedValue = $(this).attr('data-item-quantity-update');

		$('#cancelOrderId').val(orderId);
		$('#cancelItemId').val(itemId);
		$('#updatedItemQuantity').val(itemQuantityUpdatedValue);
	});
	
	$('.item-order-edit-button').click(function(){
		var orderId = $(this).attr('data-item-order-id');
		$('#itemUpdateOrderId').val(orderId);
		
		var address = $(this).parent().parent().find('.order-delivery-address').text();
		var quantityOrdered = $(this).parent().parent().find('.quantity-ordered').text();
		
		$('#itemUpdateOrderQuantity').val(quantityOrdered);
		$('#itemUpdateOrderDeliveryAddress').val(address);
	});
	
	
	
	$('#userChangePasswordForm').submit(function(event){
		passwordCheck($('#userOldPassword').val().trim(), $('#userNewPassword').val().trim())
	});
	
	$('#managerChangePasswordForm').submit(function(event){
		passwordCheck($('#managerOldPassword').val().trim(), $('#managerNewPassword').val().trim())
	});
	
	
	function passwordCheck(oldPassword, newPassword)
	{
		var isValid = true;
		
		if(oldPassword != oldSessionPassword)
		{
			alert("Old password doesn't match");
			isValid = false;
			
		}
		else if(newPassword == oldSessionPassword)
		{
			alert("New password cannot be same as old password");
			isValid = false;
		}
		else if(oldPassword == newPassword)
		{
			alert("Old and new password cannot be same");
			isValid = false;
		}
		
		if(!isValid)
		{
			event.preventDefault();
			return false;
		}
		
	}
});