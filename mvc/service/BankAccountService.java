package mvc.service;

import java.util.List;
import mvc.dao.BankAccountDao;
import entities.BankAccount;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BankAccountService extends AbstractService<BankAccount, Long>{
    
    @Autowired
    BankAccountDao dao;
    
    
    @Override
    public void save(BankAccount z){
        dao.save(z);
    }

    @Override
    public List<BankAccount> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(BankAccount o) {
        dao.delete(o);
    }

    @Override
    public void update(BankAccount o) {
        dao.update(o);
    }

    @Override
    public BankAccount get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, BankAccount obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

