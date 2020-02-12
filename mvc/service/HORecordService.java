package mvc.service;

import java.util.List;
import mvc.dao.HORecordDao;
import entities.HORecord;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class HORecordService extends AbstractService<HORecord, Long>{
    
    @Autowired
    HORecordDao dao;
    
    
    @Override
    public void save(HORecord z){
        dao.save(z);
    }

    @Override
    public List<HORecord> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(HORecord o) {
        dao.delete(o);
    }

    @Override
    public void update(HORecord o) {
        dao.update(o);
    }

    @Override
    public HORecord get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, HORecord obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

