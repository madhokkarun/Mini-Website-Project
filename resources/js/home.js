$(document).ready(function(){
	$('#itemTable').DataTable();
	
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
	
});