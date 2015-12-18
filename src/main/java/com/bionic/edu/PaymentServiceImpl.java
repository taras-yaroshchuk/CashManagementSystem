package com.bionic.edu;

import java.util.List;

import javax.inject.*;
import javax.persistence.TypedQuery;

@Named
public class PaymentServiceImpl implements PaymentService{
    @Inject
    private PaymentDao paymentDao;
    
    public List<Payment> findByMerchantId(int id){
    	return paymentDao.findByMerchantId(id);
    }
    
    public double getPaymentSum(){
        return paymentDao.getPaymentSum();
    }
    public Payment findById(int id){
        return paymentDao.findById(id);
    }

}
