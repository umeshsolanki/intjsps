package mvc.service;

import java.util.List;
import mvc.dao.InwardManagerDao;
import entities.InwardManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class InwardManagerService extends AbstractService<InwardManager, Long>{
    
    @Autowired
    InwardManagerDao dao;
    
    
    @Override
    public void save(InwardManager z){
        dao.save(z);
    }

    @Override
    public List<InwardManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(InwardManager o) {
        dao.delete(o);
    }

    @Override
    public void update(InwardManager o) {
        dao.update(o);
    }

    @Override
    public InwardManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, InwardManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

