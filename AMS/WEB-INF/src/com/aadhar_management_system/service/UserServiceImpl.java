package com.aadhar_management_system.service;

import java.util.List;

import org.json.JSONObject;

import java.sql.SQLException;
import java.util.ArrayList;
import com.aadhar_management_system.dao.UserDAO;
import com.aadhar_management_system.dao.UserDAOImpl;
import com.aadhar_management_system.dto.UserDTO;

public class UserServiceImpl implements UserService{

	@Override
	public String insert(UserDTO userDTO) {
		UserDAO userDAO = new UserDAOImpl();
		String status =userDAO.insert(userDTO);
		return status;
	}

	@Override
	public List<Object> loginCheck(UserDTO userDTO) {
		UserDAO userDAO = new UserDAOImpl();
		List<Object> status=userDAO.loginCheck(userDTO);
		return status;
	}

	@Override
	public int update(UserDTO userDTO) {
		UserDAO userDAO = new UserDAOImpl();
		int status =userDAO.update(userDTO);
		return status ;
	}

	@Override
	public UserDTO getUserById(int id) {
		UserDAO userDAO = new UserDAOImpl();
		UserDTO userDTO = new UserDTO();
		userDTO = userDAO.getUserById(id);
		return userDTO;
	}

	@Override
	public String assign_users_to_junior(UserDTO userDTO, String juniorName) {
		UserDAO userDAO = new UserDAOImpl();
		String status =userDAO.assign_users_to_junior(userDTO,juniorName);
		userDAO.assign_junior_to_users(userDTO, juniorName);
		return status;
	}

	@Override
	public int deleteUser(int id) {
		UserDAO userDAO = new UserDAOImpl();
		int status =userDAO.deleteUser(id);
		return status;
	}

	@Override
	public ArrayList<String[]> selectAllUsers(String path ,UserDTO userDTO_for_dataTable) {
	    ArrayList<String[]> userDetails = new ArrayList<>();

		try {
	    UserDAO userDAO = new UserDAOImpl();
	    boolean signDoc ;
	    boolean rcDoc ;
	    boolean poaDoc;
	    boolean birthDoc ;
	    List<UserDTO> listUser = userDAO.selectAllUsers(userDTO_for_dataTable);
	    for (UserDTO userDTO : listUser) {
	        String[] row = new String[14];
	        row[0] = "<input style='text-align:center; vertical-align: middle;' type='checkbox' value='" + String.valueOf(userDTO.getId()) + "' name='selected' id='check_boxes'>";
	        row[1] = String.valueOf(userDTO.getId());
	        row[2] = userDTO.getFname();
	        row[3] = userDTO.getLname();
	        row[4] = userDTO.getEmail();
	        row[5] = userDTO.getDateOfBirth();
	        row[6] = userDTO.getPass();
	        row[7] = userDTO.getGender();
	        row[8] = userDTO.getCountry();
	        String imageSrc = "<img style='width: 80px !important;' src='" + path + "/images/" + userDTO.getImageFileName() + "'>";
	        row[9] = imageSrc;
	        row[10] = "<button type='submit'  value='" + String.valueOf(userDTO.getId()) + "' id ='deleteButton' class='delete-btn btn-primary'>Delete</button>";
	        row[11] = "<button type='submit' name='userId' value='"+ String.valueOf(userDTO.getId())+"' id= 'updateButton' class='update-btn btn-primary'>Update</button>";
	        row[12] = userDTO.getAssignedJunior();
	        JSONObject jsonObject = new JSONObject();
			jsonObject = userDAO.checkDocuments(userDTO.getId());

			birthDoc = jsonObject.getBoolean("birthDoc");
			poaDoc = jsonObject.getBoolean("poaDoc");
			rcDoc = jsonObject.getBoolean("rcDoc");
			signDoc = jsonObject.getBoolean("signDoc");
			if(birthDoc == false|| poaDoc == false || rcDoc == false || signDoc == false) {
		        row[13] ="<button type='submit' name='userId' value='"+ String.valueOf(userDTO.getId())+"' id='documentButton' class='btn btn-primary btn-sm'>Documents</button>";
			}
			else {row[13] = "";}
	        userDetails.add(row);
	    }
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return userDetails;
	}

	@Override
	public List<UserDTO> selectAllJunior() {
		UserDAO userDAO = new UserDAOImpl();
		List <UserDTO> listJunior = userDAO.selectAllJunior();
		return listJunior;
	}

	@Override
	public ArrayList<String[]>  selectJuniorUsers(String userId,String path) {
		UserDAO userDAO = new UserDAOImpl();
		List<UserDTO> user = new ArrayList<>();
		ArrayList<String[]> userDetails = new ArrayList<>();
		user = userDAO.selectJuniorUsers(userId);
		for(UserDTO userDTO : user) {
			String[] row = new String[11];
			row[0] = String.valueOf(userDTO.getId());
			row[1] = userDTO.getFname();
			row[2] = userDTO.getLname();
			row[3] = userDTO.getEmail();
			row[4] = userDTO.getDateOfBirth();
			row[5] = userDTO.getPass();
			row[6] = userDTO.getGender();
			row[7] = userDTO.getCountry();
			String imageSrc = "<img style='width: 80px !important;' src= '" + path + "/images/" + userDTO.getImageFileName() + "'>";
			row[8] = imageSrc;
			row[9] = "<button type='submit'  value='"+String.valueOf(userDTO.getId())+"' id ='deleteButton' class='delete-btn btn-primary'>Delete</button>";
			row[10] = "<button type='submit' name='userId' value='"+ String.valueOf(userDTO.getId())+"' id= 'updateButton' class='update-btn btn-primary'>Update</button>";
			userDetails.add(row);
		}
		return userDetails;
	}

	@Override
	public int insertDocument(UserDTO userDTO) throws SQLException {
		UserDAO userDAO = new UserDAOImpl();
		int status = userDAO.insertDocument(userDTO);
		return status;
	}

	@Override
	public JSONObject checkDocuments(int id) {
		UserDAO userDAO = new UserDAOImpl();
		JSONObject jsonObject = new JSONObject();
		jsonObject = userDAO.checkDocuments(id);
		return jsonObject;
	}

	@Override
	public int countUserRecords() {
		UserDAO userDAO = new UserDAOImpl();
		int count = userDAO.countUserRecords();
		return count;
	}

	@Override
	public JSONObject selectDocuments(int userId) {
		UserDAO userDAO = new UserDAOImpl();
		JSONObject jsonObject = new JSONObject();
		jsonObject = userDAO.selectDocuments(userId);
		return jsonObject;
	}
}