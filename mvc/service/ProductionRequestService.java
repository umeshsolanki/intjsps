package mvc.service;

import java.util.List;
import mvc.dao.ProductionRequestDao;
import entities.ProductionRequest;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProductionRequestService extends AbstractService<ProductionRequest, Long>{
    
    @Autowired
    ProductionRequestDao dao;
    
    
    @Override
    public void save(ProductionRequest z){
        dao.save(z);
    }

    @Override
    public List<ProductionRequest> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(ProductionRequest o) {
        dao.delete(o);
    }

    @Override
    public void update(ProductionRequest o) {
        dao.update(o);
    }

    @Override
    public ProductionRequest get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, ProductionRequest obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

