package jee.support.entity;

import jee.support.service.TimingService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

@Data
public class DeleteByoidAndType {
    private int id;
    private String type;

    @Autowired
    TimingService timingService;

    public int DeleteTimingByoidAndType(int oid,String type){
//        System.out.println("DeleteTimingByoidAndType===="+oid+type);
        int num =this.timingService.deleteBeforeByOid(oid,type);
        if(num==0){
            return 0;
        }
        return 1;
    }
    public void SetData(int oid,String type){
        this.id =oid;
        this.type =type;
//        System.out.println(oid+type);
    }

}
