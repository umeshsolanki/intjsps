package mvc.service;

import java.util.List;
import mvc.dao.TicketDao;
import entities.Ticket;
import entities.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TicketService extends AbstractService<Ticket, Long>{
    
    @Autowired
    TicketDao dao;
    
    
    @Override
    public void save(Ticket z){
        dao.save(z);
    }

    @Override
    public List<Ticket> listAll() {
        return dao.listAll();
    }

    
    @Override
    public void delete(Ticket o) {
        dao.delete(o);
    }

    @Override
    public void update(Ticket o) {
        dao.update(o);
    }

    @Override
    public Ticket get(Long pk) {
        return dao.getByKey(pk);
    }
 
    @Override
    public boolean belongs(Customer c, Ticket obj) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
       
}

