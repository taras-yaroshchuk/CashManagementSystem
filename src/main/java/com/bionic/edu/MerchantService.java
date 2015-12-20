package com.bionic.edu;

import java.util.List;

public interface MerchantService {
	public Merchant findById(int id);
	public int getMaxId();
	public void save(Merchant merchant);
	public List<Merchant> findAll();
	public List<Merchant> findReadyToBePayed();
}
