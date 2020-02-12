package mvc.service;

import java.util.List;
import mvc.dao.PendingManDao;
import entities.PendingMan;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PendingManService extends AbstractService<PendingMan, Long>{
    
    @Autowired
    PendingManDao dao;
    
    
    @Override
    public void save(PendingMan z){
        dao.save(z);
    }

    @Override
    public List<PendingMan> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(PendingMan o) {
        dao.delete(o);
    }

    @Override
    public void update(PendingMan o) {
        dao.update(o);
    }

    @Override
    public PendingMan get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, PendingMan obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

