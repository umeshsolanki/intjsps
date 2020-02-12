package mvc.service;

import java.util.List;
import mvc.dao.SKUDao;
import entities.SKU;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SKUService extends AbstractService<SKU, Long>{
    
    @Autowired
    SKUDao dao;
    
    
    @Override
    public void save(SKU z){
        dao.save(z);
    }

    @Override
    public List<SKU> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(SKU o) {
        dao.delete(o);
    }

    @Override
    public void update(SKU o) {
        dao.update(o);
    }

    @Override
    public SKU get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, SKU obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

