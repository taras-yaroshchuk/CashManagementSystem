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
    
    public List<String> getNames(double sumPayed){
        String txt = "SELECT DISTINCT c.name FROM ";   
        txt += "Payment p, Customer c " ;
        txt += "WHERE c.id = p.customerId AND p.sumPayed > :limit";
      //String.class because we return NAMES, not Customers
        TypedQuery<String> query = em.createQuery(txt, String.class); 
        query.setParameter("limit", sumPayed);
        return query.getResultList();
  }
}
