package com.bionic.edu;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.TypedQuery;

import org.springframework.transaction.annotation.Transactional;

@Named
public class MerchantServiceImpl implements MerchantService {
	@Inject
	private MerchantDao merchantDao;

	public Merchant findById(int id) {
		return merchantDao.findById(id);
	}

	@Transactional
	public void save(Merchant merchant) {
		merchantDao.save(merchant);
	}

	@Transactional
	public void remove(int id) {
		merchantDao.remove(id);
	}

	@Transactional
	public void updateAccount(int id, String newAccount) {
		merchantDao.updateAccount(id, newAccount);
	}

	public List<Merchant> findAll() {
		return merchantDao.findAll();
	}

	public List<Merchant> getSortedByNeedToPay() {
		return merchantDao.getSortedByNeedToPay();
	}

}
