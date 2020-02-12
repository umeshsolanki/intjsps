package mvc.service;

import java.util.List;
import mvc.dao.DSRManagerDao;
import entities.DSRManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DSRManagerService extends AbstractService<DSRManager, Long>{
    
    @Autowired
    DSRManagerDao dao;
    
    
    @Override
    public void save(DSRManager z){
        dao.save(z);
    }

    @Override
    public List<DSRManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DSRManager o) {
        dao.delete(o);
    }

    @Override
    public void update(DSRManager o) {
        dao.update(o);
    }

    @Override
    public DSRManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DSRManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

