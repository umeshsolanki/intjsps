package mvc.service;

import java.util.List;
import mvc.dao.MonthlyTargetDao;
import entities.MonthlyTarget;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MonthlyTargetService extends AbstractService<MonthlyTarget, Long>{
    
    @Autowired
    MonthlyTargetDao dao;
    
    
    @Override
    public void save(MonthlyTarget z){
        dao.save(z);
    }

    @Override
    public List<MonthlyTarget> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MonthlyTarget o) {
        dao.delete(o);
    }

    @Override
    public void update(MonthlyTarget o) {
        dao.update(o);
    }

    @Override
    public MonthlyTarget get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MonthlyTarget obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

