package com.bionic.edu.repository;

import java.util.List;

import javax.persistence.*;

import com.bionic.edu.PayList;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

@Repository
public class PayListDaoImpl implements PayListDao {
	private static final Logger log = LogManager.getLogger();
	@PersistenceContext
	private EntityManager em;

	public List<PayList> findByMerchantId(int id) {
		String queryString = "SELECT p FROM PayList p WHERE p.merchantId = :id";
		TypedQuery<PayList> query = em.createQuery(queryString, PayList.class);
		query.setParameter("id", id);
		log.debug("The \"findByMerchantId\" query with id=" + id + " in PayListDaoImpl class was executed.");
		return query.getResultList();
	}

	public PayList findById(int id) {
		log.debug("The \"findById\" query with id=" + id + " in PayListDaoImpl class was executed.");
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
			log.debug("The PayList with merchantId= " + payment.getMerchantId() + " was persisted.");
		} else {
			em.merge(payment);
			log.debug("The PayList with merchantId= " + payment.getMerchantId() + " was merget.");
		}
	}

	public List<PayList> findNotPaid() {
		TypedQuery<PayList> query = em.createQuery("SELECT p FROM PayList p WHERE p.status = 'NotPaid' ",
				PayList.class);
		List<PayList> listP = query.getResultList();
		log.debug("The \"findNotPaid\" query in PayListDaoImpl class was executed.");
		return listP;
	}

	public List<PayList> getSortedList() {
		TypedQuery<PayList> query = em.createQuery("SELECT p FROM PayList p WHERE p.status = 'NotPaid' ORDER BY p.priority DESC ", PayList.class);
		List<PayList> listP = query.getResultList();
		log.debug("The \"getSortedList\" query in PayListDaoImpl class "
				+ "returned " + listP.size() + "pay lists.");
		return listP;
	}
}
