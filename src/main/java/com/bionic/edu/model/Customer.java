package com.bionic.edu.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Customer {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY) 
    private int id;
    private String name;
    private String address;
    private String email;
    private String ccNo;
    private String ccType;
    private java.sql.Date maturity;

    
    public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCcNo() {
		return ccNo;
	}
	public void setCcNo(String ccNo) {
		this.ccNo = ccNo;
	}
	public String getCcType() {
		return ccType;
	}
	public void setCcType(String ccType) {
		this.ccType = ccType;
	}
	public java.sql.Date getMaturity() {
		return maturity;
	}
	public void setMaturity(java.sql.Date maturity) {
		this.maturity = maturity;
	}
	public int getId() {
		return id;
	}
}
