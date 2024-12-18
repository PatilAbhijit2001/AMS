package com.aadhar_management_system.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.aadhar_management_system.dto.UserDTO;
import com.aadhar_management_system.service.*;
import com.google.gson.Gson;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;


@WebServlet("/AllServletController")
@MultipartConfig
public class AllServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AllServletController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String on = request.getParameter("method");
		try {
			switch (on) {
			case "insert":
				insertUser(request,response);
				break;
			case "login":
				loginUser(request,response);
				break;
			case "update":
				updateUser(request,response);
				break;
			case"logout":
				log_out(request,response);
				break;
			case"assign_users_to_juniors":
				assign_users_to_juniors(request,response);
				break;
			case"selectAllUsers":
				selectAllUsers(request,response);
				break;
			case"toUpdate":
				toUpdate(request,response);
				break;
			case"selectJuniorUsers":
				selectJuniorUsers(request,response);
				break;
			case"insertDocuments":
				insertDocuments(request,response);
				break;
			case"checkDocuments":
				checkDocuments(request,response);
				break;
			case"selectAllJuniors":
				selectAllJuniors(request,response);
				break;
			case"selectDocuments":
				selectDocuments(request,response);
				break;
			case"checkSession":
				checkSession(request,response);
				break;
			}
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
                                                                                                                                                    
	private void checkSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("checkSession");
		PrintWriter printWriter = response.getWriter();
		HttpSession session = request.getSession(false);
        if (session != null) {
            session.setMaxInactiveInterval(10000); 
            response.setStatus(HttpServletResponse.SC_OK);
            printWriter.write("true");
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session expired or invalid.");
        	printWriter.write("false");
        }
        
	}

	private void selectDocuments(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("selectDocuments");
		UserService userService = new UserServiceImpl();
		JSONObject jsonObject = new JSONObject();
		PrintWriter printWriter = response.getWriter();

		String id = request.getParameter("userId");
		int userId =0;
		if(id != null) {
			 userId = Integer.parseInt(id);
		}
		jsonObject = userService.selectDocuments(userId);
		
		response.setContentType("application/json");
		printWriter.write(jsonObject.toString());
	}

	private void selectAllJuniors(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("selectAllJuniors");
		UserService userServicejunior = new UserServiceImpl();
		List<UserDTO> listJunior = userServicejunior.selectAllJunior();
		response.setContentType("application/json");
		Gson gson = new Gson();
		PrintWriter out = response.getWriter();
		String json = gson.toJson(listJunior);
		out.write(json);
	}

	private void checkDocuments(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException {
		System.out.println("checkDocuments");
 		HttpSession session = request.getSession();
		PrintWriter printWriter = response.getWriter();
		JSONObject jsonObject = new JSONObject();
		int id = (int) session.getAttribute("id");
		UserService userService = new UserServiceImpl();
		jsonObject = userService.checkDocuments(id);
		response.setContentType("application/json");
		printWriter.write(jsonObject.toString());
	}

	private void insertDocuments(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
		System.out.println("insertDocuments");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		ServletContext context = getServletContext();
		int id = (int) session.getAttribute("id");
		String docType = StringUtils.trimToEmpty(request.getParameter("docType"));
		Part file = request.getPart("document");
		String fileName = file.getSubmittedFileName();
		if (file == null || file.getSubmittedFileName().isEmpty())
		{
			out.write("false");    
		} else {
			try {
				String randomString = RandomStringUtils.randomAlphanumeric(6);
				String extension = FilenameUtils.getExtension(fileName);
				String newFileName = System.currentTimeMillis() + randomString + "." + extension;
				String folderName = "documents";
		        String folderPath = context.getRealPath("")+folderName;
		        String uploadPath = folderPath + File.separator + newFileName;
				try (FileOutputStream fileOutputStream = new FileOutputStream(uploadPath);
						InputStream inputStream = file.getInputStream()) {
					byte[] data = new byte[inputStream.available()];
					inputStream.read(data);
					fileOutputStream.write(data);
				} catch (Exception e) {
					e.printStackTrace();
					out.write("false");
				}
				UserDTO userDTO = new UserDTO();
				userDTO.setDocFileName(newFileName);
				userDTO.setDocumentType(docType);
				userDTO.setId(id);
				UserService userService = new UserServiceImpl();
				int status = userService.insertDocument(userDTO);
				if (status > 0) {
					out.write("true");
				} else {
					out.write("false");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void selectJuniorUsers(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("selectJuniorUsers");
		String userId = request.getParameter("userId");
		String path = request.getContextPath();
		UserService userService = new UserServiceImpl();
		ArrayList<String[]> userDetails = new ArrayList<>();
		userDetails = userService.selectJuniorUsers(userId,path);
		response.setContentType("application/json");
		Gson gson = new Gson();
		PrintWriter out = response.getWriter();
		String json = gson.toJson(userDetails);
		out.write(json);
	}
                                                                                                                                                                                                                                                                      
	private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException {
		System.out.println("toUpdate");
		String userId = request.getParameter("userId");
		PrintWriter out = response.getWriter();
		int id = Integer.parseInt(userId); 
		UserService userService = new UserServiceImpl();
		UserDTO userDTO = new UserDTO();
		userDTO = userService.getUserById(id);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("id", userDTO.getId());
		jsonObject.put("fname", userDTO.getFname());
		jsonObject.put("lname", userDTO.getLname());
		jsonObject.put("email", userDTO.getEmail());
		jsonObject.put("dob", userDTO.getDateOfBirth());
		jsonObject.put("password", userDTO.getPass());
		jsonObject.put("gender", userDTO.getGender());
		jsonObject.put("country", userDTO.getCountry());
		jsonObject.put("role", userDTO.getRole());
		jsonObject.put("image", userDTO.getImageFileName());
		out.write(jsonObject.toString());
	}

	private void insertUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		System.out.println("insertUser");
		PrintWriter out = response.getWriter();
		ServletContext context = getServletContext();
		String fname = StringUtils.trimToEmpty(request.getParameter("fname"));
		String lname = StringUtils.trimToEmpty(request.getParameter("lname"));
		String email = StringUtils.trimToEmpty(request.getParameter("email"));
		String gender = StringUtils.trimToEmpty(request.getParameter("gender"));
		String pass = StringUtils.trimToEmpty(request.getParameter("pass"));
		String country = StringUtils.trimToEmpty(request.getParameter("country"));
		String dateOfBirth = StringUtils.trimToEmpty(request.getParameter("dateOfBirth"));
		Part file = request.getPart("image");
		String role1 = request.getParameter("role");
		String imageFileName = file.getSubmittedFileName();

		int role = Integer.parseInt(role1);
		UserDTO userDTO = new UserDTO();
		userDTO.setFname(fname);
		userDTO.setLname(lname);
		userDTO.setEmail(email);
		userDTO.setGender(gender);
		userDTO.setPass(pass);
		userDTO.setCountry(country);
		userDTO.setDateOfBirth(dateOfBirth);
		userDTO.setRole(role);
		if (imageFileName == null || imageFileName.isEmpty()) {
			userDTO.setImageFileName(imageFileName);
		} else {
			String folderName = "images";
	        String folderPath = context.getRealPath("")+folderName;
	        String uploadPath = folderPath + File.separator + imageFileName;
			//get real path using context
			
			try (FileOutputStream fileOutputStream = new FileOutputStream(uploadPath);
					InputStream inputStream = file.getInputStream()) {
				byte[] data = new byte[inputStream.available()];
				inputStream.read(data);
				fileOutputStream.write(data);
			} catch (Exception e) {
				e.printStackTrace();
			}

			userDTO.setImageFileName(imageFileName);
		}
		UserService userService = new UserServiceImpl();
		String status = userService.insert(userDTO);
		if (status.equals("true")) {
			out.write("true");
		} else {
			out.write("false");
		}
	}

	private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, JSONException {
		System.out.println("loginUser");
		response.setContentType("text/html");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		UserDTO userDTO = new UserDTO();
		userDTO.setEmail(email);
		userDTO.setPass(password);
		UserService userService = new UserServiceImpl();
		List<Object> status = userService.loginCheck(userDTO);
	       response.setContentType("text/plain");
	       PrintWriter out = response.getWriter();
	 if (status.get(0).equals("false")) {
	        out.write("false");
	    } else {
	        String name = (String) status.get(0);
	        int role = (int) status.get(1);
	        int id =(int) status.get(2);
	        HttpSession session = request.getSession();
	        session.setAttribute("userName", name);
	        session.setAttribute("userRole", role);
	        session.setAttribute("id", id);
	        JSONObject jsonObject = new JSONObject();
	        jsonObject.put("currentTime", System.currentTimeMillis());
	        jsonObject.put("true", "true");
	    	response.setContentType("application/json");
	        out.write(jsonObject.toString());
	    }
	}
	
	private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("updateUser");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String imageFileName = "";
		ServletContext context = getServletContext();
		String userId = request.getParameter("id");
		int id = Integer.parseInt(userId);
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String password = request.getParameter("pass");
		String country = request.getParameter("country");
		String dateOfBirth = request.getParameter("dateOfBirth");
		String role1= request.getParameter("role");
		int role= Integer.parseInt(role1);
		Part file = request.getPart("image");
		UserService userService = new UserServiceImpl();
		if (file != null && file.getSize() > 0) {
			imageFileName = file.getSubmittedFileName();
		        String folderName = "images";
		        String folderPath = context.getRealPath("")+folderName;
		        String uploadPath = folderPath + File.separator + imageFileName;
			try (FileOutputStream fileOutputStream = new FileOutputStream(uploadPath); 
					InputStream inputStream = file.getInputStream()) {
				byte[] data = new byte[inputStream.available()];
				inputStream.read(data);
				fileOutputStream.write(data);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			UserDTO userDTO = new UserDTO();
			userDTO = userService.getUserById(id);
			imageFileName = userDTO.getImageFileName();
		}
		UserDTO userDTO = new UserDTO();
		userDTO.setId(id);
		userDTO.setFname(fname);
		userDTO.setLname(lname);
		userDTO.setEmail(email);
		userDTO.setGender(gender);
		userDTO.setPass(password);
		userDTO.setCountry(country);
		userDTO.setDateOfBirth(dateOfBirth);
		userDTO.setImageFileName(imageFileName);
		userDTO.setRole(role);
		int status = userService.update(userDTO);
		if (status > 0) {
			out.write("true");
		} else {
			out.write("false");
		}
	}
	private void log_out(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("log_out");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		session.removeAttribute("userName");
		session.invalidate(); 
		out.write("true");
	}
	private void assign_users_to_juniors(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("assign_users_to_juniors");
		PrintWriter out = response.getWriter();
		String junior = request.getParameter("junior");
		String dataString = request.getParameter("dataString");
		String juniorName = request.getParameter("juniorName");
		UserDTO userDTO = new UserDTO();
		userDTO.setJunior(junior);
		userDTO.setDataString(dataString);
		
		UserService userService = new UserServiceImpl();
		
		String status = userService.assign_users_to_junior(userDTO, juniorName);
		if (status.equalsIgnoreCase("true")) {
			out.write("true");
		}
		else {
			out.write("false");
		}
	}
	private void selectAllUsers(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException {
		System.out.println("selectAllUsers");
        UserService userService = new UserServiceImpl();
        String path = request.getContextPath();
        String search = StringUtils.trimToEmpty(request.getParameter("search[value]"));
        int start = Integer.parseInt(request.getParameter("start"));
        int limit = Integer.parseInt(request.getParameter("length"));
     
        UserDTO userDTO_for_dataTable = new UserDTO();
        userDTO_for_dataTable.setSearch(search);
        userDTO_for_dataTable.setLimit(limit);
        userDTO_for_dataTable.setStart(start);
        ArrayList<String[]> listUser = userService.selectAllUsers(path,userDTO_for_dataTable);
        int count = userService.countUserRecords();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", listUser);
        jsonObject.put("recordsTotal", listUser.size());
        jsonObject.put("recordsFiltered", count);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
        out.write(jsonObject.toString());
	}
}