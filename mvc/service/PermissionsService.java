package mvc.service;

import java.util.List;
import mvc.dao.PermissionsDao;
import entities.Permissions;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PermissionsService extends AbstractService<Permissions, Long>{
    
    @Autowired
    PermissionsDao dao;
    
    
    @Override
    public void save(Permissions z){
        dao.save(z);
    }

    @Override
    public List<Permissions> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Permissions o) {
        dao.delete(o);
    }

    @Override
    public void update(Permissions o) {
        dao.update(o);
    }

    @Override
    public Permissions get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Permissions obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

