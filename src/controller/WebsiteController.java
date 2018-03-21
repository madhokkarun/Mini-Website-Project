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
import sun.usagetracker.UsageTrackerClient;

/**
 * Servlet implementation class WebsiteController
 */
@WebServlet("/WebsiteController")
public class WebsiteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WebsiteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Boolean isSignUp = Boolean.valueOf(request.getParameter("isSignUp"));
		Boolean isLogIn = Boolean.valueOf(request.getParameter("isLogIn"));
		Boolean isUser = Boolean.valueOf(request.getParameter("isUser"));
		Boolean isLogOut = Boolean.valueOf(request.getParameter("isLogOut"));
		Boolean isChangePassword = Boolean.valueOf(request.getParameter("isChangePassword"));
		
		if(isSignUp == true)
		{
			try {
				handleSignUp(request, response, isUser);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(isLogIn == true)
		{
			try {
				handleLogIn(request, response, isUser);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(isLogOut == true)
			handleLogOut(request, response);
		else if(isChangePassword == true)
		{
			try {
				handlePasswordChange(request, response);
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
	
	protected void handleSignUp(HttpServletRequest request, HttpServletResponse response, Boolean isUser) throws SQLException, ServletException, IOException
	{
		UserAccount userAccount = new UserAccount();
		Boolean isSignUpSuccessful = false;
		
		Boolean isUserExists = WebsiteDAO.getUser(request.getParameter("signUpEmail"));
		
		if(!isUserExists)
		{
			userAccount.setFirstName(request.getParameter("signUpFirstName"));
			userAccount.setLastName(request.getParameter("signUpLastName"));
			userAccount.setEmail(request.getParameter("signUpEmail"));
			userAccount.setPassword(request.getParameter("signUpPassword"));
			userAccount.setIsManager(!(isUser));
			
			isSignUpSuccessful = WebsiteDAO.insertUser(userAccount);
		}
		
		request.getSession().setAttribute("isSignUpSuccessful",isSignUpSuccessful);
		response.sendRedirect("/inventory");
		
	}
	
	protected void handleLogIn(HttpServletRequest request, HttpServletResponse response, Boolean isUser) throws SQLException, ServletException, IOException
	{
		Boolean isLoginSuccessful = false;
		
		UserAccount userAccount = new UserAccount();
		
		userAccount = WebsiteDAO.getUser(request.getParameter("logInEmail"), request.getParameter("logInPassword"), !(isUser));
		
		if(userAccount.getId() > 0)
			isLoginSuccessful = true;
		
		request.getSession().setAttribute("isCredentialsValid", isLoginSuccessful);
		
		if(!isLoginSuccessful)
			response.sendRedirect("/inventory");
		else if(isLoginSuccessful)
		{
			request.getSession().setAttribute("userAccount", userAccount);
			
			if(isUser)
				response.sendRedirect("/inventory/userHome.jsp");
			else
				response.sendRedirect("/inventory/managerHome.jsp");
		}
	}
	
	protected void handleLogOut(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		request.getSession().removeAttribute("isSignUpSuccessful");
		request.getSession().removeAttribute("userAccount");
		request.getSession().removeAttribute("isCredentialsValid");
		request.getSession().removeAttribute("isPasswordChangeSuccessful");
		
		response.sendRedirect("/inventory");
	}
	
	protected void handlePasswordChange(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException
	{
		UserAccount userAccount = (UserAccount) request.getSession().getAttribute("userAccount");
		
		Boolean isManager = userAccount.getIsManager();
		Integer id = userAccount.getId();
		String email = userAccount.getEmail();
		
		String oldPassword = "";
		String newPassword = "";
		
		if(isManager)
		{
			oldPassword = request.getParameter("managerOldPassword");
			newPassword = request.getParameter("managerNewPassword");
		}
		else
		{
			oldPassword = request.getParameter("userOldPassword");
			newPassword = request.getParameter("userNewPassword");
		}
		
		Boolean isPasswordChangeSuccessful = WebsiteDAO.updateUserPassword(id, newPassword, oldPassword);
		
		if(isPasswordChangeSuccessful)
		{
			request.getSession().setAttribute("isPasswordChangeSuccessful", isPasswordChangeSuccessful);
			request.getSession().setAttribute("userAccount", WebsiteDAO.getUser(id));
			
			response.sendRedirect("/inventory");
		}
	}
	
}
