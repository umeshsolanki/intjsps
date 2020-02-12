package mvc.service;

import java.util.List;
import mvc.dao.DistributorInfoDao;
import entities.DistributorInfo;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DistributorInfoService extends AbstractService<DistributorInfo, Long>{
    
    @Autowired
    DistributorInfoDao dao;
    
    
    @Override
    public void save(DistributorInfo z){
        dao.save(z);
    }

    @Override
    public List<DistributorInfo> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(DistributorInfo o) {
        dao.delete(o);
    }

    @Override
    public void update(DistributorInfo o) {
        dao.update(o);
    }

    @Override
    public DistributorInfo get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, DistributorInfo obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

