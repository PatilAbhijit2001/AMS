package com.aadhar_management_system.dao;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

import com.aadhar_management_system.dto.UserDTO;

public interface UserDAO {

	public String insert(UserDTO userDTO);
	
	public List<Object> loginCheck(UserDTO userDTO);
	
	public List<UserDTO> selectAllUsers(UserDTO userDTO_for_dataTable);
	
	public List<UserDTO> selectAllJunior();
	
	public int deleteUser(int id);
	
	public String assign_users_to_junior(UserDTO userDTO ,String juniorName);
	
	public int countUserRecords();
	
	public UserDTO getUserById(int id);
	
	public int update(UserDTO userDTO) ;
	
	public List<UserDTO> selectJuniorUsers(String userId);
	
	public int insertDocument(UserDTO userDTO) throws SQLException;

	public JSONObject checkDocuments(int id);

	public JSONObject selectDocuments(int userId);
	
	public String assign_junior_to_users(UserDTO userDTO, String juniorName);
	
}
