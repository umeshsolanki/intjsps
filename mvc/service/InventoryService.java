package mvc.service;

import java.util.List;
import mvc.dao.InventoryDao;
import entities.Inventory;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class InventoryService extends AbstractService<Inventory, Long>{
    
    @Autowired
    InventoryDao dao;
    
    
    @Override
    public void save(Inventory z){
        dao.save(z);
    }

    @Override
    public List<Inventory> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Inventory o) {
        dao.delete(o);
    }

    @Override
    public void update(Inventory o) {
        dao.update(o);
    }

    @Override
    public Inventory get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Inventory obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

