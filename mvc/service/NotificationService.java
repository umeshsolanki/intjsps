package mvc.service;

import java.util.List;
import mvc.dao.NotificationDao;
import entities.Notification;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class NotificationService extends AbstractService<Notification, Long>{
    
    @Autowired
    NotificationDao dao;
    
    
    @Override
    public void save(Notification z){
        dao.save(z);
    }

    @Override
    public List<Notification> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Notification o) {
        dao.delete(o);
    }

    @Override
    public void update(Notification o) {
        dao.update(o);
    }

    @Override
    public Notification get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Notification obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

