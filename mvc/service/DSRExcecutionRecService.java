package mvc.service;

import java.util.List;
import mvc.dao.DSRExcecutionRecDao;
import entities.DSRExcecutionRec;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DSRExcecutionRecService extends AbstractService<DSRExcecutionRec, Long>{
    
    @Autowired
    DSRExcecutionRecDao dao;
    
    
    @Override
    public void save(DSRExcecutionRec z){
        dao.save(z);
    }

    @Override
    public List<DSRExcecutionRec> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DSRExcecutionRec o) {
        dao.delete(o);
    }

    @Override
    public void update(DSRExcecutionRec o) {
        dao.update(o);
    }

    @Override
    public DSRExcecutionRec get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DSRExcecutionRec obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

