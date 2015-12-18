package com.bionic.edu;

import java.util.List;

import javax.inject.*;
import javax.persistence.TypedQuery;

import org.springframework.transaction.annotation.Transactional;

@Named
public class PaymentServiceImpl implements PaymentService{
    @Inject
    private PaymentDao paymentDao;
    
    public List<Payment> findByMerchantId(int id){
    	return paymentDao.findByMerchantId(id);
    }
    
    public Payment findById(int id){
        return paymentDao.findById(id);
    }

	public List<Payment> findAll() {
		return paymentDao.findAll();
	}
	
	@Transactional
	public void save(Payment payment) {
		paymentDao.save(payment);
	}
	

}
