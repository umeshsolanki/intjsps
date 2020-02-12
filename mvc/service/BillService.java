package mvc.service;

import java.util.List;
import mvc.dao.BillDao;
import entities.Bill;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BillService extends AbstractService<Bill, Long>{
    
    @Autowired
    BillDao dao;
    
    
    @Override
    public void save(Bill z){
        dao.save(z);
    }

    @Override
    public List<Bill> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Bill o) {
        dao.delete(o);
    }

    @Override
    public void update(Bill o) {
        dao.update(o);
    }

    @Override
    public Bill get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Bill obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

