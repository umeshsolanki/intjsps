package mvc.service;

import java.util.List;
import mvc.dao.RepairRecordDao;
import entities.RepairRecord;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class RepairRecordService extends AbstractService<RepairRecord, Long>{
    
    @Autowired
    RepairRecordDao dao;
    
    
    @Override
    public void save(RepairRecord z){
        dao.save(z);
    }

    @Override
    public List<RepairRecord> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(RepairRecord o) {
        dao.delete(o);
    }

    @Override
    public void update(RepairRecord o) {
        dao.update(o);
    }

    @Override
    public RepairRecord get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, RepairRecord obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

