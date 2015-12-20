package com.bionic.edu;

import org.springframework.stereotype.Repository;

import java.util.*;

import javax.persistence.*;

@Repository
public class MerchantDaoImpl implements MerchantDao {
	@PersistenceContext
	private EntityManager em;

	public Merchant findById(int id) {
		return em.find(Merchant.class, id);
	}

	public void save(Merchant merchant) {
		if (merchant.getId() == 0) {
			em.persist(merchant);
		} else {
			em.merge(merchant);
		}
	}

	public List<Merchant> findAll() {
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m", Merchant.class);
		List<Merchant> listM = query.getResultList();
		return listM;
	}

	public List<Merchant> findReadyToBePayed() {
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m " + "WHERE m.needToSend >= m.minSum",
				Merchant.class);
		List<Merchant> listM = query.getResultList();
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

}
