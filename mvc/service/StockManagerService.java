package mvc.service;

import java.util.List;
import mvc.dao.StockManagerDao;
import entities.StockManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StockManagerService extends AbstractService<StockManager, Long>{
    
    @Autowired
    StockManagerDao dao;
    
    
    @Override
    public void save(StockManager z){
        dao.save(z);
    }

    @Override
    public List<StockManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(StockManager o) {
        dao.delete(o);
    }

    @Override
    public void update(StockManager o) {
        dao.update(o);
    }

    @Override
    public StockManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, StockManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

