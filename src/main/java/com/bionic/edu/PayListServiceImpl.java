package com.bionic.edu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

@Named
public class PayListServiceImpl implements PayListService {
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

	public void workOutPayLists() {
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/application-config.xml");
		PayListService payListService = (PayListService) context.getBean("payListServiceImpl");
		MerchantService merchantService = (MerchantService) context.getBean("merchantServiceImpl");

		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

		List<PayList> notPaidPaymentLists = payListService.findNotPaid();
		for (PayList pl : notPaidPaymentLists) {
			int priority = pl.getPriority();
			pl.setPriority(priority + 1);
			payListService.save(pl);
		}

		List<Merchant> merchants = merchantService.findReadyToBePayed();
		for (Merchant merch : merchants) {
			PayList pl = new PayList();
			Integer merchantId = merch.getId();
			pl.setMerchantId(merchantId);
			pl.setFormedDate(timestamp);
			pl.setStatus("NotPaid");
			pl.setSumSent(merch.getNeedToSend());
			pl.setPriority(1);
			merch.setLastSent(sqlDate);

			merchantService.save(merch);
			payListService.save(pl);
		}
	}

	@Transactional
	public void sendMoney(Double sum) {
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/application-config.xml");
		PayListService payListService = (PayListService) context.getBean("payListServiceImpl");
		MerchantService merchantService = (MerchantService) context.getBean("merchantServiceImpl");

		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

		List<PayList> list = payListService.getSortedList();
		for (PayList pl : list) {
			Double sumSent = pl.getSumSent();
			Double residue = sum - sumSent;
			if (residue >= 0) {
				sum = sum - sumSent;
				Merchant m = merchantService.findById(pl.getMerchantId());
				m.setNeedToSend(m.getNeedToSend() - pl.getSumSent());
				pl.setStatus("Paid");
				pl.setSentDate(timestamp);
				merchantService.save(m);
				payListService.save(pl);
			} else {
				int priority = pl.getPriority();
				pl.setPriority(priority + 1);
				payListService.save(pl);
			}
		}	
	}
}
