package mvc.service;

import java.util.List;
import mvc.dao.CompanyDomainDao;
import entities.CompanyDomain;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CompanyDomainService extends AbstractService<CompanyDomain, Long>{
    
    @Autowired
    CompanyDomainDao dao;
    
    
    @Override
    public void save(CompanyDomain z){
        dao.save(z);
    }

    @Override
    public List<CompanyDomain> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(CompanyDomain o) {
        dao.delete(o);
    }

    @Override
    public void update(CompanyDomain o) {
        dao.update(o);
    }

    @Override
    public CompanyDomain get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, CompanyDomain obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

