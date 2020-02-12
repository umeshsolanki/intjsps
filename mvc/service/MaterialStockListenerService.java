package mvc.service;

import java.util.List;
import mvc.dao.MaterialStockListenerDao;
import entities.MaterialStockListener;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MaterialStockListenerService extends AbstractService<MaterialStockListener, Long>{
    
    @Autowired
    MaterialStockListenerDao dao;
    
    
    @Override
    public void save(MaterialStockListener z){
        dao.save(z);
    }

    @Override
    public List<MaterialStockListener> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MaterialStockListener o) {
        dao.delete(o);
    }

    @Override
    public void update(MaterialStockListener o) {
        dao.update(o);
    }

    @Override
    public MaterialStockListener get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MaterialStockListener obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

