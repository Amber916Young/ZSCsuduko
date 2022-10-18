package jee.support.dao;

import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.administrator;
import lombok.Data;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface AccountDao {


    List<Account> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    @Select("select account_money from money where id = #{selectid}")
    String checkmoney(int selectid);

    @Delete("deletc from money  where id = #{selectid}")
    void deletmoney(int selectid);

    void addmoeny(Money money1);

    void updatemoney(Money money2);

    @Select("select account_money from money where id = #{id}")
    double getmoney(int id);


    void setAccountmoeny(@Param("nowBalance") double nowBalance, @Param("id") int id);

    @Select("select balance from account where id = #{id}")
    double GetBalance(int id);

    List<Account> Getaccounts(int id);

    List<Account> Getaccounts_expenditureBygid(int gid);

    void insertAccount(Account account);

    @Delete("delete from account where id = #{id}")
    void deleteAccountById(String id);

    void deleteAccountsByid(Map<String, Object> map);


    @Select("select * from account where id = #{id}")
    Account getAccount(int id);

    void updateAccount(Account account);

    @Select("select * from money where id = #{id}")
    List<Money> queryMoneyByid(int id);

    @Select("select count(*) from money where id = #{id}")
    int checkIsNot(int id);
}
