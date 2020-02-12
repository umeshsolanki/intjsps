package mvc.service;

import java.util.List;
import mvc.dao.MyCustomizationDao;
import entities.MyCustomization;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MyCustomizationService extends AbstractService<MyCustomization, Long>{
    
    @Autowired
    MyCustomizationDao dao;
    
    
    @Override
    public void save(MyCustomization z){
        dao.save(z);
    }

    @Override
    public List<MyCustomization> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MyCustomization o) {
        dao.delete(o);
    }

    @Override
    public void update(MyCustomization o) {
        dao.update(o);
    }

    @Override
    public MyCustomization get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MyCustomization obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

