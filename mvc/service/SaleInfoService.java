package mvc.service;

import java.util.List;
import mvc.dao.SaleInfoDao;
import entities.SaleInfo;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SaleInfoService extends AbstractService<SaleInfo, Long>{
    
    @Autowired
    SaleInfoDao dao;
    
    
    @Override
    public void save(SaleInfo z){
        dao.save(z);
    }

    @Override
    public List<SaleInfo> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(SaleInfo o) {
        dao.delete(o);
    }

    @Override
    public void update(SaleInfo o) {
        dao.update(o);
    }

    @Override
    public SaleInfo get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, SaleInfo obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

