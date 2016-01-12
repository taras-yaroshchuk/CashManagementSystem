package com.bionic.edu.repository;

import com.bionic.edu.Merchant;

import java.util.List;

public interface MerchantDao {
	public Merchant findById(int id);
	public int getMaxId();
	public void save(Merchant merchant);
	public List<Merchant> findAll();
	public List<Merchant> findSatisfiedByMinsum();
}
