package com.bionic.edu;

import java.util.List;

public interface CustomerService {
	public Customer findById(int id);
	public void save(Customer customer);
	public List<String> getNames(double sumPayed);
}
