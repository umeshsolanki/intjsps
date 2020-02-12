package mvc.service;

import java.util.List;
import mvc.dao.DistFinanceDao;
import entities.DistFinance;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistFinanceService extends AbstractService<DistFinance, Long>{
    
    @Autowired
    DistFinanceDao dao;
    
    
    @Override
    public void save(DistFinance z){
        dao.save(z);
    }

    @Override
    public List<DistFinance> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistFinance o) {
        dao.delete(o);
    }

    @Override
    public void update(DistFinance o) {
        dao.update(o);
    }

    @Override
    public DistFinance get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistFinance obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

