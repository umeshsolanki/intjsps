package mvc.service;

import java.util.List;
import mvc.dao.ManufacturedDao;
import entities.Manufactured;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ManufacturedService extends AbstractService<Manufactured, Long>{
    
    @Autowired
    ManufacturedDao dao;
    
    
    @Override
    public void save(Manufactured z){
        dao.save(z);
    }

    @Override
    public List<Manufactured> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Manufactured o) {
        dao.delete(o);
    }

    @Override
    public void update(Manufactured o) {
        dao.update(o);
    }

    @Override
    public Manufactured get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Manufactured obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

