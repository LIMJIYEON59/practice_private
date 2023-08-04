package edu.kh.test.user.model.vo;

public class UserDTO {
//	USER_NO   NOT NULL NUMBER       
//	USER_ID   NOT NULL VARCHAR2(50) 
//	USER_NAME NOT NULL VARCHAR2(50) 
//	USER_AGE  NOT NULL NUMBER  
	
	private int userNo;
	private String userId;
	private String userName;
	private int userAge;
	
	public UserDTO() {
		super();
	}
	public UserDTO(int userNo, String userId, String userName, int userAge) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userName = userName;
		this.userAge = userAge;
	}
	@Override
	public String toString() {
		return "UserDTO [userNo=" + userNo + ", userId=" + userId + ", userName=" + userName + ", userAge=" + userAge
				+ "]";
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	
	
}
