package mvc.service;

import java.util.List;
import mvc.dao.DistStockListenerDao;
import entities.DistStockListener;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistStockListenerService extends AbstractService<DistStockListener, Long>{
    
    @Autowired
    DistStockListenerDao dao;
    
    
    @Override
    public void save(DistStockListener z){
        dao.save(z);
    }

    @Override
    public List<DistStockListener> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistStockListener o) {
        dao.delete(o);
    }

    @Override
    public void update(DistStockListener o) {
        dao.update(o);
    }

    @Override
    public DistStockListener get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistStockListener obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

