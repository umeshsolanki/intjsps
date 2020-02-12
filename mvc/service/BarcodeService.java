package mvc.service;

import java.util.List;
import mvc.dao.BarcodeDao;
import entities.Barcode;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BarcodeService extends AbstractService<Barcode, Long>{
    
    @Autowired
    BarcodeDao dao;
    
    
    @Override
    public void save(Barcode z){
        dao.save(z);
    }

    @Override
    public List<Barcode> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Barcode o) {
        dao.delete(o);
    }

    @Override
    public void update(Barcode o) {
        dao.update(o);
    }

    @Override
    public Barcode get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Barcode obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

