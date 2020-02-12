package mvc.service;

import java.util.List;
import mvc.dao.FPSTKListenerDao;
import entities.FPSTKListener;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class FPSTKListenerService extends AbstractService<FPSTKListener, Long>{
    
    @Autowired
    FPSTKListenerDao dao;
    
    
    @Override
    public void save(FPSTKListener z){
        dao.save(z);
    }

    @Override
    public List<FPSTKListener> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(FPSTKListener o) {
        dao.delete(o);
    }

    @Override
    public void update(FPSTKListener o) {
        dao.update(o);
    }

    @Override
    public FPSTKListener get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, FPSTKListener obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

