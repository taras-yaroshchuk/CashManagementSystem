package com.bionic.edu;

import java.util.List;

import javax.persistence.*;

import org.springframework.stereotype.Repository;

@Repository
public class PaymentDaoImpl implements PaymentDao {
    @PersistenceContext
    private EntityManager em;
    
    public List<Payment> findByMerchantId(int id) {
    	String queryString = "SELECT p FROM Payment p 	WHERE p.merchantId = :id";
        TypedQuery<Payment> query = em.createQuery(queryString, Payment.class);
        query.setParameter("id", id);
        return query.getResultList();
    }
     //SAME AS
//    public List<Payment> findByMerchantId(int id){
//    	String queryString = "SELECT p FROM Payment p WHERE p.merchantId = ?1";
//        TypedQuery<Payment> query = em.createQuery(queryString, Payment.class);
//        query.setParameter(1, id);
//        return query.getResultList();
//    }

    public double getPaymentSum(){
        TypedQuery<Double> query = em.createQuery("SELECT SUM(p.sumPayed) FROM 	Payment p", Double.class);
        return query.getSingleResult();
    }
    public Payment findById(int id){
        return em.find(Payment.class, id);
    }


}
