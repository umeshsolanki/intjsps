package mvc.service;

import java.util.List;
import mvc.dao.OrdersBackupDao;
import entities.OrdersBackup;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrdersBackupService extends AbstractService<OrdersBackup, Long>{
    
    @Autowired
    OrdersBackupDao dao;
    
    
    @Override
    public void save(OrdersBackup z){
        dao.save(z);
    }

    @Override
    public List<OrdersBackup> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(OrdersBackup o) {
        dao.delete(o);
    }

    @Override
    public void update(OrdersBackup o) {
        dao.update(o);
    }

    @Override
    public OrdersBackup get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, OrdersBackup obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

