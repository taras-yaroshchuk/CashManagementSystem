package com.bionic.edu;

import org.springframework.stereotype.Repository;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Repository
public class MerchantDaoImpl implements MerchantDao {
    @PersistenceContext
    private EntityManager em;
    
    public Merchant findById(int id){
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
        TypedQuery<Merchant> query = 
        		em.createQuery("SELECT m FROM Merchant m", Merchant.class);
         List<Merchant> listM = query.getResultList();
         return listM; 
    }    

}
