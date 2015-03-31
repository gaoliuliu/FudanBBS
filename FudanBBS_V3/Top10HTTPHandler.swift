//
//  Top10HTTPHandler.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/21.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import Foundation


public class Top10HTTPHandler {
    
    func getTop10List(username:String,password:String) -> [Top10]{
        var top10s:[Top10] = []
        
        
        var xmlToParse:NSString  = getResponse("/top10",params:nil)
        
        var len = xmlToParse.rangeOfString("<bbstop10>").location
        //println(len)
        var newstr = xmlToParse.substringFromIndex(len)
        //println(newstr)
        let xml = SWXMLHash.parse(newstr)
        
        
        for elem in xml["bbstop10"]["top"] {
            var tmp = Top10()
            tmp.text = elem.element?.text
            tmp.count = elem.element?.attributes["count"]
            tmp.gid = elem.element?.attributes["gid"]
            tmp.owner = elem.element?.attributes["owner"]
            tmp.board = elem.element?.attributes["board"]
            
            
            top10s.append(tmp)
        }
        
        return top10s
        
    }
    
    func getTop10PostPA(new1:String,board:String,f:String) -> bbstcon{
        
        //var top10s:[Top10] = []
        var bbs = bbstcon()
        //var pa_list:[Post_PA] = []
        var params1 = ["new":new1,"board":board,"f":f]
        var xmlToParse:NSString  = getTopPost("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        //println(len)
        var newstr = xmlToParse.substringFromIndex(len)
        //println(newstr)
        //va/r newstr = "<bbstcon bid='80' gid='3085294642' anony='0' page='20' attach='307200'><session m=''><p>    </p><u></u><f></f></session><po fid='3085294642' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>东京中等价位餐馆推荐</title><date>2014年12月23日16:03:22 星期二</date><pa m='t'><p>&#160;本来lz自认为是对美食是很有追求的。总是yy自己为了好吃的原意远赴千山万水，</p><p>花重金吃好吃的，然后一入口，流下了感动的泪水………………</p><p>觉得自己果然生来就应该吃好吃的。</p><p><br/></p><p>现实是，每次看到毛十八或者其他大神高洋上的帖子，就开始狂算，</p><p>其实也不用算，5万2日币脚趾头想想也知道吃不起的。</p><p>那么问题来了，又馋又要吃，还任性地想要好吃的，怎么办呢？</p><p><br/></p><p>1．做功课&#160;&#160;&#160;懒</p><p>2．碰运气&#160;&#160;&#160;看人品</p><p><br/></p><p>这次出差，实在很赶，要带很多东西，除了电器。差不多所有时间都在银座一带转悠。</p><p>方便啊。两个百货店松屋和三越，再加个药店松本清，一站式搞定。</p><p>Ds的lz还去优衣库买了些保暖内衣和围脖给老人，没想到意外大好评……扯远了，不好意思</p><p>即使这样，要买的太多，时间太少，还是没有时间去找好吃的，于是就碰运气了。</p><p>本文推推荐的主要是还算好吃又不是很贵的，交通还算方便的饭店。</p><p><br/></p><p>①築地玉寿司&#160;銀座6丁目店（<a href='http://tabelog.com/tokyo/A1301/A130101/13015058/'/></p><p>周日的下午，3点一过，所有的饭店基本都不营业了，下午茶的地方排队那叫一个恐怖，</p><p>还好这家店还开着，救了命了简直。</p><p>很家庭饭店的氛围，点一个“お任せ”（厨师推荐寿司拼盘）</p><p>大概2千多3千不到日币，然后实在很饿，又加了几个，结账4千多5千不到日币。</p><p>师傅很好，怕吃不掉，在加单的时候表示可以换套餐内容不用加，</p><p>被饿死鬼无情地拒绝了。</p><p>整体来说，一分价钱一分货，不会特别惊艳，</p><p>但是就够啦。已经满足啦。再好吃就浪费啦。</p><p><br/></p><p>②築地寿司清&#160;銀座博品館店</p><p><a href='http://tabelog.com/tokyo/A1301/A130103/13007828/'/></p><p>优衣库总店隔壁，非常好找，一开始看装修以为那么哗众取宠，外国人会很多。其实并没有。</p><p>一个“お任せ”（厨师推荐寿司拼盘）大概3千多，最后结账7千多。</p><p>整体来说，比築地玉寿司贵一点，味道并没有很大区别。</p><p>但是也是很满足，所以每天胖一斤是活该。</p><p><br/></p><p>③银藏</p><p><a href='http://tabelog.com/tokyo/A1301/A130103/13028615/'/></p><p>这是家连锁店，便宜又好。很多地方都有。</p><p>如果不是对生的要求很高又钱实在花不掉的朋友，足够了。</p><p>感觉人均三五千日币吃到扶墙出了。</p><p>拷鸡皮什么也很好。还有中国人服务员。不会日文的朋友也可以放心。</p><p><br/></p><p><br/></p><p>下面夹点私心，如果不参观某值得谴责的神社，交通其实并不顺路。但是东西是好吃的</p><p>④旬菜ステーキ処&#160;らいむらいと</p><p><a href='http://tabelog.com/tokyo/A1309/A130904/13000220/'/></p><p>这家店中午有1000日币左右的套餐，好吃，周围ol经常排个半小时队。。。。。</p><p>这次吃了一个晚上的套餐，就不po图了，每一道都这么好吃，</p><p>从前菜到甜点。不知道是不是幻觉，感觉此等水平只应该在贵贵的饭店才有啊。</p><p>酸味，调料，各种都恰到好处。</p><p>看到lz消灭速度很快也很nice地上菜飞快。赞一下报菜名时紧张的妹子，萌萌的。</p><p><br/></p><p>结果让前几天已经每天胖一斤的继续堕落向了深渊。</p><p>结账8000日币左右。这次吃的最贵的一顿。好想带队友来学习一下。</p><p>其实以前带过得，结果周六还是周末人家关门。。。。。。。。。。。。。。。。。。。。。。。。。。。。。</p><p><br/></p><p>⑤トラットリア&#160;ラ&amp;#12539;スカルペッタ（trattonria&#160;la&#160;scarpetta）</p><p><a href='http://tabelog.com/tokyo/A1309/A130904/13006432/'/></p><p>这家是最爱，被包场了才去旬菜ステーキ処&#160;らいむらいと的。我对他们家是真爱。</p><p>1．	不是最喜欢意面，但是他们家的从来吃光</p><p>2．	专程赶去看到不能进，为他们欣慰，觉得总比没人去倒闭的好。</p><p>上次好像写过的，他们家吃的北海道鹿肉是目前吃的最好吃的东西没有之一。</p><p>其他东西也是有保证。</p><p>中午人多，晚上一般来说人少。。。（碰到包场也是醉了）</p><p><br/></p><p><br/></p><p>请大家如果懒得花心思去做功课的话，又有时间的话，光顾一下④和⑤。真的好吃。over</p><p><br/></p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='33' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p><p><c h='0' f='37' b='40'></c><c h='1' f='36' b='40'>※&#160;修改:·suzieYU&#160;于&#160;2014年12月23日16:44:48·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294648' owner='Visiting'><owner>Visiting</owner><nick>try&#160;to&#160;remember&#160;what&#160;we&#160;shoul</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:05:57 星期二</date><pa m='t'><p>f回去先，赞美你</p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;&#160;本来lz自认为是对美是很有追求的。总是yy自己为了好吃的原意远赴千山万水，</p><p>:&#160;花重金吃好吃的，然后一入口，流下了感动的泪水………………</p><p>:&#160;觉得自己果然生来就应该吃好吃的。</p><p>:&#160;现实是，每次看到毛十八或者其他大神高洋上的帖子，就开始狂算，</p><p>:&#160;其实也不用算，5万2日币脚趾头想想也知道吃不起的。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>来源:·日月光华&#160;bbs.fudan.edu.cn·FROM:[1234]</p><p><c h='0' f='37' b='40'></c><c h='1' f='31' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;210.13.79.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294650' owner='LuDo'><owner>LuDo</owner><nick>LuDo</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:06:54 星期二</date><pa m='t'><p>上次给我推荐的不在这里？</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;&#160;本来lz自认为是对美是很有追求的。总是yy自己为了好吃的原意远赴千山万水，</p><p>:&#160;花重金吃好吃的，然后一入口，流下了感动的泪水………………</p><p>:&#160;觉得自己果然生来就应该吃好吃的。</p><p>:&#160;现实是，每次看到毛十八或者其他大神高洋上的帖子，就开始狂算，</p><p>:&#160;其实也不用算，5万2日币脚趾头想想也知道吃不起的。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;117.184.15.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294660' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:11:25 星期二</date><pa m='t'><p>每次都要重复推荐的话，工作量太大了。</p><p>都很好吃。</p><p>这次的重点是：前几个交通方便</p><p>最后一个，算2个好了，是本人的真爱。</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;上次给我推荐的不在这里？</p><p>:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;&#160;本来lz自认为是对美是很有追求的。总是yy自己为了好吃的原意远赴千山万水，</p><p>:&#160;:&#160;花重金吃好吃的，然后一入口，流下了感动的泪水………………</p><p>:&#160;:&#160;觉得自己果然生来就应该吃好吃的。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='34' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294663' owner='LuDo'><owner>LuDo</owner><nick>LuDo</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:12:27 星期二</date><pa m='t'><p>出个大全啊！</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;每次都要重复推荐的话，工作量太大了。</p><p>:&#160;都很好吃。</p><p>:&#160;这次的重点是：前几个交通方便</p><p>:&#160;最后一个，算2个好了，是本人的真爱。</p><p>:&#160;【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;117.184.15.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294671' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:19:23 星期二</date><pa m='t'><p>懒。脑子不够用。。。。</p><p>其实这次的体会是，随便找也不要紧。</p></pa><pa m='q'><p>【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;出个大全啊！</p><p>:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;每次都要重复推荐的话，工作量太大了。</p><p>:&#160;:&#160;都很好吃。</p><p>:&#160;:&#160;这次的重点是：前几个交通方便</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='33' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294674' owner='LuDo'><owner>LuDo</owner><nick>LuDo</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:20:37 星期二</date><pa m='t'><p>啥时候又去霓虹了？</p><p><br/></p><p>这法国刚回来没多久吧</p><p><br/></p><p>法国播种游记有写吗？</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;懒。脑子不够用。。。。</p><p>:&#160;其实这次的体会是，随便找也不要紧。</p><p>:&#160;【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;出个大全啊！</p><p>:&#160;:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;117.184.15.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294681' owner='rot'><owner>rot</owner><nick>趋吉远祸</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:23:08 星期二</date><pa m='t'><p>一回生</p><p>二回熟</p><p>这种深耕密植都知道阿</p></pa><pa m='q'><p>【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;啥时候又去霓虹了？</p><p>:&#160;这法国刚回来没多久吧</p><p>:&#160;法国播种游记有写吗？</p><p>:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;懒。脑子不够用。。。。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><a i='i' href='http://bbs.fudan.edu.cn/upload/PIC/1404464176-8777.jpg'/></p><p><br/></p><p><a i='i' href='http://bbs.fudan.edu.cn/upload/PIC/1404464189-4492.jpg'/></p><p><br/></p><p><a i='i' href='http://bbs.fudan.edu.cn/upload/PIC/1404464204-3556.jpg'/></p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;120.89.63.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294684' owner='xixixixi'><owner>xixixixi</owner><nick>01CDE·执子之手与子偕老</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:24:04 星期二</date><pa m='t'><p>qmd第一张图每次萌死我了</p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;rot&#160;(趋吉远祸)&#160;的大作中提到:&#160;】</p><p>:&#160;一回生</p><p>:&#160;二回熟</p><p>:&#160;这种深耕密植都知道阿</p><p>:&#160;【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;啥时候又去霓虹了？</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>如果我是雪代巴，你是否是我的剑心。</p><p>我是不是会在死之前在你的脸上划下那道疤？</p><p>我想我会的。</p><p>可是你在感觉疼痛的时候，还会不会想到我。。</p><p>应该不会了吧。</p><p>爱在失去的时候，心痛到极痛就不痛了，伤到伤透也麻木了。&#160;&#160;</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;210.51.43.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294686' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:30:50 星期二</date><pa m='t'><p>日本是出差。</p><p><br/></p><p>法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。天意。</p><p>前几个月吃队友烧青口的时候，想一个人霸占一盆青口的梦想，就这么简单地实现了。</p><p>幸福来的太快</p><p><br/></p><p>德国就是，吕贝克不要去。坑爹，</p><p>汉堡的模型博物馆非常适合宅男，但是其他就什么都没有了。</p><p>柏林很冷，一半很破，其他的么，就有点怪怪的说不出的感觉。</p><p>最讨厌的事买了个杯子，发觉盒子里空的。。。。。写邮件去argue了同意退钱但是没有道歉</p><p><br/></p><p>队友得出结论，在德国不能说德文，因为说德文的东方脸别人就认为是穷学生不好好服务。说英文人家可能会觉得是是来消费的，就会态度好。。。。</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;啥时候又去霓虹了？</p><p>:&#160;这法国刚回来没多久吧</p><p>:&#160;法国播种游记有写吗？</p><p>:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;懒。脑子不够用。。。。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='31' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294689' owner='Visiting'><owner>Visiting</owner><nick>try&#160;to&#160;remember&#160;what&#160;we&#160;shoul</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:33:48 星期二</date><pa m='t'><p>原来德国人也这么不靠谱阿</p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;日本是出差。</p><p>:&#160;法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。</p><p>:&#160;天意。</p><p>:&#160;前几个月吃队友烧青口的时候，想一个人霸占一盆青口的梦想，就这么简单地实现了。</p><p>:&#160;幸福来的太快</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>来源:·日月光华&#160;bbs.fudan.edu.cn·FROM:[1234]</p><p><c h='0' f='37' b='40'></c><c h='1' f='32' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;210.13.79.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294691' owner='LuDo'><owner>LuDo</owner><nick>LuDo</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:35:14 星期二</date><pa m='t'><p>那上两张旅游wd也好啊&#160;允许你戴墨镜出镜</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;日本是出差。</p><p>:&#160;法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。</p><p>:&#160;天意。</p><p>:&#160;前几个月吃队友烧青口的时候，想一个人霸占一盆青口的梦想，就这么简单地实现了。</p><p>:&#160;幸福来的太快</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;117.184.15.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294696' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:38:47 星期二</date><pa m='t'><p>之后帮别人买包和皮夹子都反复确认里面有东西。。。。。有心理阴影了。</p><p>队友不停地黑巴黎，</p><p>被子事件，队友说，根据他的理解，德国人会寄个被子到中国来</p><p><br/></p><p>结果并没有</p></pa><pa m='q'><p>【&#160;在&#160;Visiting&#160;的大作中提到:&#160;】</p><p>:&#160;原来德国人也这么不靠谱阿</p><p>:&#160;【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;日本是出差。</p><p>:&#160;:&#160;法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。</p><p>:&#160;:&#160;天意。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294697' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:39:32 星期二</date><pa m='t'><p>旅游的时候有时差，像鬼一样，谁还拍照片啊</p></pa><pa m='q'><p>【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;那上两张旅游wd也好啊&#160;允许你戴墨镜出镜</p><p>:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;日本是出差。</p><p>:&#160;:&#160;法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。</p><p>:&#160;:&#160;天意。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='32' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294699' owner='LuDo'><owner>LuDo</owner><nick>LuDo</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:40:26 星期二</date><pa m='t'><p>鬼也有鬼样啊</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;旅游的时候有时差，像鬼一样，谁还拍照片啊</p><p>:&#160;【&#160;在&#160;LuDo&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;那上两张旅游wd也好啊&#160;允许你戴墨镜出镜</p><p>:&#160;:&#160;【&#160;在&#160;suzieYU&#160;(苏西（20120804M&#160;爪爪）)&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;117.184.15.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294702' owner='anniePL'><owner>anniePL</owner><nick>人生若只如初见</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:45:37 星期二</date><pa m='t'><p>leo好吃哒。。。</p><p>德国是不是南德比较好玩？明年去德奥自驾，打算就慕尼黑周边玩玩了，北面柏林神马的好像没有特别好玩的地方挖。。。</p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;日本是出差。</p><p>:&#160;法国只去巴黎，没啥好写的。就是看景点。吃leo,旅馆隔壁就有一家也是。。。。。。</p><p>:&#160;天意。</p><p>:&#160;前几个月吃队友烧青口的时候，想一个人霸占一盆青口的梦想，就这么简单地实现了。</p><p>:&#160;幸福来的太快</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><c h='0' f='37' b='40'></c><c h='1' f='37' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;64.104.124.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294705' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:51:43 星期二</date><pa m='t'><p>队友烧的比他家好吃，加半瓶干白下去就会微酸的香气</p><p>但是在百里这种物价吓人的地方，leo真良心</p><p>但是。。。。为什么一定要有但是</p><p><br/></p><p>看到有10欧优惠券</p><p>结果申请了过了5天才收到。。。。。。已经不能用了</p></pa><pa m='q'><p>【&#160;在&#160;anniePL&#160;的大作中提到:&#160;】</p><p>:&#160;leo好吃哒。。。</p><p>:&#160;德国是不是南德比较好玩？明年去德奥自驾，打算就慕尼黑周边玩玩了，北面柏林神马</p><p>:&#160;的好像没有特别好玩的地方挖。。。</p><p>:&#160;【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;日本是出差。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='34' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294706' owner='Visiting'><owner>Visiting</owner><nick>try&#160;to&#160;remember&#160;what&#160;we&#160;shoul</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:52:16 星期二</date><pa m='t'><p>momo，这样看来法国人意大利人都还好阿</p></pa><pa m='q'><p>【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;之后帮别人买包和皮夹子都反复确认里面有东西。。。。。有心理阴影了。</p><p>:&#160;队友不停地黑巴黎，</p><p>:&#160;被子事件，队友说，根据他的理解，德国人会寄个被子到中国来</p><p>:&#160;结果并没有</p><p>:&#160;【&#160;在&#160;Visiting&#160;的大作中提到:&#160;】</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>来源:·日月光华&#160;bbs.fudan.edu.cn·FROM:[1234]</p><p><c h='0' f='37' b='40'></c><c h='1' f='31' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;210.13.79.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294707' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:55:21 星期二</date><pa m='t'><p>整体来说科隆和慕尼黑比柏林好一点。</p><p>不记得了。。。。就天鹅堡也就这样，科隆大教堂还是挺牛的</p><p>是不是南德不知道，lz地理盲，还懒，请别较真</p><p><br/></p><p>但是柏林吃东西的物价不错啊</p><p>柏林有几个景点还是值得买票的，</p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;anniePL&#160;的大作中提到:&#160;】</p><p>:&#160;leo好吃哒。。。</p><p>:&#160;德国是不是南德比较好玩？明年去德奥自驾，打算就慕尼黑周边玩玩了，北面柏林神马</p><p>:&#160;的好像没有特别好玩的地方挖。。。</p><p>:&#160;【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;日本是出差。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='31' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po><po fid='3085294708' owner='suzieYU'><owner>suzieYU</owner><nick>苏西（20120804M&#160;爪爪）</nick><board>Travel</board><title>Re:&#160;东京中等价位餐馆推荐</title><date>2014年12月23日16:58:07 星期二</date><pa m='t'><p>一开始我觉得肯定漏了，这种事情偶然也会发生的也没什么</p><p>但是很吃惊的是队友很生气，他说盒子里有包装纸，这个是盗窃</p><p>大半夜写了很长的邮件去谴责。。。。。</p></pa><pa m='q'><p>【&#160;在&#160;Visiting&#160;的大作中提到:&#160;】</p><p>:&#160;momo，这样看来法国人意大利人都还好阿</p><p>:&#160;【&#160;在&#160;suzieYU&#160;的大作中提到:&#160;】</p><p>:&#160;:&#160;之后帮别人买包和皮夹子都反复确认里面有东西。。。。。有心理阴影了。</p><p>:&#160;:&#160;队友不停地黑巴黎，</p><p>:&#160;:&#160;被子事件，队友说，根据他的理解，德国人会寄个被子到中国来</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>请叫我羊毛怪</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·HTTP&#160;[FROM:&#160;58.32.237.*]</c><c h='0' f='37' b='40'></c></p></pa></po></bbstcon>"
        //println(newstr)
        
        
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            tmp.fid = elem.element?.attributes["fid"]
            tmp.owner1 = elem.element?.attributes["owner"]
            tmp.owner2 = elem["owner"].element?.text
            tmp.nick = elem["nick"].element?.text
            tmp.title = elem["title"].element?.text
            tmp.board = elem["board"].element?.text
            tmp.date = elem["date"].element?.text
           
            let isQ = elem["pa"].all.count
            
            
            
            
            
            println("isQ:\(isQ)")
            if isQ == 3 {
                //println("引用")
                for elem2 in elem["pa"][0]["p"]
                {
                    let tmppa = elem2.element?.text
                    if (tmppa?.isEmpty != nil){
                        //println(elem2.element?.text)
                        tmp.pa.extend(elem2.element!.text!)
                        tmp.pa.extend("\n")
                    }
                }
                
                
                for elem3 in elem["pa"][1]["p"]
                {
                    let tmppa = elem3.element?.text
                    if (tmppa?.isEmpty != nil){
                        //println(elem2.element?.text)
                        tmp.quote.extend(elem3.element!.text!)
                        tmp.quote.extend("\n")
                    }
                }
                
                for elem4 in elem["pa"][2]["p"]
                {
                    let tmppa = elem4.element?.text
                    if (tmppa?.isEmpty != nil){
                        //println(elem2.element?.text)
                        tmp.tail.extend(elem4.element!.text!)
                        tmp.tail.extend("\n")
                        //println(tmppa)
                    }
                }
            }else{
            
            for elem2 in elem["pa"][0]["p"]
            {
            let tmppa = elem2.element?.text
            if (tmppa?.isEmpty != nil){
            //println(elem2.element?.text)
            tmp.pa.extend(elem2.element!.text!)
            tmp.pa.extend("\n")
            }
            }
            
                tmp.quote.extend("")
                tmp.quote.extend("\n")
            
            for elem4 in elem["pa"][1]["p"]
            {
            let tmppa = elem4.element?.text
            if (tmppa?.isEmpty != nil){
            //println(elem2.element?.text)
            tmp.tail.extend(elem4.element!.text!)
            tmp.tail.extend("\n")
            }
            }
            
            }
            
            
            
            
            //println("tail:\(tmp.pa)")
            bbs.paList.append(tmp)
        }
        
        return bbs
        
    }
    
    
    
    func getResponse(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode)!
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
                println("error: \(error)")
        })
        
        sleep(1)
        return str
        
    }
    
    func getTopPost(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.GET("/tcon", parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode)!
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
                println("error: \(error)")
        })
        
        sleep(1)
        //println("toppost: \(str)")
        return str
        
        
    }
    
}