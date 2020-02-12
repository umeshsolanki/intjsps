package mvc.service;

import java.util.List;
import mvc.dao.OrderInfoDao;
import entities.OrderInfo;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderInfoService extends AbstractService<OrderInfo, Long>{
    
    @Autowired
    OrderInfoDao dao;
    
    
    @Override
    public void save(OrderInfo z){
        dao.save(z);
    }

    @Override
    public List<OrderInfo> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(OrderInfo o) {
        dao.delete(o);
    }

    @Override
    public void update(OrderInfo o) {
        dao.update(o);
    }

    @Override
    public OrderInfo get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, OrderInfo obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

