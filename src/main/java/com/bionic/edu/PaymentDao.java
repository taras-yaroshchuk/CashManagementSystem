package com.bionic.edu;

import java.util.List;

public interface PaymentDao {
	public List<Payment> findByMerchantId(int id);
	public double getPaymentSum();
	public Payment findById(int id);
}
