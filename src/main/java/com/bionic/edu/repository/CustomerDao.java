package com.bionic.edu.repository;

import com.bionic.edu.model.Customer;

import java.util.List;

public interface CustomerDao {
	public Customer findById(int id);
	public void save(Customer customer);
	public List<Customer> findAll();
}
