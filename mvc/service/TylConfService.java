package mvc.service;

import java.util.List;
import mvc.dao.TylConfDao;
import entities.TylConf;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TylConfService extends AbstractService<TylConf, Long>{
    
    @Autowired
    TylConfDao dao;
    
    
    @Override
    public void save(TylConf z){
        dao.save(z);
    }

    @Override
    public List<TylConf> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(TylConf o) {
        dao.delete(o);
    }

    @Override
    public void update(TylConf o) {
        dao.update(o);
    }

    @Override
    public TylConf get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, TylConf obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

