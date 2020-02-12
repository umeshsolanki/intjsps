package mvc.service;

import java.util.List;
import mvc.dao.CustomerDao;
import entities.Customer;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CustomerService extends AbstractService<Customer, Long>{
    
    @Autowired
    CustomerDao dao;
    
    
    @Override
    public void save(Customer z){
        dao.save(z);
    }

    @Override
    public List<Customer> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Customer o) {
        dao.delete(o);
    }

    @Override
    public void update(Customer o) {
        dao.update(o);
    }

    @Override
    public Customer get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Customer obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

