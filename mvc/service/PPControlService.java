package mvc.service;

import java.util.List;
import mvc.dao.PPControlDao;
import entities.PPControl;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PPControlService extends AbstractService<PPControl, Long>{
    
    @Autowired
    PPControlDao dao;
    
    
    @Override
    public void save(PPControl z){
        dao.save(z);
    }

    @Override
    public List<PPControl> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(PPControl o) {
        dao.delete(o);
    }

    @Override
    public void update(PPControl o) {
        dao.update(o);
    }

    @Override
    public PPControl get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, PPControl obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

