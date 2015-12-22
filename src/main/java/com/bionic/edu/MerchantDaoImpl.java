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

	public List<Merchant> findSatisfiedByMinsum() {
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m  WHERE m.needToSend >= m.minSum",
				Merchant.class);
		List<Merchant> listM = query.getResultList();
		return listM;
	}

	public int getMaxId(){
		TypedQuery<Merchant> query = em.createQuery("SELECT m FROM Merchant m ORDER BY m.id DESC", Merchant.class);
		List<Merchant> listM = query.getResultList();
		return listM.get(0).getId();
	}
}
