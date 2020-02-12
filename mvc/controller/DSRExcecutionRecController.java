
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.controller;

import entities.DSRExcecutionRec;
import javax.servlet.http.HttpSession;
import mvc.service.DSRExcecutionRecService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;

/**
 *
 * @author om
 */
@Controller
@RequestMapping(value = "/dSRExcecutionRec")
public class DSRExcecutionRecController {
   
    @Autowired
    DSRExcecutionRecService service;

    @RequestMapping(method = RequestMethod.GET,value = "/table")
    public String listTable(HttpSession session,ModelMap m){
        m.addAttribute("elist", service.listAll());
        return "/admin/$ccentity.jsp";
    }

    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String form(HttpSession session){
        return "/new$ccentity.jsp";
    }
    
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String save(HttpSession session,@RequestBody DSRExcecutionRec e){
        service.save(e);
        return "Saved";
    }

    @RequestMapping(value = "/update/{id}",method = RequestMethod.GET)
    public String editForm(HttpSession session, ModelMap m, @PathVariable("id") Long id){
        m.addAttribute("e",service.get(id));
        return "/update$ccentity.jsp";
    }

    @RequestMapping(value = "/update/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public String edit(HttpSession session, @RequestBody DSRExcecutionRec e, @PathVariable("id") Long id){
        service.update(e);
        return "Updated";
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.GET)
    @ResponseBody
    public String delete(HttpSession session, @PathVariable("id") Long id){
        DSRExcecutionRec e = service.get(id);
        if(e==null)
            return "Record not found";
        service.delete(e);
        return "Deleted";
    }
    
}
