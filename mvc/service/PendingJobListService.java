package mvc.service;

import java.util.List;
import mvc.dao.PendingJobListDao;
import entities.PendingJobList;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PendingJobListService extends AbstractService<PendingJobList, Long>{
    
    @Autowired
    PendingJobListDao dao;
    
    
    @Override
    public void save(PendingJobList z){
        dao.save(z);
    }

    @Override
    public List<PendingJobList> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(PendingJobList o) {
        dao.delete(o);
    }

    @Override
    public void update(PendingJobList o) {
        dao.update(o);
    }

    @Override
    public PendingJobList get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, PendingJobList obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

