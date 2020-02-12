package mvc.service;

import java.util.List;
import mvc.dao.MaterialDao;
import entities.Material;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MaterialService extends AbstractService<Material, Long>{
    
    @Autowired
    MaterialDao dao;
    
    
    @Override
    public void save(Material z){
        dao.save(z);
    }

    @Override
    public List<Material> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Material o) {
        dao.delete(o);
    }

    @Override
    public void update(Material o) {
        dao.update(o);
    }

    @Override
    public Material get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Material obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

