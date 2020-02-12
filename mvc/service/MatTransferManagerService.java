package mvc.service;

import java.util.List;
import mvc.dao.MatTransferManagerDao;
import entities.MatTransferManager;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MatTransferManagerService extends AbstractService<MatTransferManager, Long>{
    
    @Autowired
    MatTransferManagerDao dao;
    
    
    @Override
    public void save(MatTransferManager z){
        dao.save(z);
    }

    @Override
    public List<MatTransferManager> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(MatTransferManager o) {
        dao.delete(o);
    }

    @Override
    public void update(MatTransferManager o) {
        dao.update(o);
    }

    @Override
    public MatTransferManager get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, MatTransferManager obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

