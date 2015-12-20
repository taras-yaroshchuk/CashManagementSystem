package com.bionic.edu;

import java.util.List;

import javax.persistence.*;

import org.springframework.stereotype.Repository;

@Repository
public class PaymentListDaoImpl implements PaymentListDao {
	@PersistenceContext
	private EntityManager em;

	public List<PaymentList> findByMerchantId(int id) {
		String queryString = "SELECT p FROM PaymentList p 	WHERE p.merchantId = :id";
		TypedQuery<PaymentList> query = em.createQuery(queryString, PaymentList.class);
		query.setParameter("id", id);
		return query.getResultList();
	}

	public PaymentList findById(int id) {
		return em.find(PaymentList.class, id);
	}

	public List<PaymentList> findAll() {
		TypedQuery<PaymentList> query = em.createQuery("SELECT p FROM PaymentList p", PaymentList.class);
		List<PaymentList> listP = query.getResultList();
		return listP;
	}


	public void save(PaymentList payment) {
		if (payment.getId() == 0) {
			em.persist(payment);
		} else {
			em.merge(payment);
		}
	}

	public List<PaymentList> findNotPaid() {
		TypedQuery<PaymentList> query = em.createQuery("SELECT p FROM PaymentList p WHERE p.status = 'NotPaid' ", PaymentList.class);
		List<PaymentList> listP = query.getResultList();
		return listP;
	}

}
