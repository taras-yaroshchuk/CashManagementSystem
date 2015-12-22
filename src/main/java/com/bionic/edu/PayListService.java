package com.bionic.edu;

import java.util.List;

public interface PayListService {
	public void save(PayList payment);
	public List<PayList> findByMerchantId(int id);
	public PayList findById(int id);
	public List<PayList> findAll();
	public List<PayList> findNotPaid();
	public List<PayList> getSortedList();
	public void workOutPayLists();
	public void sendMoney(Double sum);
}
