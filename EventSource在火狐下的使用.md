ventSoruce支持除IE外几乎所有浏览器，在做comet类的项目中，使用这个HTML5方法能减轻太多的工作，强烈推荐，但原文档中html端的方法

    var source = new EventSource('/er');
    source.onmessage = function(e){
    ......
    }
    或 监听   
    source.addEventListener('eventname',function(e){
    .........................................
    });
    
两种方式在chrome都运行良好，但在firefox下无法持续获取服务端消息，最长的一次也只成功的接收了10几条翻墙后g了无数论坛终于找到兼容ff的方法。


node服务端
router.get('/er', function(req, res) {
        res.setHeader("Content-Type", "text/event-stream");
        res.write("data: now Date :" + new Date()+"\r\n\r\n");
        res.end();
});


html端
  document.addEventListener("DOMContentLoaded", function() {
           // declare localized references
          var  eventSrc  = new EventSource( "/er" ),
                  handler = function( event ) {

                      console.log( [ event.type, new Date(), event, event.data ] );

                  },
                  getReadyState = function( src ) {

                      if ( src.readyState ) {
                          // readyState is almost always 0, we're only interested in
                          // seeing readyState OPEN (1) ( or CLOSED (2) )
                          console.log( [ src.readyState, new Date() ] );
                      }

                      setTimeout(function() {
                          getReadyState( src );
                      }, 1);
                  };

          console.log( eventSrc );

          // Setup event handlers
          [ "open", "message" ].forEach( function( name ) {

              eventSrc.addEventListener( name, handler, false );

          });

          // Begin sampling the ready state
          getReadyState( eventSrc );

      }, false);

注意：firefox/chrome/ 皆可用  ie不支持
firefox 控制台打印
EventSource { url="http://localhost:3000/er", withCredentials=false, readyState=0, 更多...}
home (第 40 行)
["open", Date {Fri Sep 05 2014 10:55:05 GMT+0800}, open , undefined]
home (第 24 行)
["message", Date {Fri Sep 05 2014 10:55:05 GMT+0800}, message origin=http://localhost:3000, data=now Date :Fri Sep 05 2014 10:55:05 GMT+0800 (中国标准时间), "now Date :Fri Sep 05 201...55:05 GMT+0800 (中国标准时间)"]
home (第 24 行)
["open", Date {Fri Sep 05 2014 10:55:10 GMT+0800}, open , undefined]
home (第 24 行)
["message", Date {Fri Sep 05 2014 10:55:10 GMT+0800}, message origin=http://localhost:3000, data=now Date :Fri Sep 05 2014 10:55:10 GMT+0800 (中国标准时间), "now Date :Fri Sep 05 201...55:10 GMT+0800 (中国标准时间)"]

测试下终止接收消息，
修改代码如下
html

      document.addEventListener("DOMContentLoaded", function() {
           // declare localized references
          var htmlstr;
          var strs;
          var timea;
          var  eventSrc  = new EventSource( "/er" ),

                  handler = function( event ) {
                      console.log( [ event.type, new Date(), event, event.data ] );
                      if(event.data){
                strs = $.parseJSON(event.data);
                          if(strs.success){
                          htmlstr += strs.now;
                          $("#msgp").html(htmlstr);//需要建一个id=msgp的容器，
                          }else{
                              eventSrc.close();
                              clearTimeout(timea);
                          }
                      }
                  },
                  getReadyState = function( src ) {
                      if ( src.readyState ) {
                          // readyState is almost always 0, we're only interested in
                          // seeing readyState OPEN (1) ( or CLOSED (2) )
                          console.log( [ src.readyState, new Date() ] );
                      }

                      timea = setTimeout(function() {
                          getReadyState( src );
                      }, 1);
                  };

          console.log( eventSrc );

          // Setup event handlers
          [ "open", "message" ].forEach( function( name ) {

              eventSrc.addEventListener( name, handler, false );

          });

          // Begin sampling the ready state
          getReadyState( eventSrc );

      }, false);


server 端
var tt=0;
router.get('/er', function(req, res) {
        res.setHeader("Content-Type", "text/event-stream");
    tt++;
    if(tt<5){
        res.write("data: {\"now\":\"" + new Date()+"\",\"success\":true}\r\n\r\n");
    }
    else{
        res.write("data: {\"now\":\"" + new Date()+"\",\"success\":false}\r\n\r\n");
    }
        res.end();
});
