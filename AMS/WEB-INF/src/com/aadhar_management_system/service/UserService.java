package com.aadhar_management_system.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import com.aadhar_management_system.dto.UserDTO;

public interface UserService {
	public String insert(UserDTO userDTO);

	public List<Object> loginCheck(UserDTO userDTO);

	public int update(UserDTO userDTO);

	public UserDTO getUserById(int id);

	public String assign_users_to_junior(UserDTO userDTO,String juniorName);

	public int deleteUser(int id);
	
	public ArrayList<String[]> selectAllUsers(String path,UserDTO userDTO_for_dataTable);
	
	public List<UserDTO> selectAllJunior();

	public ArrayList<String[]>  selectJuniorUsers(String userId,String path);
	
	public int insertDocument(UserDTO userDTO) throws SQLException;

	public JSONObject checkDocuments(int id);
	
	public int countUserRecords();

	public JSONObject selectDocuments(int userId);

}
