package com.bionic.edu;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

@Repository
public class CustomerDaoImpl implements CustomerDao{
	@PersistenceContext
    private EntityManager em;
    
    public Customer findById(int id){
    	return em.find(Customer.class, id);
    }

    public void save(Customer customer){
    	if (customer.getId() == 0) {
    		em.persist(customer);
    	} else{
    		em.merge(customer);
    	}
    }
    


	public List<Customer> findAll() {
		TypedQuery<Customer> query = 
        		em.createQuery("SELECT c FROM Customer c", Customer.class);
         List<Customer> listC = query.getResultList();
         return listC; 
	}
}
