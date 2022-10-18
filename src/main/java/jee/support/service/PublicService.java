package jee.support.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jee.support.dao.PublicDao;
import jee.support.entity.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class PublicService {

    @Autowired
    PublicDao publicDao;


    public List<Announcement> pageQueryData(Map<String, Object> map) {
        return publicDao.pageQueryData(map);
    }

    public int pageQueryCount(Map<String, Object> map) {
        return publicDao.pageQueryCount(map);
    }

    public void deleteAnnouncemnetById(int id) {
        publicDao.deleteAnnouncemnetById(id);
    }

    public void deleteAnnouncemnetByids(Map<String, Object> map) {
        publicDao.deleteAnnouncemnetByids(map);
    }

    public void insertannouncement(Announcement announcement) {
        publicDao.insertannouncement(announcement);
    }

    public Announcement getAnnouncementByid(int id) {
        return publicDao.getAnnouncementByid(id);
    }

    //设置主页面的公告信息，存储notice表中
    public void SetNoticeByid(Notice notice) {
        publicDao.SetNoticeByid(notice);
    }

    public List<Notice> GetNotice() {
       return publicDao.GetNotice();
    }



    public int CheckNoticeBynid(int id) {
        return publicDao.CheckNoticeBynid(id);
    }

    //根据nid 从announcement中找到相关的公告内容
    public Announcement GetNoticeByAid(int aid) {
        return publicDao.GetNoticeByAid(aid);
    }

    //插入活动
    public void insertActivity(Activity activity) {
        publicDao.insertActivity(activity);
    }
    //分页查询所有活动
    public List<Activity> pageQueryActivityData(Map<String, Object> map) {
        return publicDao.pageQueryActivityData(map);
    }

    public int pageQueryActivityCount(Map<String, Object> map) {
        return publicDao.pageQueryActivityCount(map);
    }

    public HashMap<String, Object> QueryActivity(int id) {
        return publicDao.QueryActivity(id);
    }

    public void deleteActivityByid(int id) {
        publicDao.deleteActivityByid(id);
    }

    public void deleteActivityByids(Map<String, Object> map) {
        publicDao.deleteActivityByids(map);
    }

    public PageInfo<Activity> getActivityIndex(int page, int size) {

        PageHelper.startPage(page, size);
        List list = publicDao.getActivityIndex();
        PageInfo<Activity> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    public void insertSuduko(Suduko suduko) {
        publicDao.insertSuduko(suduko);
    }

    public HashMap<String, Object> GetSudukoByid(int id) {
        return publicDao.GetSudukoByid(id);
    }

    //分页查询数独题目
    public List<Suduko> pageQuerySudukoData(Map<String, Object> map) {
        return publicDao.pageQuerySudukoData(map);
    }

    public int pageQuerySudukoCount(Map<String, Object> map) {
        return publicDao.pageQuerySudukoCount(map);
    }

    public void deleteSudukoByid(int id) {
        publicDao.deleteSudukoByid(id);
    }

    public void deleteSudukoByids(Map<String, Object> map) {
        publicDao.deleteSudukoByids(map);
    }

    //上传轮播图片的地方
    public void UpLoadPhoto(Carousel carousel) {
        publicDao.UpLoadPhoto(carousel);
    }

    public void changeimage_del(String id) {
        publicDao.changeimage_del(id);
    }

    public List<Carousel> QueryCarousel(int id) {
        return publicDao.QueryCarousel(id);
    }

    public List<Carousel> QueryAllCarousel() {
        return publicDao. QueryAllCarousel();
    }

    //修改activity的status
    public void updatestatusBytypeAndoid(int oid) {
        publicDao.updatestatusBytypeAndoid(oid);
    }

    //修改accouncement的status
    public void updatestatusBynoticetypeAndoid(int oid) {
        publicDao.updatestatusBynoticetypeAndoid(oid);
    }

    public void updateNoticestatusByoid(int oid) {
        publicDao.updateNoticestatusByoid(oid);
    }

    public void updatestatusByannoncementtypeAndoid(int oid) {
        publicDao.updatestatusByannoncementtypeAndoid(oid);
    }

    public void updatestatusActivityByoid(int aid) {
        publicDao.updatestatusActivityByoid(aid);
    }

    public Activity  getActivityStatusByid(@Param("id") int id) {
        System.out.println("getActivityStatusByid:"+id);
        return publicDao.getActivityStatusByid(id);
    }

    public Carousel QueryCarouselByid(int id) {
        return publicDao.QueryCarouselByid(id);
    }

    public int pageQuerySudukoCountIndex(Map<String, Object> map) {
        return publicDao.pageQuerySudukoCountIndex(map);
    }

//    public int pageQuerySudukoCountIndexBy10(Map<String, Object> map) {
//        return publicDao.pageQuerySudukoCountIndexBy10(map);
//    }

    public List<Suduko> pageQuerySudukoIndexData(Map<String, Object> map) {
        return publicDao.pageQuerySudukoIndexData(map);
    }
    public List<Suduko> pageQuerySudukoIndexDataBy10(Map<String, Object> map) {
        return publicDao.pageQuerySudukoIndexDataBy10(map);
    }
    public void updatestatusBysudukotypeAndoid(int oid) {
        publicDao.updatestatusBysudukotypeAndoid(oid);
    }

    public void insertSudukoImg(SudukoImg sudukoImg) {
        publicDao.insertSudukoImg(sudukoImg);
    }

    public int deleteSudukoImgByid(int id) {
        return publicDao.deleteSudukoImgByid(id);
    }

    public int deleteSudukoImgByMap(Map<String, Object> map) {
        return publicDao.deleteSudukoImgByMap(map);
    }

    public SudukoImg GetSudukoImgByid(int id) {
        return publicDao.GetSudukoImgByid(id);
    }

    public List<Activity> QueryAllActivity() {
        return publicDao.QueryAllActivity();
    }

    public List<Suduko> QueryAlSuduko() {
        return publicDao.QueryAlSuduko();
    }

    public void UpdataActivity(Activity activity) {
        publicDao.UpdataActivity(activity);
    }

    public void insertPreview(Preview preview) {
        publicDao.insertPreview(preview);
    }


    public int checkPreviewByaid(int aid) {
        return publicDao.checkPreviewByaid(aid);
    }

    public void deletePreviewByaid(int aid) {
        publicDao.deletePreviewByaid(aid);
    }

    public HashMap<String, Object> QueryPreviewByid(int id) {
        return  publicDao.QueryPreviewByid(id);
    }

    public HashMap<String, Object> QueryPreviewByaid(int id) {
        return  publicDao.QueryPreviewByaid(id);
    }

    public void deletenoticeByid(Integer selectid) {
        publicDao.deletenoticeByid(selectid);
    }

    public List<Activity> pageQueryActivityDataBystatue1(Map<String, Object> map) {
        return publicDao.pageQueryActivityDataBystatue1(map);
    }

    public int pageQueryActivityCountBystatue1(Map<String, Object> map) {
        return publicDao.pageQueryActivityCountBystatue1(map);
    }


    public void insertSudukoAnwser(@Param("answer") String answer,@Param("id") int id) {
        publicDao.insertSudukoAnwser(answer,id);
    }
//
//    public int getActivityByaid(Map<String,Object> map) {
//        return publicDao.getActivityByaid(map);
//    }
        public Activity getActivityByaid(int aid) {
            return publicDao.getActivityByaid(aid);
        }

    public void insertZhoubian(Zhoubian zhoubian) {
        publicDao.insertZhoubian(zhoubian);
    }

    public List<Zhoubian> Queryzhoubian() {
        return publicDao.Queryzhoubian();
    }

    public void zhoubian_del(int id) {
        publicDao.zhoubian_del(id);
    }


    public void insertArticle(Article article) {publicDao.insertArticle(article);}

    public List<Article> pageQueryArticleData(Map<String, Object> map){
        return publicDao.pageQueryArticleData(map);
    }

    public int pageQueryArticleCount(Map<String, Object> map){
        return publicDao.pageQueryArticleCount(map);
    }

    public HashMap<String, Object> QueryArticle(int id) {return publicDao.QueryArticle(id);}

    public void deleteArticleByid(int id) {publicDao.deleteArticleByid(id);}

    public void deleteArticleByids(Map<String,Object> map) {publicDao.deleteArticleByids(map);}

    public PageInfo<Article> getArticleIndex(int page,int size) {
        PageHelper.startPage(page,size);
        List list=publicDao.getArticleIndex();
        PageInfo<Article> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    public void UpdataArticle(Article article) {
        publicDao.UpdataArticle(article);
    }

    public void insertPreviewArticle(Preview preview) {
        publicDao.insertPreviewArticle(preview);
    }

    public HashMap<String, Object> QueryPreviewArticleByaid(int id) {
        return publicDao.QueryPreviewArticleByaid(id);
    }

    public int checkPreviewArtByaid(int aid) {
        return publicDao.checkPreviewArtByaid(aid);
    }

    public void deletePreviewArtByaid(int aid) {
        publicDao.deletePreviewArtByaid(aid);
    }

    public HashMap<String, Object> QueryPreviewarticlesByid(int id) {
        return publicDao.QueryPreviewarticlesByid(id);
    }

    public HashMap<String, Object> QueryArticles(int id) {
        return publicDao.QueryArticles(id);
    }

    public void updatestatusArticleBytypeAndoid(int oid) {
        publicDao.updatestatusArticleBytypeAndoid(oid);
    }

    public List<Article> pageQueryArticleDataBytype(String type) {
        return publicDao.pageQueryArticleDataBytype(type);
    }

    public int pageQueryArticleCountBytype(String type) {
        return publicDao.pageQueryArticleCountBytype(type);
    }


    public List<Timing> getArticleByStandard(String type) {
        return publicDao.getArticleByStandard(type);
    }

    public Article getArticleByaid(int aid) {
        return publicDao.getArticleByaid(aid);
    }


    public Article getArticleStatusByid(int id) {
        return publicDao.getArticleStatusByid(id);
    }

    public void deleteSudukoAnswerByid(int id) {
        publicDao.deleteSudukoAnswerByid(id);
    }

    public void deleteSudukoAnswerByids(Map<String,Object> map) {
        publicDao.deleteSudukoAnswerByids(map);
    }

    public void deleteCarouselByid(Integer id) {
        publicDao.deleteCarouselByid(id);
    }

    public void deleteCarouselByids(Map<String,Object> map) {
        publicDao.deleteCarouselByids(map);
    }

    public Carousel queryCarouselPicurlByAid(int oid) {
        return publicDao.queryCarouselPicurlByAid(oid);
    }

    public String queryCarouselPicurlByAid2(int aid) {
        return publicDao.queryCarouselPicurlByAid2(aid);
    }
}

