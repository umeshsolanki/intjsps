package mvc.service;

import java.util.List;
import mvc.dao.BranchTransferDao;
import entities.BranchTransfer;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BranchTransferService extends AbstractService<BranchTransfer, Long>{
    
    @Autowired
    BranchTransferDao dao;
    
    
    @Override
    public void save(BranchTransfer z){
        dao.save(z);
    }

    @Override
    public List<BranchTransfer> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(BranchTransfer o) {
        dao.delete(o);
    }

    @Override
    public void update(BranchTransfer o) {
        dao.update(o);
    }

    @Override
    public BranchTransfer get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, BranchTransfer obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

