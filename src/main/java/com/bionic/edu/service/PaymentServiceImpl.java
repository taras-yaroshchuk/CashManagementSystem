package com.bionic.edu.service;

import java.math.BigDecimal;
import java.util.List;

import javax.inject.*;

import com.bionic.edu.Merchant;
import com.bionic.edu.Payment;
import com.bionic.edu.repository.PaymentDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.*;
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

	@Transactional 
	public Payment add(int customerId, int merchantId, String goods, Double sum) {
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/application-config.xml");
		MerchantService merchantService = (MerchantService) context.getBean("merchantServiceImpl");
		
		Payment payment = new Payment();
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		
		Merchant merchant = merchantService.findById(merchantId);
		Double chargePayed = (sum / 100) * merchant.getCharge();
		Double accuracyChargePayed = new BigDecimal(chargePayed).setScale(3, java.math.RoundingMode.HALF_UP).doubleValue();
		
		payment.setChargePayed(accuracyChargePayed);
		payment.setDt(new java.sql.Timestamp(sqlDate.getTime()));
		payment.setCustomerId(customerId);
		payment.setMerchantId(merchantId);
		payment.setSumPayed(sum);
		payment.setGoods(goods);
		
		merchant.setNeedToSend(merchant.getNeedToSend() + sum - chargePayed);

		merchantService.save(merchant);
		
		paymentDao.save(payment);
		return payment;
	}
	

}
