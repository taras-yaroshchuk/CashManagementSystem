package com.bionic.edu;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.transaction.annotation.Transactional;

@Named
public class CustomerServiceImpl implements CustomerService {
	@Inject
    private CustomerDao customerDao;
    
    public Customer findById(int id) { 
    	return customerDao.findById(id); 
    }

    @Transactional
    public void save(Customer customer) {
    	customerDao.save(customer);
    }

	public List<Customer> findAll() {
		return customerDao.findAll();
	}

	@Transactional
	public Customer add(String name, String address, String email, String ccno, String cctype) {
		Customer customer = new Customer();
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		customer.setName(name);
		customer.setAddress(address);
		customer.setEmail(email);
		customer.setCcNo(ccno);
		customer.setCcType(cctype);
		customer.setMaturity(sqlDate);
		customerDao.save(customer);
		
		return customer;
	}
	
}
