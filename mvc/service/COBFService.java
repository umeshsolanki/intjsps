package mvc.service;

import java.util.List;
import mvc.dao.COBFDao;
import entities.COBF;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class COBFService extends AbstractService<COBF, Long>{
    
    @Autowired
    COBFDao dao;
    
    
    @Override
    public void save(COBF z){
        dao.save(z);
    }

    @Override
    public List<COBF> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(COBF o) {
        dao.delete(o);
    }

    @Override
    public void update(COBF o) {
        dao.update(o);
    }

    @Override
    public COBF get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, COBF obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

