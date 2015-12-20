package com.bionic.edu;

import java.util.List;

public interface PaymentListService {
	public void save(PaymentList payment);
	public List<PaymentList> findByMerchantId(int id);
	public PaymentList findById(int id);
	public List<PaymentList> findAll();
	public List<PaymentList> findNotPaid();
}
