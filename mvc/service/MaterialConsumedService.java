package mvc.service;

import java.util.List;
import mvc.dao.MaterialConsumedDao;
import entities.MaterialConsumed;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MaterialConsumedService extends AbstractService<MaterialConsumed, Long>{
    
    @Autowired
    MaterialConsumedDao dao;
    
    
    @Override
    public void save(MaterialConsumed z){
        dao.save(z);
    }

    @Override
    public List<MaterialConsumed> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MaterialConsumed o) {
        dao.delete(o);
    }

    @Override
    public void update(MaterialConsumed o) {
        dao.update(o);
    }

    @Override
    public MaterialConsumed get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MaterialConsumed obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

