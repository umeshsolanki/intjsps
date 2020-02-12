package mvc.service;

import java.util.List;
import mvc.dao.FinanceRequestDao;
import entities.FinanceRequest;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class FinanceRequestService extends AbstractService<FinanceRequest, Long>{
    
    @Autowired
    FinanceRequestDao dao;
    
    
    @Override
    public void save(FinanceRequest z){
        dao.save(z);
    }

    @Override
    public List<FinanceRequest> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(FinanceRequest o) {
        dao.delete(o);
    }

    @Override
    public void update(FinanceRequest o) {
        dao.update(o);
    }

    @Override
    public FinanceRequest get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, FinanceRequest obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

