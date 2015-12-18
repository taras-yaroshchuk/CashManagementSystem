package com.bionic.edu;

import java.util.List;

public interface MerchantService {
	public Merchant findById(int id);
	public void save(Merchant merchant);
	public void remove(int id);
	public void updateAccount(int id, String newAccount);
	public List<Merchant> findAll();
	public List<Merchant> getSortedByNeedToPay();
	
}
