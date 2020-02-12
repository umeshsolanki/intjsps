package mvc.service;

import java.util.List;
import mvc.dao.TrackerDao;
import entities.Tracker;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TrackerService extends AbstractService<Tracker, Long>{
    
    @Autowired
    TrackerDao dao;
    
    
    @Override
    public void save(Tracker z){
        dao.save(z);
    }

    @Override
    public List<Tracker> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Tracker o) {
        dao.delete(o);
    }

    @Override
    public void update(Tracker o) {
        dao.update(o);
    }

    @Override
    public Tracker get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Tracker obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

