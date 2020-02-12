package mvc.service;

import java.util.List;
import mvc.dao.DistributionRecordDao;
import entities.DistributionRecord;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistributionRecordService extends AbstractService<DistributionRecord, Long>{
    
    @Autowired
    DistributionRecordDao dao;
    
    
    @Override
    public void save(DistributionRecord z){
        dao.save(z);
    }

    @Override
    public List<DistributionRecord> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistributionRecord o) {
        dao.delete(o);
    }

    @Override
    public void update(DistributionRecord o) {
        dao.update(o);
    }

    @Override
    public DistributionRecord get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistributionRecord obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

