package com.bionic.edu;

import java.util.List;

import javax.persistence.*;

import org.springframework.stereotype.Repository;

@Repository
public class PayListDaoImpl implements PayListDao {
	@PersistenceContext
	private EntityManager em;

	public List<PayList> findByMerchantId(int id) {
		String queryString = "SELECT p FROM PayList p WHERE p.merchantId = :id";
		TypedQuery<PayList> query = em.createQuery(queryString, PayList.class);
		query.setParameter("id", id);
		return query.getResultList();
	}

	public PayList findById(int id) {
		return em.find(PayList.class, id);
	}

	public List<PayList> findAll() {
		TypedQuery<PayList> query = em.createQuery("SELECT p FROM PayList p", PayList.class);
		List<PayList> listP = query.getResultList();
		return listP;
	}

	public void save(PayList payment) {
		if (payment.getId() == 0) {
			em.persist(payment);
		} else {
			em.merge(payment);
		}
	}

	public List<PayList> findNotPaid() {
		TypedQuery<PayList> query = em.createQuery("SELECT p FROM PayList p WHERE p.status = 'NotPaid' ",
				PayList.class);
		List<PayList> listP = query.getResultList();
		return listP;
	}

	public List<PayList> getSortedList() {
		TypedQuery<PayList> query = em.createQuery("SELECT p FROM PayList p WHERE p.status = 'NotPaid' ORDER BY p.priority DESC ", PayList.class);
		List<PayList> listP = query.getResultList();
		return listP;
	}
}
