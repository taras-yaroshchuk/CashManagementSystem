package com.bionic.edu;

import java.util.List;

public interface PaymentService {
	public List<Payment> findByMerchantId(int id);
	public Payment findById(int id);
	public List<Payment> findAll();
	public void save(Payment payment);
	public Payment add(int customerId,int merchantId, String goods, Double sum);
}
