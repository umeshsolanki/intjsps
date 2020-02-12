package mvc.service;

import java.util.List;
import mvc.dao.TaxesDao;
import entities.Taxes;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TaxesService extends AbstractService<Taxes, Long>{
    
    @Autowired
    TaxesDao dao;
    
    
    @Override
    public void save(Taxes z){
        dao.save(z);
    }

    @Override
    public List<Taxes> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Taxes o) {
        dao.delete(o);
    }

    @Override
    public void update(Taxes o) {
        dao.update(o);
    }

    @Override
    public Taxes get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Taxes obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

