package com.bionic.edu;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.util.*;

import javax.persistence.*;

@Repository
public class MerchantDaoImpl implements MerchantDao {
	private static final Logger log = LogManager.getLogger();
	@PersistenceContext
	private EntityManager em;

	public Merchant findById(int id) {
		return em.find(Merchant.class, id);
	}

	public void save(Merchant merchant) {
		if (merchant.getId() == 0) {
			em.persist(merchant);
			log.info("The merchant " + merchant.getName() +" was persisted.");
		} else {
			em.merge(merchant);
			log.debug("The merchant " + merchant.getName() +" was persisted.");
		}
	}

	public List<Merchant> findAll() {
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m", Merchant.class);
		List<Merchant> listM = query.getResultList();
		log.debug("The \"findAll\" query in MerchantDaoImpl class was executed.");
		return listM;
	}

	public List<Merchant> findSatisfiedByMinsum() {
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m  WHERE m.needToSend >= m.minSum",
				Merchant.class);
		List<Merchant> listM = query.getResultList();
		log.debug("The \"findSatisfiedByMinsum\" query in MerchantDaoImpl class was executed.");
		return listM;
	}

	public int getMaxId(){
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m ORDER BY m.id DESC", Merchant.class);
		List<Merchant> listM = query.getResultList();
		log.debug("The \"getMaxId\" query in MerchantDaoImpl class was executed.");
		return listM.get(0).getId();
	}
}
