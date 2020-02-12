package mvc.service;

import java.util.List;
import mvc.dao.ReturnInfoDao;
import entities.ReturnInfo;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ReturnInfoService extends AbstractService<ReturnInfo, Long>{
    
    @Autowired
    ReturnInfoDao dao;
    
    
    @Override
    public void save(ReturnInfo z){
        dao.save(z);
    }

    @Override
    public List<ReturnInfo> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(ReturnInfo o) {
        dao.delete(o);
    }

    @Override
    public void update(ReturnInfo o) {
        dao.update(o);
    }

    @Override
    public ReturnInfo get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, ReturnInfo obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

