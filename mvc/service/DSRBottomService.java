package mvc.service;

import java.util.List;
import mvc.dao.DSRBottomDao;
import entities.DSRBottom;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DSRBottomService extends AbstractService<DSRBottom, Long>{
    
    @Autowired
    DSRBottomDao dao;
    
    
    @Override
    public void save(DSRBottom z){
        dao.save(z);
    }

    @Override
    public List<DSRBottom> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DSRBottom o) {
        dao.delete(o);
    }

    @Override
    public void update(DSRBottom o) {
        dao.update(o);
    }

    @Override
    public DSRBottom get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DSRBottom obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

