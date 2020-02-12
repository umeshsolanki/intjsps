package mvc.service;

import java.util.List;
import mvc.dao.ConfigDao;
import entities.Config;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ConfigService extends AbstractService<Config, Long>{
    
    @Autowired
    ConfigDao dao;
    
    
    @Override
    public void save(Config z){
        dao.save(z);
    }

    @Override
    public List<Config> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Config o) {
        dao.delete(o);
    }

    @Override
    public void update(Config o) {
        dao.update(o);
    }

    @Override
    public Config get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Config obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

