package mvc.service;

import java.util.List;
import mvc.dao.DistSaleManagerDao;
import entities.DistSaleManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistSaleManagerService extends AbstractService<DistSaleManager, Long>{
    
    @Autowired
    DistSaleManagerDao dao;
    
    
    @Override
    public void save(DistSaleManager z){
        dao.save(z);
    }

    @Override
    public List<DistSaleManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistSaleManager o) {
        dao.delete(o);
    }

    @Override
    public void update(DistSaleManager o) {
        dao.update(o);
    }

    @Override
    public DistSaleManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistSaleManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

