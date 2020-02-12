package mvc.service;

import java.util.List;
import mvc.dao.PurBillsDao;
import entities.PurBills;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PurBillsService extends AbstractService<PurBills, Long>{
    
    @Autowired
    PurBillsDao dao;
    
    
    @Override
    public void save(PurBills z){
        dao.save(z);
    }

    @Override
    public List<PurBills> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(PurBills o) {
        dao.delete(o);
    }

    @Override
    public void update(PurBills o) {
        dao.update(o);
    }

    @Override
    public PurBills get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, PurBills obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

