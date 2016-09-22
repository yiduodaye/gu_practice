


//var duitangscript=document.createElement('script');duitangscript.type='text/javascript';duitangscript.async=true;duitangscript.src='{{base_url}}/js/core/no/collectitcode1.js?t';var duitanginto=document.getElementsByTagName('script')[0];duitanginto.parentNode.insertBefore(duitangscript,duitanginto);


/*var duitangscript=document.createElement('script');duitangscript.type='text/javascript';duitangscript.async=true;duitangscript.src='{{base_url}}/js/core/no/collectitcode1.js';var duitanginto=document.getElementsByTagName('script')[0];duitanginto.parentNode.insertBefore(duitangscript,duitanginto);*/
/*
 duitang-collect-tool produced by duitang.com
 author balibell
 */

(function(W,D){
 //如果已经提取图片则返回
 if(D.DUITANG_COLLECT){ return; }
 D.DUITANG_COLLECT = 1;
 
 
 var L = W.location,
 U = L.href,
 A = navigator.userAgent,
 B = D.body,
 H = B.parentNode,
 DUITANG = false,
 TIMER,
 IMG,
 ie = A.indexOf('MSIE') >= 0 && A.indexOf('Opera') < 0,
 iev = ie ? navigator.appVersion.split(';')[1].replace(/[ ]/g,'') : '',
 ie6 = iev =='MSIE6.0',
 ie7 = iev =='MSIE7.0',
 ie8 = iev =='MSIE8.0',
 opera = A.indexOf('Opera') >= 0 ? true : false,
 webkit = /(webkit)[ \/]([\w.]+)/.exec(A.toLowerCase()),
 COLLECTTO = '{{base_url}}/collect/', // 配置新开窗口的地址
 ISTMALL = L.hostname.indexOf('tmall\.com') > -1 && L.pathname == '/item.htm',
 ISTAOBAO = L.hostname.indexOf('taobao\.com') > -1 && L.pathname == '/item.htm',
 blogsConf = {
 'e.weibo.com':{
 //feedArea		: '#pl_content_hisFeed',
 feedSelector	: '.content',
 detailCont		: '[node-type=feed_list_forwardContent],[node-type=feed_list_content]',
 detailEntr		: '.date'
 },
 'weibo.com':{
 //feedArea		: '#pl_content_myFeed',
 deTitle			: '的新浪微博',
 deName			: '.WB_name',
 feedSelector	: '.WB_detail',
 detailCont		: '.WB_text',
 detailEntr		: '.WB_time'
 },
 't.sohu.com':{
 //feedArea		: '#twitter_container',
 deTitle			: ' - 搜狐微博',
 deName			: '.nm',
 feedSelector	: '.twi',
 detailCont		: '.ugc',
 detailEntr		: '.twiB'
 },
 't.163.com':{
 //feedArea		: '#userTweetPage',
 deTitle			: '的微博_网易微博',
 deName			: '.js-remark',
 feedSelector	: '.tweet',
 detailCont		: '.tweet-message',
 detailEntr		: '.tweet-time'
 },
 't.qq.com':{
 //feedArea		:'#talkList',
 deTitle			: '的腾讯微博',
 deName			: '.msgCnt strong a',
 feedSelector	: '.msgBox',
 detailCont		: '.msgCnt',
 detailEntr		: '.time'
 }
 },
 siteName = getSiteName(),
 config = (siteName && blogsConf[siteName]),
 undefined;
 
 
 
 
 function getSiteName(){
 if(siteName) return siteName;
 var i, each;
 for(e in blogsConf){
 if(U.indexOf(e) != -1){
 siteName = e;
 return e;
 }
 }
 return '';
 };
 
 
 //trim 方法
 function trim(v){
 return v.replace(/^[\s\n\t]*/ig,'').replace(/[\s\n\t]*$/ig,'')
 }
 
 
 // 内容字符串整理，去除多余的标签
 function replaceTags(str){
 return trim(str.replace(/<span [^>]*class="duitang-commissionrate"[^>]*>[^<]*<\/span>/ig,'').replace(/(<[a-z]{1,10} ?[^>]*>|<\/[a-z]{1,10}>)/ig,'')).replace(/&nbsp;/ig,' ').replace(/&lt;/ig,'<').replace(/&gt;/ig,'>')
 }
 
 /*
  @说明： 通过图片获取微博detail 链接
  @参数： im      - (Dom) 图片节点
  */
 function getWeiboDetail(im){
 var arr = ['','',''];
 if( config ){
 var p = DGP(config["feedSelector"].substr(1),im),
 sppt = p && p.querySelectorAll,
 reg = new RegExp('\\b' + config["detailEntr"].substr(1) + '\\b'),
 entr = sppt ? p.querySelectorAll(config["detailEntr"]) : [],
 aa = entr.length ? entr[0].tagName.toLowerCase() == 'a' ? [entr[0]] : entr[entr.length-1].getElementsByTagName('a') : [],
 conts = sppt ? p.querySelectorAll(config["detailCont"]) : [],
 cont = conts.length ? conts[conts.length-1] : null,
 nms = sppt ? p.querySelectorAll(config["deName"]) : [],
 nm = nms.length ? nms[nms.length-1] : null;
 
 for( var j=0; j<aa.length; j++ ){
 var ae = aa[j];
 if( ae.className.match(reg) || siteName == 't.sohu.com' && (ae.parentNode.className.match(reg) || ae.parentNode.parentNode.className.match(reg)) ){
 //					var ureg = new RegExp('^http\:\/\/(www\.|)' + siteName,'i')
 //					arr[0] = 'http://' + siteName + (ae.href.replace(ureg,''));
 arr[0] = ae.href;
 break;
 }
 }
 if( nm ){
 arr[1] = replaceTags(nm.innerHTML) + config["deTitle"]
 }
 
 if( cont ){
 arr[2] = replaceTags(cont.innerHTML)
 }
 }
 
 // 天猫特殊处理
 if( ISTMALL ){
 var de = DG('J_DetailMeta');
 if( de ){
 var ht = de && de.getElementsByTagName('h3');
 if( ht.length ){
 arr = ['','',replaceTags(ht[0].innerHTML)]
 }
 }
 }
 
 // 淘宝市集特殊处理
 if( ISTAOBAO ){
 var de = DG('detail');
 if( de ){
 var ht = de && de.getElementsByTagName('h3');
 if( ht.length ){
 arr = ['','',replaceTags(ht[0].innerHTML)]
 }
 }
 }
 return arr;
 }
 
 //事件绑定
 function addEvent(el,eventType,fn){
 if(el.addEventListener){
 el.addEventListener(eventType,fn,false);
 }else if(el.attachEvent){
 el.attachEvent("on" + eventType,fn);
 }else{
 el["on"+eventType]=fn;
 }
 }
 
 function DG(id){
 return D.getElementById(id);
 }
 
 function DGP(classname,el){
 classname = classname.replace(',','\\b|\\b')
 var rg = new RegExp('(\\b'+classname+'\\b)','ig')
 var pn = el.parentNode || null;
 while( pn &&!rg.test(pn.className) ){
 var tg = pn.tagName ? pn.tagName.toLowerCase() : ''
 if( tg == 'body' ||  tg == '' || pn.parentNode && !pn.parentNode.tagName ){
 return null;
 }
 pn = pn.parentNode;
 }
 return pn;
 };
 
 
 function getImgOffset(im){
 var of = [0,0]
 if( im.getBoundingClientRect ){
 var DE = D.documentElement,
 rect = im.getBoundingClientRect(),
 dt = DE.clientTop || B.clientTop ||0,
 offsetY = W.pageYOffset || ( D.compatMode && D.compatMode!="BackCompat" ? DE : B ).scrollTop,
 _offsetTop = 0,
 _offsetLeft = 0;
 //if(currentImage._parentNode){_offsetTop=currentImage._parentNode.offsetTop||0;_offsetLeft=currentImage._parentNode.offsetLeft||0}
 of[0] = Math.max(rect.left + (W.pageXOffset || B.scrollLeft ) - ( DE.clientLeft || B.clientLeft || 0 ) + _offsetLeft - 0,0),
 of[1] = Math.max(rect.top + offsetY - dt + _offsetTop - 6,0)
 
 //alert('rect.left :' + rect.left + '///rect.top : ' + rect.top + '//offset top : ' + offsetY)
 }
 return of
 }
 
 //获取页面上选中的文字
 function getSelectedText(){
 var W = window, D = document;
 if (W.getSelection) {
 // This technique is the most likely to be standardized.
 // getSelection() returns a Selection object, which we do not document.
 return W.getSelection().toString();
 }else if (D.getSelection) {
 // This is an older, simpler technique that returns a string
 return D.getSelection();
 }else if (D.selection) {
 // This is the IE-specific technique.
 // We do not document the IE selection property or TextRange objects.
 return D.selection.createRange().text;
 }
 }
 
 //判断是否在数组里
 function inArray( elem, array ) {
 var indexOf = Array.prototype.indexOf
 if ( indexOf ) {
 return indexOf.call( array, elem );
 }
 
 for ( var i = 0, length = array.length; i < length; i++ ) {
 if ( array[ i ] === elem ) {
 return i;
 }
 }
 
 return -1;
 }
 
 //字符串截取
 function leftB(s, n){
 var s2 = s.slice(0, n),
 i = s2.replace(/[^\x00-\xff]/g, "**").length;
 if (i <= n) {
 return s2;
 }
 i -= s2.length;
 switch (i) {
 case 0: return s2;
 case n: return s.slice(0, n >> 1);
 default:
 var k = n - i,
 s3 = s.slice(k, n),
 j = s3.replace(/[\x00-\xff]/g, "").length;
 return j ? s.slice(0, k) + leftB(s3, j) : s.slice(0, k);
 }
 }
 
 
 //字符串截取
 function cut(s, n, a, b){
 var r = b ? s.substr(0, n) : leftB(s, n);
 return r == s ? r : r + (typeof a === 'undefined' ? '…' : a);
 }
 
 //获取屏幕和页面的宽高，并以数组形式返回
 function getSize() {
 var xScroll,
 yScroll,
 windowWidth,
 windowHeight,
 delement = D.documentElement;
 
 if (W.innerHeight && W.scrollMaxY) {
 xScroll = B.scrollWidth;
 yScroll = W.innerHeight + W.scrollMaxY;
 } else if (B.scrollHeight > B.offsetHeight){      // all but Explorer Mac
 xScroll = B.scrollWidth;
 yScroll = B.scrollHeight;
 } else {      // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
 xScroll = B.offsetWidth;
 yScroll = B.offsetHeight;
 }
 
 if (self.innerHeight) {      // all except Explorer
 windowWidth = self.innerWidth;
 windowHeight = self.innerHeight;
 } else if (delement && delement.clientHeight) {      // Explorer 6 Strict Mode
 windowWidth = delement.clientWidth;
 windowHeight = delement.clientHeight;
 } else if (B) {      // other Explorers
 windowWidth = B.clientWidth;
 windowHeight = B.clientHeight;
 }
 
 // for small pages with total height less then height of the viewport
 if(yScroll < windowHeight){
 pageHeight = windowHeight;
 y = pageHeight;
 } else {
 pageHeight = yScroll;
 y = pageHeight;
 }
 
 if(xScroll < windowWidth){
 pageWidth = windowWidth;
 } else {
 pageWidth = xScroll;
 }
 return [pageWidth,pageHeight,windowWidth,windowHeight]
 }
 
 
 
 /*
  描述：	getFitSize : 在区间内给出合适的等比输出值，可参详setImgSize 的功能
  参数：
  a       - (Arr) 待处理的高宽
  b       - (Arr) 范围高宽数组
  */
 function getFitSize(a,b) {
 if(a[0]&&a[1]&&b[0]) {
 if(!b[1]) b[1]=b[0];
 if(a[0]>b[0]||a[1]>b[1]) {
 var scale=a[0]/a[1],fit=scale>=b[0]/b[1];
 return fit?[b[0],parseInt(b[0]/scale)]:[parseInt(b[1]*scale),b[1]];
 }
 }
 return a;
 }
 
 //按面积大小排序，输入图片src 数组
 //[{src:'',power:0,w:200,h:300},{src:'',power:0,w:100,h:200}]
 function sortImagesByArea(arr,ideal){
 //ideal 为理想面积，默认为1000000
 ideal = ideal || 100000000;
 //判断第一个图片是否有w 值，如果有则不需要new Image 获取w 和 h
 if(arr[0].w && arr[0].h){
 for(var i=0,l=arr.length; i<l; i++){
 arr[i].power = -1/ideal*Math.abs(arr[i].w*arr[i].h-ideal) + 1;
 }
 }else{
 var tm,tmw,tmh;
 for(var i=0,l=arr.length; i<l; i++){
 tm = new Image();
 tm.src = arr[i].src;
 tmw = tm.width;
 tmh = tm.height;
 arr[i].power = -1/ideal*Math.abs(tmw*tmh-ideal) + 1;
 }
 }
 arr.sort(function (a,b){
          if(a.power>b.power){
          return -1;
          }else{
          return 1;
          }
          });
 return arr;
 }
 
 /*
  描述：获取图片的原始尺寸
  */
 function getImgSrcDim(dimg){
 var stw = dimg.style.width,
 sth = dimg.style.height,
 smw = dimg.style.maxWidth,
 smh = dimg.style.maxHeight,
 aw = dimg.getAttribute('width',2),
 ah = dimg.getAttribute('height',2);
 
 if( stw != '' && stw != 'auto' ){
 dimg.style.width = 'auto'
 }
 if( sth !== '' && sth != 'auto' ){
 dimg.style.height = 'auto'
 }
 if( smw !== '' && smw != 'none' ){
 dimg.style.maxWidth = 'none'
 }
 if( smh !== '' && smh != 'none' ){
 dimg.style.maxHeight = 'none'
 }
 
 dimg.removeAttribute('width')
 dimg.removeAttribute('height')
 
 var rw = dimg.width,
 rh = dimg.height;
 
 if( stw && stw != 'auto' ){
 dimg.style.width = stw
 }
 if( sth && sth != 'auto' ){
 dimg.style.height = sth
 }
 if( smw && smw != 'none' ){
 dimg.style.maxWidth = smw
 }
 if( smh && smh != 'none' ){
 dimg.style.maxHeight = smh
 }
 if( aw ){
 dimg.setAttribute('width',aw)
 }
 if( ah ){
 dimg.setAttribute('height',ah)
 }
 
 return [rw,rh]
 }
 
 /*
  @说明：attrImage 计算图片的属性
  */
 function attrImage(img){
 var dim = getImgSrcDim(img),
 sw = dim[0],
 sh = dim[1];
 
 var img = img.cloneNode(true),
 dsrc = img.getAttribute('data-src') || '', //人人网相册
 dsrc = dsrc.match(/loading\.gif$/ig) ? '' : dsrc,
 src = dsrc ? dsrc : img.src,
 range_sm = [150,150],
 range = [200,200];
 
 //计算 200 * 200 范围内的合适宽度高度
 var fsize = getFitSize([sw,sh],range),
 fsize_sm = getFitSize([sw,sh],range_sm);
 return {
 "w" : sw,
 "h" : sh,
 "sw" : fsize[0],
 "sh" : fsize[1],
 "ssw" : fsize_sm[0],
 "ssh" : fsize_sm[1],
 "st" : ( range[1] - fsize[1] )/2,
 "sst" : ( range_sm[1] - fsize_sm[1] )/2,
 "src" : src,
 // "img" : img,
 "alt" : img.alt || img.title.replace('【试试--拖拽--这张图片】','')
 };
 }
 
 
 // 动态添加style 节点
 function addStyle(sheetid, style){
 var stylesheet = DG(sheetid);
 if( !stylesheet || stylesheet.tagName.toLowerCase() !== 'style' ){
 stylesheet = D.createElement('style');
 stylesheet.id = sheetid; //'DUITANGSHEET';
 if( ie ){
 stylesheet.type = 'text/css';
 stylesheet.styleSheet.cssText = style;
 D.getElementsByTagName('head')[0].appendChild(stylesheet);
 }else if((A.lastIndexOf('Safari/') > 0) && parseInt(A.substr(A.lastIndexOf('Safari/') + 7, 7)) < 533){
 stylesheet.innerText= style;
 B.appendChild(stylesheet);
 }else{
 stylesheet.innerHTML = style;
 B.appendChild(stylesheet);
 }
 }
 }
 
 /*
  @说明：寻找并收罗页面上的图片
  */
 var getImages = function (){
 var imgs = [],
 dimgs = document.images;
 
 for( var i=0; i<dimgs.length; i++ ){
 var im = dimgs[i],
 attr = attrImage(im),
 info;
 
 if( attr.w >= 80 && attr.h >= 80 ){
 info = getWeiboDetail(im)
 attr["lnk"] = info[0];
 attr["ptitle"] = info[1];
 attr["pcont"] = info[2];
 //查找是否已经在 imgs 数组里
 var has = false;
 for( var k=0; k<imgs.length; k++ ){
 if( imgs[k].src == im.src ){
 if( !imgs[k]["lnk"] ){
 imgs[k] = attr;
 }
 has = true;
 }
 }
 if( !has ){
 imgs.push( attr );
 }
 }
 }
 
 if( imgs.length ){
 //按图片大小排序
 return sortImagesByArea(imgs);
 }else{
 return []
 }
 }
 
 function collectImage(src,alt,lnk,ptitle,pcont){
 var url = COLLECTTO,
 lnk = lnk || '',
 ttw = ptitle || D.title.replace(/^【你有[^】]*】/ig,''),
 desw = getSelectedText() || pcont || alt;
 
 // 替换掉 ttw 和 alt 中可能出现的换行符
 ttw = ttw.replace(/\n/ig,' ')
 desw = desw.replace(/\n/ig,' ')
 
 url += '?img=' + encodeURIComponent(src)
 + '&url=' + (encodeURIComponent(lnk) || encodeURIComponent((src == U ? D.referrer || U : U).replace(/&ref=[^&]+/ig,'')))
 + '&title=' + encodeURIComponent(cut(ttw, 80))
 + '&desc=' + encodeURIComponent(cut(desw, 300))
 
 //url += '&gp=1'
 
 
 W.open(url, 'duitang' + new Date().getTime(), 'status=no,resizable=no,scrollbars=yes,personalbar=no,directories=no,location=no,toolbar=no,menubar=no,width=840,height=530,left=60,top=80');
 }
 
 /*
  @说明：检查url 堆糖站内、本地图片是不能使用工具抓取的
  */
 var checkDomain = function(){
 var blist = [
              [/^https?:\/\/.*?\.?duitang\.com\//, '很抱歉，不能抓取本站的图片噢，请到其他网站抓取吧~'],
              [/^file/,'本地电脑里的图片是不能抓取的，去网页上抓取图片吧~']
              ]
 
 for( var i=0; i<blist.length; i++ ){
 if( blist[i][0].test(U) ){
// alert(blist[i][1])
 return false;
 }
 }
 return true;
 }
 
 
 //域名检查，检查不通过则返回。堆糖站内不能使用堆糖工具
 if( !checkDomain() ){
 DUITANG = true
 D.DUITANG_COLLECT = 0;
 return;
 }
 
 //增加图片上方收藏到堆糖的按钮
 if( !D.DUITANG_CHROMECOLLECT ){
 function hideDirPic(e){
 var tg = e.relatedTarget || e.toElement,
 dirbtn = DG('duitang_dirpic_btn');
 
 clearTimeout(TIMER)
 if( dirbtn && ( !tg ||  tg.tagName.toLowerCase() != 'img' && tg != dirbtn ) ){
 TIMER = setTimeout(function (){
					if( dirbtn && dirbtn.style ){
                    dirbtn.style.display = 'none';
					}
                    },400)
 }
 
 
 }
 //document 事件设置，如果是鼠标移出
 addEvent(D,'mouseout',hideDirPic)
 
 
 //document 事件设置，如果是鼠标移动到图片上
// addEvent(D,'mouseover',function (e){
//          var tg = e.target || e.srcElement;
//          
//          //duitang_action 为堆糖工具生成的节点
//          if( tg && tg.tagName && tg.tagName.toLowerCase() == 'img' && tg.parentNode && tg.parentNode.className != 'duitang_action' && tg.offsetWidth ){
//          var attr = attrImage(tg),
//          dirbtn = DG('duitang_dirpic_btn');
//          if( attr.w < 120 || attr.h < 120 ){
//          if( dirbtn && dirbtn.style ){
//          dirbtn.style.display = 'none';
//          }
//          return;
//          }
//          clearTimeout(TIMER)
//          //新增功能 图片上方显示按钮直接收藏
//          var ofs = getImgOffset(tg),
//          info = getWeiboDetail(tg),
//          sty;
//          
//          attr["lnk"] = info[0];
//          attr["ptitle"] = info[1];
//          attr["pcont"] = info[2];
//          
//          IMG = attr;
//          
//          if( !dirbtn ){
//          dirbtn = D.createElement('a');
//          dirbtn.href = 'javascript:;',
//          dirbtn.target = '_self',
//          dirbtn.innerHTML = DUITANG ? '收藏' : '收藏到堆糖',
//          dirbtn.id  = 'duitang_dirpic_btn';
//          
//          B.appendChild(dirbtn)
//          dirbtn.onclick = function (e){
//          this.blur();
//          e = e || window.event;
//          if ( e.preventDefault ) {
//          e.preventDefault();
//          }else{
//          e.returnValue = false;
//          }
//          if( e.stopPropagation ){
//          e.stopPropagation()
//          }
//          e.cancelBubble = true;
//          collectImage(IMG.src,IMG.alt,IMG.lnk,IMG.ptitle,IMG.pcont)
//          }
//          }
//          
//          sty = dirbtn.style;
//          sty.left = ofs[0]+'px'
//          sty.top = ofs[1]+'px'
//          sty.display = 'block';
//          //鼠标hover 显示收藏按钮 over
//          }
//          })
 }
 
 // 如果设置自动执行为 false ，则提前结束返回
 if( D.duitangCollectConfig && !D.duitangCollectConfig.autoExecute ){
 var style = " \
 #duitang_dirpic_btn:link,#duitang_dirpic_btn:visited{position:absolute;z-index:999999998;width:auto;height:20px;overflow:hidden;padding:0 8px;border:1px solid #bababa;border-radius:5px;text-align:center;font:normal normal 12px/19px '\5FAE\8F6F\96C5\9ED1';color:#666;background:#fff;text-decoration:none;width:102px;height:30px;_width:100px;_height:26px;padding:0;border:0 none;text-indent:-9999px;background-color:transparent;background-image:url('http://cdn.duitang.com/uploads/people/201207/27/20120727180326_uewU8.png');_background-image:url('http://cdn.duitang.com/uploads/files/201207/27/20120727180852_j3AjP.png');background-repeat:no-repeat;} \
 #duitang_dirpic_btn:hover{color:#999;text-decoration:none;background-position:0 -36px;} \
 #duitang_dirpic_btn:focus{outline:0} \
 ";
 
 addStyle('DUITANGSHEET',style);
 return
 }
// alert('aaa');
// document.write('波波1111');
 document.getImg = getImages;
document.checkDomain = checkDomain;
 //获取当前页的所有 img 标签中的图片
// var imgs = getImages();
 // window.haha = "haha";
// if( imgs.length <= 0 ){
 // alert('本页面没有适合的图片，请换一个页面试试吧~');
// D.DUITANG_COLLECT = 0;
// return;
// }
 })(window,document);