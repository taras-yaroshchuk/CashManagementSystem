package com.bionic.edu;

import java.util.List;

public interface MerchantDao {
	public Merchant findById(int id);
	public void save(Merchant merchant);
	public List<Merchant> findAll();
	public List<Merchant> findReadyToBePayed();
}
