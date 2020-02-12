package mvc.service;

import java.util.List;
import mvc.dao.UIManagerDao;
import entities.UIManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UIManagerService extends AbstractService<UIManager, Long>{
    
    @Autowired
    UIManagerDao dao;
    
    
    @Override
    public void save(UIManager z){
        dao.save(z);
    }

    @Override
    public List<UIManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(UIManager o) {
        dao.delete(o);
    }

    @Override
    public void update(UIManager o) {
        dao.update(o);
    }

    @Override
    public UIManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, UIManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

