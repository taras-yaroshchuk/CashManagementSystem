package com.bionic.edu.repository;

import com.bionic.edu.model.PayList;

import java.util.List;

public interface PayListDao {
	public void save(PayList payment);
	public List<PayList> findByMerchantId(int id);
	public PayList findById(int id);
	public List<PayList> findAll();
	public List<PayList> findNotPaid();
	public List<PayList> getSortedList();
}
