package com.bionic.edu;

import java.util.ArrayList;
import java.util.Calendar;
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
		List<Merchant> listM = merchantDao.findSatisfiedByMinsum();

		List<Merchant> readyToBePayed = new ArrayList<Merchant>();

		for (Merchant merch : listM) {
			Short period = merch.getPeriod();

			Calendar cal = Calendar.getInstance();

			java.util.Date utilDate = new java.util.Date();
			java.sql.Date nowDate = new java.sql.Date(utilDate.getTime());

			java.sql.Date lastSentDate = merch.getLastSent();

			cal.setTime(lastSentDate);
			cal.add(Calendar.DAY_OF_YEAR, period);

			java.sql.Date needToSentDate = new java.sql.Date(cal.getTimeInMillis());

			if (needToSentDate.compareTo(nowDate) <= 0) {
				readyToBePayed.add(merch);
			}
		}
		return readyToBePayed;
	}


	public int getMaxId() {
		return merchantDao.getMaxId();
	}
	
	@Transactional
	public Merchant add(String name, String bank, String swift, String account, Double charge,Short period,Double sum) {
		Merchant merchant = new Merchant();
		merchant.setName(name);
		merchant.setBankName(bank);
		merchant.setSwift(swift);
		merchant.setAccount(account);
		merchant.setCharge(charge);
		merchant.setPeriod(period);
		merchant.setMinSum(sum);
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		merchant.setLastSent(sqlDate);
		merchantDao.save(merchant);
		return merchant;
	}

}
