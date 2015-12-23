package com.bionic.edu;

import java.util.List;

import javax.persistence.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDaoImpl implements PaymentDao {
	private static final Logger log = LogManager.getLogger();
    @PersistenceContext
    private EntityManager em;
    
    public List<Payment> findByMerchantId(int id) {
    	String queryString = "SELECT p FROM Payment p 	WHERE p.merchantId = :id";
        TypedQuery<Payment> query = em.createQuery(queryString, Payment.class);
        query.setParameter("id", id);
        log.debug("The \"findByMerchantId\" query with id=" + id + " in PaymentDaoImpl class was executed.");
        return query.getResultList();
    }
    

    public Payment findById(int id){
    	log.debug("The \"findById\" query with id=" + id + " in PaymentDaoImpl class was executed.");
        return em.find(Payment.class, id);
    }


	public List<Payment> findAll() {
		TypedQuery<Payment> query = 
		em.createQuery("SELECT p FROM Payment p", Payment.class);
		List<Payment> listP = query.getResultList();
		log.debug("The \"findAll\" query in PaymentDaoImpl class returntd +" +
		listP.size() + " payment.");
		return listP; 
	}


	public void save(Payment payment) {
		if (payment.getId() == 0) {
    		em.persist(payment);
    		log.debug("The payment with merchantId=" + payment.getMerchantId() +" was persisted.");
    	} else{
    		em.merge(payment);
    		log.debug("The payment with merchantId=" + payment.getMerchantId() +" was merget.");
    	}
	}
}

