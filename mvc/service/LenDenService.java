package mvc.service;

import java.util.List;
import mvc.dao.LenDenDao;
import entities.LenDen;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LenDenService extends AbstractService<LenDen, Long>{
    
    @Autowired
    LenDenDao dao;
    
    
    @Override
    public void save(LenDen z){
        dao.save(z);
    }

    @Override
    public List<LenDen> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(LenDen o) {
        dao.delete(o);
    }

    @Override
    public void update(LenDen o) {
        dao.update(o);
    }

    @Override
    public LenDen get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, LenDen obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

