package com.bionic.edu;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDaoImpl implements CustomerDao{
	private static final Logger log = LogManager.getLogger();
	@PersistenceContext
    private EntityManager em;
    
    public Customer findById(int id){
    	return em.find(Customer.class, id);
    }

    public void save(Customer customer){
    	if (customer.getId() == 0) {
    		em.persist(customer);
    		log.debug("The customer " + customer.getName() +"was persisted.");
    	} else{
    		em.merge(customer);
    		log.debug("The customer " + customer.getName() +"was merged.");
    	}
    }
    


	public List<Customer> findAll() {
		TypedQuery<Customer> query = 
        		em.createQuery("SELECT c FROM Customer c", Customer.class);
         List<Customer> listC = query.getResultList();
         log.debug("The \"findAll\" query in CustomerDaoImpl class returntd +" +
        		 listC.size() + " customers.");
         return listC; 
	}
}
