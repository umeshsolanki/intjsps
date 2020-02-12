package mvc.service;

import java.util.List;
import mvc.dao.TaxRecDao;
import entities.TaxRec;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TaxRecService extends AbstractService<TaxRec, Long>{
    
    @Autowired
    TaxRecDao dao;
    
    
    @Override
    public void save(TaxRec z){
        dao.save(z);
    }

    @Override
    public List<TaxRec> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(TaxRec o) {
        dao.delete(o);
    }

    @Override
    public void update(TaxRec o) {
        dao.update(o);
    }

    @Override
    public TaxRec get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, TaxRec obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

