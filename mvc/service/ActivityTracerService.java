package mvc.service;

import java.util.List;
import mvc.dao.ActivityTracerDao;
import entities.ActivityTracer;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ActivityTracerService extends AbstractService<ActivityTracer, Long>{
    
    @Autowired
    ActivityTracerDao dao;
    
    
    @Override
    public void save(ActivityTracer z){
        dao.save(z);
    }

    @Override
    public List<ActivityTracer> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(ActivityTracer o) {
        dao.delete(o);
    }

    @Override
    public void update(ActivityTracer o) {
        dao.update(o);
    }

    @Override
    public ActivityTracer get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, ActivityTracer obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

