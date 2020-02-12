package mvc.service;

import java.util.List;
import mvc.dao.AdminsDao;
import entities.Admins;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminsService extends AbstractService<Admins, Long>{
    
    @Autowired
    AdminsDao dao;
    
    
    @Override
    public void save(Admins z){
        dao.save(z);
    }

    @Override
    public List<Admins> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Admins o) {
        dao.delete(o);
    }

    @Override
    public void update(Admins o) {
        dao.update(o);
    }

    @Override
    public Admins get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Admins obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

