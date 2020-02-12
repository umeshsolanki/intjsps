package mvc.service;

import java.util.List;
import mvc.dao.TransferRecordDao;
import entities.TransferRecord;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TransferRecordService extends AbstractService<TransferRecord, Long>{
    
    @Autowired
    TransferRecordDao dao;
    
    
    @Override
    public void save(TransferRecord z){
        dao.save(z);
    }

    @Override
    public List<TransferRecord> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(TransferRecord o) {
        dao.delete(o);
    }

    @Override
    public void update(TransferRecord o) {
        dao.update(o);
    }

    @Override
    public TransferRecord get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, TransferRecord obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

