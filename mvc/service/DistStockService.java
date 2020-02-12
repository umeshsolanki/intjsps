package mvc.service;

import java.util.List;
import mvc.dao.DistStockDao;
import entities.DistStock;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistStockService extends AbstractService<DistStock, Long>{
    
    @Autowired
    DistStockDao dao;
    
    
    @Override
    public void save(DistStock z){
        dao.save(z);
    }

    @Override
    public List<DistStock> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistStock o) {
        dao.delete(o);
    }

    @Override
    public void update(DistStock o) {
        dao.update(o);
    }

    @Override
    public DistStock get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistStock obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

