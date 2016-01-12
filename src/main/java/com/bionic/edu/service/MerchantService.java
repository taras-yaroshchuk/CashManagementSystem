package com.bionic.edu.service;

import com.bionic.edu.model.Merchant;

import java.util.List;

public interface MerchantService {
	public Merchant findById(int id);
	public int getMaxId();
	public void save(Merchant merchant);
	public List<Merchant> findAll();
	public List<Merchant> findReadyToBePayed();
	public Merchant add(String name, String bank, String swift, String account, Double charge,Short period,Double sum);
}
