package mvc.service;

import java.util.List;
import mvc.dao.CustReturnsDao;
import entities.CustReturns;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CustReturnsService extends AbstractService<CustReturns, Long>{
    
    @Autowired
    CustReturnsDao dao;
    
    
    @Override
    public void save(CustReturns z){
        dao.save(z);
    }

    @Override
    public List<CustReturns> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(CustReturns o) {
        dao.delete(o);
    }

    @Override
    public void update(CustReturns o) {
        dao.update(o);
    }

    @Override
    public CustReturns get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, CustReturns obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

