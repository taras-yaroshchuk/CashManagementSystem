package com.bionic.edu;

import java.util.List;

public interface PaymentDao {
	public List<Payment> findByMerchantId(int id);
	public Payment findById(int id);
	public List<Payment> findAll();
}
