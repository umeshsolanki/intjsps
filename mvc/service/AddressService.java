package mvc.service;

import java.util.List;
import mvc.dao.AddressDao;
import entities.Address;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AddressService extends AbstractService<Address, Long>{
    
    @Autowired
    AddressDao dao;
    
    
    @Override
    public void save(Address z){
        dao.save(z);
    }

    @Override
    public List<Address> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Address o) {
        dao.delete(o);
    }

    @Override
    public void update(Address o) {
        dao.update(o);
    }

    @Override
    public Address get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Address obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

