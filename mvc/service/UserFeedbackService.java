package mvc.service;

import java.util.List;
import mvc.dao.UserFeedbackDao;
import entities.UserFeedback;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserFeedbackService extends AbstractService<UserFeedback, Long>{
    
    @Autowired
    UserFeedbackDao dao;
    
    
    @Override
    public void save(UserFeedback z){
        dao.save(z);
    }

    @Override
    public List<UserFeedback> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(UserFeedback o) {
        dao.delete(o);
    }

    @Override
    public void update(UserFeedback o) {
        dao.update(o);
    }

    @Override
    public UserFeedback get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, UserFeedback obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

