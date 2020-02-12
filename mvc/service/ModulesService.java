package mvc.service;

import java.util.List;
import mvc.dao.ModulesDao;
import entities.Modules;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ModulesService extends AbstractService<Modules, Long>{
    
    @Autowired
    ModulesDao dao;
    
    
    @Override
    public void save(Modules z){
        dao.save(z);
    }

    @Override
    public List<Modules> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Modules o) {
        dao.delete(o);
    }

    @Override
    public void update(Modules o) {
        dao.update(o);
    }

    @Override
    public Modules get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Modules obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

