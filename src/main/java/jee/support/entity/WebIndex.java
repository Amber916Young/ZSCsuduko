package jee.support.entity;
//import net.paoding.analysis.analyzer.PaodingAnalyzer;
import com.github.pagehelper.StringUtil;
import jdk.nashorn.internal.runtime.ListAdapter;
import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
//import org.apache.lucene.queryParser.QueryParser;

import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.search.highlight.SimpleSpanFragmenter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;

import java.io.StringReader;
import java.nio.file.Paths;
import java.util.Date;
//import java.util.LinkedList;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * lucene 增删改查
* */
public class WebIndex {
    private static final String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
    private static final String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
    private static final String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
    private static final String regEx_space = "\\s*|\t|\r|\n";//定义空格回车换行符


    private Directory dir = null;
    private String lucenePath = "C://lucene";
    private IndexWriter getWriter() throws Exception{
        dir = FSDirectory.open(Paths.get(lucenePath,new String[0]));
        SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
        IndexWriterConfig iwc = new IndexWriterConfig(analyzer);
        IndexWriter writer = new IndexWriter(dir,iwc);
        return writer;
    }

    /**
     * 增加索引
     * */
    public void addIndex(Activity activity)throws Exception{
        IndexWriter writer =getWriter();
        Document doc = new Document();
        doc.add(new StringField("id",String.valueOf(activity.getId()), Field.Store.YES));
        doc.add(new TextField("title",activity.getTitle(),Field.Store.YES));
        doc.add(new StringField("relesaseDate",DateUtil.formatDate(new Date(),"yyy-MM-dd"),Field.Store.YES));
        doc.add(new TextField("content",activity.getContent(),Field.Store.YES));
//        doc.add(new TextField("keyWord"," ",Field.Store.YES));
        writer.addDocument(doc);
        writer.close();
    }

    public void addIndex2(Article article)throws Exception{
        IndexWriter writer =getWriter();
        Document doc = new Document();
        doc.add(new StringField("id2",String.valueOf(article.getId()), Field.Store.YES));
        doc.add(new TextField("title2",article.getTitle(),Field.Store.YES));
        doc.add(new StringField("relesaseDate2",DateUtil.formatDate(new Date(),"yyy-MM-dd"),Field.Store.YES));
        doc.add(new TextField("content2",article.getContent(),Field.Store.YES));
        writer.addDocument(doc);
        writer.close();
    }
    /**
     * 更新
     * */
    public void updateIndex(Activity activity) throws Exception{
        IndexWriter writer =getWriter();
        Document doc = new Document();
        doc.add(new StringField("id",String.valueOf(activity.getId()), Field.Store.YES));
        doc.add(new TextField("title",activity.getTitle(),Field.Store.YES));
        doc.add(new StringField("relesaseDate",DateUtil.formatDate(new Date(),"yyy-MM-dd"),Field.Store.YES));
        doc.add(new TextField("content",activity.getContent(),Field.Store.YES));
//        doc.add(new TextField("keyWord"," ",Field.Store.YES));
        writer.updateDocument(new Term("id",String.valueOf(activity.getId())),doc);
        writer.close();
    }

    public void updateIndex2(Article article) throws Exception{
        IndexWriter writer =getWriter();
        Document doc = new Document();
        doc.add(new StringField("id2",String.valueOf(article.getId()), Field.Store.YES));
        doc.add(new TextField("title2",article.getTitle(),Field.Store.YES));
        doc.add(new StringField("relesaseDate2",DateUtil.formatDate(new Date(),"yyy-MM-dd"),Field.Store.YES));
        doc.add(new TextField("content2",article.getContent(),Field.Store.YES));
        writer.updateDocument(new Term("id2",String.valueOf(article.getId())),doc);
        writer.close();
    }

    /**
     * 正则表达式，去除html标签
     * */
    public static String delHTMLTag(String htmlStr) {
        Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
        Matcher m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll(""); // 过滤script标签

        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
        Matcher m_style = p_style.matcher(htmlStr);
        htmlStr = m_style.replaceAll(""); // 过滤style标签

        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
        Matcher m_html = p_html.matcher(htmlStr);
        htmlStr = m_html.replaceAll(""); // 过滤html标签

        Pattern p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);
        Matcher m_space = p_space.matcher(htmlStr);
        htmlStr = m_space.replaceAll(""); // 过滤空格回车标签
        return htmlStr.trim(); // 返回文本字符串
    }
    public static String getTextFromHtml(String htmlStr){
        //去除html标签
        htmlStr = delHTMLTag(htmlStr);
        //去除空格" "
        htmlStr = htmlStr.replaceAll(" ","");
        return htmlStr;
    }

        /***
         * 删除
         */
    public void deleteIndex (String activityId) throws Exception{
        IndexWriter writer =getWriter();
        writer.deleteDocuments(new Term[] {new Term("id",activityId)});
        writer.forceMergeDeletes();
        writer.commit();
        writer.close();
    }

    public void deleteIndex2 (String articleId) throws Exception{
        IndexWriter writer =getWriter();
        writer.deleteDocuments(new Term[] {new Term("id",articleId)});
        writer.forceMergeDeletes();
        writer.commit();
        writer.close();
    }
    /**
     * 搜索索引
     * */
    public List<Activity> searchActivity(String q) throws Exception{
        List<Activity> activityList = new LinkedList<>();
        dir = FSDirectory.open(Paths.get(lucenePath,new String[0]));
        //获取reader
        IndexReader reader = DirectoryReader.open(dir);
        //获取流
        IndexSearcher is = new IndexSearcher(reader);
        //放入查询条件
        BooleanQuery.Builder booleanQuery = new BooleanQuery.Builder();
        SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
        QueryParser parser = new QueryParser("title",analyzer);
        Query query = parser.parse(q);

        QueryParser parser2 = new QueryParser("content",analyzer);
        Query query2 = parser2.parse(q);

//        QueryParser parser3 = new QueryParser("keyword",analyzer);
//        Query query3 = parser.parse(q);
        booleanQuery.add(query,BooleanClause.Occur.SHOULD);
        booleanQuery.add(query2,BooleanClause.Occur.SHOULD);
//        booleanQuery.add(query3,BooleanClause.Occur.SHOULD);

        //最多返回一百条
        TopDocs hits = is.search(booleanQuery.build(),100);
        //高亮搜索关键字
        QueryScorer scorer =new QueryScorer(query);
        Fragmenter fragmenter = new SimpleSpanFragmenter(scorer);
        SimpleHTMLFormatter simpleHTMLFormatter= new SimpleHTMLFormatter("<b><front style='color:red'>","</front></b>");
        Highlighter highlighter = new Highlighter(simpleHTMLFormatter,scorer);
        highlighter.setTextFragmenter(fragmenter);
        //遍历查询结果，放入list
        for(ScoreDoc scoreDoc :hits.scoreDocs){
            Document doc = is.doc(scoreDoc.doc);
            Activity activity = new Activity();
            activity.setId(Integer.parseInt(doc.get("id")));
            activity.setTime(doc.get("relesaseDate"));

            String title = doc.get("title");
            String content=doc.get("content");//content为从数据库获取的包含标签的博文内容
            content=content.replaceAll("<[.[^<]]*>", "");
//            System.out.println("content="+content);
//            String keyword = doc.get("keyword");
            if(title!=null){
                TokenStream tokenStream = analyzer.tokenStream("title",new StringReader(title));
                String hTitle = highlighter.getBestFragment(tokenStream,title);
                if(StringUtil.isEmpty(hTitle)){
                    System.out.println("title=="+title);
                    activity.setTitle(title);
                }else {
                    activity.setTitle(hTitle);
                    System.out.println("hTitle=="+hTitle);
                }
            }
            if(content!=null){
                TokenStream tokenStream = analyzer.tokenStream("content",new StringReader(content));
                String hContent = highlighter.getBestFragment(tokenStream,content);
                if(StringUtil.isEmpty(hContent)){
                    if(content.length()<=200){
                        String aaa= doc.get("content");
                        System.out.println("aaa==="+getTextFromHtml(aaa));
                        activity.setContent(content);
                    }else{
                        String aaa= doc.get("content");
                        activity.setContent(content.substring(0,100));
                    }
                }else {
                    activity.setContent(getTextFromHtml(hContent));
                }
            }
            //keyword????????
            activityList.add(activity);
        }

        return activityList;

    }

    public List<Article> searchArticle(String q) throws Exception{
        List<Article> articleList = new LinkedList<>();
        dir = FSDirectory.open(Paths.get(lucenePath,new String[0]));
        //获取reader
        IndexReader reader = DirectoryReader.open(dir);
        //获取流
        IndexSearcher is = new IndexSearcher(reader);
        //放入查询条件
        BooleanQuery.Builder booleanQuery = new BooleanQuery.Builder();
        SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
        QueryParser parser = new QueryParser("title2",analyzer);
        Query query = parser.parse(q);
        QueryParser parser2 = new QueryParser("content2",analyzer);
        Query query2 = parser2.parse(q);
        booleanQuery.add(query,BooleanClause.Occur.SHOULD);
        booleanQuery.add(query2,BooleanClause.Occur.SHOULD);
        //最多返回一百条
        TopDocs hits = is.search(booleanQuery.build(),100);
        //高亮搜索关键字
        QueryScorer scorer =new QueryScorer(query);
        Fragmenter fragmenter = new SimpleSpanFragmenter(scorer);
        SimpleHTMLFormatter simpleHTMLFormatter= new SimpleHTMLFormatter("<b><front style='color:red'>","</front></b>");
        Highlighter highlighter = new Highlighter(simpleHTMLFormatter,scorer);
        highlighter.setTextFragmenter(fragmenter);
        //遍历查询结果，放入list
        for(ScoreDoc scoreDoc :hits.scoreDocs){
            Document doc = is.doc(scoreDoc.doc);
            Article article = new Article();
            article.setId(Integer.parseInt(doc.get("id2")));
            article.setTime(doc.get("relesaseDate2"));
            String title = doc.get("title2");
            String content=doc.get("content2");//content为从数据库获取的包含标签的博文内容
            content=content.replaceAll("<[.[^<]]*>", "");
            if(title!=null){
                TokenStream tokenStream = analyzer.tokenStream("title2",new StringReader(title));
                String hTitle = highlighter.getBestFragment(tokenStream,title);
                if(StringUtil.isEmpty(hTitle)){
                    article.setTitle(title);
                }else {
                    article.setTitle(hTitle);
                }
            }
            if(content!=null){
                TokenStream tokenStream = analyzer.tokenStream("content2",new StringReader(content));
                String hContent = highlighter.getBestFragment(tokenStream,content);
                if(StringUtil.isEmpty(hContent)){
                    if(content.length()<=200){
                        article.setContent(content);
                    }else{
                        article.setContent(content.substring(0,100));
                    }
                }else {
                    article.setContent(getTextFromHtml(hContent));
                }
            }
            articleList.add(article);
        }
        return articleList;
    }
}
