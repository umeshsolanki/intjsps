package mvc.service;

import java.util.List;
import mvc.dao.EmployeeDao;
import entities.Employee;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmployeeService extends AbstractService<Employee, Long>{
    
    @Autowired
    EmployeeDao dao;
    
    
    @Override
    public void save(Employee z){
        dao.save(z);
    }

    @Override
    public List<Employee> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Employee o) {
        dao.delete(o);
    }

    @Override
    public void update(Employee o) {
        dao.update(o);
    }

    @Override
    public Employee get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Employee obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

