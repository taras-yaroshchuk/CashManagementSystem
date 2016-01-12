package com.bionic.edu.service;

import com.bionic.edu.model.Customer;

import java.util.List;

public interface CustomerService {
	public Customer findById(int id);
	public void save(Customer customer);
	public List<Customer> findAll();
	public Customer add(String name, String address,String email,String ccno,String cctype);
}
