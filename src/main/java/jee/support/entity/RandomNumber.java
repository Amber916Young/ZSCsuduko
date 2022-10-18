package jee.support.entity;

import java.util.ArrayList;
import java.util.Random;

public class RandomNumber {
    public int CreateRandomNumber(){
        int randInt = 0;//新建变量用于临时存储产生的随机数
        randInt = (int)Math.ceil(Math.random() * (1000000 - 10)) + 10;
        System.out.println(randInt+"  ");
        return randInt;
    }
    public int CreateRandomNumber2(){
        int randInt = 0;//新建变量用于临时存储产生的随机数
        randInt = (int)Math.ceil(Math.random() * (2000000 - 1000000)) + 1000000;
        System.out.println(randInt+"  ");
        return randInt;
    }
    public int CreateRandomNumber3(){
        int randInt = 0;//新建变量用于临时存储产生的随机数
        randInt = (int)Math.ceil(Math.random() * (3000000 - 2000000)) + 2000000;
        System.out.println(randInt+"  ");
        return randInt;
    }
    public int CreateRandomNumber4(){
        int randInt = 0;//新建变量用于临时存储产生的随机数
        randInt = (int)Math.ceil(Math.random() * (4000000 - 3000000)) + 3000000;
        System.out.println(randInt+"  ");
        return randInt;
    }
    public int CreateRandomNumber5(){
        int randInt = 0;//新建变量用于临时存储产生的随机数
        randInt = (int)Math.ceil(Math.random() * (5000000 - 4000000)) + 4000000;
        System.out.println(randInt+"  ");
        return randInt;
    }
}
