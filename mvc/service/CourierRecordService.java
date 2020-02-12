package mvc.service;

import java.util.List;
import mvc.dao.CourierRecordDao;
import entities.CourierRecord;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CourierRecordService extends AbstractService<CourierRecord, Long>{
    
    @Autowired
    CourierRecordDao dao;
    
    
    @Override
    public void save(CourierRecord z){
        dao.save(z);
    }

    @Override
    public List<CourierRecord> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(CourierRecord o) {
        dao.delete(o);
    }

    @Override
    public void update(CourierRecord o) {
        dao.update(o);
    }

    @Override
    public CourierRecord get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, CourierRecord obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

