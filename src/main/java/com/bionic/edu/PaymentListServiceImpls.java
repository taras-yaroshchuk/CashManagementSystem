package com.bionic.edu;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.transaction.annotation.Transactional;

@Named
public class PaymentListServiceImpls implements PaymentListService {
    @Inject
    private PaymentListDao paymentListDao;
 
   
	public List<PaymentList> findByMerchantId(int id) {
		return paymentListDao.findByMerchantId(id);
	}


	public PaymentList findById(int id) {
		return paymentListDao.findById(id);
	}


	public List<PaymentList> findAll() {
		return paymentListDao.findAll();
	}



	@Transactional
	public void save(PaymentList payment) {
		paymentListDao.save(payment);
	}


	public List<PaymentList> findNotPaid() {
		return paymentListDao.findNotPaid();
	}

}
