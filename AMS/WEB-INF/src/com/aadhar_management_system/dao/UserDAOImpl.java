package com.aadhar_management_system.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import com.aadhar_management_system.utils.ConnectionHelper;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import java.util.ArrayList;
import com.aadhar_management_system.dto.UserDTO;

public class UserDAOImpl implements UserDAO {

	String email = "";
	String pass = "";
	String fname = "";

	public String insert(UserDTO userDTO) {
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		String query = "INSERT INTO amsDetails(fname,lname,email,gender,user_password,country,dateOfBirth,imageFileName,user_role) VALUES(?,?,?,?,?,?,?,?,?)";
		String result = "";
		String fileName="";
		PreparedStatement preparedStatement = null;
		int status;
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, userDTO.getFname());
			preparedStatement.setString(2, userDTO.getLname());
			preparedStatement.setString(3, userDTO.getEmail());
			preparedStatement.setString(4, userDTO.getGender());
			preparedStatement.setString(5, userDTO.getPass());
			preparedStatement.setString(6, userDTO.getCountry());
			preparedStatement.setString(7, userDTO.getDateOfBirth());
			preparedStatement.setInt(9, userDTO.getRole());
			if(userDTO.getImageFileName().equalsIgnoreCase(null)||userDTO.getImageFileName().isBlank()) {
				fileName = "default.png";
				preparedStatement.setString(8, fileName);
			}
			else {
				preparedStatement.setString(8, userDTO.getImageFileName());
			}
			status = preparedStatement.executeUpdate();
			if(status >0) {
				result ="true";
			}
			else {
				result="false";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = "false";
		}
		finally {
			try {
				if(preparedStatement != null)  preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	    public List<Object> loginCheck(UserDTO userDTO) {
			ConnectionHelper.loadDriver();
			Connection connection = ConnectionHelper.getConnection();
	        String query ="SELECT fname, user_role, id FROM amsDetails WHERE email = ? AND user_password = ? AND isDeleted=0 ";
	        String result = "";
	        String name = "";
	        int role = 0; 
	        int id = 0;
	        ResultSet resultSet = null;
	        PreparedStatement preparedStatement = null;
	        List<Object> user = new ArrayList<>();
	        try {
	            preparedStatement = connection.prepareStatement(query);
	            preparedStatement.setString(1, userDTO.getEmail());
	            preparedStatement.setString(2, userDTO.getPass());
	            resultSet = preparedStatement.executeQuery();
	            if (resultSet.next()) {
	                result = "true";
	                name = StringUtils.trimToEmpty(resultSet.getString("fname"));
	                role = resultSet.getInt("user_role"); 
	                id = resultSet.getInt("id");
	            } else {
	                result = "false";
	                System.out.println(result);
	                System.out.println(email);
	                System.out.println(pass);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	        }
	        finally {
					try {
						if(resultSet != null)resultSet.close();
						if(preparedStatement != null)preparedStatement.close();
						ConnectionHelper.CloseConnection(connection);
					} catch (SQLException e) {
						e.printStackTrace();
					}
			}
	        if (result.equalsIgnoreCase("true")) {
	           user.add(name);
	           user.add(role);
	           user.add(id);
	        } else {
	        	user.add(result);
	        }
	        return user;
	    }
	
		@Override
		public int countUserRecords() {
			ConnectionHelper.loadDriver();
			Connection connection = ConnectionHelper.getConnection();
			String countQuery = "SELECT COUNT(*) FROM amsDetails WHERE isDeleted = 0 AND user_role = 3";
			ResultSet resultSet = null;
		    PreparedStatement preparedStatement = null;
		    int count=0;
		    try {
				preparedStatement = connection.prepareStatement(countQuery);
				resultSet = preparedStatement.executeQuery();
				while(resultSet.next()) {
					count = Integer.parseInt(resultSet.getString(1));
				}
		    }catch(Exception e) {e.printStackTrace();}
		    finally {
		    	try {
					if(resultSet != null) resultSet.close();
					if(preparedStatement != null)preparedStatement.close();
					ConnectionHelper.CloseConnection(connection);
		    	}catch(Exception e) {e.printStackTrace();}
		    }
			return count;
		}
	
		public List<UserDTO> selectAllUsers(UserDTO userDTO_for_dataTable) {
			List<UserDTO> user = new ArrayList<>();
			ConnectionHelper.loadDriver();
			Connection connection = ConnectionHelper.getConnection();
			ResultSet resultSet = null;
			PreparedStatement preparedStatement = null;
			int parameterIndex = 0;
			UserDTO userDTO = null;
			String query = "SELECT id, fname, lname, email, dateOfBirth, gender, user_password, country, imageFileName, user_role, assigned_junior  FROM amsDetails"
					+ " WHERE isDeleted = 0 AND user_role = 3";

			try {
		        if (StringUtils.isNotBlank(userDTO_for_dataTable.getSearch()))
					query += " AND fname LIKE ?";
				if (userDTO_for_dataTable.getLimit() > 0)
					query += " LIMIT ?";
				if (userDTO_for_dataTable.getStart() > 0)
					query += " OFFSET ?";
				preparedStatement = connection.prepareStatement(query);
		        if (StringUtils.isNotBlank(userDTO_for_dataTable.getSearch()))
					preparedStatement.setString(++parameterIndex, "%" + userDTO_for_dataTable.getSearch() + "%");
				if (userDTO_for_dataTable.getLimit() > 0)
					preparedStatement.setInt(++parameterIndex, userDTO_for_dataTable.getLimit());
				if (userDTO_for_dataTable.getStart() > 0)
					preparedStatement.setInt(++parameterIndex, userDTO_for_dataTable.getStart());
				resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
					userDTO = new UserDTO();
					userDTO.setId(resultSet.getInt("id"));
					userDTO.setFname(StringUtils.trimToEmpty(resultSet.getString("fname")));
					userDTO.setLname(StringUtils.trimToEmpty(resultSet.getString("lname")));
					userDTO.setEmail(StringUtils.trimToEmpty(resultSet.getString("email")));
					userDTO.setDateOfBirth(StringUtils.trimToEmpty(resultSet.getString("dateOfBirth")));
					userDTO.setGender(StringUtils.trimToEmpty(resultSet.getString("gender")));
					userDTO.setPass(StringUtils.trimToEmpty(resultSet.getString("user_password")));
					userDTO.setCountry(StringUtils.trimToEmpty(resultSet.getString("country")));
					userDTO.setImageFileName(resultSet.getString("imageFileName"));
					userDTO.setRole(resultSet.getInt("user_role"));
					userDTO.setAssignedJunior(StringUtils.trimToEmpty(resultSet.getString("assigned_junior")));
					user.add(userDTO);
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			} finally {
				try {
					resultSet.close();
					preparedStatement.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				ConnectionHelper.CloseConnection(connection);
			}
			return user;
		}

	public List<UserDTO> selectAllJunior(){
		
		List<UserDTO> user = new ArrayList<>();
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		String query ="SELECT * FROM amsDetails WHERE isDeleted= 0 AND user_role= 2";
		ResultSet resultSet = null;
	    PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(query);
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				String fname = StringUtils.trimToEmpty(resultSet.getString("fname"));
				int id = resultSet.getInt("id");
				UserDTO userDTO = new UserDTO();
				userDTO.setFname(fname);
				userDTO.setId(id);
				user.add(userDTO);
			}
		}catch(Exception e) {e.printStackTrace();}
		finally {
			try {
				if(resultSet != null)resultSet.close();
				if(preparedStatement != null)preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return user;
	}
	public int deleteUser(int id) {
		int status = 0;
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
	    PreparedStatement preparedStatement = null;
		try {
			String query = "UPDATE  amsDetails SET isDeleted = 1 WHERE id=?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, id);
			status = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return status;
	}
	
	public String assign_users_to_junior(UserDTO userDTO, String juniorName) {
		String status= "";
		String junior1 =userDTO.getJunior();
		int junior = Integer.parseInt(junior1);
		String DataString =userDTO.getDataString();
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
	    PreparedStatement preparedStatement = null;
		try {
			String query = "UPDATE amsDetails SET assigned_users_to_juniors = ? WHERE id =?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, DataString);
			preparedStatement.setInt(2, junior);
			int test = preparedStatement.executeUpdate();
			if (test > 0) {
				status = "true";
			}else {
				status = "false";
			}
		}catch(Exception e) {e.printStackTrace();}
		finally {
			try {
				if(preparedStatement != null)  preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return status;
	}
	
	public String assign_junior_to_users(UserDTO userDTO,String juniorName) {
//		String junior1 =userDTO.getJunior();
//		int junior = Integer.parseInt(junior1);
		String DataString =userDTO.getDataString();
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
	    PreparedStatement preparedStatement = null;
	    if(!DataString.isEmpty()) {
			String[] arrOfStr = DataString.split(",");

			int[] numbers = new int[arrOfStr.length];

			for (int i = 0; i < arrOfStr.length; i++) {
				numbers[i] = Integer.parseInt(arrOfStr[i]);
				
			    try {
			    	preparedStatement = connection.prepareStatement("UPDATE amsDetails SET assigned_junior = ? WHERE id = ?");
			    	preparedStatement.setString(1, juniorName);
			    	preparedStatement.setInt(2, numbers[i]);
			    	preparedStatement.executeUpdate();
			    	
			    	if(preparedStatement != null) preparedStatement.close();
			    }catch(Exception e) {e.printStackTrace();}
			}
	    }
		return null;
	}

	public UserDTO getUserById(int id) {
		UserDTO userDTO = new UserDTO();
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		ResultSet resultSet = null;
	    PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement("SELECT * FROM amsDetails WHERE id=? AND isDeleted=0");
			preparedStatement.setInt(1, id);
			resultSet= preparedStatement.executeQuery();
			if(resultSet.next()) {
				userDTO.setId(resultSet.getInt("id"));
				userDTO.setFname(StringUtils.trimToEmpty(resultSet.getString("fname")));
				userDTO.setLname(StringUtils.trimToEmpty(resultSet.getString("lname")));
				userDTO.setEmail(StringUtils.trimToEmpty(resultSet.getString("email")));
				userDTO.setGender(StringUtils.trimToEmpty(resultSet.getString("gender")));
				userDTO.setPass(StringUtils.trimToEmpty(resultSet.getString("user_password")));
				userDTO.setCountry(StringUtils.trimToEmpty(resultSet.getString("country")));
				userDTO.setDateOfBirth(StringUtils.trimToEmpty(resultSet.getString("dateOfBirth")));
				userDTO.setImageFileName(resultSet.getString("imageFileName"));
				userDTO.setRole(resultSet.getInt("user_role"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(resultSet != null)resultSet.close();
				if(preparedStatement != null)preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return userDTO;
	}
	public int update(UserDTO userDTO) {
		int status = 0;
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
	    PreparedStatement preparedStatement = null;
		try {
			preparedStatement =connection.prepareStatement("UPDATE amsDetails SET fname=? ,lname=?,email=?,gender=?,user_password=?, country=?,dateOfBirth=?,imageFileName=? WHERE id= ?");
			preparedStatement.setString(1, userDTO.getFname());
			preparedStatement.setString(2, userDTO.getLname());
			preparedStatement.setString(3, userDTO.getEmail());
			preparedStatement.setString(4, userDTO.getGender());
			preparedStatement.setString(5, userDTO.getPass());
			preparedStatement.setString(6, userDTO.getCountry());
			preparedStatement.setString(7, userDTO.getDateOfBirth());
			preparedStatement.setString(8, userDTO.getImageFileName());
			preparedStatement.setInt(9, userDTO.getId());
			status=preparedStatement.executeUpdate();
		}catch (Exception e) {e.printStackTrace();}
		finally {
				try {
					if(preparedStatement != null)  preparedStatement.close();
					ConnectionHelper.CloseConnection(connection);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return status;
	}
	
	public List<UserDTO> selectJuniorUsers(String userId) {
		int id=0;
		try {
			 id =Integer.parseInt(userId);
		}catch(Exception e) {e.printStackTrace();}
		String Status = "";
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<UserDTO> user = new ArrayList<>();
		String query = "SELECT assigned_users_to_juniors FROM amsDetails WHERE isDeleted= 0 AND id =?";
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, id);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				Status = StringUtils.trimToEmpty(resultSet.getString("assigned_users_to_juniors"));
			}
			if(!Status.isEmpty()) {
				String[] arrOfStr = Status.split(",");

				int[] numbers = new int[arrOfStr.length];

				for (int i = 0; i < arrOfStr.length; i++) {
					numbers[i] = Integer.parseInt(arrOfStr[i]);
				}
				for (int number : numbers) {
					UserDTO userDTO = new UserDTO();
					userDTO = getUserById(number);
					if (StringUtils.isBlank(userDTO.getFname())) {

					} else {
						user.add(userDTO);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) resultSet.close();
				if (preparedStatement != null) preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return user;
	}

	@Override
	public int insertDocument(UserDTO userDTO) throws SQLException {

		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement2 = null;
		ResultSet resultSet = null;
		int status = 0;

		String type = userDTO.getDocumentType();
		preparedStatement1 = connection.prepareStatement("SELECT * FROM userDocuments where u_id=?");
		preparedStatement1.setInt(1, userDTO.getId());
		resultSet = preparedStatement1.executeQuery();
		try {
		    if (!resultSet.isBeforeFirst()) {
		        preparedStatement2 = connection.prepareStatement("INSERT INTO userDocuments(u_id) VALUES(?)");
		        preparedStatement2.setInt(1, userDTO.getId());
		        preparedStatement2.executeUpdate();
		        preparedStatement2.close();
		    }

		    String updateQuery = "";
		    switch (type.toLowerCase()) {
		        case "birth":
		            updateQuery = "UPDATE userDocuments SET birth_certificate=? WHERE u_id=?";
		            break;
		        case "poa":
		            updateQuery = "UPDATE userDocuments SET proof_of_address=? WHERE u_id=?";
		            break;
		        case "rc":
		            updateQuery = "UPDATE userDocuments SET ration_card=? WHERE u_id=?";
		            break;
		        case "sign":
		            updateQuery = "UPDATE userDocuments SET sign=? WHERE u_id=?";
		            break;
		        default:
		            throw new IllegalArgumentException("Invalid document type: " + type);
		    }

		    preparedStatement = connection.prepareStatement(updateQuery);
		    preparedStatement.setString(1, userDTO.getDocFileName());
		    preparedStatement.setInt(2, userDTO.getId());
		    status = preparedStatement.executeUpdate();
		} catch (Exception e) {
		    e.printStackTrace();
		} finally {
		    try {
		        if (resultSet != null) resultSet.close();
		        if (preparedStatement1 != null) preparedStatement1.close();
		        if (preparedStatement != null) preparedStatement.close();
		        ConnectionHelper.CloseConnection(connection);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		return status;
	}

	@Override
	public JSONObject checkDocuments(int id) {

		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		JSONObject jsonObject = new JSONObject();
		String birth = "";
		String poa = "";
		String rc = "";
		String sign = "";
		try {
			preparedStatement = connection.prepareStatement("SELECT * FROM userDocuments WHERE u_id= ?");
			preparedStatement.setInt(1, id);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				birth = StringUtils.trimToEmpty(resultSet.getString("birth_certificate"));
				poa = StringUtils.trimToEmpty(resultSet.getString("proof_of_address"));
				rc = StringUtils.trimToEmpty(resultSet.getString("ration_card"));
				sign = StringUtils.trimToEmpty(resultSet.getString("sign"));
			}
			boolean birthDoc = StringUtils.isBlank(birth);
			boolean poaDoc = StringUtils.isBlank(poa);
			boolean rcDoc = StringUtils.isBlank(rc);
			boolean signDoc = StringUtils.isBlank(sign);

			jsonObject.put("birthDoc", birthDoc);
			jsonObject.put("poaDoc", poaDoc);
			jsonObject.put("rcDoc", rcDoc);
			jsonObject.put("signDoc", signDoc);
			jsonObject.put("birth", birth);
			jsonObject.put("poa", poa);
			jsonObject.put("rc", rc);
			jsonObject.put("sign", sign);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (preparedStatement != null)
					preparedStatement.close();
				ConnectionHelper.CloseConnection(connection);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return jsonObject;
	}

	@Override
	public JSONObject selectDocuments(int userId) {
		ConnectionHelper.loadDriver();
		Connection connection = ConnectionHelper.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		JSONObject jsonObject = new JSONObject();
		String birth = "";
		String poa = "";
		String rc = "";
		String sign = "";
		try {
			preparedStatement = connection.prepareStatement("SELECT * FROM userDocuments WHERE u_id= ?");
			preparedStatement.setInt(1, userId);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				birth = StringUtils.trimToEmpty(resultSet.getString("birth_certificate"));
				poa = StringUtils.trimToEmpty(resultSet.getString("proof_of_address"));
				rc = StringUtils.trimToEmpty(resultSet.getString("ration_card"));
				sign = StringUtils.trimToEmpty(resultSet.getString("sign"));
			}
			
			if(birth != null && !birth.isBlank()) {
				jsonObject.put("Birth Certificate", birth);
			}
			if(poa != null && !poa.isBlank()) {
				jsonObject.put("Proof Of Address", poa);
			}
			if(rc != null && !rc.isBlank()) {
				jsonObject.put("Ration Card", rc);
			}
			if(sign != null && !sign.isBlank()) {
				jsonObject.put("Sign", sign);
			}
	}catch(Exception e){
		e.printStackTrace(); 
	}finally {
		try {
			if (resultSet != null)
				resultSet.close();
			if (preparedStatement != null)
				preparedStatement.close();
			ConnectionHelper.CloseConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		return jsonObject;
}
}