package com.bionic.edu.repository;

import com.bionic.edu.Payment;

import java.util.List;

public interface PaymentDao {
	public List<Payment> findByMerchantId(int id);
	public Payment findById(int id);
	public List<Payment> findAll();
	public void save(Payment payment);
	
}
