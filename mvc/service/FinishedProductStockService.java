package mvc.service;

import java.util.List;
import mvc.dao.FinishedProductStockDao;
import entities.FinishedProductStock;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class FinishedProductStockService extends AbstractService<FinishedProductStock, Long>{
    
    @Autowired
    FinishedProductStockDao dao;
    
    
    @Override
    public void save(FinishedProductStock z){
        dao.save(z);
    }

    @Override
    public List<FinishedProductStock> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(FinishedProductStock o) {
        dao.delete(o);
    }

    @Override
    public void update(FinishedProductStock o) {
        dao.update(o);
    }

    @Override
    public FinishedProductStock get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, FinishedProductStock obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

