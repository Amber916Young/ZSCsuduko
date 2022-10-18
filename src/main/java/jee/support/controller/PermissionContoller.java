package jee.support.controller;


import jee.support.entity.AJAXResult;
import jee.support.entity.Permission;
import jee.support.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 权限 核心部分
 * */
@Controller
@RequestMapping(value = {"/permission"})
public class PermissionContoller {

    @Autowired
    private PermissionService permissionService;

    @RequestMapping(value = {"/"})
    public String GotoPermission(){
        return "permission/permission";
    }


    @ResponseBody
    @RequestMapping(value = {"/loadData"})
    public Object loadData(){
        /**
         * 模拟的数据
         *
         * **/
        List<Permission> permissions = new ArrayList<Permission>();

        Permission parent = new Permission();
        parent.setId(0);
        queryChildPermissions(parent);
        return parent.getChildren();
    }

    //递归算法  但是效率比较低，因为操作数据库很多次
    private void queryChildPermissions(Permission parent){
        List<Permission> childPermissions = permissionService.queryChildPermissions(parent.getId());
        for(Permission permission :childPermissions){
            queryChildPermissions(permission);
        }
        parent.setChildren(childPermissions);
    }


    //增加节点
    @RequestMapping("/add")
    public String add(){
        return "permission/add";
    }


    @ResponseBody
    @RequestMapping(value = {"/insert"})
    public Object insert(Permission permission){
        System.out.println("insert  permission"+permission);
        AJAXResult result = new AJAXResult();
        try {
            permissionService.insertPermission(permission);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //修改节点

    @RequestMapping(value = {"/edit"})
    public String edit(Integer id , Model model){
        Permission permission = permissionService.queryById(id);
        model.addAttribute("permission",permission);
        return "permission/edit";
    }

    @ResponseBody
    @RequestMapping(value = {"/update"})
    public Object update(Permission permission){

        AJAXResult result = new AJAXResult();
        try {
            System.out.println(permission);
            permissionService.updatePermission(permission);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //删除节点
    @ResponseBody
    @RequestMapping(value = "/delete")
    public Object delete(Permission permission){
        System.out.println("delete"+permission);
        AJAXResult result = new AJAXResult();
        try {
            permissionService.deletePermission(permission);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }



    @ResponseBody
    @RequestMapping({"/loadAssignData"})
    public Object loadAssignData(Integer roleid) {
        List<Permission> permissions = new ArrayList();
        List<Permission> ps = this.permissionService.queryAll();
        List<Integer> permissionids = this.permissionService.queryPermissionidsByRoleid(roleid);
        Map<Integer, Permission> permissionMap = new HashMap();

        Permission p;
        Iterator var7;
        for(var7 = ps.iterator(); var7.hasNext(); permissionMap.put(p.getId(), p)) {
            p = (Permission)var7.next();
            if (permissionids.contains(p.getId())) {
                p.setChecked(true);
            } else {
                p.setChecked(false);
            }
        }
        var7 = ps.iterator();
        while(var7.hasNext()) {
            p = (Permission)var7.next();
            if (p.getPid() == 0) {
                permissions.add(p);
            } else {
                Permission parent = (Permission)permissionMap.get(p.getPid());
                parent.getChildren().add(p);
            }
        }

        return permissions;
    }


}
