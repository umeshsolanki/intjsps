package mvc.service;

import java.util.List;
import mvc.dao.DistOrderManagerDao;
import entities.DistOrderManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistOrderManagerService extends AbstractService<DistOrderManager, Long>{
    
    @Autowired
    DistOrderManagerDao dao;
    
    
    @Override
    public void save(DistOrderManager z){
        dao.save(z);
    }

    @Override
    public List<DistOrderManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistOrderManager o) {
        dao.delete(o);
    }

    @Override
    public void update(DistOrderManager o) {
        dao.update(o);
    }

    @Override
    public DistOrderManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistOrderManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

