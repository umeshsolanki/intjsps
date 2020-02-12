package mvc.service;

import java.util.List;
import mvc.dao.FinishedProductDao;
import entities.FinishedProduct;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class FinishedProductService extends AbstractService<FinishedProduct, Long>{
    
    @Autowired
    FinishedProductDao dao;
    
    
    @Override
    public void save(FinishedProduct z){
        dao.save(z);
    }

    @Override
    public List<FinishedProduct> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(FinishedProduct o) {
        dao.delete(o);
    }

    @Override
    public void update(FinishedProduct o) {
        dao.update(o);
    }

    @Override
    public FinishedProduct get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, FinishedProduct obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

