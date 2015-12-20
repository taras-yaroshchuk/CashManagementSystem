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


	public List<Merchant> findAll() {
		return merchantDao.findAll();
	}

	public List<Merchant> findReadyToBePayed() {
		return merchantDao.findReadyToBePayed();
	}

}
