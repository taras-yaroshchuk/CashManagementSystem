package com.bionic.edu;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.transaction.annotation.Transactional;

@Named
public class PayListServiceImpls implements PayListService {
    @Inject
    private PayListDao payListDao;
 
   
	public List<PayList> findByMerchantId(int id) {
		return payListDao.findByMerchantId(id);
	}


	public PayList findById(int id) {
		return payListDao.findById(id);
	}


	public List<PayList> findAll() {
		return payListDao.findAll();
	}



	@Transactional
	public void save(PayList payment) {
		payListDao.save(payment);
	}


	public List<PayList> findNotPaid() {
		return payListDao.findNotPaid();
	}


	public List<PayList> getSortedList() {
		return payListDao.getSortedList();
	}

}
