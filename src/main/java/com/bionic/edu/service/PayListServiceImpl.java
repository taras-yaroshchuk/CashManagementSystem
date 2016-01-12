package com.bionic.edu.service;

import java.math.BigDecimal;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import com.bionic.edu.Merchant;
import com.bionic.edu.PayList;
import com.bionic.edu.repository.PayListDao;
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
			pl.setPriority(1);
			
			// Problem with a lot of PayLists with one MerchantId
			List<PayList> paylListsOfMerchant = findByMerchantId(merchantId);
			if (paylListsOfMerchant != null) {
				Double totalNeedToSent = merch.getNeedToSend();
				for (PayList payList : paylListsOfMerchant) {
					if (payList.getStatus().equals("NotPaid")) {
						totalNeedToSent -= payList.getSumSent();
					}
				}
				if (totalNeedToSent >= merch.getMinSum()) {
					Double accuracySumSent = new BigDecimal(totalNeedToSent).setScale(3, java.math.RoundingMode.HALF_UP)
							.doubleValue();
					
					pl.setSumSent(accuracySumSent);
					merch.setLastSent(sqlDate);
					merchantService.save(merch);
					payListService.save(pl);
				}
			} else {
				Double accuracyNeedToSendSum = new BigDecimal(merch.getNeedToSend())
						.setScale(3, java.math.RoundingMode.HALF_UP).doubleValue();
				
				pl.setSumSent(accuracyNeedToSendSum);
				merch.setLastSent(sqlDate);
				merchantService.save(merch);
				payListService.save(pl);
			}

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
				Double needToSend = m.getNeedToSend();
				m.setNeedToSend(needToSend - sumSent);
				Double totalSent = m.getSent();
				m.setSent(totalSent + sumSent);
				pl.setStatus("Paid");
				pl.setSentDate(timestamp);
				merchantService.save(m);
				payListService.save(pl);
			}
		}
	}
}
