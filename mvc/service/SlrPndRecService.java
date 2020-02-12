package mvc.service;

import java.util.List;
import mvc.dao.SlrPndRecDao;
import entities.SlrPndRec;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SlrPndRecService extends AbstractService<SlrPndRec, Long>{
    
    @Autowired
    SlrPndRecDao dao;
    
    
    @Override
    public void save(SlrPndRec z){
        dao.save(z);
    }

    @Override
    public List<SlrPndRec> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(SlrPndRec o) {
        dao.delete(o);
    }

    @Override
    public void update(SlrPndRec o) {
        dao.update(o);
    }

    @Override
    public SlrPndRec get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, SlrPndRec obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

