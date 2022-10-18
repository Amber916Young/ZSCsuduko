package jee.support.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jee.support.entity.AJAXResult;
import jee.support.entity.Page;
import jee.support.entity.Role;
import jee.support.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(Integer id){
		System.out.println(id);
		AJAXResult result = new AJAXResult();
		try {
			roleService.deleteRole(id);
			result.setSuccess(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}

	@RequestMapping("/edit")
	public String edit() {
		return "role/edit";
	}


	@ResponseBody
	@RequestMapping(value = "/upload",method = RequestMethod.POST)
	public Object upload(Role role){
		System.out.println(role);
		AJAXResult result = new AJAXResult();
		try {
			roleService.updataRole(role);
			result.setSuccess(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}


	@RequestMapping("/add")
	public String add() {
		return "role/add";
	}
	@ResponseBody
	@RequestMapping(value = "/insert",method = RequestMethod.POST)
	public Object insert(Role role){
		System.out.println(role);
		AJAXResult result = new AJAXResult();
		try {
			roleService.insertRole(role);
			result.setSuccess(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/pageQuery")
	public Object pageQuery( String queryText, Integer pageno, Integer pagesize ) {
		AJAXResult result = new AJAXResult();
		System.out.println( "queryText"+queryText);
		System.out.println( "pageno"+pageno);
		try {
			// 分页查询
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("start", (pageno-1)*pagesize);
			map.put("size", pagesize);
			map.put("queryText", queryText);

			List<Role> roles = roleService.pageQueryData( map );
			// 当前页码
			// 总的数据条数
			int totalsize = roleService.pageQueryCount( map );
			// 最大页码（总页码）
			int totalno = 0;
			if ( totalsize % pagesize == 0 ) {
				totalno = totalsize / pagesize;
			} else {
				totalno = totalsize / pagesize + 1;
			}

			// 分页对象
			Page<Role> rolePage = new Page<Role>();
			rolePage.setDatas(roles);
			rolePage.setTotalno(totalno);
			rolePage.setTotalsize(totalsize);
			rolePage.setPageno(pageno);

			result.setData(rolePage);
			result.setSuccess(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			result.setSuccess(false);
		}

		return result;

	}

	//分配角色
	@ResponseBody
	@RequestMapping(value = "/doAssign",method = RequestMethod.POST)
	public Object doAssign( Integer roleid, Integer[] permissionids ) {
		AJAXResult result = new AJAXResult();
		
		try {
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("roleid", roleid);
			paramMap.put("permissionids", permissionids);
			roleService.insertRolePermission(paramMap);
			result.setSuccess(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		
		return result;
	}
	
	@RequestMapping("/assign")
	public String assign() {
		return "role/assign";
	}
	
	@RequestMapping("/")
	public String index() {
		return "role/role";
	}
}
