package jee.support.dao;

import com.github.pagehelper.PageInfo;
import jee.support.entity.*;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PublicDao {


    List<Announcement> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    @Delete("delete from announcement where id=#{id}")
    void deleteAnnouncemnetById(int id);

    void deleteAnnouncemnetByids(Map<String, Object> map);

    void insertannouncement(Announcement announcement);

    @Select("select * from announcement where id =#{id}")
    Announcement getAnnouncementByid(int id);

    void SetNoticeByid(Notice notice);

    @Select("select * from notice where status=1 order by nid asc")
    List<Notice> GetNotice();

    @Select("select count(*) from notice where nid = #{id}")
    int CheckNoticeBynid(int id);

    @Select("select * from announcement where id = #{aid}")
    Announcement GetNoticeByAid(int aid);


    //插入活动
    void insertActivity(Activity activity);

    List<Activity> pageQueryActivityData(Map<String, Object> map);

    int pageQueryActivityCount(Map<String, Object> map);

    @Select("select * from activity where id =#{id}")
    HashMap<String, Object> QueryActivity(int id);

    @Delete("delete from activity where id =#{id}")
    void deleteActivityByid(int id);

    void deleteActivityByids(Map<String, Object> map);

    @Select("select * from activity where status=1 order by time desc")
    public List<Activity> getActivityIndex();


    @Select("select * from activity where status=1 and id = #{id}")
    Activity  getActivityStatusByid(@Param("id") int id);

    void insertSuduko(Suduko suduko);

    @Select("select * from suduko where id =#{id}")
    HashMap<String, Object> GetSudukoByid(int id);

    List<Suduko> pageQuerySudukoData(Map<String, Object> map);

    int pageQuerySudukoCount(Map<String, Object> map);

    @Delete("delete from suduko where id =#{id}")
    void deleteSudukoByid(int id);
    @Delete("delete from sudukoanswer where id =#{id}")
    void deleteSudukoAnswerByid(int id);

    void deleteSudukoByids(Map<String, Object> map);
    void deleteSudukoAnswerByids(Map<String, Object> map);

    void UpLoadPhoto(Carousel carousel);

    @Delete("delete from carousel where id = #{id}")
    void changeimage_del(String id);


    List<Carousel> QueryCarousel(int id);

    @Select("select * from carousel order by time desc limit 3")
    List<Carousel> QueryAllCarousel();


    void updatestatusBytypeAndoid(int oid);

    void updatestatusBynoticetypeAndoid(int oid);

    void updateNoticestatusByoid(int oid);

    void updatestatusByannoncementtypeAndoid(int oid);

    void updatestatusActivityByoid(int aid);


    @Select("select * from carousel where aid = #{aid} ")
    public Carousel QueryCarouselByid(int aid);

    int pageQuerySudukoCountIndex(Map<String, Object> map);

    List<Suduko> pageQuerySudukoIndexData(Map<String, Object> map);

    void updatestatusBysudukotypeAndoid(int oid);

//    上传变形数独的图片
    void insertSudukoImg(SudukoImg sudukoImg);


    @Delete("delete from SudukoImg where sid = #{id}")
    int deleteSudukoImgByid(int id);

    int deleteSudukoImgByMap(Map<String, Object> map);

    @Select("select * from SudukoImg where sid =#{id}")
    SudukoImg GetSudukoImgByid(int id);

    /**
     * 路径拦截器
     * */
    @Select("select * from activity ")
    List<Activity> QueryAllActivity();

    @Select("select * from suduko")
    List<Suduko> QueryAlSuduko();

    void UpdataActivity(Activity activity);

    void insertPreview(Preview preview);

    @Select("select count(*) from preview where aid =#{aid}")
    int checkPreviewByaid(int aid);

    @Delete("delete from preview where aid =#{aid}")
    void deletePreviewByaid(int aid);

    @Select("select * from preview where id =#{id}")
    HashMap<String, Object> QueryPreviewByid(int id);

    @Select("select * from preview where aid =#{id}")
    HashMap<String, Object> QueryPreviewByaid(int id);


    @Delete("delete from notice where nid =#{selectid}")
    void deletenoticeByid(Integer selectid);

    List<Activity> pageQueryActivityDataBystatue1(Map<String, Object> map);

    @Select("select * from activity where id = #{aid}")
    Activity getActivityByaid(int aid);

    int pageQueryActivityCountBystatue1(Map<String, Object> map);


    @Select("select * from suduko where status =1 order by time desc limit #{start},#{size}")
    List<Suduko> pageQuerySudukoIndexDataBy10(Map<String, Object> map);


    void insertSudukoAnwser(@Param("answer") String answer,@Param("id") int id);



    void insertZhoubian(Zhoubian zhoubian);

    @Select("select * from zhoubian order by time desc")
    List<Zhoubian> Queryzhoubian();

    @Delete("delete from zhoubian where id = #{id}")
    void zhoubian_del(int id);

//    int pageQuerySudukoCountIndexBy10(Map<String, Object> map);

    /////////
//    @Select("select count(*) from mycomment where aid=#{aid}")
//    int getActivityByaid(int aid);
    /////////

    void insertArticle(Article article);
    List<Article> pageQueryArticleData(Map<String,Object> map);
    int pageQueryArticleCount(Map<String,Object> map);

    @Select("select * from article where id =#{id}")
    HashMap<String, Object> QueryArticle(int id);

    @Delete("delete from article where id =#{id}")
    void deleteArticleByid(int id);

    void deleteArticleByids(Map<String, Object> map);

    @Select("select * from article where status=1 order by time desc")
    public List<Article> getArticleIndex();

    @Select("select * from article where status=1 and id=#{id}")
    Article getArticleStatusByid(@Param("id") int id);

    void UpdataArticle(Article article);

    void insertPreviewArticle(Preview preview);


    @Select("select * from previewArticle where aid =#{id}")
    HashMap<String, Object> QueryPreviewArticleByaid(int id);

    @Select("select count(*) from previewArticle where aid =#{aid}")
    int checkPreviewArtByaid(int aid);

    @Delete("delete from previewArticle where aid =#{aid}")
    void deletePreviewArtByaid(int aid);

    @Select("select * from previewArticle where id =#{id}")
    HashMap<String, Object> QueryPreviewarticlesByid(int id);

    @Select("select * from article where id =#{id}")
    HashMap<String, Object> QueryArticles(int id);

    void updatestatusArticleBytypeAndoid(int oid);

    List<Article> pageQueryArticleDataBytype(String type);

    int pageQueryArticleCountBytype(String type);


    List<Timing> getArticleByStandard(String type);

    @Select("select * from article where id = #{aid}")
    Article getArticleByaid(int aid);


    @Delete("delete from carousel where aid = #{id}")
    void deleteCarouselByid(Integer id);

    void deleteCarouselByids(Map<String,Object> map);

    @Select("select * from carousel where aid = #{oid}")
    Carousel queryCarouselPicurlByAid(int oid);

    @Select("select url from carousel where aid = #{aid}")
    String queryCarouselPicurlByAid2(int aid);
}
