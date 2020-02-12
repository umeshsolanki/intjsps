package mvc.service;

import java.util.List;
import mvc.dao.ProductionBranchDao;
import entities.ProductionBranch;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProductionBranchService extends AbstractService<ProductionBranch, Long>{
    
    @Autowired
    ProductionBranchDao dao;
    
    
    @Override
    public void save(ProductionBranch z){
        dao.save(z);
    }

    @Override
    public List<ProductionBranch> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(ProductionBranch o) {
        dao.delete(o);
    }

    @Override
    public void update(ProductionBranch o) {
        dao.update(o);
    }

    @Override
    public ProductionBranch get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, ProductionBranch obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

