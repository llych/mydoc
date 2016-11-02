#### golang crontab的项目地址:
https://github.com/robfig/cron

#### 意义

> Golang不仅仅是兼容了linux标准的crontab格式，而且扩展了秒。也就是说正常的crontab是 分 时 小时 月 星期，而robfig cron是 秒 分 时 日 月 星期。

> 实现后的任务定时器，部署灵活，跨平台。 

#### 使用说明

> 注册任务到调度器里，当任务要执行的时候会使用goroutines调用，这样每个任务都不会发生阻塞。 



```
c := cron.New()
c.AddFunc("0 30 * * * *", func() { fmt.Println("Every hour on the half hour") })
c.AddFunc("@hourly",      func() { fmt.Println("Every hour") })
c.AddFunc("@every 1h30m", func() { fmt.Println("Every hour thirty") })
c.Start()
 
//这些任务都是异步执行的.
c.AddFunc("@daily", func() { fmt.Println("Every day") })
 
//获取他下次执行的时间. 
inspect(c.Entries())
 
//关闭着计划任务, 但是不能关闭已经在执行中的任务. 
c.Stop()  

```
 
CRON Expression Format
 
A cron expression represents a set of times, using 6 space-separated fields.

Field name   | Mandatory? | Allowed values  | Allowed special characters
----------   | ---------- | --------------  | --------------------------
Seconds      | Yes        | 0-59            | * / , -
Minutes      | Yes        | 0-59            | * / , -
Hours        | Yes        | 0-23            | * / , -
Day of month | Yes        | 1-31            | * / , - ?
Month        | Yes        | 1-12 or JAN-DEC | * / , -
Day of week  | Yes        | 0-6 or SUN-SAT  | * / , - ?


#### 下面是robfig/cron的实例用法。 

```
package main
//blog: xiaorui.cc
import (
    "github.com/robfig/cron"
    "log"
)
 
func main() {
    i := 0
    c := cron.New()
    spec := "0 */1 * * * *"
    c.AddFunc(spec, func() {
        i++
        log.Println("start", i)
    })
    c.Start()
    select{} //阻塞主线程不退出
 
}

```

#### 下面就是robfig/cron的执行的效果，结果跟咱们设定的一样每分钟一次调用一次。

```
[eason@devops test ]$ go run cron.go
2016/03/03 13:48:00 start 1
2016/03/03 13:49:00 start 2
2016/03/03 13:50:00 start 3
2016/03/03 13:51:00 start 4
2016/03/03 13:52:00 start 5
2016/03/03 13:53:00 start 6
2016/03/03 13:54:00 start 7

```

