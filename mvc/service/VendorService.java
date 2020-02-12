package mvc.service;

import java.util.List;
import mvc.dao.VendorDao;
import entities.Vendor;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class VendorService extends AbstractService<Vendor, Long>{
    
    @Autowired
    VendorDao dao;
    
    
    @Override
    public void save(Vendor z){
        dao.save(z);
    }

    @Override
    public List<Vendor> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Vendor o) {
        dao.delete(o);
    }

    @Override
    public void update(Vendor o) {
        dao.update(o);
    }

    @Override
    public Vendor get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Vendor obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

