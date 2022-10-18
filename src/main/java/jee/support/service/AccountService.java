package jee.support.service;

import jee.support.dao.AccountDao;
import jee.support.dao.AdministratorDao;
import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.administrator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class AccountService {

    @Autowired
    AccountDao accountDao;

    public List<Account> pageQueryData(Map<String, Object> map) {
        return accountDao.pageQueryData(map);
    }

    public int pageQueryCount(Map<String, Object> map) {
        return accountDao.pageQueryCount(map);
    }

    public String checkmoney(int selectid) {
        return accountDao.checkmoney(selectid);
    }

    public void deletmoney(int selectid) {
        accountDao.deletmoney(selectid);
    }

    public void addmoeny(Money money1) {
        accountDao.addmoeny(money1);
    }

    public void updatemoney(Money money2) {
        accountDao.updatemoney(money2);
    }

    public double getmoney(int id) {
        return accountDao.getmoney(id);
    }

    public void setAccountmoeny( double nowBalance ,int id) {
        accountDao.setAccountmoeny(nowBalance,id);
    }

    public double GetBalance(int id) {
        return accountDao.GetBalance(id);
    }

    public List<Account> Getaccounts(int id) {
        return accountDao.Getaccounts(id);
    }

    public List<Account> Getaccounts_expenditureBygid(int gid) {
        return accountDao.Getaccounts_expenditureBygid(gid);
    }

    public void insertAccount(Account account) {
         accountDao.insertAccount(account);
    }

    public void deleteAccountById(String id) {
        accountDao.deleteAccountById(id);
    }

    public void deleteAccountsByid(Map<String, Object> map) {
        accountDao.deleteAccountsByid(map);
    }

    public Account getAccount(int id) {
        return accountDao.getAccount(id);
    }

    public void updateAccount(Account account) {
        accountDao.updateAccount(account);
    }

    public List<Money> queryMoneyByid(int id) {
        return accountDao.queryMoneyByid(id);
    }

    public int checkIsNot(int id) {
        return accountDao.checkIsNot(id);
    }
}

