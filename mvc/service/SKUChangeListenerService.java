package mvc.service;

import java.util.List;
import mvc.dao.SKUChangeListenerDao;
import entities.SKUChangeListener;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SKUChangeListenerService extends AbstractService<SKUChangeListener, Long>{
    
    @Autowired
    SKUChangeListenerDao dao;
    
    
    @Override
    public void save(SKUChangeListener z){
        dao.save(z);
    }

    @Override
    public List<SKUChangeListener> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(SKUChangeListener o) {
        dao.delete(o);
    }

    @Override
    public void update(SKUChangeListener o) {
        dao.update(o);
    }

    @Override
    public SKUChangeListener get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, SKUChangeListener obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

