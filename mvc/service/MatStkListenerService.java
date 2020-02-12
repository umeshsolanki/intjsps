package mvc.service;

import java.util.List;
import mvc.dao.MatStkListenerDao;
import entities.MatStkListener;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MatStkListenerService extends AbstractService<MatStkListener, Long>{
    
    @Autowired
    MatStkListenerDao dao;
    
    
    @Override
    public void save(MatStkListener z){
        dao.save(z);
    }

    @Override
    public List<MatStkListener> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MatStkListener o) {
        dao.delete(o);
    }

    @Override
    public void update(MatStkListener o) {
        dao.update(o);
    }

    @Override
    public MatStkListener get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MatStkListener obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

